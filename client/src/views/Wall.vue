<script setup>
import { computed, onMounted, reactive, ref, watch } from "vue";
import { useRoute, useRouter } from "vue-router";
import { useStore } from "vuex";
import { useDisplay } from "vuetify";
import NameCard from "@/components/NameCard.vue";
import FindEventForm from "@/components/FindEventForm.vue";
import EventFeatured from "@/components/EventFeatured.vue";
import CategoryList from "@/components/CategoryList.vue";
import EventsUpcoming from "@/components/EventsUpcoming.vue";
import EventInfinite from "@/components/EventInfinite.vue";
import { isObjEmpty } from "@/util";

const { mobile } = useDisplay();
const route = useRoute();
const router = useRouter();
const store = useStore();

const currentUser = store.getters["cuser/getCurrentUser"];
const isAdmin = store.getters["cuser/isAdmin"];
const isSubscriptionValid = computed(
  () => store.getters["subscription/isSubscriptionValid"]
);
const openAddEvent = async () => {
  await store.dispatch("subscription/fetchPremiumSubscriptionData", {
    userId: currentUser.id,
  });
  if (!isSubscriptionValid.value) return router.push({ name: "pricing" });
  else return router.push({ name: "eventAdd" });
};

const events = computed(() => store.state.eventWall.events);
const user = computed(() => store.state.eventWall.user);
const featuredEvent = computed(() => store.state.eventWall.featuredEvent);
const upcomingEvents = computed(() => store.state.eventWall.upcomingEvents);
const mountedEventCategories = computed(
  () => store.getters["eventWall/getMountedEventCategories"]
);

const settings = computed(() => store.state.cuser.settings);
if (isObjEmpty(settings.value?.sort)) {
  store.dispatch("cuser/setUserSettings");
}

let filterActive = ref("none");
const findFormData = reactive({
  searchKeyword: null,
  startDate: null,
  endDate: null,
  category: null,
  sort: settings.value?.sort,
});
const page = computed(() => store.state.eventWall.page);

const loadEvents = async ({ done }) => {
  try {
    const action =
      filterActive.value === "findForm" ? "findEvents" : "setEvents";

    const payload = {
      userId: route.params.id,
      searchKeyword:
        filterActive.value === "findForm" ? findFormData.searchKeyword : null,
      startDate:
        filterActive.value === "findForm" ? findFormData.startDate : null,
      endDate: filterActive.value === "findForm" ? findFormData.endDate : null,
      category: findFormData.category,
      sort: findFormData.sort,
      page: page.value,
    };
    const result = await store.dispatch(`eventWall/${action}`, payload);
    store.commit("eventWall/setPage", page.value + 1);

    done(result && result.data?.payload?.length < 1 ? "empty" : "ok");
    await store.dispatch("category/setCategories");
  } catch (error) {
    done("error");
  }
};

const nullifyFindFormData = () => {
  findFormData.searchKeyword =
    findFormData.startDate =
    findFormData.endDate =
    findFormData.category =
      null;
};

const resetPageNEvents = () => {
  store.commit("eventWall/setPage", 1);
  store.commit("eventWall/resetEvents");
};

const setFindFormData = async (filterValue, formOrCategory) => {
  resetPageNEvents();

  filterActive.value = filterValue;
  if (filterValue === "findForm") {
    Object.assign(findFormData, formOrCategory);
  } else if (filterValue === "none") {
    nullifyFindFormData();
  }
};

const handleResetFindEvents = () => setFindFormData("none");
const handleFindEvents = (form) => setFindFormData("findForm", form);
const handleClickCategory = (category) => setFindFormData("findForm", category);
const handleSort = (form) => {
  setFindFormData("findForm", form);
  store.dispatch("cuser/updateSettings", {
    ...settings.value,
    sort: form.sort,
  });
};

const fetchData = async () => {
  resetPageNEvents();
  const validFriends =
    route.params.id == currentUser.id
      ? true
      : await store
          .dispatch("cuser/checkFriends", route.params.id)
          .then((result) => result.data.payload);

  if (validFriends || isAdmin) {
    await Promise.all([
      store.dispatch("eventWall/getUserById", route.params.id),
      store.dispatch("eventWall/getFeaturedEvent", route.params.id),
      store.dispatch("eventWall/getUpcomingEvents", {
        userId: route.params.id,
        source: "own",
      }),
    ]);
  } else {
    await router.push({
      name: "notFound",
      params: {
        status: 401,
        message: "You don't have access to the profile!",
      },
    });
  }
};

