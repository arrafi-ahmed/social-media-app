<script setup>
import { computed, onMounted, ref } from "vue";
import { useStore } from "vuex";
import Event from "@/model/event";
import PageTitle from "@/components/PageTitle.vue";
import { useDisplay } from "vuetify";
import EventInfinite from "@/components/EventInfinite.vue";

const { mobile } = useDisplay();
const store = useStore();

const allEventCategories = computed(() =>
  store.state.category.categories.map((item) => item.name)
);
const events = computed(() => store.state.eventWishlist.events);
const dialog = ref(false);

const form = ref(null);
const isFormValid = ref(true);

const newEventTitle = ref(null);
const newEventLocation = ref(null);
const newEventDescription = ref(null);
const newEventSelectedCategory = ref(null);

const addNewEvent = async () => {
  await form.value.validate();
  if (!isFormValid.value) return;

  const event = new Event(
    newEventTitle.value,
    null,
    null,
    null,
    newEventLocation.value,
    newEventDescription.value,
    newEventSelectedCategory.value,
    null,
    null,
    null
  );
  store
    .dispatch("eventWishlist/addEvent", event)
    .then((response) => {
      dialog.value = false;
    })
    .catch((err) => {});
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

onMounted(() => {
  if (routeInfo.value.from?.name === "wishlistSingle") return;
  store.commit("eventWishlist/resetEvents");
  store.dispatch("category/setCategories");
});
</script>

<template>
  <v-row v-if="events">
    <!-- Main content -->
    <v-col cols="12">
      <page-title title="Wishlist">
        <v-dialog v-model="dialog" width="600">
          <template v-slot:activator="{ props }">
            <v-btn
              v-if="mobile"
              color="primary"
              density="compact"
              icon="mdi-plus-circle-outline"
              v-bind="props"
              variant="text"
            >
            </v-btn>
            <v-btn v-else color="primary" v-bind="props"> Add Event</v-btn>
          </template>

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
                  v-model="newEventTitle"
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
                  v-model="newEventLocation"
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
                  v-model="newEventDescription"
                  :rules="[
                    (v) => !!v || 'Description is required!',
                    (v) =>
                      (v && v.length <= 1000) ||
                      'Must not exceed 1000 characters',
                  ]"
                  class="mt-2 text-pre-wrap"
                  clearable
                  hide-details="auto"
                  label="Description"
                  rows="5"
                  variant="solo"
                ></v-textarea>

                <v-select
                  v-model="newEventSelectedCategory"
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
</template>

<style scoped></style>
