<script setup>
import { useDisplay } from "vuetify";

const { mobile } = useDisplay();
const { title, justify, customClass } = defineProps({
  title: {},
  justify: { default: "space-between" },
  customClass: {},
});
</script>

<template>
  <v-row :class="customClass" :justify="justify" align="center">
    <v-col cols="auto">
      <h2>{{ title }}</h2>
    </v-col>
    <v-col cols="auto">
      <slot></slot>
    </v-col>
  </v-row>
  <v-divider class="my-2"></v-divider>
</template>

<style scoped></style>
