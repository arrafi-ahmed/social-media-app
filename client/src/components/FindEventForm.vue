<script setup>
import { computed, reactive, ref } from "vue";
import { useStore } from "vuex";
import { useDisplay } from "vuetify";
import DatePicker from "@/components/DatePicker.vue";

const { mobile } = useDisplay();
const store = useStore();

const emit = defineEmits(["findEvents", "resetFindEvents"]);
const form = ref(null);
const isFormValid = ref(true);
const allEventCategories = computed(() =>
  store.state.category.categories.map((item) => item.name)
);
const findForm = reactive({
  searchKeyword: null,
  startDate: null,
  endDate: null,
  category: null,
});

const handleFindEvents = async () => {
  await form.value.validate();
  if (!isFormValid.value) return;

  emit("findEvents", findForm);
};
const resetForm = () => {
  form.value.reset();
  emit("resetFindEvents");
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
          <v-btn
            :density="mobile ? 'comfortable' : 'default'"
            class="mr-1 rounded flex-grow-1"
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
