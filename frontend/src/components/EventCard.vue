<!--source = [browse, wall, collection]-->
<script setup>
  import { computed } from 'vue'
  import { useRouter } from 'vue-router'
  import { useTheme } from 'vuetify'
  import { useStore } from 'vuex'
  import ConfirmationDialog from '@/components/ConfirmationDialog.vue'
  import UserAvatar from '@/components/UserAvatar.vue'
  import {
    formatDateFromTimestamp,
    formatMonthYear,
    getDate,
    getDaysUntilExpiration,
    goUserProfile,
    loadEventThumb,
    to12hTime,
  } from '@/others/util.js'

  const store = useStore()
  const router = useRouter()
  const theme = useTheme()
  const { event, type, source } = defineProps(['event', 'type', 'source'])

  // Computed styles for date chip based on theme
  const dateChipStyles = computed(() => {
    const isDark = theme.current.value.dark
    return {
      dateBg: '#e40046', // Primary color for date (consistent across themes)
      monthBg: isDark ? 'rgba(255, 255, 255, 0.2)' : 'rgba(255, 255, 255, 0.9)', // Semi-transparent overlay
      monthText: isDark ? '#ffffff' : '#e40046', // White text in dark, primary text in light
    }
  })

  const currentUser = computed(() => store.getters['auth/getCurrentUser'])
  const isAdmin = computed(() => store.getters['auth/isAdmin'])
  const isOwner = computed(() => event.userId == currentUser.value.id)
  const featuredEvent = computed(
    () => store.getters['eventWall/getFeaturedEvent'],
  )

  const storeModule = computed(() =>
    source === 'browse' ? 'eventBrowse' : (source === 'wall' ? 'eventWall' : null),
  )

  // Helper to get user identifier (slug preferred, fallback to userId)
  const getUserIdentifier = computed(() => {
    return event.slug || event.userId
  })

  // Calculate days until expiration
  const daysUntilExpiration = computed(() => {
    return getDaysUntilExpiration(event.expiresAt)
  })

  function deleteEvent (eventId, images) {
    store
      .dispatch(`${storeModule.value}/deleteEvent`, { eventId, images })
      .then(() => {})
  }

  function handleSetFeaturedEvent (eventId) {
    store.dispatch('eventWall/setFeaturedEvent', { eventId })
  }

  function handleUnsetFeaturedEvent (eventId) {
    store.dispatch('eventWall/unsetFeaturedEvent', { eventId })
  }

  function setEventNotification (eventId) {
    store
      .dispatch('eventWall/setEventNotification', {
        eventId: eventId,
        payload: false,
      })
      .then(res => {
        router.push({
          name: 'eventSingle',
          params: { id: event.id },
        })
      })
  }

  function goEditEvent (event) {
    store.commit(`setScrollY`, window.scrollY)
    store.commit('setActionSource', 'edit')
    store.commit(`${storeModule.value}/setEditingEvent`, event)
    router
      .push({ name: 'eventEdit', params: { id: event.id }, query: { src: source } })
  }

  function goEventSingle (eventId) {
    store.commit(`setScrollY`, window.scrollY)
    router.push({
      name: 'eventSingle',
      params: { id: eventId },
    })
  }
</script>