const routeInfo = computed(() => store.state.routeInfo);
onMounted(() => {
  if (["eventSingle", "eventEdit-wall"].includes(routeInfo.value.from?.name))
    return;

  fetchData();
});
watch(
  () => route.params.id,
  (newItem, oldItem) => {
    if (route.name === "wall" && newItem && newItem !== oldItem) {
      fetchData();
    }
  }
);
</script>

<template>
  <v-container>
    <div class="d-flex justify-space-between align-center">
      <name-card
        :imgSize="80"
        :isDetailed="false"
        :profile="user"
        img-class="rounded-xl"
      ></name-card>

      <v-divider v-if="mobile" inset vertical></v-divider>

      <v-btn
        v-if="mobile && route.params.id == currentUser.id"
        color="primary"
        density="compact"
        icon="mdi-plus-circle-outline"
        variant="text"
        @click="openAddEvent"
      >
      </v-btn>
      <v-btn
        v-else-if="!mobile && route.params.id == currentUser.id"
        color="primary"
        @click="openAddEvent"
        >Add Event
      </v-btn>
    </div>
    <v-divider class="my-3"></v-divider>

    <v-row :no-gutters="!!mobile">
      <!-- Sidebar -->
      <v-col
        :class="{ 'flex-sticky top-60': !mobile }"
        cols="12"
        lg="3"
        order-lg="2"
      >
        <!--        for mobile screen-->
        <div v-if="mobile">
          <v-expansion-panels class="mb-4 expansion-pa-0" variant="popout">
            <v-expansion-panel>
              <v-expansion-panel-title>Featured Event</v-expansion-panel-title>
              <v-expansion-panel-text>
                <event-featured
                  v-if="featuredEvent?.id"
                  :event="featuredEvent"
                  type="headerless"
                ></event-featured>
                <div v-else>
                  <small>No featured event set</small>
                </div>
              </v-expansion-panel-text>
            </v-expansion-panel>
            <v-expansion-panel>
              <v-expansion-panel-title
                >Event Categories
              </v-expansion-panel-title>
              <v-expansion-panel-text>
                <category-list
                  :categories="mountedEventCategories"
                  :selected="findFormData.category"
                  type="headerless"
                  @click-category="handleClickCategory"
                ></category-list>
              </v-expansion-panel-text>
            </v-expansion-panel>
            <v-expansion-panel>
              <v-expansion-panel-title>Upcoming Events</v-expansion-panel-title>
              <v-expansion-panel-text>
                <events-upcoming
                  :events="upcomingEvents"
                  type="headerless"
                ></events-upcoming>
              </v-expansion-panel-text>
            </v-expansion-panel>
            <v-expansion-panel class="find-events">
              <v-expansion-panel-title>Find Events</v-expansion-panel-title>
              <v-expansion-panel-text>
                <find-event-form
                  @find-events="handleFindEvents"
                  @reset-find-events="handleResetFindEvents"
                  @sort-events="handleSort"
                ></find-event-form>
              </v-expansion-panel-text>
            </v-expansion-panel>
          </v-expansion-panels>
        </div>

        <!--        for large screen-->
        <div v-else>
          <!-- Featured event -->
          <event-featured
            v-if="featuredEvent?.id"
            :event="featuredEvent"
            type="has-header"
          ></event-featured>

          <!-- Categories Section -->
          <category-list
            :categories="mountedEventCategories"
            :selected="findFormData.category"
            type="has-header"
            @click-category="handleClickCategory"
          ></category-list>

          <!-- Upcoming Events Section -->
          <events-upcoming
            :events="upcomingEvents"
            type="has-header"
          ></events-upcoming>
        </div>
      </v-col>

      <!-- Main content -->
      <v-col cols="12" lg="9" order-lg="1">
        <!-- Filter Form -->
        <find-event-form
          v-if="!mobile"
          @find-events="handleFindEvents"
          @reset-find-events="handleResetFindEvents"
          @sort-events="handleSort"
        ></find-event-form>

        <!-- Event Posts Feed -->
        <event-infinite
          :events="events"
          :grid="{ sm: 6 }"
          source="wall"
          type="headerless"
          @fetch-events="loadEvents"
        >
        </event-infinite>
      </v-col>
    </v-row>
  </v-container>
</template>

<style scoped></style>
