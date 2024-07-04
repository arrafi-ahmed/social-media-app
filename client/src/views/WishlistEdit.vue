<script setup>
import { computed, onMounted, reactive, ref } from "vue";
import { useDisplay } from "vuetify";
import { useStore } from "vuex";
import { useRoute, useRouter } from "vue-router";
import { getEventImageUrl, isValidImage } from "@/util";
import PageTitle from "@/components/PageTitle.vue";

const { mobile } = useDisplay();
const store = useStore();

const storedEditingEvent = computed(
  () => store.state.eventWishlist.editingEvent
);
const route = useRoute();
const router = useRouter();
let imagesInit = [];
const editingEvent = reactive({});

const form = ref(null);
const isFormValid = ref(true);

const handleImageClear = (index) => {
  editingEvent.images.splice(index, 1, null);
};
const handleUploadClear = (index) => {
  if (imagesInit.value[index])
    editingEvent.images.splice(index, 1, imagesInit.value[index]);
  else editingEvent.images.splice(index, 1, null);
};
const handleEventUploadChange = (index, files) => {
  editingEvent.images.splice(index, 1, files);
};

const handleSubmitEditEvent = async () => {
  await form.value.validate();
  if (!isFormValid.value) return;

  const formData = new FormData();
  formData.append("id", editingEvent.id);
  formData.append("title", editingEvent.title);
  formData.append("location", editingEvent.location);
  formData.append("description", editingEvent.description);
  formData.append("category", editingEvent.category);
  formData.append("imagesInit", JSON.stringify(imagesInit));
  formData.append("images", JSON.stringify(editingEvent.images));

  if (editingEvent.images && Array.isArray(editingEvent.images)) {
    editingEvent.images.forEach((item) => {
      if (item && item instanceof File) formData.append("files", item);
    });
  }

  store.dispatch("eventWishlist/editEvent", formData).then(() => {
    router.push({ name: "wishlist" });
  });
};

const allEventCategories = computed(() =>
  store.state.category.categories.map((item) => item.name)
);

onMounted(async () => {
  await store.dispatch("eventWishlist/setEditingEvent", route.params.eventId);

  if (Array.isArray(storedEditingEvent.value.images)) {
    imagesInit = [...storedEditingEvent.value.images];
  } else {
    imagesInit = [];
  }

  Object.assign(editingEvent, { ...storedEditingEvent.value });
  if (storedEditingEvent.value.images?.length < 2) {
    // If there are less than two items
    imagesInit = storedEditingEvent.value.images.concat(
      Array(2 - storedEditingEvent.value.images.length).fill(null)
    ); // Fill the remaining slots with null
  }
});
</script>

<template>
  <v-container>
    <page-title title="Edit Wishlist">
      <v-btn
        icon="mdi-arrow-left"
        variant="text"
        @click="$router.back()"
      ></v-btn>
    </page-title>

    <v-row align="center" justify="center">
      <v-col cols="12" md="8" sm="10">
        <v-form
          ref="form"
          v-model="isFormValid"
          fast-fail
          @submit.prevent="handleSubmitEditEvent()"
        >
          <v-row>
            <v-col>
              <v-text-field
                v-model="editingEvent.title"
                :rules="[
                  (v) => !!v || 'Title is required!',
                  (v) =>
                    (v && v.length <= 50) || 'Must not exceed 50 characters',
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
                v-model="editingEvent.location"
                :rules="[
                  (v) => !!v || 'Location is required!',
                  (v) =>
                    (v && v.length <= 50) || 'Must not exceed 50 characters',
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
                v-model="editingEvent.description"
                :rules="[
                  (v) => !!v || 'Description is required!',
                  (v) =>
                    (v && v.length <= 1000) ||
                    'Must not exceed 1000 characters',
                ]"
                class="mt-2"
                clearable
                hide-details="auto"
                label="Description"
                rows="5"
                variant="solo"
              ></v-textarea>
              <v-select
                v-model="editingEvent.category"
                :items="allEventCategories"
                :rules="[(v) => !!v || 'Category is required!']"
                class="mt-2"
                clearable
                density="compact"
                hide-details
                label="Category"
                required
                variant="solo"
              ></v-select>
            </v-col>
          </v-row>

          <v-row align="center" class="mt-1" justify="center" no-gutters>
            <v-col v-for="n in 2" :key="n" class="mt-2" cols="12" sm="4">
              <v-img
                :src="getEventImageUrl(editingEvent.images?.[n - 1])"
                aspect-ratio="2"
                class="position-relative mx-1"
                cover
              >
                <v-btn
                  v-if="editingEvent.images?.[n - 1]"
                  class="position-absolute rounded-0"
                  color="primary"
                  density="comfortable"
                  icon="mdi-delete"
                  location="top end"
                  size="small"
                  @click="handleImageClear(n - 1)"
                >
                </v-btn>
              </v-img>

              <v-file-input
                :rules="[
                  (v) =>
                    !v ||
                    (Array.isArray(v) ? v : [v]).every(
                      (file) => file.size < 25 * 1024 * 1024
                    ) ||
                    'Max file size is 25MB!',
                  (v) =>
                    (Array.isArray(v) ? v : [v]).every((file) =>
                      isValidImage(file)
                    ) || 'Only jpeg/png allowed!',
                ]"
                accept="image/*"
                class="mx-1"
                clearable
                density="compact"
                hide-details="auto"
                label="Upload Image"
                prepend-icon=""
                prepend-inner-icon="mdi-camera"
                variant="solo-filled"
                @update:modelValue="handleEventUploadChange(n - 1, $event)"
                @click:clear="handleUploadClear(n - 1)"
              >
                <template v-slot:selection="{}">
                  {{ "New Image " + n }}
                </template>
              </v-file-input>
            </v-col>
          </v-row>

          <v-row justify="end">
            <v-col cols="auto">
              <v-btn
                :density="mobile ? 'comfortable' : 'default'"
                class="mt-5"
                color="primary"
                type="submit"
                variant="flat"
                >Confirm
              </v-btn>
            </v-col>
          </v-row>
        </v-form>
      </v-col>
    </v-row>
  </v-container>
</template>

<style scoped></style>
