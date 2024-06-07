<script setup>
import { to12hTime } from "@/util";
import { useStore } from "vuex";
import { useRouter } from "vue-router";

const store = useStore();
const router = useRouter();
const { event } = defineProps(["event"]);

const deleteEvent = (eventId) => {
  store.dispatch("eventWishlist/deleteEvent", eventId);
};

const openEditEvent = (eventId) => {
  router.push({ name: "wishlistEdit", params: { eventId } });
};
</script>

<template>
  <v-sheet
    v-if="event"
    :elevation="3"
    class="bg-grey-lighten-4 position-relative rounded"
  >
    <v-menu>
      <template v-slot:activator="{ props: menuProps }">
        <v-btn
          class="pa-2 rounded-0"
          color="primary"
          icon="mdi-dots-vertical"
          location="top end"
          position="absolute"
          size="x-small"
          v-bind="menuProps"
        >
        </v-btn>
      </template>
      <v-list density="compact">
        <v-list-item
          density="compact"
          link
          @click="() => openEditEvent(event.id)"
        >
          <v-list-item-title>Edit</v-list-item-title>
        </v-list-item>

        <v-list-item density="compact" link @click="deleteEvent(event.id)">
          <v-list-item-title>Delete</v-list-item-title>
        </v-list-item>
      </v-list>
    </v-menu>

    <div class="pa-3">
      <div class="text-primary text-overline">
        {{ event.category }}
      </div>
      <h4 class="mb-2">{{ event.title }}</h4>
      <div v-if="event.start_time" class="d-flex align-center">
        <v-icon class="mr-2" color="primary" size="small">mdi-clock</v-icon>
        <span>{{ to12hTime(event.start_time) }}</span>
        <span v-if="event.end_time"> - {{ to12hTime(event.end_time) }}</span>
      </div>
      <div v-if="event.location" class="d-flex align-center">
        <v-icon class="mr-2" color="primary" size="small"
          >mdi-map-marker
        </v-icon>
        <span>{{ event.location }}</span>
      </div>

      <div class="d-flex justify-space-between">
        <v-btn
          :to="{
            name: 'wishlistSingle',
            params: { id: event.id },
          }"
          class="mt-4"
          density="comfortable"
          variant="tonal"
          >More Details
        </v-btn>
      </div>
    </div>
  </v-sheet>
</template>

<style scoped></style>
