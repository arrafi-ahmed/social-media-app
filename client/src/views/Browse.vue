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

const isAdmin = computed(() => store.getters["cuser/isAdmin"]);
const moduleName = computed(() =>
  !isAdmin.value ? "eventBrowse" : "eventWall"
);
const moduleCore = computed(() =>
  !isAdmin.value ? store.state.eventBrowse : store.state.eventWall
);
const events = computed(() => moduleCore.value.events);
const upcomingEvents = computed(() => moduleCore.value.upcomingEvents);

const mountedEventCategories = computed(
  () => store.getters[`${moduleName.value}/getMountedEventCategories`]
);

let filterActive = ref("none");
const findFormData = reactive({
  searchKeyword: null,
  startDate: null,
  endDate: null,
  category: null,
});

const page = computed(() => moduleCore.value.page);
const loadEvents = async ({ done }) => {
  try {
    const payload = {
      page: page.value,
      searchKeyword:
        filterActive.value === "findForm" ? findFormData.searchKeyword : null,
      startDate:
        filterActive.value === "findForm" ? findFormData.startDate : null,
      endDate: filterActive.value === "findForm" ? findFormData.endDate : null,
      category: findFormData.category,
    };

    const action = filterActive.value === "none" ? "setEvents" : "findEvents";

    const result = await store.dispatch(
      `${moduleName.value}/${action}`,
      payload
    );
    store.commit(`${moduleName.value}/setPage`, page.value + 1);

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
  store.commit(`${moduleName.value}/setPage`, 1);
  store.commit(`${moduleName.value}/resetEvents`);
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

  await store.dispatch(`${moduleName.value}/getUpcomingEvents`, {
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
  <v-container>
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
      <v-col cols="12" lg="9" order-lg="1">
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
  </v-container>
</template>

<style>
.expansion-pa-0 .v-expansion-panel-text__wrapper {
  padding: 0;
}
</style>
