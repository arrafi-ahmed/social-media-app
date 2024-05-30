<script setup>
import { computed, onMounted } from "vue";
import { useStore } from "vuex";
import PageTitle from "@/components/PageTitle.vue";
import EventInfinite from "@/components/EventInfinite.vue";

const store = useStore();
const events = computed(() => store.state.eventFavorite.events);

const page = computed(() => store.state.eventFavorite.page);
const loadEvents = async ({ done }) => {
  const payload = { page: page.value };
  try {
    const result = await store.dispatch("eventFavorite/setEvents", payload);
    store.commit("eventFavorite/setPage", page.value + 1);
    done(result && result.data?.payload?.length < 1 ? "empty" : "ok");
  } catch (error) {
    done("error");
  }
};
const routeInfo = computed(() => store.state.routeInfo);

onMounted(() => {
  if (routeInfo.value.from?.name === "eventSingle") return;
  store.commit("eventFavorite/resetEvents");
});
</script>

<template>
  <v-container>
    <v-row v-if="events">
      <!-- Main content -->
      <v-col cols="12">
        <page-title title="Favourite"></page-title>

        <!-- Event Card Feed -->
        <event-infinite
          :events="events"
          :grid="{ sm: 6, md: 4 }"
          source="favorite"
          type="has-header"
          @fetch-events="loadEvents"
        ></event-infinite>
      </v-col>
    </v-row>
  </v-container>
</template>

<style scoped></style>
