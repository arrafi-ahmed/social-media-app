<script setup>
import { computed, onMounted, reactive, ref } from "vue";
import { useStore } from "vuex";
import { useDisplay } from "vuetify";
import FindEventForm from "@/components/FindEventForm.vue";
import CategoryList from "@/components/CategoryList.vue";
import EventsUpcoming from "@/components/EventsUpcoming.vue";
import EventInfinite from "@/components/EventInfinite.vue";

const { mobile } = useDisplay();
const store = useStore();
const events = computed(() => store.state.eventBrowse.events);
const upcomingEvents = computed(() => store.state.eventBrowse.upcomingEvents);

const mountedEventCategories = computed(
  () => store.getters["eventBrowse/getMountedEventCategories"]
);

let filterActive = ref("none");
const findFormData = reactive({
  startDate: null,
  endDate: null,
  category: null,
});
const page = computed(() => store.state.eventBrowse.page);
const loadEvents = async ({ done }) => {
  try {
    const action = filterActive.value === "none" ? "setEvents" : "findEvents";
    const payload = {
      page: page.value,
      startDate:
        filterActive.value === "findForm" ? findFormData.startDate : null,
      endDate: filterActive.value === "findForm" ? findFormData.endDate : null,
      category: findFormData.category,
    };

    const result = await store.dispatch(`eventBrowse/${action}`, payload);
    store.commit("eventBrowse/setPage", page.value + 1);

    done(result && result.data?.payload?.length < 1 ? "empty" : "ok");
    await store.dispatch("category/setCategories");
  } catch (error) {
    done("error");
  }
};

const nullifyFindFormData = () => {
  findFormData.startDate = findFormData.endDate = findFormData.category = null;
};

const resetPageNEvents = () => {
  store.commit("eventBrowse/setPage", 1);
  store.commit("eventBrowse/resetEvents");
};

const setFindFormData = async (filterValue, formOrCategory) => {
  resetPageNEvents();

  filterActive.value = filterValue;

  if (filterValue === "findForm") {
    Object.assign(findFormData, formOrCategory);
  } else if (filterValue === "category") {
    findFormData.category = formOrCategory;
  } else if (filterValue === "none") {
    nullifyFindFormData();
  }
};

const handleFindEvents = (form) => setFindFormData("findForm", form);
const handleResetFindEvents = () => setFindFormData("none");
const handleClickCategory = (category) => setFindFormData("category", category);

const fetchData = async () => {
  resetPageNEvents();

  await store.dispatch("eventBrowse/getUpcomingEvents", {
    userId: store.getters["cuser/getCurrentUserId"],
    source: "friends",
  });
};

const routeInfo = computed(() => store.state.routeInfo);

onMounted(() => {
  if (routeInfo.value.from?.name === "eventSingle") return;
  fetchData();
});
</script>

<template>
  <v-row :no-gutters="!!mobile">
    <!-- Sidebar -->
    <v-col
      :class="{ 'flex-sticky top-60': !mobile }"
      cols="12"
      md="3"
      order-md="2"
    >
      <!--        for mobile screen-->
      <div v-if="mobile">
        <v-expansion-panels class="mb-4 expansion-pa-0" variant="popout">
          <v-expansion-panel>
            <v-expansion-panel-title>Event Categories</v-expansion-panel-title>
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
          <v-expansion-panel>
            <v-expansion-panel-title>Find Events</v-expansion-panel-title>
            <v-expansion-panel-text>
              <find-event-form
                @find-events="handleFindEvents"
                @reset-find-events="handleResetFindEvents"
              ></find-event-form>
            </v-expansion-panel-text>
          </v-expansion-panel>
        </v-expansion-panels>
      </div>

      <!--        for large screen-->
      <div v-else>
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
    <v-col cols="12" md="9" order-md="1">
      <!-- Filter Form -->
      <find-event-form
        v-if="!mobile"
        @find-events="handleFindEvents"
        @reset-find-events="handleResetFindEvents"
      ></find-event-form>

      <!-- Event Posts Feed -->
      <event-infinite
        :events="events"
        :grid="{ sm: 6 }"
        source="browse"
        type="has-header"
        @fetch-events="loadEvents"
      >
      </event-infinite>
    </v-col>
  </v-row>
</template>

<style>
.expansion-pa-0 .v-expansion-panel-text__wrapper {
  padding: 0;
}
</style>
