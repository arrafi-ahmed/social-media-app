<script setup>
import { computed, onMounted, reactive, ref } from "vue";
import { useStore } from "vuex";
import PageTitle from "@/components/PageTitle.vue";
import { useDisplay } from "vuetify";
import EventInfinite from "@/components/EventInfinite.vue";
import { isValidImage } from "@/util";
import { useRouter } from "vue-router";

const { mobile } = useDisplay();
const store = useStore();
const router = useRouter();

const allEventCategories = computed(() =>
  store.state.category.categories.map((item) => item.name)
);
const events = computed(() => store.state.eventWishlist.events);
const dialog = ref(false);

const form = ref(null);
const isFormValid = ref(true);

const currentUser = store.getters["cuser/getCurrentUser"];
const newEventInit = {
  title: null,
  location: null,
  description: null,
  category: null,
  images: [],
};
const newEvent = reactive({ ...newEventInit });
const isSubscriptionValid = computed(
  () => store.getters["subscription/isSubscriptionValid"]
);
const addNewEvent = async () => {
  if (!isSubscriptionValid.value) {
    return router.push({ name: "pricing" });
  }
  await form.value.validate();
  if (!isFormValid.value) return;

  const formData = new FormData();
  formData.append("title", newEvent.title);
  formData.append("location", newEvent.location);
  formData.append("description", newEvent.description);
  formData.append("category", newEvent.selectedCategory);
  if (newEvent.images.length > 0) {
    newEvent.images.forEach((item) => {
      formData.append("files", item);
    });
  }
  store.dispatch("eventWishlist/addEvent", formData).then(() => {
    dialog.value = false;
  });
};
const handleEventImageChange = (files) => {
  files.forEach((file) => {
    newEvent.images.push(file);
  });
};

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
            @click="openAddEventDialog"
          >
          </v-btn>
          <v-btn
            v-else
            color="primary"
            v-bind="props"
            @click="openAddEventDialog"
          >
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

  <v-dialog v-model="dialog" width="600">
    <template v-slot:activator="{ props }"></template>

    <v-card>
      <v-card-title>
        <span>Add Wishlist Event</span>
      </v-card-title>
      <v-card-text>
        <v-form
          ref="form"
          v-model="isFormValid"
          fast-fail
          @submit.prevent="addNewEvent"
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

          <v-select
            v-model="newEvent.selectedCategory"
            :items="allEventCategories"
            :rules="[(v) => !!v || 'Category is required!']"
            class="mt-2"
            clearable
            density="compact"
            hide-details
            label="Category"
            variant="solo"
          ></v-select>

          <v-file-input
            :rules="[
              (v) =>
                newEvent.images.length === 0 ||
                (Array.isArray(v) ? v : [v]).every(
                  (file) => file.size <= 25 * 1024 * 1024
                ) ||
                'Max file size is 25MB!',
              (v) => newEvent.images.length <= 2 || 'Max 2 images allowed!',
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
            hint="Upload up to 2 images"
            label="Upload Images"
            multiple
            persistent-hint
            prepend-icon=""
            prepend-inner-icon="mdi-camera"
            show-size
            variant="solo"
            @update:modelValue="handleEventImageChange"
            @click:clear="newEvent.images = []"
          >
            <template v-slot:selection="{ fileNames }">
              <template v-for="(image, index) in newEvent.images" :key="index">
                <v-chip class="me-2" color="primary" label size="small">
                  {{ image.name }}
                </v-chip>
              </template>
            </template>
          </v-file-input>

          <v-card-actions>
            <v-spacer></v-spacer>
            <v-btn
              :density="mobile ? 'comfortable' : 'default'"
              color="primary"
              type="submit"
              >Add
            </v-btn>
          </v-card-actions>
        </v-form>
      </v-card-text>
    </v-card>
  </v-dialog>
</template>

<style scoped></style>
