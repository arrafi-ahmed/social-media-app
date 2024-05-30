<script setup>
import EventCardSm from "@/components/EventCardSm.vue";

const { events, type } = defineProps(["events", "type"]);
</script>

<template>
  <v-sheet
    :class="{ 'pa-2 mb-2 bg-grey-lighten-3 rounded': type === 'has-header' }"
  >
    <h4 v-if="type === 'has-header'" class="px-2 pb-1">Upcoming Events</h4>
    <div v-if="events?.length > 0">
      <div v-for="(event, index) in events" :key="index">
        <event-card-sm :event="event"></event-card-sm>
        <v-divider v-if="index !== events.length - 1" class="my-2"></v-divider>
      </div>
    </div>
    <div v-else><small class="px-2">No upcoming events found</small></div>
  </v-sheet>
</template>

<style scoped></style>
