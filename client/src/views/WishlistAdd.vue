<script setup>
import { computed, onMounted, reactive, ref } from "vue";
import { useDisplay } from "vuetify";
import { useRoute, useRouter } from "vue-router";
import { useStore } from "vuex";
import { isValidImage } from "@/util";
import PageTitle from "@/components/PageTitle.vue";

const { mobile } = useDisplay();
const route = useRoute();
const router = useRouter();
const store = useStore();

const currentUser = store.getters["cuser/getCurrentUser"];
const isSubscriptionValid = computed(
  () => store.getters["subscription/isSubscriptionValid"]
);

const form = ref(null);
const isFormValid = ref(true);

const newEventInit = {
  title: null,
  location: null,
  description: null,
  category: null,
  images: [],
};
const newEvent = reactive({ ...newEventInit });
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
    router.push({ name: "wishlist" });
  });
};
const handleEventImageChange = (files) => {
  files.forEach((file) => {
    newEvent.images.push(file);
  });
};
const allEventCategories = computed(() =>
  store.state.category.categories.map((item) => item.name)
);
onMounted(async () => {
  await store.dispatch("subscription/fetchPremiumSubscriptionData", {
    userId: currentUser.id,
  });
  if (!isSubscriptionValid.value) {
    return router.push({ name: "pricing" });
  }
  Object.assign(newEvent, { ...newEventInit, images: [] });
});
</script>

<template>
  <v-container>
    <page-title title="Add Wishlist">
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
              <template v-slot:selection="{}">
                <template
                  v-for="(image, index) in newEvent.images"
                  :key="index"
                >
                  <v-chip class="me-2" color="primary" label size="small">
                    {{ image.name }}
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
