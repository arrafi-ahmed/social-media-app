<script setup>
  import DOMPurify from 'dompurify'
  import { computed, onMounted, ref } from 'vue'
  import { useRoute, useRouter } from 'vue-router'
  import { useDisplay } from 'vuetify'
  import { useStore } from 'vuex'
  import CollectionDialog from '@/components/CollectionDialog.vue'
  import CommentMentions from '@/components/CommentMentions.vue'
  import ConfirmationDialog from '@/components/ConfirmationDialog.vue'
  import GroupDialog from '@/components/GroupDialog.vue'
  import Lightbox from '@/components/Lightbox.vue'
  import MentionAutocomplete from '@/components/MentionAutocomplete.vue'
  import ReactionButtons from '@/components/ReactionButtons.vue'
  import UserAvatar from '@/components/UserAvatar.vue'
  import { formatDateFromTimestamp, formatExpirationDate, formatTimeFromTime, getDaysUntilExpiration, getEventImageUrl, goUserProfile } from '@/others/util.js'

  // Helper to check if content is HTML and sanitize it
  function getSanitizedDescription (html) {
    if (!html) return ''
    // Check if content contains HTML tags (from rich editor)
    const hasHtmlTags = /<[a-z][\s\S]*>/i.test(html)
    if (hasHtmlTags) {
      return DOMPurify.sanitize(html, {
        ALLOWED_TAGS: ['p', 'br', 'strong', 'em', 'u', 'h1', 'h2', 'h3', 'ul', 'ol', 'li', 'a'],
        ALLOWED_ATTR: ['href', 'target', 'rel'],
        ALLOW_DATA_ATTR: false,
      })
    }
    // Plain text - escape HTML and convert newlines to <br>
    const escaped = html
      .replace(/&/g, '&amp;')
      .replace(/</g, '&lt;')
      .replace(/>/g, '&gt;')
    return escaped.replace(/\n/g, '<br>')
  }

  const sanitizedDescription = computed(() => getSanitizedDescription(event.value?.description))

  definePage({
    name: 'eventSingle',
    meta: {
      requiresAuth: true,
      title: 'Event',
      layout: 'default',
    },
  })

  const { xs, mobile } = useDisplay()
  const route = useRoute()
  const router = useRouter()
  const store = useStore()
  const event = computed(() => store.state.eventSingle.event)
  const newCommentText = ref(null)
  const currentUser = computed(() => store.getters['auth/getCurrentUser'])

  const isAdmin = computed(() => store.getters['auth/isAdmin'])
  const isOwner = commenterId => commenterId == currentUser.value.id
  const isEventOwner = computed(() => event.value?.userId === currentUser.value?.id)

  // Helper to get user identifier (slug preferred, fallback to userId)
  const getUserIdentifier = computed(() => {
    return event.value?.slug || event.value?.userId
  })

  // Calculate days until expiration
  const daysUntilExpiration = computed(() => {
    return getDaysUntilExpiration(event.value?.expiresAt)
  })

  // Format expiration date
  const expirationDateFormatted = computed(() => {
    return formatExpirationDate(event.value?.expiresAt)
  })

  const collectionDialogOpen = ref(false)
  const selectedCollectionId = ref(null)
  const collections = computed(() => store.state.eventCollection.collections)
  const showCollectionSelector = ref(false)
  const removeFromSaved = ref(false)
  const commentTextareaRef = ref(null)
  const mentionAutocompleteRef = ref(null)

  // Group sharing
  const groups = computed(() => store.state.group.groups)
  const eventGroups = ref([])
  const showGroupSelector = ref(false)
  const selectedGroupIds = ref([])
  const isLoadingGroups = ref(false)
  const groupDialogOpen = ref(false)

  async function handleFavoriteEvent () {
    // Always show collection selector dialog
    await store.dispatch('eventCollection/getCollections')
    // Pre-select current collection if event is already saved
    if (event.value?.isFavorite) {
      // We need to find which collection this event is in
      // For now, just reset to null (All Saved)
      selectedCollectionId.value = null
    } else {
      selectedCollectionId.value = null
    }
    removeFromSaved.value = false
    showCollectionSelector.value = true
  }

  async function saveToCollection () {
    if (removeFromSaved.value) {
      // Remove from saved
      await store.dispatch('eventSingle/switchFavoriteEvent', {
        eventId: route.params.id,
        payload: false,
      })
    } else {
      // Save to collection
      await store.dispatch('eventSingle/switchFavoriteEvent', {
        eventId: route.params.id,
        payload: true,
        collectionId: selectedCollectionId.value,
      })
    }
    showCollectionSelector.value = false
    selectedCollectionId.value = null
    removeFromSaved.value = false
  }

  function openCreateCollectionDialog () {
    collectionDialogOpen.value = true
  }

  function handleCollectionSaved () {
    // Refresh collections list
    store.dispatch('eventCollection/getCollections')
  }

  async function handleGroupSaved () {
    // Refresh groups list
    await store.dispatch('group/getGroups')
    // Reload event groups to include newly created group
    await loadEventGroups()
  }

  function openCreateGroupDialog () {
    groupDialogOpen.value = true
  }

  async function loadEventGroups () {
    if (!event.value?.id) return
    try {
      isLoadingGroups.value = true
      const response = await store.dispatch('group/getGroupsForEvent', event.value.id)
      eventGroups.value = response.data.payload || []
      selectedGroupIds.value = eventGroups.value.map(g => g.id)
    } catch (error) {
      console.error('Error loading event groups:', error)
    } finally {
      isLoadingGroups.value = false
    }
  }

  async function openGroupSelector () {
    await store.dispatch('group/getGroups')
    await loadEventGroups()
    showGroupSelector.value = true
  }

  async function saveGroupSharing () {
    if (!event.value?.id) return
    try {
      const currentGroupIds = new Set(eventGroups.value.map(g => g.id))
      const selectedGroupIdsSet = new Set(selectedGroupIds.value)

      // Unshare from groups that were removed
      for (const group of eventGroups.value) {
        if (!selectedGroupIdsSet.has(group.id)) {
          await store.dispatch('group/unshareEventFromGroup', {
            eventId: event.value.id,
            groupId: group.id,
          })
        }
      }

      // Share with new groups
      for (const groupId of selectedGroupIds.value) {
        if (!currentGroupIds.has(groupId)) {
          await store.dispatch('group/shareEventWithGroup', {
            eventId: event.value.id,
            groupId,
          })
        }
      }

      await loadEventGroups()
      showGroupSelector.value = false
    } catch (error) {
      console.error('Error saving group sharing:', error)
    }
  }

  function addComment () {
    const newComment = {
      eventId: route.params.id,
      text: newCommentText.value,
      fullName: currentUser.value.name,
      image: currentUser.value.image,
    }
    store.dispatch('eventSingle/addComment', newComment).then(res => {
      newCommentText.value = null
      // Hide mention dropdown after posting comment
      if (mentionAutocompleteRef.value) {
        mentionAutocompleteRef.value.hideDropdown()
      }
      return store.dispatch('eventWall/setEventNotification', {
        eventId: route.params.id,
        payload: true,
      })
    })
  }

  function deleteComment (commentId) {
    store.dispatch('eventSingle/deleteComment', commentId)
  }

  onMounted(() => {
    store
      .dispatch('eventSingle/getEvent', route.params.id)
      .then(res => {
        return Promise.all([
          store.dispatch('eventSingle/setIsFavorite', route.params.id),
          store.dispatch('eventSingle/getCommentsByEventId', route.params.id),
          store.dispatch('eventSingle/getReactions', route.params.id),
          loadEventGroups(),
        ])
      })
      .finally(() => {
        if (!event.value || !event.value.id) {
          router.push({ name: 'notFound' })
        }
      })
  })

  function goBack () {
    store.commit('setActionSource', 'back')
    router.back()
  }

  function goProfile (userId) {
    store.commit('setActionSource', 'namecard')
    goUserProfile(userId)
  }

  function goEditEvent () {
    if (!event.value?.id) return
    store.commit('setScrollY', window.scrollY)
    store.commit('eventSingle/setEditingEvent', event.value)
    router.push({ name: 'eventEdit', params: { id: event.value.id }, query: { src: 'single' } })
  }
