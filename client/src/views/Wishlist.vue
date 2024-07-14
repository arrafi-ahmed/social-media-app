<script setup>
import { computed, onMounted, ref } from "vue";
import { useStore } from "vuex";
import PageTitle from "@/components/PageTitle.vue";
import { useDisplay } from "vuetify";
import EventInfinite from "@/components/EventInfinite.vue";
import { useRouter } from "vue-router";

const { xs } = useDisplay();
const store = useStore();

const events = computed(() => store.state.eventWishlist.events);
const router = useRouter();
const currentUser = store.getters["cuser/getCurrentUser"];

const page = computed(() => store.state.eventWishlist.page);
let isLoading = false;

const loadEvents = async ({ done }) => {
  if (isLoading) return;
  isLoading = true;
  try {
    const payload = { page: page.value };
    const result = await store.dispatch("eventWishlist/setEvents", payload);
    store.commit("eventWishlist/setPage", page.value + 1);
    done(result && result.data?.payload?.length < 1 ? "empty" : "ok");
  } catch (error) {
    done("error");
  } finally {
    isLoading = false;
  }
};
const routeInfo = computed(() => store.state.routeInfo);
const openAddEvent = () => {
  router.push({ name: "wishlistAdd", params: { id: currentUser.id } });
};
onMounted(() => {
  if (["wishlistSingle", "wishlistEdit"].includes(routeInfo.value.from?.name)) {
    if (routeInfo.value.lastScrollY)
      window.scrollTo(0, routeInfo.value.lastScrollY);
    return;
  }
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
            v-if="xs"
            color="primary"
            icon="mdi-plus-circle-outline"
            variant="text"
            tile
            rounded
            @click="openAddEvent"
          >
          </v-btn>
          <v-menu v-else>
            <template v-slot:activator="{ props: menuProps }">
              <v-btn
                rounded
                variant="text"
                icon="mdi-dots-vertical"
                location="top end"
                v-bind="menuProps"
              >
              </v-btn>
            </template>
            <v-list density="compact">
              <v-list-item link title="Add Event" @click="openAddEvent">
              </v-list-item>
            </v-list>
          </v-menu>
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
