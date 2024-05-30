<!--source = [browse, wall, favorite]-->
<script setup>
import {
  formatDateFromTimestamp,
  formatMonthYear,
  getDate,
  getEventImageUrl,
  getUserImageUrl,
  goUserProfile,
  isValidImage,
  loadEventThumb,
  to12hTime,
  toLocalISOString,
} from "@/util";
import { useRouter } from "vue-router";
import { useStore } from "vuex";
import { computed, reactive, ref } from "vue";
import { useDisplay } from "vuetify";
import DatePicker from "@/components/DatePicker.vue";

const { mobile } = useDisplay();
const store = useStore();
const router = useRouter();
const { event, type, source } = defineProps(["event", "type", "source"]);

const currentUser = computed(() => store.getters["cuser/getCurrentUser"]);
const isAdmin = computed(() => store.getters["cuser/isAdmin"]);
const isOwner = computed(() => event.user_id == currentUser.value.id);
const featuredEvent = computed(
  () => store.getters["eventWall/getFeaturedEvent"]
);
const editEventDialog = ref(false);
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
const imagesClone = ref([]);
const allEventCategories = computed(() =>
  store.state.category.categories.map((item) => item.name)
);
const getInputLabel = (n) => (n === 1 ? "Upload Cover" : "Upload Image");

const handleImageClear = (index) => {
  imagesClone.value.splice(index, 1, null);
};
const handleUploadClear = (index) => {
  editingEvent.newUploads.splice(index, 1, null);
};
const handleEventUploadChange = (index, files) => {
  editingEvent.newUploads.splice(index, 1, files);
};
const openEditEventDialog = (event) => {
  editEventDialog.value = true;
  Object.assign(editingEvent, { ...event });
  imagesClone.value = [...editingEvent.images];
  editingEvent.newUploads = [null, null, null, null, null]; //reset image array everytime open dialog
  editingEvent.rmImages = []; //reset rmImages array everytime open dialog
};
const form = ref(null);
const isFormValid = ref(true);
const storeModule = computed(() =>
  source === "browse" ? "eventBrowse" : "eventWall"
);

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
    .finally(() => (editEventDialog.value = false));
};
const deleteEvent = (eventId, images) => {
  store
    .dispatch(`${storeModule.value}/deleteEvent`, { eventId, images })
    .then(() => (editEventDialog.value = false));
};
const handleSetFeaturedEvent = (eventId) => {
  store.dispatch("eventWall/setFeaturedEvent", { eventId });
};
const handleUnsetFeaturedEvent = (eventId) => {
  store.dispatch("eventWall/unsetFeaturedEvent", { eventId });
};
const setEventNotification = (eventId) => {
  store
    .dispatch("eventWall/setEventNotification", {
      eventId: eventId,
      payload: false,
    })
    .then((res) => {
      router.push({
        name: "eventSingle",
        params: { id: event.id },
      });
    });
};
</script>

