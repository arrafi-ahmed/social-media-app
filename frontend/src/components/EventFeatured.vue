<!--source = [browse, wall, collection, wishlist]-->
<script setup>
  import { computed } from 'vue'
  import { useStore } from 'vuex'
  import { formatMonthYear, getDate, loadEventThumb, to12hTime } from '@/others/util.js'

  const store = useStore()
  const { event, type } = defineProps(['event', 'type'])

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
  <v-sheet
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
          class="mt-2 absolute high-z-index v-chip-0-padding rounded-0"
          density="compact"
          label
          variant="text"
        >
          <div class="d-flex justify-center align-center">
            <div class="text-overline bg-primary pa-2">
              {{ getDate(event.date) }}
            </div>
            <div class="text-overline text-primary pa-2">
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
  </v-sheet>
</template>

<style scoped>
.text-overline {
  font-size: 0.8em;
}
</style>
