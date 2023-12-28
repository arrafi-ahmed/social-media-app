<script setup>
import { to12hTime } from "@/util";
import { useRouter } from "vue-router";
import { useStore } from "vuex";
import { computed, reactive, ref } from "vue";
import { useDisplay } from "vuetify";

const { mobile } = useDisplay();
const store = useStore();
const router = useRouter();
const { event } = defineProps(["event"]);

const currentUser = computed(() => store.getters["cuser/getCurrentUser"]);
// const isAdmin = computed(() => store.getters["cuser/isAdmin"]);
// const isOwner = computed(() => event.user_id == currentUser.value.id);
// const featuredEvent = computed(
//   () => store.getters["eventWall/getFeaturedEvent"]
// );
const editEventDialog = ref(false);
const editingEvent = reactive({});
const allEventCategories = computed(() =>
  store.state.category.categories.map((item) => item.name)
);
// const handleEventImageChange = (files) => {
//   files.forEach((item) => editingEvent.images.push(item));
// };
const openEditEventDialog = (event) => {
  editEventDialog.value = true;
  Object.assign(editingEvent, event);
  // editingEvent.images = []; //reset image array everytime open dialog
  // editingEvent.date = new Date(event.date).toISOString().split("T")[0];
};

const form = ref(null);
const isFormValid = ref(true);

const handleSubmitEditEvent = async (event) => {
  await form.value.validate();
  if (!isFormValid.value) return;

  const formData = new FormData();
  formData.append("id", editingEvent.id);
  formData.append("title", editingEvent.title);
  formData.append("location", editingEvent.location);
  formData.append("description", editingEvent.description);
  formData.append("category", editingEvent.category);

  store.dispatch("eventWishlist/editEvent", editingEvent).then((res) => {
    editEventDialog.value = false;
  });
};

const deleteEvent = (eventId) => {
  store.dispatch("eventWishlist/deleteEvent", eventId);
};
</script>

<template>
  <v-sheet
    v-if="event"
    :elevation="3"
    class="bg-grey-lighten-4 position-relative rounded"
  >
    <v-menu>
      <template v-slot:activator="{ props: menuProps }">
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
          density="compact"
          link
          @click="() => openEditEventDialog(event)"
        >
          <v-list-item-title>Edit</v-list-item-title>
        </v-list-item>

        <v-list-item density="compact" link @click="deleteEvent(event.id)">
          <v-list-item-title>Delete</v-list-item-title>
        </v-list-item>
      </v-list>
    </v-menu>

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
            name: 'wishlistSingle',
            params: { id: event.id },
          }"
          class="mt-4"
          density="comfortable"
          variant="tonal"
          >More Details
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
          @submit.prevent="handleSubmitEditEvent(event)"
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
