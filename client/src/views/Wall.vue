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
import DatePicker from "@/components/DatePicker.vue";
import { isValidImage, toLocalISOString } from "@/util";

const { mobile } = useDisplay();
const route = useRoute();
const router = useRouter();
const store = useStore();

const currentUser = store.getters["cuser/getCurrentUser"];
const isAdmin = store.getters["cuser/isAdmin"];
const dialog = ref(false);

const newEventInit = {
  title: null,
  location: null,
  description: null,
  selectedCategory: null,
  date: new Date(),
  startTime: "00:00",
  endTime: "23:59",
  images: [],
};

const newEvent = reactive({ ...newEventInit });
const form = ref(null);
const isFormValid = ref(true);

const handleCoverImageChange = (file) => {
  newEvent.images[0] = file;
};

const handleEventImageChange = (files) => {
  if (newEvent.images.length === 0) newEvent.images.push(null);
  newEvent.images.splice(1, 0, ...files);
};
const isSubscriptionValid = computed(
  () => store.getters["subscription/isSubscriptionValid"]
);
const openAddEventDialog = async () => {
  await store.dispatch("subscription/fetchPremiumSubscriptionData", {
    userId: currentUser.id,
  });
  if (!isSubscriptionValid.value) {
    return router.push({ name: "pricing" });
  }
  Object.assign(newEvent, { ...newEventInit, images: [] });
  dialog.value = !dialog.value;
};

const addEvent = async () => {
  if (!isSubscriptionValid.value) {
    return router.push({ name: "pricing" });
  }
  await form.value.validate();
  if (!isFormValid.value) return;
  const formData = new FormData();
  formData.append("title", newEvent.title);
  formData.append("date", toLocalISOString(newEvent.date).slice(0, 10));
  formData.append("start_time", newEvent.startTime);
  formData.append("end_time", newEvent.endTime);
  formData.append("location", newEvent.location);
  formData.append("description", newEvent.description);
  formData.append("category", newEvent.selectedCategory);
  newEvent.images.forEach((file) => {
    formData.append("files", file);
  });
  formData.append("is_featured", false);

  store.dispatch("eventWall/addEvent", formData).then(() => {
    dialog.value = false;
  });
};
const events = computed(() => store.state.eventWall.events);
const user = computed(() => store.state.eventWall.user);
const featuredEvent = computed(() => store.state.eventWall.featuredEvent);
const allEventCategories = computed(() =>
  store.state.category.categories.map((item) => item.name)
);
const upcomingEvents = computed(() => store.state.eventWall.upcomingEvents);
const mountedEventCategories = computed(
  () => store.getters["eventWall/getMountedEventCategories"]
);

let filterActive = ref("none");
const findFormData = reactive({
  searchKeyword: null,
  startDate: null,
  endDate: null,
  category: null,
});
let prevPage = 0;
const page = computed(() => store.state.eventWall.page);