<template>
  <v-sheet v-if="event" :elevation="3" class="bg-grey-lighten-4 rounded">
    <div
      v-if="type === 'has-header'"
      class="d-flex align-center position-relative clickable pa-2"
      @click="goUserProfile(event.user_id)"
    >
      <!--      menu for browse page-->
      <v-menu v-if="(isAdmin || isOwner) && source === 'browse'">
        <template v-slot:activator="{ props: menuProps }">
          <v-btn
            class="pa-2 rounded-0"
            color="primary"
            icon="mdi-dots-vertical"
            location="top end"
            position="absolute"
            size="x-small"
            v-bind="menuProps"
            @click.stop=""
          >
          </v-btn>
        </template>
        <v-list density="compact">
          <v-list-item
            density="compact"
            link
            @click="() => openEditEventDialog(event)"
          >
            <v-list-item-title>Edit</v-list-item-title>
          </v-list-item>
          <v-list-item
            density="compact"
            link
            @click="deleteEvent(event.id, event.images)"
          >
            <v-list-item-title>Delete</v-list-item-title>
          </v-list-item>
        </v-list>
      </v-menu>

      <v-img
        :aspect-ratio="1"
        :max-width="45"
        :src="getUserImageUrl(event?.image)"
        class="rounded-circle"
        cover
      >
      </v-img>
      <div class="ml-3">
        <h4>
          {{ event?.full_name }}
        </h4>
        <small>Posted on {{ formatDateFromTimestamp(event.created_at) }}</small>
      </div>
    </div>

    <v-img
      :class="type === 'headerless' ? 'position-relative' : ''"
      :src="loadEventThumb(event?.images?.[0], event?.category)"
      aspect-ratio="1.16"
      class="clickable"
      cover
      @click="
        router.push({
          name: 'eventSingle',
          params: { id: event.id },
        })
      "
    >
      <v-chip
        v-if="event.date"
        class="mt-4 absolute bg-white high-z-index v-chip-0-padding rounded-0"
        label
        variant="text"
      >
        <div class="d-flex">
          <div class="text-overline bg-primary pa-2">
            {{ getDate(event.date) }}
          </div>
          <div class="text-overline text-primary pa-2">
            {{ formatMonthYear(event.date) }}
          </div>
        </div>
      </v-chip>

      <!--      menu for wall page-->
      <v-menu v-if="source === 'wall'">
        <template
          v-if="isAdmin || isOwner"
          v-slot:activator="{ props: menuProps }"
        >
          <v-btn
            class="pa-2 rounded-0"
            color="primary"
            icon="mdi-dots-vertical"
            location="top end"
            position="absolute"
            size="x-small"
            v-bind="menuProps"
          >
          </v-btn>
        </template>
        <v-list density="compact">
          <v-list-item
            v-if="isAdmin || isOwner"
            density="compact"
            link
            @click="() => openEditEventDialog(event)"
          >
            <v-list-item-title>Edit</v-list-item-title>
          </v-list-item>

          <v-list-item
            v-if="isAdmin || isOwner"
            density="compact"
            link
            @click="deleteEvent(event.id, event.images)"
          >
            <v-list-item-title>Delete</v-list-item-title>
          </v-list-item>

          <v-list-item
            v-if="source === 'wall' && isOwner"
            density="compact"
            link
          >
            <v-list-item-title
              v-if="featuredEvent?.id != event.id"
              @click="handleSetFeaturedEvent(event.id)"
              >Feature
            </v-list-item-title>
            <v-list-item-title
              v-else
              @click="handleUnsetFeaturedEvent(event.id)"
              >Unfeature
            </v-list-item-title>
          </v-list-item>
        </v-list>
      </v-menu>
    </v-img>

    <div class="pa-3">
      <div class="text-primary text-overline">
        {{ event.category }}
      </div>
      <h4 class="mb-2">{{ event.title }}</h4>
      <div v-if="event.start_time" class="d-flex align-center">
        <v-icon class="mr-2" color="primary" size="small">mdi-clock</v-icon>
        <span>{{ to12hTime(event.start_time) }}</span>
        <span v-if="event.end_time"> - {{ to12hTime(event.end_time) }}</span>
      </div>
      <div v-if="event.location" class="d-flex align-center">
        <v-icon class="mr-2" color="primary" size="small"
          >mdi-map-marker
        </v-icon>
        <span>{{ event.location }}</span>
      </div>

      <div class="d-flex justify-space-between">
        <v-btn
          :to="{
            name: 'eventSingle',
            params: { id: event.id },
          }"
          class="mt-4"
          density="comfortable"
          variant="tonal"
          >More Details
        </v-btn>

        <!--        only show in own wall page-->
        <v-btn
          v-if="
            event.new_notification &&
            source === 'wall' &&
            $route.params.id === currentUser?.id
          "
          icon
          variant="text"
          @click="setEventNotification(event.id)"
        >
          <v-badge color="primary" dot>
            <v-icon icon="mdi-bell-outline"></v-icon>
          </v-badge>
        </v-btn>
      </div>
    </div>
  </v-sheet>

  <v-dialog v-model="editEventDialog" width="600">
    <v-card>
      <v-card-title>
        <span>Edit Event</span>
      </v-card-title>
      <v-card-text>
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
                  size="x-small"
                  @click="handleImageClear(n - 1)"
                >
                </v-btn>
              </v-img>

              <v-file-input
                :label="!editingEvent.newUploads[n - 1] ? getInputLabel(n) : ''"
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
                <template v-slot:selection="{ fileNames }">
                  {{ n === 1 ? "New Cover" : "New Image " + n }}
                </template>
              </v-file-input>
            </v-col>
          </v-row>

          <v-card-actions>
            <v-spacer></v-spacer>
            <v-btn
              :density="mobile ? 'compact' : 'default'"
              color="primary"
              type="submit"
              >Confirm
            </v-btn>
          </v-card-actions>
        </v-form>
      </v-card-text>
    </v-card>
  </v-dialog>
</template>

<style scoped></style>
