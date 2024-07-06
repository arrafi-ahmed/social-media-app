<script setup>
import { defineEmits, defineProps, ref, watch } from "vue";
import { useDisplay } from "vuetify";
import { formatDate } from "@/util";

//use new Date() in parent before passing v-model in child
const model = defineModel();
const { width, height, mobile } = useDisplay();
const emit = defineEmits(["update:modelValue"]);

const { label, color, customClass, rules, variant } = defineProps({
  label: { type: String },
  color: { type: String },
  customClass: { type: String },
  rules: { type: Object },
  variant: { type: String },
});
const selectedDate = ref();
const menu = ref(false);

const handleDateChange = (newDate) => {
  emit("update:modelValue", new Date(newDate));
};
watch(
  () => model.value,
  (newVal) => {
    selectedDate.value = new Date(newVal);
    selectedDate.value = newVal ? formatDate(newVal) : "";
  }
);
watch(
  () => model.value,
  () => {
    menu.value = false;
  }
);
</script>

<template v-if="selectedDate">
  <v-menu v-model="menu" :close-on-content-click="false">
    <template v-slot:activator="{ props }">
      <v-text-field
        v-model="selectedDate"
        :class="customClass"
        :label="label"
        :rules="rules"
        :variant="variant"
        density="compact"
        hide-details="auto"
        prepend-inner-icon="mdi-calendar"
        readonly
        v-bind="props"
        @click:clear="selectedDate = null"
      />
    </template>
    <v-date-picker
      v-model="model"
      :color="color"
      :height="mobile ? height : 'auto'"
      :width="mobile ? width : 'auto'"
      show-adjacent-months
      title=""
      @update:modelValue="handleDateChange"
    />
  </v-menu>
</template>
<style>
.v-overlay__content:has(> .v-date-picker) {
  min-width: auto !important;
}

.v-picker-title {
  padding: 0 !important;
}

@media only screen and (max-width: 600px) {
  .v-overlay__content:has(> .v-date-picker) {
    left: 0 !important;
  }
}
</style>
