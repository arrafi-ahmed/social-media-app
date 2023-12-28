<!--source = [browse, wall, favorite, wishlist]-->
<script setup>
import { formatMonthYear, getDate, loadEventThumb, to12hTime } from "@/util";
import { useStore } from "vuex";
import { computed } from "vue";

const store = useStore();
const { event, type } = defineProps(["event", "type"]);

const currentUser = computed(() => store.getters["cuser/getCurrentUser"]);
const isOwner = computed(() => event.user_id == currentUser.value.id);
const featuredEvent = computed(
  () => store.getters["eventWall/getFeaturedEvent"]
);
const handleUnsetFeaturedEvent = (eventId) => {
  store.dispatch("eventWall/unsetFeaturedEvent", { eventId });
};
</script>

<template>
  <v-sheet
    :class="{ 'pa-2 mb-2 bg-grey-lighten-3 rounded': type === 'has-header' }"
  >
    <h4 v-if="type === 'has-header'" class="px-2 pb-1">Featured Event</h4>
    <v-sheet class="bg-grey-lighten-3 rounded featured-event">
      <v-img
        :src="loadEventThumb(event?.images?.[0], event?.category)"
        aspect-ratio="3"
        class="position-relative"
        cover
      >
        <v-chip
          v-if="event.date"
          class="mt-2 absolute bg-white high-z-index v-chip-0-padding rounded-0"
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
          <template v-if="isOwner" v-slot:activator="{ props: menuProps }">
            <v-btn
              class="rounded-0"
              color="primary"
              density="compact"
              icon="mdi-dots-vertical"
              location="top end"
              position="absolute"
              size="small"
              v-bind="menuProps"
            >
            </v-btn>
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
        class="pb-1 px-2 clickable"
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
        <div v-if="event.start_time" class="d-flex align-center">
          <v-icon class="mr-1" color="primary" size="small">mdi-clock</v-icon>
          <small>{{ to12hTime(event.start_time) }}</small>
          <small v-if="event.end_time">
            - {{ to12hTime(event.end_time) }}</small
          >
        </div>
        <div v-if="event.location" class="d-flex align-center">
          <v-icon class="mr-1" color="primary" size="small"
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
