<script setup>
import {
  getEventImageUrl,
  isObjEmpty,
  isValidImage,
  toLocalISOString,
} from "@/util";
import { computed, onMounted, reactive, ref } from "vue";
import { useStore } from "vuex";
import DatePicker from "@/components/DatePicker.vue";
import { useRoute, useRouter } from "vue-router";
import PageTitle from "@/components/PageTitle.vue";
import { useDisplay } from "vuetify";

const { mobile } = useDisplay();
const route = useRoute();
const router = useRouter();
const store = useStore();
const editingEvent = reactive({
  id: null,
  title: null,
  location: null,
  description: null,
  category: null,
  date: null,
  start_time: null,
  end_time: null,
  images: [],
  rmImages: [],
});
const form = ref(null);
const isFormValid = ref(true);
const getInputLabel = (n) => (n === 1 ? "Upload Cover" : "Upload Image");

const imagesClone = ref([]);
const allEventCategories = computed(() =>
  store.state.category.categories.map((item) => item.name)
);
const storeModule = computed(() =>
  route.fullPath.includes("browse")
    ? "eventBrowse"
    : route.fullPath.includes("wall")
    ? "eventWall"
    : null
);
const currentUser = computed(() => store.getters["cuser/getCurrentUser"]);
const storedEditingEvent = computed(
  () => store.state[`${storeModule.value}`].editingEvent
);
const handleImageClear = (index) => {
  imagesClone.value.splice(index, 1, null);
};
const handleUploadClear = (index) => {
  editingEvent.newUploads.splice(index, 1, null);
};
const handleEventUploadChange = (index, files) => {
  editingEvent.newUploads.splice(index, 1, files);
};
const handleSubmitEditEvent = async () => {
  await form.value.validate();
  if (!isFormValid.value) return;

  const formData = new FormData();
  formData.append("id", editingEvent.id);
  formData.append("title", editingEvent.title);
  formData.append("date", toLocalISOString(editingEvent.date).slice(0, 10));
  formData.append("start_time", editingEvent.start_time);
  formData.append("end_time", editingEvent.end_time);
  formData.append("location", editingEvent.location);
  formData.append("description", editingEvent.description);
  formData.append("category", editingEvent.category);

  editingEvent.newUploads.forEach((item, index) => {
    if (item instanceof File) {
      formData.append("files", item);
      editingEvent.newUploads[index] = "new";
      if (editingEvent.images?.[index]) {
        editingEvent.rmImages.push(editingEvent.images[index]);
      }
    } else if (
      editingEvent.images?.[index] &&
      (!imagesClone.value?.[index] || item)
    ) {
      editingEvent.rmImages.push(editingEvent.images[index]);
    } else if (item === null && imagesClone.value?.[index]) {
      editingEvent.newUploads[index] = imagesClone.value[index];
    }
  });
  formData.append("newUploads", JSON.stringify(editingEvent.newUploads));
  formData.append("rmImages", JSON.stringify(editingEvent.rmImages));
  store
    .dispatch(`${storeModule.value}/editEvent`, formData)
    .then(() =>
      route.fullPath.includes("browse")
        ? router.push({ name: "browse" })
        : route.fullPath.includes("wall")
        ? router.push({ name: "wall", params: { id: currentUser.value.id } })
        : null
    );
};

onMounted(async () => {
  if (isObjEmpty(storedEditingEvent.value)) {
    await store.dispatch(
      `${storeModule.value}/setEditingEvent`,
      route.params.eventId
    );
  }
  Object.assign(editingEvent, {
    ...storedEditingEvent.value,
    date: new Date(storedEditingEvent.value.date),
  });
  imagesClone.value = [...editingEvent.images];
  editingEvent.newUploads = [null, null, null, null, null]; //reset image array everytime open dialog
  editingEvent.rmImages = []; //reset rmImages array everytime open dialog
});
</script>

<template>
  <v-container>
    <page-title title="Edit Event">
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
          @submit.prevent="handleSubmitEditEvent"
        >
          <v-text-field
            v-model="editingEvent.title"
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
            v-model="editingEvent.location"
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
            v-model="editingEvent.description"
            :rules="[
              (v) => !!v || 'Description is required!',
              (v) =>
                (v && v.length <= 1000) || 'Must not exceed 1000 characters',
            ]"
            class="mt-2"
            clearable
            hide-details="auto"
            label="Description"
            rows="5"
            variant="solo"
          ></v-textarea>
          <v-row :no-gutters="!!mobile">
            <v-col class="mt-2" cols="12" md="6">
              <v-select
                v-model="editingEvent.category"
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
                v-model="editingEvent.date"
                :rules="[(v) => !!v || 'Date is required!']"
                color="primary"
                label="Date"
                variant="solo"
              ></date-picker>
            </v-col>
          </v-row>

          <v-row :no-gutters="!!mobile">
            <v-col class="mt-2 mt-md-n3" cols="12" md="6">
              <v-text-field
                v-model="editingEvent.start_time"
                :rules="[(v) => !!v || 'Start Time is required!']"
                density="compact"
                hide-details="auto"
                label="Start Time"
                required
                type="time"
                variant="solo"
              ></v-text-field>
            </v-col>
            <v-col class="mt-2 mt-md-n3" cols="12" md="6">
              <v-text-field
                v-model="editingEvent.end_time"
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

          <v-row align="center" class="mt-1" justify="center" no-gutters>
            <v-col v-for="n in 5" :key="n" class="mt-2" cols="12" sm="4">
              <v-img
                :src="getEventImageUrl(imagesClone[n - 1])"
                aspect-ratio="2"
                class="position-relative mx-1"
                cover
              >
                <v-btn
                  v-if="imagesClone[n - 1]"
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
                :label="
                  !editingEvent.newUploads?.[n - 1] ? getInputLabel(n) : ''
                "
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
                prepend-icon=""
                prepend-inner-icon="mdi-camera"
                variant="solo-filled"
                @update:modelValue="handleEventUploadChange(n - 1, $event)"
                @click:clear="handleUploadClear(n - 1)"
              >
                <template v-slot:selection="{}">
                  {{ n === 1 ? "New Cover" : "New Image " + n }}
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
