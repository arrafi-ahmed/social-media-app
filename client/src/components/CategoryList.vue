<script setup>
import { useDisplay } from "vuetify";

const { mobile } = useDisplay();
const { categories, selected, type } = defineProps([
  "categories",
  "selected",
  "type",
]);
</script>
<template>
  <v-sheet
    v-if="categories"
    :class="{
      'pa-2 mb-2 rounded bg-grey-lighten-3': type === 'has-header',
    }"
  >
    <h4 v-if="type === 'has-header'" class="px-2 pb-1">Event Categories</h4>
    <!-- Category List -->
    <v-list
      v-if="categories.length > 0"
      :class="{ 'bg-white': mobile, 'bg-grey-lighten-3': !mobile }"
      class="pa-0"
      density="compact"
    >
      <v-list-item
        v-for="(category, index) in categories"
        :key="index"
        :class="{
          'v-list-item--active': category === selected,
        }"
        class="pa-0"
        density="compact"
        @click="$emit('clickCategory', category)"
      >
        <v-icon
          class="d-inline"
          color="primary"
          icon="mdi-circle-small"
        ></v-icon>
        <v-list-item-title class="d-inline"
          ><small>
            {{ category }}
          </small>
        </v-list-item-title>
      </v-list-item>
    </v-list>
    <div v-else class="mx-4 my-2">
      <small>No category found</small>
    </div>
  </v-sheet>
</template>

<style scoped>
.v-list-item--density-compact.v-list-item--one-line {
  min-height: auto;
}
</style>