<template>
  <v-sheet v-if="event" class="rounded event-card-sheet" :elevation="2">
    <div
      v-if="type === 'has-header'"
      class="d-flex align-center position-relative clickable pa-2"
      @click="goUserProfile(getUserIdentifier)"
    >

      <!--      menu for browse page-->
      <v-menu v-if="(isAdmin || isOwner) && source === 'browse'">
        <template #activator="{ props: menuProps }">
          <v-btn
            class="pa-2"
            color="primary"
            icon="mdi-dots-vertical"
            location="top end"
            position="absolute"
            rounded
            size="x-small"
            v-bind="menuProps"
            @click.stop=""
          />
        </template>
        <v-list density="compact">
          <v-list-item density="compact" link @click="goEditEvent(event)">
            <v-list-item-title>Edit</v-list-item-title>
          </v-list-item>
          <v-divider />
          <confirmation-dialog
            popup-content="Are you sure?"
            popup-title="Delete"
            @confirm="deleteEvent(event.id, event.images)"
          >
            <template #activator="{ onClick }">
              <v-list-item class="text-error" density="compact" link @click.stop="onClick">
                <v-list-item-title>Delete</v-list-item-title>
              </v-list-item>
            </template>
          </confirmation-dialog>
        </v-list>
      </v-menu>

      <user-avatar :img-src="event?.image" rounded="circle" @click-avatar="goUserProfile(getUserIdentifier)" />
      <div class="ml-3">
        <h4>
          {{ event?.fullName }}
        </h4>
        <small>Posted on {{ formatDateFromTimestamp(event.createdAt) }}</small>
      </div>
    </div>

    <v-img
      aspect-ratio="1.16"
      class="clickable"
      :class="type === 'headerless' ? 'position-relative' : ''"
      cover
      :src="loadEventThumb(event?.images?.[0], event?.category)"
      @click="goEventSingle(event.id)"
    >
      <v-chip
        v-if="event.date"
        class="mt-4 absolute high-z-index v-chip-0-padding"
        label
        variant="text"
      >
        <div class="d-flex overflow-hidden" style="border-radius: 4px; box-shadow: 0 2px 8px rgba(0, 0, 0, 0.15);">
          <div
            class="text-overline pa-2 text-white font-weight-bold"
            style="border-radius: 4px 0 0 4px;"
            :style="{ backgroundColor: dateChipStyles.dateBg }"
          >
            {{ getDate(event.date) }}
          </div>
          <div
            class="text-overline pa-2 font-weight-medium"
            style="border-radius: 0 4px 4px 0;"
            :style="{
              backgroundColor: dateChipStyles.monthBg,
              color: dateChipStyles.monthText
            }"
          >
            {{ formatMonthYear(event.date) }}
          </div>
        </div>
      </v-chip>

      <!--      menu for wall page-->
      <v-menu v-if="source === 'wall'" :close-on-content-click="false">
        <template v-if="isAdmin || isOwner" #activator="{ props: menuProps }">
          <v-btn
            class="pa-2"
            color="primary"
            icon="mdi-dots-vertical"
            location="top end"
            position="absolute"
            rounded
            size="x-small"
            v-bind="menuProps"
            @click.stop
          />
        </template>
        <v-list density="compact" @click.stop>
          <v-list-item
            v-if="source === 'wall' && isOwner"
            density="compact"
            link
          >
            <v-list-item-title
              v-if="featuredEvent?.id != event.id"
              @click="handleSetFeaturedEvent(event.id)"
            >Feature
            </v-list-item-title>
            <v-list-item-title
              v-else
              @click="handleUnsetFeaturedEvent(event.id)"
            >Unfeature
            </v-list-item-title>
          </v-list-item>

          <v-list-item
            v-if="isAdmin || isOwner"
            density="compact"
            link
            @click.stop="() => goEditEvent(event)"
          >
            <v-list-item-title>Edit</v-list-item-title>
          </v-list-item>

          <v-divider />

          <confirmation-dialog
            v-if="isAdmin || isOwner"
            popup-content="Are you sure?"
            popup-title="Delete"
            @confirm="deleteEvent(event.id, event.images)"
          >
            <template #activator="{ onClick }">
              <v-list-item class="text-error" density="compact" link @click.stop="onClick">
                <v-list-item-title>Delete</v-list-item-title>
              </v-list-item>
            </template>
          </confirmation-dialog>
        </v-list>
      </v-menu>
    </v-img>

    <div class="pa-4">
      <div class="d-flex align-center mb-2" style="gap: 8px;">
        <v-chip
          v-if="event.category"
          color="primary"
          size="small"
          variant="tonal"
        >
          {{ event.category }}
        </v-chip>
        <v-chip
          v-if="event.expiresAt && daysUntilExpiration !== null && daysUntilExpiration > 0"
          color="warning"
          size="small"
          variant="tonal"
        >
          Expires in {{ daysUntilExpiration }} {{ daysUntilExpiration === 1 ? "day" : "days" }}
        </v-chip>
      </div>
      <h3 class="mb-3">{{ event.title }}</h3>

      <div v-if="event.startTime || event.location">
        <div v-if="event.startTime" class="d-flex align-center mb-2">
          <v-icon class="mr-2" color="primary" size="small">mdi-clock</v-icon>
          <span>{{ to12hTime(event.startTime) }}</span>
          <span v-if="event.endTime"> - {{ to12hTime(event.endTime) }}</span>
        </div>
        <div v-if="event.location" class="d-flex align-center">
          <v-icon
            class="mr-2"
            color="primary"
            size="small"
          >mdi-map-marker
          </v-icon>
          <span>{{ event.location }}</span>
        </div>
      </div>

      <div class="d-flex justify-space-between align-center">
        <v-btn
          class="mt-3"
          color="primary"
          density="comfortable"
          variant="flat"
          @click="goEventSingle(event.id)"
        >More Details
        </v-btn>

        <!--        only show in own wall page-->
        <v-btn
          v-if="
            event.newNotification &&
              source === 'wall' &&
              $route.params.id === currentUser?.id
          "
          icon
          variant="text"
          @click="setEventNotification(event.id)"
        >
          <v-badge color="primary" dot>
            <v-icon icon="mdi-bell-outline" />
          </v-badge>
        </v-btn>
      </div>
    </div>
  </v-sheet>
</template>

<style scoped>
.event-card-sheet {
  transition: box-shadow 0.2s ease;
  overflow: hidden;
}

.event-card-sheet:hover {
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15) !important;
}
</style>
