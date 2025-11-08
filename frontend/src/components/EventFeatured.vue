<!--source = [browse, wall, collection, wishlist]-->
<script setup>
  import { computed } from 'vue'
  import { useTheme } from 'vuetify'
  import { useStore } from 'vuex'
  import { formatMonthYear, getDate, loadEventThumb, to12hTime } from '@/others/util.js'

  const store = useStore()
  const theme = useTheme()
  const { event, type } = defineProps(['event', 'type'])

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
  const isOwner = computed(() => event.userId == currentUser.value.id)
  const featuredEvent = computed(
    () => store.getters['eventWall/getFeaturedEvent'],
  )

  function handleUnsetFeaturedEvent (eventId) {
    store.dispatch('eventWall/unsetFeaturedEvent', { eventId })
  }
</script>

<template>
  <v-card
    :class="{ 'pa-2 mb-2 rounded': type === 'has-header' }"
  >
    <h4 v-if="type === 'has-header'" class="px-2 pb-1">Featured Event</h4>
    <v-sheet class="rounded featured-event">
      <v-img
        aspect-ratio="3"
        class="position-relative"
        cover
        :src="loadEventThumb(event?.images?.[0], event?.category)"
      >
        <v-chip
          v-if="event.date"
          class="mt-2 absolute high-z-index v-chip-0-padding"
          label
          variant="text"
        >
          <div class="d-flex overflow-hidden" style="border-radius: 4px; box-shadow: 0 2px 8px rgba(0, 0, 0, 0.15);">
            <div
              class="text-overline pa-1 text-white font-weight-bold"
              :style="{ backgroundColor: dateChipStyles.dateBg }"
            >
              {{ getDate(event.date) }}
            </div>
            <div
              class="text-overline pa-1 font-weight-medium"
              :style="{
                backgroundColor: dateChipStyles.monthBg,
                color: dateChipStyles.monthText
              }"
            >
              {{ formatMonthYear(event.date) }}
            </div>
          </div>
        </v-chip>

        <!--      menu -->
        <v-menu>
          <template v-if="isOwner" #activator="{ props: menuProps }">
            <v-btn
              color="primary"
              density="compact"
              icon="mdi-dots-vertical"
              location="top end"
              position="absolute"
              rounded
              size="small"
              v-bind="menuProps"
            />
          </template>
          <v-list density="compact">
            <v-list-item v-if="isOwner" density="compact" link>
              <v-list-item-title
                v-if="featuredEvent?.id == event.id"
                @click="handleUnsetFeaturedEvent(event.id)"
              >Unfeature
              </v-list-item-title>
            </v-list-item>
          </v-list>
        </v-menu>
      </v-img>

      <div
        class="pa-2 clickable"
        @click="
          $router.push({
            name: 'eventSingle',
            params: { id: event.id },
          })
        "
      >
        <small class="text-primary">
          {{ event.category }}
        </small>

        <h5 class="mb-1">{{ event.title }}</h5>
        <div v-if="event.startTime" class="d-flex align-center">
          <v-icon class="mr-1" color="primary" size="small">mdi-clock</v-icon>
          <small>{{ to12hTime(event.startTime) }}</small>
          <small v-if="event.endTime">
            - {{ to12hTime(event.endTime) }}</small>
        </div>
        <div v-if="event.location" class="d-flex align-center">
          <v-icon
            class="mr-1"
            color="primary"
            size="small"
          >mdi-map-marker
          </v-icon>
          <small>{{ event.location }}</small>
        </div>
      </div>
    </v-sheet>
  </v-card>
</template>

<style scoped>
.text-overline {
  font-size: 0.75em;
}
</style>
