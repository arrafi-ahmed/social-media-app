<script setup>
  import { useDisplay } from 'vuetify'
  import NoItems from '@/components/NoItems.vue'

  const { mobile } = useDisplay()
  const { categories, selected, type } = defineProps([
    'categories',
    'selected',
    'type',
  ])
</script>
<template>
  <v-card
    v-if="categories"
    :class="{
      'pa-2 mb-2 rounded': type === 'has-header',
    }"
  >
    <h4 v-if="type === 'has-header'" class="px-2 pb-1">Event Categories</h4>
    <!-- Category List -->
    <v-list
      v-if="categories.length > 0"
      class="pa-0"
      density="compact"
    >
      <v-list-item
        v-for="(category, index) in categories"
        :key="index"
        class="pa-0"
        :class="{
          'v-list-item--active': category === selected,
        }"
        density="compact"
        @click="$emit('clickCategory', category)"
      >
        <v-icon class="d-inline" color="primary" icon="mdi-circle-small" />
        <v-list-item-title class="d-inline"><small>
          {{ category }}
        </small>
        </v-list-item-title>
      </v-list-item>
    </v-list>
    <no-items
      v-else
      :closable="false"
      description="No category found"
      icon="mdi-tag-outline"
      variant="text"
    />
  </v-card>
</template>

<style scoped>
.v-list-item--density-compact.v-list-item--one-line {
  min-height: auto;
}
</style>
