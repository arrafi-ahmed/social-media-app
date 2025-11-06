<script setup>
  import { computed, ref, watch } from 'vue'
  import { useStore } from 'vuex'

  const props = defineProps({
    modelValue: {
      type: Boolean,
      default: false,
    },
    group: {
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
  const icon = ref('mdi-account-group')

  const isEditing = computed(() => props.group !== null)

  const dialogTitle = computed(() => isEditing.value ? 'Edit Group' : 'Create Group')

  // Icon options (group-specific)
  const iconOptions = [
    { value: 'mdi-account-group', label: 'Group' },
    { value: 'mdi-account-multiple', label: 'People' },
    { value: 'mdi-home-heart', label: 'Family' },
    { value: 'mdi-airplane', label: 'Travel Buddies' },
    { value: 'mdi-music', label: 'Music' },
    { value: 'mdi-soccer', label: 'Sports' },
    { value: 'mdi-school', label: 'School' },
    { value: 'mdi-briefcase', label: 'Work' },
    { value: 'mdi-heart', label: 'Close Friends' },
    { value: 'mdi-star', label: 'Favorites' },
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
      if (props.group) {
        name.value = props.group.name || ''
        description.value = props.group.description || ''
        color.value = props.group.color || '#e40046'
        icon.value = props.group.icon || 'mdi-account-group'
      } else {
        name.value = ''
        description.value = ''
        color.value = '#e40046'
        icon.value = 'mdi-account-group'
      }
    }
  })

  async function save () {
    if (!name.value.trim()) {
      return
    }

    try {
      await (isEditing.value
        ? store.dispatch('group/updateGroup', {
          id: props.group.id,
          name: name.value,
          description: description.value,
          color: color.value,
          icon: icon.value,
        })
        : store.dispatch('group/createGroup', {
          name: name.value,
          description: description.value,
          color: color.value,
          icon: icon.value,
        }))
      emit('saved')
      dialog.value = false
    } catch (error) {
      console.error('Error saving group:', error)
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
          label="Group Name"
          required
          variant="solo"
        />

        <v-textarea
          v-model="description"
          class="mb-3"
          density="comfortable"
          label="Description (optional)"
          rows="2"
          variant="solo"
        />

        <div class="mb-3">
          <label class="text-body-2 mb-2 d-block">Icon</label>
          <v-select
            v-model="icon"
            density="comfortable"
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
          {{ isEditing ? 'Update' : 'Create' }}
        </v-btn>
      </v-card-actions>
    </v-card>
  </v-dialog>
</template>

<style scoped></style>