</script>

<template>
  <v-container v-if="event?.id">
    <v-row align="center" class="pb-1" justify="space-between">
      <v-col class="d-flex align-center" cols="auto">
        <v-btn icon="mdi-arrow-left" variant="text" @click="goBack" />
        <user-avatar
          class="ml-2"
          :img-src="event?.image"
          @click-avatar="goUserProfile(getUserIdentifier)"
        />

        <div class="pl-3">
          <h4 class="clickable" @click="goUserProfile(getUserIdentifier)">
            {{ event?.fullName }}
          </h4>
          <small>Posted on {{ formatDateFromTimestamp(event?.createdAt) }}</small>
        </div>
      </v-col>
      <v-col class="d-flex align-center justify-end" cols="auto">
        <v-btn
          color="primary"
          :icon="event.isFavorite ? 'mdi-bookmark' : 'mdi-bookmark-outline'"
          variant="text"
          @click="handleFavoriteEvent"
        />
        <v-btn
          v-if="isEventOwner || isAdmin"
          color="primary"
          icon="mdi-pencil"
          variant="text"
          @click="goEditEvent"
        />
      </v-col>
    </v-row>

    <v-row justify="center">
      <v-col cols="12" md="8">
        <lightbox
          :key="event?.images?.[0]"
          :aspect-ratio="2.5"
          :img-src="getEventImageUrl(event?.images?.[0])"
        />

        <div class="mt-6 mb-4">
          <v-chip
            v-if="event?.category"
            class="mb-3"
            color="primary"
            size="small"
            variant="tonal"
          >
            {{ event?.category }}
          </v-chip>
          <h2 class="mb-4" style="font-weight: 600; line-height: 1.3;">{{ event?.title }}</h2>
        </div>

        <v-card class="mb-4">
          <v-card-text class="pa-4">
            <div class="d-flex flex-column" style="gap: 16px;">
              <div v-if="event?.date" class="d-flex align-center">
                <v-icon class="mr-3" color="primary" size="small">mdi-calendar</v-icon>
                <div>
                  <div class="text-body-2 font-weight-medium">{{ formatDateFromTimestamp(event?.date) }}</div>
                  <div v-if="event?.startTime" class="text-caption text-medium-emphasis mt-1">
                    {{ formatTimeFromTime(event?.startTime) }}
                    <span v-if="event?.endTime"> - {{ formatTimeFromTime(event?.endTime) }}</span>
                  </div>
                </div>
              </div>

              <v-divider v-if="event?.location" />

              <div v-if="event?.location" class="d-flex align-center">
                <v-icon class="mr-3" color="primary" size="small">mdi-map-marker</v-icon>
                <div class="text-body-2">{{ event?.location }}</div>
              </div>

              <v-divider v-if="event?.expiresAt && daysUntilExpiration !== null && daysUntilExpiration > 0" />

              <div
                v-if="event?.expiresAt && daysUntilExpiration !== null && daysUntilExpiration > 0"
                class="d-flex align-center"
              >
                <v-icon class="mr-3" color="warning" size="small">mdi-clock-alert</v-icon>
                <div>
                  <div class="text-body-2 text-warning font-weight-medium">
                    Expires in {{ daysUntilExpiration }} {{ daysUntilExpiration === 1 ? 'day' : 'days' }}
                  </div>
                  <div class="text-caption text-medium-emphasis mt-1">
                    {{ expirationDateFormatted }}
                  </div>
                </div>
              </div>
            </div>
          </v-card-text>
        </v-card>

        <v-card v-if="event?.description" class="mb-4">
          <v-card-text class="pa-5">
            <div class="rich-text-content" v-html="sanitizedDescription" />
          </v-card-text>
        </v-card>

        <!-- Reactions and Group Sharing Section -->
        <v-card class="mb-4">
          <v-card-text class="pa-4">
            <div class="d-flex align-center">
              <reaction-buttons
                :compact="false"
                :event-id="event?.id"
                :reactions="event?.reactions || { like: 0, unlike: 0, heart: 0, laugh: 0, sad: 0, angry: 0 }"
                store-module="eventSingle"
                :user-reaction="event?.userReaction"
              />
              <v-spacer v-if="isEventOwner" />
              <div v-if="isEventOwner" class="d-flex align-center gap-2">
                <div v-if="eventGroups.length > 0" class="d-flex flex-wrap gap-1">
                  <v-chip
                    v-for="group in eventGroups"
                    :key="group.id"
                    :color="group.color || 'primary'"
                    size="small"
                    variant="flat"
                  >
                    <v-icon :icon="group.icon || 'mdi-account-group'" start size="x-small" />
                    <span class="text-caption">{{ group.name }}</span>
                  </v-chip>
                </div>
                <v-btn
                  color="primary"
                  icon="mdi-share-variant"
                  size="small"
                  variant="text"
                  @click="openGroupSelector"
                />
              </div>
            </div>
          </v-card-text>
        </v-card>

        <v-row v-if="event?.images?.length > 1" class="mb-4" justify="start">
          <v-col
            v-for="(image, index) in event?.images?.slice(1)"
            :key="index"
            cols="12"
            md="4"
            sm="6"
          >
            <!--              loop started from second item-->
            <lightbox
              :key="image"
              :aspect-ratio="1.45"
              :img-set="event.images.map(img => getEventImageUrl(img))"
              :img-src="getEventImageUrl(image)"
              :opening-index="index + 1"
            />
          </v-col>
        </v-row>
      </v-col>
    </v-row>

    <!-- Comment Section -->
    <v-row class="mt-2 mt-md-4" justify="center">
      <v-col cols="12" md="8">
        <h3>Comments</h3>
        <v-divider />

        <!-- Comment Input -->
        <v-row align="center" class="mt-2 mt-md-4" :no-gutters="!!xs">
          <v-col v-if="!xs" class="mr-2 ml-md-0" cols="auto">
            <user-avatar :clickable="false" :img-src="currentUser.image" />
          </v-col>
          <v-col class="mr-2 ml-md-0 position-relative">
            <v-textarea
              ref="commentTextareaRef"
              v-model="newCommentText"
              auto-grow
              class="text-pre-wrap"
              :density="xs ? 'comfortable' : 'default'"
              hide-details
              label="Write a comment..."
              required
              rows="2"
              variant="solo"
              @keydown="mentionAutocompleteRef?.handleKeydown"
              @keyup.enter="addComment"
              @focus="mentionAutocompleteRef?.checkActiveMention"
            />
            <mention-autocomplete
              ref="mentionAutocompleteRef"
              :model-value="newCommentText"
              :textarea-ref="commentTextareaRef"
              @update:model-value="newCommentText = $event"
            />
          </v-col>
          <v-col cols="auto">
            <v-btn
              color="primary"
              :density="xs ? 'comfortable' : 'default'"
              icon="mdi-send"
              @click="addComment"
            />
          </v-col>
        </v-row>

        <!-- Comments List -->
        <v-list v-if="event?.comments?.length > 0" class="mt-2 mt-md-4" variant="text">
          <v-list-item
            v-for="(comment, index) in event?.comments"
            :key="index"
            class="mt-1 mt-md-3 px-0"
          >
            <v-row align="center" :no-gutters="!!mobile">
              <v-col class="mr-2 mr-md-0" cols="auto">
                <user-avatar
                  :img-src="comment?.image"
                  @click-avatar="goUserProfile(comment.slug || comment.userId)"
                />
              </v-col>
              <v-col>
                <v-card class="pa-3" :elevation="1" variant="tonal">
                  <v-hover v-slot="{ isHovering, props }">
                    <div class="position-relative" v-bind="props">
                      <confirmation-dialog
                        popup-content="Are you sure?"
                        popup-title="Delete Comment"
                        @confirm="deleteComment(comment.id)"
                      >
                        <template #activator="{ onClick }">
                          <v-btn
                            v-if="isHovering && (isAdmin || isOwner(comment.userId))"
                            color="error"
                            icon="mdi-delete"
                            location="top end"
                            position="absolute"
                            rounded
                            size="x-small"
                            variant="flat"
                            @click="onClick"
                          />
                        </template>
                      </confirmation-dialog>
                      <div class="d-flex align-center">
                        <v-list-item-title
                          class="clickable font-weight-bold"
                          @click="goUserProfile(comment.slug || comment.userId)"
                        >{{ comment.fullName }}
                        </v-list-item-title>
                        <v-list-item-subtitle class="ml-2">{{ formatDateFromTimestamp(comment.createdAt) }}
                        </v-list-item-subtitle>
                      </div>
                      <comment-mentions
                        class="text-body-2 mt-2 d-block"
                        :mentions="comment.mentions || []"
                        :text="comment.text"
                      />
                    </div>
                  </v-hover>
                </v-card>
              </v-col>
            </v-row>
          </v-list-item>
        </v-list>
      </v-col>
    </v-row>

    <!-- Collection Selector Dialog -->
    <v-dialog
      v-model="showCollectionSelector"
      :width="450"
    >
      <v-card>
        <v-card-title class="text-h6 pa-4 pb-3">
          {{ event?.isFavorite ? 'Move to Collection' : 'Save to Collection' }}
        </v-card-title>
        <v-card-text class="pa-4">
          <v-radio-group
            v-model="selectedCollectionId"
            :disabled="removeFromSaved"
          >
            <v-radio
              class="mb-2"
              label="All Saved (uncategorized)"
              :value="null"
            />
            <v-radio
              v-for="collection in collections"
              :key="collection.id"
              class="mb-2"
              :value="collection.id"
            >
              <template #label>
                <div class="d-flex align-center">
                  <v-icon
                    class="mr-2"
                    :color="collection.color || 'primary'"
                    :icon="collection.icon || 'mdi-folder'"
                    size="small"
                  />
                  <span>{{ collection.name }}</span>
                  <span v-if="collection.event_count > 0" class="ml-2 text-caption text-medium-emphasis">
                    ({{ collection.event_count }})
                  </span>
                </div>
              </template>
            </v-radio>
          </v-radio-group>

          <!-- Remove from saved checkbox -->
          <v-divider v-if="event?.isFavorite" class="my-4" />
          <v-checkbox
            v-if="event?.isFavorite"
            v-model="removeFromSaved"
            color="error"
            density="comfortable"
            hide-details
            label="Remove from saved events"
          >
            <template #label>
              <span class="text-error">Remove from saved events</span>
            </template>
          </v-checkbox>
        </v-card-text>
        <v-card-actions class="pa-4 pt-0">
          <v-spacer />
          <v-btn
            class="mr-2"
            size="default"
            variant="text"
            @click="showCollectionSelector = false"
          >
            Cancel
          </v-btn>
          <v-btn
            v-if="!removeFromSaved"
            class="mr-2"
            color="primary"
            size="default"
            variant="flat"
            @click="openCreateCollectionDialog"
          >
            New Collection
          </v-btn>
          <v-btn
            :color="removeFromSaved ? 'error' : 'primary'"
            size="default"
            variant="flat"
            @click="saveToCollection"
          >
            {{ removeFromSaved ? 'Remove' : 'Save' }}
          </v-btn>
        </v-card-actions>
      </v-card>
    </v-dialog>

    <!-- Collection Create/Edit Dialog -->
    <collection-dialog
      v-model="collectionDialogOpen"
      @saved="handleCollectionSaved"
    />

    <!-- Group Selector Dialog -->
    <v-dialog
      v-model="showGroupSelector"
      :width="450"
    >
      <v-card>
        <v-card-title class="text-h6 pa-4 pb-3">
          Share with Groups
        </v-card-title>
        <v-card-text class="pa-4">
          <div v-if="isLoadingGroups" class="text-center py-4">
            <v-progress-circular
              indeterminate
              color="primary"
              size="24"
            />
          </div>
          <div v-else-if="groups.length === 0" class="text-center py-4">
            <div class="text-body-2 text-medium-emphasis mb-3">
              No groups available
            </div>
            <v-btn
              color="primary"
              prepend-icon="mdi-account-group-plus"
              variant="flat"
              @click="openCreateGroupDialog"
            >
              Create Group
            </v-btn>
          </div>
          <div v-else>
            <v-checkbox
              v-for="group in groups"
              :key="group.id"
              v-model="selectedGroupIds"
              class="mb-2"
              hide-details='auto'
              :value="group.id"
            >
              <template #label>
                <div class="d-flex align-center">
                  <v-icon
                    class="mr-2"
                    :color="group.color || 'primary'"
                    :icon="group.icon || 'mdi-account-group'"
                    size="small"
                  />
                  <span>{{ group.name }}</span>
                  <span v-if="group.memberCount > 0" class="ml-2 text-caption text-medium-emphasis">
                    ({{ group.memberCount }})
                  </span>
                </div>
              </template>
            </v-checkbox>
          </div>
        </v-card-text>
        <v-card-actions class="pa-4 pt-0">
          <v-btn
            v-if="groups.length > 0"
            color="primary"
            prepend-icon="mdi-account-group-plus"
            size="small"
            variant="text"
            @click="openCreateGroupDialog"
          >
            New Group
          </v-btn>
          <v-spacer />
          <v-btn
            class="mr-2"
            size="default"
            variant="text"
            @click="showGroupSelector = false"
          >
            Cancel
          </v-btn>
          <v-btn
            v-if="groups.length > 0"
            color="primary"
            size="default"
            variant="flat"
            @click="saveGroupSharing"
          >
            Save
          </v-btn>
        </v-card-actions>
      </v-card>
    </v-dialog>

    <!-- Group Create/Edit Dialog -->
    <group-dialog
      v-model="groupDialogOpen"
      @saved="handleGroupSaved"
    />
  </v-container>
</template>
<style scoped>
.rich-text-content {
  line-height: 1.6;
}

.rich-text-content :deep(h1),
.rich-text-content :deep(h2),
.rich-text-content :deep(h3) {
  font-weight: 600;
  line-height: 1.2;
  margin-top: 1em;
  margin-bottom: 0.5em;
}

.rich-text-content :deep(h1) {
  font-size: 2em;
}

.rich-text-content :deep(h2) {
  font-size: 1.5em;
}

.rich-text-content :deep(h3) {
  font-size: 1.25em;
}

.rich-text-content :deep(p) {
  margin-bottom: 0.75em;
}

.rich-text-content :deep(ul),
.rich-text-content :deep(ol) {
  padding-left: 1.5em;
  margin-bottom: 0.75em;
}

.rich-text-content :deep(ul) {
  list-style-type: disc;
}

.rich-text-content :deep(ol) {
  list-style-type: decimal;
}

.rich-text-content :deep(li) {
  margin-bottom: 0.25em;
}

.rich-text-content :deep(a) {
  color: rgb(var(--v-theme-primary));
  text-decoration: underline;
}

.rich-text-content :deep(a:hover) {
  opacity: 0.8;
}
</style>
