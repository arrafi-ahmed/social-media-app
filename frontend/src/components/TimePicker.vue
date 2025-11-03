<script setup>
  const model = defineModel()

  const { label, density, variant, showIcon, rules, format } = defineProps({
    label: { type: String },
    density: { type: String },
    variant: { type: String },
    showIcon: { type: Boolean },
    format: { type: String },
    rules: { type: Object },
  })
</script>
<template>
  <v-text-field
    v-model="model"
    hide-details="auto"
    :label="label"
    :prepend-inner-icon="showIcon ? 'mdi-clock-time-four-outline' : null"
    readonly
    :rules="rules"
    :variant="variant"
  >
    <v-menu
      activator="parent"
      :close-on-content-click="false"
    >
      <v-time-picker v-model="model" :format="format" />
    </v-menu>
  </v-text-field>
</template>
