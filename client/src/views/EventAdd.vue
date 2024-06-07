<script setup>
import DatePicker from "@/components/DatePicker.vue";
import { computed, onMounted, reactive, ref } from "vue";
import { useRoute, useRouter } from "vue-router";
import { isValidImage, toLocalISOString } from "@/util";
import { useStore } from "vuex";
import PageTitle from "@/components/PageTitle.vue";
import { useDisplay } from "vuetify";

const { mobile } = useDisplay();
const route = useRoute();
const router = useRouter();
const store = useStore();

const currentUser = store.getters["cuser/getCurrentUser"];
const isSubscriptionValid = computed(
  () => store.getters["subscription/isSubscriptionValid"]
);
const allEventCategories = computed(() =>
  store.state.category.categories.map((item) => item.name)
);
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
const handleCoverImageChange = (file) => {
  newEvent.images[0] = file;
};

const handleEventImageChange = (files) => {
  if (newEvent.images.length === 0) newEvent.images.push(null);
  newEvent.images.splice(1, 0, ...files);
};

const form = ref(null);
const isFormValid = ref(true);

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
    router.push({ name: "wall", params: { id: currentUser.id } });
  });
};

onMounted(async () => {
  await store.dispatch("subscription/fetchPremiumSubscriptionData", {
    userId: currentUser.id,
  });
  if (!isSubscriptionValid.value) {
    return router.push({ name: "pricing" });
  }
  Object.assign(newEvent, { ...newEventInit, images: [] });
  await store.dispatch("category/setCategories");
});
</script>

<template>
  <v-container>
    <page-title title="Add Event">
      <v-btn
        icon="mdi-arrow-left"
        variant="text"
        @click="$router.back()"
      ></v-btn>
    </page-title>
    <v-row align="center" justify="center">
      <v-col cols="12" md="8" sm="10">
        <div v-if="route.params.id == currentUser.id">
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
              <template v-slot:selection="{}">
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
                    {{ image.name }} ({{ Math.round(image.size / 1000) }}
                    KB)
                  </v-chip>
                </template>
              </template>
            </v-file-input>

            <v-row justify="end">
              <v-col cols="auto">
                <v-btn
                  :density="mobile ? 'comfortable' : 'default'"
                  class="mt-5"
                  color="primary"
                  type="submit"
                  variant="flat"
                  >Add
                </v-btn>
              </v-col>
            </v-row>
          </v-form>
        </div>
      </v-col>
    </v-row>
  </v-container>
</template>

<style scoped></style>
