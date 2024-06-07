<script setup>
import { computed, onMounted, ref } from "vue";
import { useStore } from "vuex";
import PageTitle from "@/components/PageTitle.vue";
import { useDisplay } from "vuetify";
import EventInfinite from "@/components/EventInfinite.vue";
import { useRouter } from "vue-router";

const { mobile } = useDisplay();
const store = useStore();

const events = computed(() => store.state.eventWishlist.events);
const dialog = ref(false);
const router = useRouter();
const currentUser = store.getters["cuser/getCurrentUser"];

const page = computed(() => store.state.eventWishlist.page);

const loadEvents = async ({ done }) => {
  try {
    const payload = { page: page.value };
    const result = await store.dispatch("eventWishlist/setEvents", payload);
    store.commit("eventWishlist/setPage", page.value + 1);
    done(result && result.data?.payload?.length < 1 ? "empty" : "ok");
  } catch (error) {
    done("error");
  }
};
const routeInfo = computed(() => store.state.routeInfo);
const openAddEvent = () => {
  router.push({ name: "wishlistAdd", params: { id: currentUser.id } });
};
onMounted(() => {
  if (routeInfo.value.from?.name === "wishlistSingle") return;
  // store.commit("eventWishlist/resetEvents");
  store.dispatch("category/setCategories");
});
</script>

<template>
  <v-container>
    <v-row v-if="events">
      <!-- Main content -->
      <v-col cols="12">
        <page-title title="Wishlist">
          <v-btn
            v-if="mobile"
            color="primary"
            density="compact"
            icon="mdi-plus-circle-outline"
            v-bind="props"
            variant="text"
            @click="openAddEvent"
          >
          </v-btn>
          <v-btn v-else color="primary" @click="openAddEvent">
            Add Event
          </v-btn>
        </page-title>

        <!-- Event Card Feed -->
        <event-infinite
          :events="events"
          :grid="{ sm: 6, md: 4 }"
          source="wishlist"
          type="headerless"
          @fetch-events="loadEvents"
        ></event-infinite>
      </v-col>
    </v-row>
  </v-container>
</template>

<style scoped></style>
