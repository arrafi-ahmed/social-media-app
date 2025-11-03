<script setup>
  import { computed } from 'vue'
  import { useDisplay } from 'vuetify'

  const { mdAndUp } = useDisplay()

  const {
    justify,
    text,
    variant,
    cols,
    sm,
    md,
    lg,
    xl,
    closable,
    customClass,
    icon,
    title,
    description,
    actionText,
    actionIcon,
    color,
    type,
    maxWidth,
  } = defineProps({
    justify: { type: String, default: 'center' },
    text: { type: String, default: 'No items found!' },
    variant: { type: String, default: 'tonal' },
    cols: { type: Number, default: 12 },
    sm: { type: Number },
    md: { type: Number },
    lg: { type: Number },
    xl: { type: Number },
    closable: { type: Boolean, default: true },
    customClass: { type: String, default: 'text-center' },
    icon: { type: String, default: 'mdi-information-outline' },
    title: { type: String },
    description: { type: String },
    actionText: { type: String },
    actionIcon: { type: String },
    color: { type: String, default: 'info' },
    type: { type: String, default: 'info' },
    maxWidth: { type: Number, default: 650 },
  })

  const emit = defineEmits(['action'])
</script>

<template>
  <v-container :max-width="maxWidth">
    <v-row
      :class="`${customClass} text-wrap`"
      :justify="justify"
    >
      <v-col
        :cols="cols"
        :lg="lg"
        :md="md"
        :sm="sm"
        :xl="xl"
      >
        <v-alert
          :closable="closable"
          :color="color"
          :density="mdAndUp ? 'comfortable' : 'compact'"
          :icon="icon"
          :type="type"
          :variant="variant"
        >
          <div v-if="title" class="text-h6 mb-2">{{ title }}</div>
          <div v-if="description">{{ description }}</div>

          <!-- Enhanced action button for large screens -->
          <div v-if="actionText" class="my-3">
            <v-btn
              :color="color"
              :icon="actionIcon && !mdAndUp ? actionIcon : undefined"
              :prepend-icon="actionIcon && mdAndUp ? actionIcon : undefined"
              :size="mdAndUp ? 'default' : 'small'"
              :variant="mdAndUp ? 'elevated' : 'text'"
              @click="emit('action')"
            >
              {{ actionText }}
            </v-btn>
          </div>

          <!-- Legacy append slot for backward compatibility -->
          <template v-if="actionText && !mdAndUp" #append>
            <v-btn
              class="my-3"
              :icon="actionIcon"
              size="small"
              variant="text"
              @click="emit('action')"
            >
              {{ actionText }}
            </v-btn>
          </template>
        </v-alert>
      </v-col>
    </v-row>
  </v-container>
</template>

<style scoped></style>