const loadEvents = async ({ done }) => {
  try {
    const action = filterActive.value === "none" ? "setEvents" : "findEvents";

    //hotfix for wall events page-1 fetched twice while reloading page
    if (action === "setEvents" && prevPage == page.value) return;
    prevPage = page.value;

    const payload = {
      userId: route.params.id,
      page: page.value,
      searchKeyword:
        filterActive.value === "findForm" ? findFormData.searchKeyword : null,
      startDate:
        filterActive.value === "findForm" ? findFormData.startDate : null,
      endDate: filterActive.value === "findForm" ? findFormData.endDate : null,
      category: findFormData.category,
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
onMounted(async () => {
  if (routeInfo.value.from?.name === "eventSingle") return;
  await fetchData();
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
        @click="openAddEventDialog"
      >
      </v-btn>
      <v-btn
        v-else-if="!mobile && route.params.id == currentUser.id"
        color="primary"
        @click="openAddEventDialog"
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

    <v-dialog
      v-if="route.params.id == currentUser.id"
      v-model="dialog"
      width="600"
    >
      <v-card>
        <v-card-title>
          <span>Add Event</span>
        </v-card-title>
        <v-card-text>
          <v-form
            ref="form"
            v-model="isFormValid"
            fast-fail
            @submit.prevent="addEvent"
          >
            <v-text-field
              v-model="newEvent.title"
              :rules="[
                (v) => !!v || 'Title is required!',
                (v) => (v && v.length <= 50) || 'Must not exceed 50 characters',
              ]"
              class="mt-2"
              clearable
              density="compact"
              hide-details="auto"
              label="Title"
              required
              variant="solo"
            ></v-text-field>

            <v-text-field
              v-model="newEvent.location"
              :rules="[
                (v) => !!v || 'Location is required!',
                (v) => (v && v.length <= 50) || 'Must not exceed 50 characters',
              ]"
              class="mt-2"
              clearable
              density="compact"
              hide-details="auto"
              label="Location"
              required
              variant="solo"
            ></v-text-field>

            <v-textarea
              v-model="newEvent.description"
              :rules="[
                (v) => !!v || 'Description is required!',
                (v) =>
                  (v && v.length <= 1000) || 'Must not exceed 1000 characters',
              ]"
              class="mt-2 text-pre-wrap"
              clearable
              hide-details="auto"
              label="Description"
              rows="5"
              variant="solo"
            ></v-textarea>
            <v-row :no-gutters="!!mobile">
              <v-col class="mt-2" cols="12" md="6">
                <v-select
                  v-model="newEvent.selectedCategory"
                  :items="allEventCategories"
                  :rules="[(v) => !!v || 'Category is required!']"
                  clearable
                  density="compact"
                  hide-details
                  label="Category"
                  required
                  variant="solo"
                ></v-select>
              </v-col>
              <v-col class="mt-2" cols="12" md="6">
                <date-picker
                  v-model="newEvent.date"
                  :rules="[(v) => !!v || 'Date is required!']"
                  color="primary"
                  label="Date"
                  variant="solo"
                ></date-picker>
              </v-col>
            </v-row>
            <v-row :no-gutters="!!mobile" class="mt-md-n1">
              <v-col class="mt-2 mt-md-0" cols="12" md="6">
                <v-text-field
                  v-model="newEvent.startTime"
                  :rules="[(v) => !!v || 'Start Time is required!']"
                  density="compact"
                  hide-details="auto"
                  label="Start Time"
                  required
                  type="time"
                  variant="solo"
                ></v-text-field>
              </v-col>
              <v-col class="mt-2 mt-md-0" cols="12" md="6">
                <v-text-field
                  v-model="newEvent.endTime"
                  :rules="[(v) => !!v || 'End Time is required!']"
                  density="compact"
                  hide-details="auto"
                  label="End Time"
                  required
                  type="time"
                  variant="solo"
                ></v-text-field>
              </v-col>
            </v-row>

            <v-file-input
              :rules="[
                (v) =>
                  newEvent.images.length === 0 ||
                  (Array.isArray(v) ? v : [v]).every(
                    (file) => file.size <= 25 * 1024 * 1024
                  ) ||
                  'Max file size is 25MB!',
                (v) =>
                  (Array.isArray(v) ? v : [v]).every((file) =>
                    isValidImage(file)
                  ) || 'Only jpeg/png allowed!',
                (v) =>
                  newEvent.images.length === 0 ||
                  newEvent.images[0] ||
                  'Cover image required!',
              ]"
              accept="image/*"
              class="mt-2"
              clearable
              density="compact"
              hide-details="auto"
              label="Upload Cover Image"
              prepend-icon=""
              prepend-inner-icon="mdi-camera"
              show-size
              variant="solo"
              @update:modelValue="handleCoverImageChange"
              @click:clear="newEvent.images.splice(0, 1, null)"
            >
              <template v-slot:selection="{ fileNames }">
                <v-chip
                  v-if="newEvent.images[0]"
                  class="me-2"
                  color="primary"
                  label
                  size="small"
                >
                  {{ newEvent.images[0].name }} ({{
                    newEvent.images[0].size / 1000
                  }}
                  KB)
                </v-chip>
              </template>
            </v-file-input>

            <v-file-input
              :rules="[
                (v) =>
                  newEvent.images.length === 0 ||
                  (Array.isArray(v) ? v : [v]).every(
                    (file) => file.size <= 25 * 1024 * 1024
                  ) ||
                  'Max file size is 25MB!',
                (v) => newEvent.images.length <= 5 || 'Max 4 images allowed!',
                //  newEvent.images =5 but event images =4
                (v) =>
                  (Array.isArray(v) ? v : [v]).every((file) =>
                    isValidImage(file)
                  ) || 'Only jpeg/png allowed!',
              ]"
              accept="image/*"
              class="mt-2"
              clearable
              density="compact"
              hide-details="auto"
              hint="Upload up to 4 images"
              label="Upload Images"
              multiple
              persistent-hint
              prepend-icon=""
              prepend-inner-icon="mdi-camera"
              show-size
              variant="solo"
              @update:modelValue="handleEventImageChange"
              @click:clear="newEvent.images.splice(1, 4)"
            >
              <template v-slot:selection="{ fileNames }">
                <template
                  v-for="(image, index) in newEvent.images"
                  :key="index"
                >
                  <v-chip
                    v-if="index > 0 && image"
                    class="me-2"
                    color="primary"
                    label
                    size="small"
                  >
                    {{ image.name }} ({{ Math.round(image.size / 1000) }} KB)
                  </v-chip>
                </template>
              </template>
            </v-file-input>

            <v-card-actions>
              <v-spacer></v-spacer>
              <v-btn
                :density="mobile ? 'compact' : 'default'"
                color="primary"
                type="submit"
                >Add
              </v-btn>
            </v-card-actions>
          </v-form>
        </v-card-text>
      </v-card>
    </v-dialog>
  </v-container>
</template>

<style scoped></style>
