<script setup>
  import { ref } from 'vue'

  const dialog = ref(false)

  const { popupTitle, popupContent, color } = defineProps({
    popupTitle: {
      type: String,
      default: 'Delete',
    },
    popupContent: {
      type: String,
      default: 'Are you sure?',
    },
    color: { type: String, default: 'error' },
  })

  const emit = defineEmits(['confirm'])

  function onClick () {
    dialog.value = true
  }

  function confirmAction () {
    emit('confirm')
    dialog.value = false
  }
</script>

<template>
  <!-- Slot for activator button -->
  <slot
    name="activator"
    :on-click="onClick"
  />

  <!-- Confirmation dialog -->
  <v-dialog
    v-model="dialog"
    :width="400"
  >
    <v-card>
      <v-card-title>
        <span>{{ popupTitle }}</span>
      </v-card-title>
      <v-card-text>{{ popupContent }}</v-card-text>
      <v-card-actions>
        <v-spacer />
        <v-btn
          :color="color"
          @click="confirmAction"
        >
          Yes
        </v-btn>
        <v-btn
          :color="color"
          @click="dialog = false"
        >
          No
        </v-btn>
      </v-card-actions>
    </v-card>
  </v-dialog>
</template>
