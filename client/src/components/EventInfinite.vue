<script setup>
import EventCard from "@/components/EventCard.vue";
import WishlistCard from "@/components/WishlistCard.vue";

const { events, source, type, grid } = defineProps([
  "events",
  "source",
  "type",
  "grid",
]);
const emit = defineEmits(["fetchEvents"]);

const onLoading = ({ done }) => {
  emit("fetchEvents", { done });
};
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
          ></event-card>
          <wishlist-card v-else :event="event"></wishlist-card>
        </v-col>
      </v-row>
    </v-container>
    <template v-slot:loading></template>
    <template v-slot:empty>
      <v-alert
        border="start"
        class="mx-2"
        closable
        color="primary"
        density="compact"
        variant="tonal"
        >You've reached the end!
      </v-alert>
    </template>
  </v-infinite-scroll>
</template>

<style>
.v-infinite-scroll--vertical {
  overflow-y: hidden !important;
}
</style>
