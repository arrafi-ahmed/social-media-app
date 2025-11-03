<script setup>
  import EventCard from '@/components/EventCard.vue'
  import NoItems from '@/components/NoItems.vue'
  import WishlistCard from '@/components/WishlistCard.vue'

  const { events, source, type, grid } = defineProps([
    'events',
    'source',
    'type',
    'grid',
  ])
  const emit = defineEmits(['fetchEvents'])

  function onLoading ({ done }) {
    emit('fetchEvents', { done })
  }

  function getEmptyIcon () {
    switch (source) {
      case 'wishlist': {
        return 'mdi-heart-outline'
      }
      case 'favorite': {
        return 'mdi-star-outline'
      }
      case 'browse': {
        return 'mdi-magnify'
      }
      case 'wall': {
        return 'mdi-calendar-outline'
      }
      default: {
        return 'mdi-calendar-outline'
      }
    }
  }

  function getEmptyText () {
    switch (source) {
      case 'wishlist': {
        return 'No wishlist events yet'
      }
      case 'favorite': {
        return 'No favorite events yet'
      }
      case 'browse': {
        return 'No events found'
      }
      case 'wall': {
        return 'No events posted yet'
      }
      default: {
        return 'No events found'
      }
    }
  }
</script>

<template>
  <v-infinite-scroll
    :key="events.length === 0 ? Date.now() : undefined"
    :margin="0"
    @load="onLoading"
  >
    <v-container v-if="events.length > 0">
      <v-row>
        <v-col
          v-for="(event, index) in events"
          :key="index"
          :cols="grid?.cols || 12"
          :lg="grid?.lg || grid?.md || grid?.sm || grid?.cols"
          :md="grid?.md || grid?.sm || grid?.cols"
          :sm="grid?.sm || grid?.cols"
        >
          <event-card
            v-if="source !== 'wishlist'"
            :event="event"
            :source="source"
            :type="type"
          />
          <wishlist-card v-else :event="event" />
        </v-col>
      </v-row>
    </v-container>
    <no-items
      v-else-if="events.length === 0"
      :description="getEmptyText()"
      :icon="getEmptyIcon()"
    />
    <template #loading />
    <template #empty>
      <no-items
        v-if="events.length > 0"
        :closable="true"
        color="primary"
        description="You've reached the end!"
        icon="mdi-calendar-check-outline"
      />
    </template>
  </v-infinite-scroll>
</template>

<style>
.v-infinite-scroll--vertical {
  overflow-y: hidden !important;
}
</style>
