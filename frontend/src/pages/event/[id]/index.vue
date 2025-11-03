<script setup>
  import { computed, onMounted, ref } from 'vue'
  import { useRoute, useRouter } from 'vue-router'
  import { useDisplay } from 'vuetify'
  import { useStore } from 'vuex'
  import ConfirmationDialog from '@/components/ConfirmationDialog.vue'
  import Lightbox from '@/components/Lightbox.vue'
  import UserAvatar from '@/components/UserAvatar.vue'
  import { formatDateFromTimestamp, formatTimeFromTime, getEventImageUrl, goUserProfile } from '@/others/util.js'

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

  // Helper to get user identifier (slug preferred, fallback to userId)
  const getUserIdentifier = computed(() => {
    return event.value?.slug || event.value?.userId
  })

  function handleFavoriteEvent (payload) {
    store.dispatch('eventSingle/switchFavoriteEvent', {
      eventId: route.params.id,
      payload: !payload,
    })
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
        ])
      })
      .finally(() => {
        if (!event.value.id) {
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
</script>

<template>
  <v-container v-if="event.id">
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
      <v-col cols="auto">
      </v-col>
    </v-row>

    <v-row justify="center">
      <v-col cols="12" md="8">
        <lightbox
          :key="event?.images?.[0]"
          :aspect-ratio="2.5"
          :img-src="getEventImageUrl(event?.images?.[0])"
        />

        <h2 class="mt-8">{{ event?.title }}</h2>

        <div class="d-flex justify-space-between mt-4">
          <div>
            <div v-if="event?.date" class="d-flex">
              <v-icon
                class="mt-half"
                color="primary"
                size="small"
              >mdi-calendar
              </v-icon>
              <span class="ml-3">{{
                formatDateFromTimestamp(event?.date)
              }}</span>
            </div>
            <div v-if="event?.startTime && event?.endTime" class="d-flex">
              <v-icon
                class="mt-half"
                color="primary"
                size="small"
              >mdi-clock
              </v-icon>
              <span class="ml-3">{{ formatTimeFromTime(event?.startTime) }} -
                {{ formatTimeFromTime(event?.endTime) }}</span>
            </div>
            <div v-if="event?.location" class="d-flex">
              <v-icon
                class="mt-half"
                color="primary"
                size="small"
              >mdi-map-marker
              </v-icon>
              <span class="ml-3">{{ event?.location }}</span>
            </div>
            <div v-if="event?.category" class="d-flex">
              <v-icon
                class="mt-half"
                color="primary"
                size="small"
              >mdi-list-box
              </v-icon>
              <span class="ml-3">{{ event?.category }}</span>
            </div>
          </div>
          <v-btn
            color="primary"
            :icon="event.isFavorite ? 'mdi-heart' : 'mdi-heart-outline'"
            variant="text"
            @click="handleFavoriteEvent(event.isFavorite)"
          />
        </div>

        <p v-if="event?.description" class="mt-6 text-pre-wrap">
          {{ event?.description }}
        </p>

        <v-row v-if="event?.images?.length > 1" class="mt-6" justify="start">
          <v-col
            v-for="(image, index) in event?.images?.slice(1)"
            :key="index"
            cols="4"
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
          <v-col class="mr-2 ml-md-0">
            <v-textarea
              v-model="newCommentText"
              auto-grow
              class="text-pre-wrap"
              density="compact"
              hide-details
              label="Write a comment..."
              required
              rows="1"
              variant="solo"
              @keyup.enter="addComment"
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
        <v-list v-if="event?.comments?.length > 0" class="mt-2 mt-md-4">
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
                <v-sheet class="pa-3" color="grey-lighten-3" :elevation="5">
                  <v-hover v-slot="{ isHovering, props }">
                    <div class="position-relative" v-bind="props">
                      <confirmation-dialog
                        v-if="isHovering && (isAdmin || isOwner(comment.userId))"
                        popup-content="Are you sure?"
                        popup-title="Delete Comment"
                        @confirm="deleteComment(comment.id)"
                      >
                        <template #activator="{ onClick }">
                          <v-btn
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
                      <p class="text-pre-wrap">{{ comment.text }}</p>
                    </div>
                  </v-hover>
                </v-sheet>
              </v-col>
            </v-row>
          </v-list-item>
        </v-list>
      </v-col>
    </v-row>
  </v-container>
</template>
<style></style>
