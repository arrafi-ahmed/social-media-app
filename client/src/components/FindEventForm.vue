<script setup>
import { computed, reactive, ref } from "vue";
import { useStore } from "vuex";
import { useDisplay } from "vuetify";
import DatePicker from "@/components/DatePicker.vue";

const { mobile } = useDisplay();
const store = useStore();

const emit = defineEmits(["findEvents", "resetFindEvents", "sortEvents"]);
const form = ref(null);
const isFormValid = ref(true);
const allEventCategories = computed(() =>
  store.state.category.categories.map((item) => item.name)
);
const settings = computed(() => store.state.cuser.settings);
const findForm = reactive({
  searchKeyword: null,
  startDate: null,
  endDate: null,
  category: null,
  sort: settings.value?.sort,
});

const sortIcon = computed(() =>
  findForm.sort === "ASC"
    ? "mdi-sort-reverse-variant"
    : findForm.sort === "DESC"
    ? "mdi-sort-variant"
    : findForm.sort === "LATEST"
    ? "mdi-sort-clock-descending-outline"
    : null
);

const handleFindEvents = async () => {
  await form.value.validate();
  if (!isFormValid.value) return;

  emit("findEvents", findForm);
};
const resetForm = () => {
  form.value.reset();
  emit("resetFindEvents");
};
// let sort = ref(settings.value?.sort);
const handleSort = (sortInput) => {
  findForm.sort = sortInput;
  emit("sortEvents", findForm);
};
</script>

<template>
  <v-form
    ref="form"
    v-model="isFormValid"
    :class="{ 'flex-sticky top-60': !mobile }"
    class="bg-grey-lighten-3 rounded"
    @submit.prevent="handleFindEvents"
  >
    <v-container>
      <v-row align="center" no-gutters>
        <v-col class="d-flex" cols="12" md="10">
          <v-row no-gutters>
            <v-col cols="12" md="3">
              <v-text-field
                v-model="findForm.searchKeyword"
                class="mb-3 mb-md-0 mr-0 mr-md-2"
                clearable
                color="primary"
                density="compact"
                hide-details
                label="Search"
                variant="solo"
                @click-clear="findForm.searchKeyword = null"
              ></v-text-field>
            </v-col>
            <v-col cols="12" md="3">
              <date-picker
                v-model="findForm.startDate"
                color="primary"
                custom-class="mb-3 mb-md-0 mr-0 mr-md-2"
                label="Start Date"
                variant="solo"
                @click-clear="findForm.startDate = null"
              ></date-picker>
            </v-col>
            <v-col cols="12" md="3">
              <date-picker
                v-model="findForm.endDate"
                :rules="[
                  (v) =>
                    !findForm.startDate ||
                    !findForm.endDate ||
                    findForm.startDate < findForm.endDate ||
                    'Start Date must be less than End Date!',
                ]"
                color="primary"
                custom-class="mb-3 mb-md-0 mr-0 mr-md-2"
                label="End Date"
                variant="solo"
                @click-clear="findForm.endDate = null"
              ></date-picker>
            </v-col>
            <v-col cols="12" md="3">
              <v-select
                v-model="findForm.category"
                :items="allEventCategories"
                class="mb-3 mb-md-0 mr-0 mr-md-2"
                density="compact"
                hide-details
                label="Category"
                variant="solo"
              ></v-select>
            </v-col>
          </v-row>
        </v-col>
        <v-col class="text-center d-flex" cols="12" md="2">
          <v-menu>
            <template v-slot:activator="{ props }">
              <v-btn
                :density="mobile ? 'comfortable' : 'default'"
                class="mr-sm-1 rounded flex-grow-1"
                color="primary"
                :icon="sortIcon"
                v-bind="props"
              >
              </v-btn>
            </template>
            <v-list density="compact">
              <!--              LATEST-->
              <v-list-item
                link
                title="Recent Posts"
                prepend-icon="mdi-sort-clock-descending-outline"
                @click="handleSort('LATEST')"
              >
              </v-list-item>
              <!--              DESC-->
              <v-list-item
                link
                title="Newest Events First"
                prepend-icon="mdi-sort-variant"
                @click="handleSort('DESC')"
              >
              </v-list-item>
              <!--              ASC-->
              <v-list-item
                link
                title="Oldest Events First"
                prepend-icon="mdi-sort-reverse-variant"
                @click="handleSort('ASC')"
              >
              </v-list-item>
            </v-list>
          </v-menu>
          <v-btn
            :density="mobile ? 'comfortable' : 'default'"
            class="ml-2 mr-sm-1 ml-md-0 rounded flex-grow-1"
            color="primary"
            icon="mdi-magnify"
            type="submit"
          >
          </v-btn>
          <v-btn
            :density="mobile ? 'comfortable' : 'default'"
            class="ml-2 ml-md-0 rounded flex-grow-1"
            color="primary"
            icon="mdi-restore"
            @click="resetForm"
          >
          </v-btn>
        </v-col>
      </v-row>
    </v-container>
  </v-form>
</template>

<style scoped></style>
