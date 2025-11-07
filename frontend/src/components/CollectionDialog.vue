<script setup>
  import { computed, ref, watch } from 'vue'
  import { useStore } from 'vuex'

  const props = defineProps({
    modelValue: {
      type: Boolean,
      default: false,
    },
    collection: {
      type: Object,
      default: null,
    },
  })

  const emit = defineEmits(['update:modelValue', 'saved'])

  const store = useStore()

  const dialog = computed({
    get: () => props.modelValue,
    set: value => emit('update:modelValue', value),
  })

  const name = ref('')
  const description = ref('')
  const color = ref('#e40046') // Primary color default
  const icon = ref('mdi-folder')

  const isEditing = computed(() => props.collection !== null)

  const dialogTitle = computed(() => isEditing.value ? 'Edit Collection' : 'Create Collection')

  // Icon options
  const iconOptions = [
    { value: 'mdi-folder', label: 'Folder' },
    { value: 'mdi-music', label: 'Music' },
    { value: 'mdi-airplane', label: 'Travel' },
    { value: 'mdi-calendar-star', label: 'Events' },
    { value: 'mdi-camera', label: 'Photos' },
    { value: 'mdi-food', label: 'Food' },
    { value: 'mdi-soccer', label: 'Sports' },
    { value: 'mdi-book', label: 'Books' },
    { value: 'mdi-heart', label: 'Favorites' },
    { value: 'mdi-star', label: 'Star' },
  ]

  // Color options
  const colorOptions = [
    '#e40046', // Primary
    '#1976d2', // Blue
    '#388e3c', // Green
    '#f57c00', // Orange
    '#7b1fa2', // Purple
    '#0288d1', // Light Blue
    '#c2185b', // Pink
    '#5d4037', // Brown
    '#455a64', // Blue Grey
    '#616161', // Grey
  ]

  watch(() => props.modelValue, newVal => {
    if (newVal) {
      if (props.collection) {
        name.value = props.collection.name || ''
        description.value = props.collection.description || ''
        color.value = props.collection.color || '#e40046'
        icon.value = props.collection.icon || 'mdi-folder'
      } else {
        name.value = ''
        description.value = ''
        color.value = '#e40046'
        icon.value = 'mdi-folder'
      }
    }
  })

  async function save () {
    if (!name.value.trim()) {
      return
    }

    try {
      await (isEditing.value
        ? store.dispatch('eventCollection/updateCollection', {
          id: props.collection.id,
          name: name.value,
          description: description.value,
          color: color.value,
          icon: icon.value,
        })
        : store.dispatch('eventCollection/createCollection', {
          name: name.value,
          description: description.value,
          color: color.value,
          icon: icon.value,
        }))
      emit('saved')
      dialog.value = false
    } catch (error) {
      console.error('Error saving collection:', error)
    }
  }

  function cancel () {
    dialog.value = false
  }
</script>

<template>
  <v-dialog
    v-model="dialog"
    :width="400"
    @update:model-value="dialog = $event"
  >
    <v-card>
      <v-card-title>
        <span>{{ dialogTitle }}</span>
      </v-card-title>

      <v-card-text>
        <v-text-field
          v-model="name"
          class="mb-3"
          density="comfortable"
          hide-details="auto"
          label="Collection Name"
          required
          variant="solo"
        />

        <v-textarea
          v-model="description"
          class="mb-3"
          density="comfortable"
          hide-details="auto"
          label="Description (optional)"
          rows="2"
          variant="solo"
        />

        <div class="mb-3">
          <label class="text-body-2 mb-2 d-block">Icon</label>
          <v-select
            v-model="icon"
            density="comfortable"
            hide-details="auto"
            item-title="label"
            item-value="value"
            :items="iconOptions"
            variant="solo"
          >
            <template #item="{ props, item }">
              <v-list-item v-bind="props">
                <template #prepend>
                  <v-icon class="mr-2" :icon="item.value" />
                </template>
              </v-list-item>
            </template>
            <template #selection="{ item }">
              <v-icon class="mr-2" :icon="item.value" />
              <span>{{ item.title }}</span>
            </template>
          </v-select>
        </div>

        <div>
          <label class="text-body-2 mb-2 d-block">Color</label>
          <div class="d-flex flex-wrap" style="gap: 8px;">
            <v-btn
              v-for="col in colorOptions"
              :key="col"
              :color="col"
              icon
              size="small"
              :variant="color === col ? 'flat' : 'outlined'"
              @click="color = col"
            >
              <v-icon v-if="color === col">mdi-check</v-icon>
            </v-btn>
          </div>
        </div>
      </v-card-text>

      <v-card-actions>
        <v-spacer />
        <v-btn
          color="primary"
          variant="text"
          @click="cancel"
        >
          Cancel
        </v-btn>
        <v-btn
          color="primary"
          :disabled="!name.trim()"
          variant="flat"
          @click="save"
        >
          {{ isEditing ? "Update" : "Create" }}
        </v-btn>
      </v-card-actions>
    </v-card>
  </v-dialog>
</template>

<style scoped></style>
