<!--source = [browse, wall, favorite]-->
<script setup>
import {
  formatDateFromTimestamp,
  formatMonthYear,
  getDate,
  getUserImageUrl,
  goUserProfile,
  loadEventThumb,
  to12hTime,
} from "@/util";
import { useRouter } from "vue-router";
import { useStore } from "vuex";
import { computed } from "vue";

const store = useStore();
const router = useRouter();
const { event, type, source } = defineProps(["event", "type", "source"]);

const currentUser = computed(() => store.getters["cuser/getCurrentUser"]);
const isAdmin = computed(() => store.getters["cuser/isAdmin"]);
const isOwner = computed(() => event.user_id == currentUser.value.id);
const featuredEvent = computed(
  () => store.getters["eventWall/getFeaturedEvent"]
);

const storeModule = computed(() =>
  source === "browse" ? "eventBrowse" : source === "wall" ? "eventWall" : null
);

const deleteEvent = (eventId, images) => {
  store
    .dispatch(`${storeModule.value}/deleteEvent`, { eventId, images })
    .then(() => {});
};
const handleSetFeaturedEvent = (eventId) => {
  store.dispatch("eventWall/setFeaturedEvent", { eventId });
};
const handleUnsetFeaturedEvent = (eventId) => {
  store.dispatch("eventWall/unsetFeaturedEvent", { eventId });
};
const setEventNotification = (eventId) => {
  store
    .dispatch("eventWall/setEventNotification", {
      eventId: eventId,
      payload: false,
    })
    .then((res) => {
      router.push({
        name: "eventSingle",
        params: { id: event.id },
      });
    });
};

const goEditEvent = (event) => {
  store.commit(`setScrollY`, window.scrollY);
  store.commit(`${storeModule.value}/setEditingEvent`, event);
  router.push({
    name: `eventEdit-${source}`,
    params: { eventId: event.id },
  });
};

const goEventSingle = (eventId) => {
  store.commit(`setScrollY`, window.scrollY);
  router.push({
    name: "eventSingle",
    params: { id: eventId },
  });
};
</script>

<template>
  <v-sheet v-if="event" :elevation="3" class="bg-grey-lighten-4 rounded">
    <div
      v-if="type === 'has-header'"
      class="d-flex align-center position-relative clickable pa-2"
      @click="goUserProfile(event.user_id)"
    >
      <!--      menu for browse page-->
      <v-menu v-if="(isAdmin || isOwner) && source === 'browse'">
        <template v-slot:activator="{ props: menuProps }">
          <v-btn
            class="pa-2"
            color="primary"
            icon="mdi-dots-vertical"
            location="top end"
            position="absolute"
            size="x-small"
            rounded
            v-bind="menuProps"
            @click.stop=""
          >
          </v-btn>
        </template>
        <v-list density="compact">
          <v-list-item density="compact" link @click="goEditEvent(event)">
            <v-list-item-title>Edit</v-list-item-title>
          </v-list-item>
          <v-list-item
            density="compact"
            link
            @click="deleteEvent(event.id, event.images)"
          >
            <v-list-item-title>Delete</v-list-item-title>
          </v-list-item>
        </v-list>
      </v-menu>

      <v-img
        :aspect-ratio="1"
        :max-width="45"
        :src="getUserImageUrl(event?.image)"
        class="rounded-circle"
        cover
      >
      </v-img>
      <div class="ml-3">
        <h4>
          {{ event?.full_name }}
        </h4>
        <small>Posted on {{ formatDateFromTimestamp(event.created_at) }}</small>
      </div>
    </div>

    <v-img
      :class="type === 'headerless' ? 'position-relative' : ''"
      :src="loadEventThumb(event?.images?.[0], event?.category)"
      aspect-ratio="1.16"
      class="clickable"
      cover
      @click="goEventSingle(event.id)"
    >
      <v-chip
        v-if="event.date"
        class="mt-4 absolute bg-white high-z-index v-chip-0-padding rounded-0"
        label
        variant="text"
      >
        <div class="d-flex">
          <div class="text-overline bg-primary pa-2">
            {{ getDate(event.date) }}
          </div>
          <div class="text-overline text-primary pa-2">
            {{ formatMonthYear(event.date) }}
          </div>
        </div>
      </v-chip>

      <!--      menu for wall page-->
      <v-menu v-if="source === 'wall'">
        <template
          v-if="isAdmin || isOwner"
          v-slot:activator="{ props: menuProps }"
        >
          <v-btn
            class="pa-2"
            color="primary"
            icon="mdi-dots-vertical"
            location="top end"
            position="absolute"
            size="x-small"
            rounded
            v-bind="menuProps"
          >
          </v-btn>
        </template>
        <v-list density="compact">
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
            @click="() => goEditEvent(event)"
          >
            <v-list-item-title>Edit</v-list-item-title>
          </v-list-item>

          <v-divider></v-divider>

          <v-list-item
            v-if="isAdmin || isOwner"
            density="compact"
            link
            class="text-error"
            @click="deleteEvent(event.id, event.images)"
          >
            <v-list-item-title>Delete</v-list-item-title>
          </v-list-item>
        </v-list>
      </v-menu>
    </v-img>

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
          class="mt-4"
          density="comfortable"
          variant="tonal"
          @click="goEventSingle(event.id)"
          >More Details
        </v-btn>

        <!--        only show in own wall page-->
        <v-btn
          v-if="
            event.new_notification &&
            source === 'wall' &&
            $route.params.id === currentUser?.id
          "
          icon
          variant="text"
          @click="setEventNotification(event.id)"
        >
          <v-badge color="primary" dot>
            <v-icon icon="mdi-bell-outline"></v-icon>
          </v-badge>
        </v-btn>
      </div>
    </div>
  </v-sheet>
</template>

<style scoped></style>
