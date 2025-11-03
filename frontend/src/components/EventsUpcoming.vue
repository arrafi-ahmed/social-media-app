<script setup>
  import EventCardSm from '@/components/EventCardSm.vue'
  import NoItems from '@/components/NoItems.vue'

  const { events, type } = defineProps(['events', 'type'])
</script>

<template>
  <v-sheet
    :class="{ 'pa-2 mb-2 rounded': type === 'has-header' }"
  >
    <h4 v-if="type === 'has-header'" class="px-2 pb-1">Upcoming Events</h4>
    <div v-if="events?.length > 0">
      <div v-for="(event, index) in events" :key="index">
        <event-card-sm :event="event" />
        <v-divider v-if="index !== events.length - 1" class="my-2" />
      </div>
    </div>
    <no-items
      v-else
      :closable="false"
      description="No upcoming events found"
      icon="mdi-calendar-clock-outline"
      variant="text"
    />
  </v-sheet>
</template>

<style scoped></style>
