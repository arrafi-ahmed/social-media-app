<script setup>
  import { nextTick, ref, watch } from 'vue'
  import UserAvatar from '@/components/UserAvatar.vue'
  import $axios from '@/plugins/axios'

  const props = defineProps({
    modelValue: {
      type: String,
      default: '',
    },
    textareaRef: {
      type: Object,
      default: null,
    },
  })

  const emit = defineEmits(['update:modelValue'])

  const showDropdown = ref(false)
  const users = ref([])
  const searchQuery = ref('')
  const mentionStart = ref(-1)
  const selectedIndex = ref(-1)
  const isLoading = ref(false)

  let searchTimeout = null

  // Watch for @ symbol in input
  watch(() => props.modelValue, newValue => {
    if (!props.textareaRef || !newValue) {
      showDropdown.value = false
      return
    }

    nextTick(() => {
      const textarea = props.textareaRef.$el?.querySelector('textarea') || props.textareaRef.$el
      if (!textarea) return

      const cursorPos = textarea.selectionStart || 0
      const textBeforeCursor = newValue.slice(0, cursorPos)
      const lastAtIndex = textBeforeCursor.lastIndexOf('@')

      // Only set flag to true if cursor is right after @
      const isCursorRightAfterAt = cursorPos === lastAtIndex + 1
      console.log('isCursorRightAfterAt', isCursorRightAfterAt)

      if (isCursorRightAfterAt) {
        // Cursor is right after @ - set flag to true
        showDropdown.value = true
        mentionStart.value = lastAtIndex
        searchQuery.value = ''
        selectedIndex.value = -1
        searchUsers('')
      } else {
        // All other cases - set flag to false
        showDropdown.value = false
      }
    })
  })

  // Search users based on query
  async function searchUsers (query) {
    isLoading.value = true

    if (searchTimeout) {
      clearTimeout(searchTimeout)
    }

    searchTimeout = setTimeout(async () => {
      try {
        const response = await $axios.get('/user/search', {
          params: { q: query || '', limit: 10 },
        })
        users.value = response.data.payload || []
      } catch (error) {
        console.error('Error searching users:', error)
        users.value = []
      } finally {
        isLoading.value = false
      }
    }, 200)
  }

  // Select user and insert mention
  function selectUser (user) {
    if (!props.textareaRef || mentionStart.value === -1) return

    const textarea = props.textareaRef.$el?.querySelector('textarea') || props.textareaRef.$el
    if (!textarea) return

    const currentValue = props.modelValue || ''
    const textBeforeMention = currentValue.slice(0, mentionStart.value)
    const textAfterMention = currentValue.slice(textarea.selectionStart || currentValue.length)

    const userName = user.fullName || ''
    const mentionText = `@${userName} `
    const newValue = textBeforeMention + mentionText + textAfterMention

    showDropdown.value = false
    emit('update:modelValue', newValue)

    // Set cursor position after mention
    nextTick(() => {
      const newCursorPos = textBeforeMention.length + mentionText.length
      if (textarea.setSelectionRange) {
        textarea.setSelectionRange(newCursorPos, newCursorPos)
        textarea.focus()
      }
    })
  }

  // Keyboard navigation
  function handleKeydown (event) {
    if (!showDropdown.value || users.value.length === 0) return

    if (event.key === 'ArrowDown') {
      event.preventDefault()
      selectedIndex.value = (selectedIndex.value + 1) % users.value.length
    } else if (event.key === 'ArrowUp') {
      event.preventDefault()
      selectedIndex.value = selectedIndex.value <= 0 ? users.value.length - 1 : selectedIndex.value - 1
    } else if (event.key === 'Enter' && selectedIndex.value >= 0) {
      event.preventDefault()
      selectUser(users.value[selectedIndex.value])
    } else if (event.key === 'Escape') {
      showDropdown.value = false
    }
  }

  // Hide dropdown (can be called from parent)
  function hideDropdown () {
    showDropdown.value = false
  }

  defineExpose({
    handleKeydown,
    hideDropdown,
  })
</script>

<template>
  <v-menu
    v-if="showDropdown"
    v-model="showDropdown"
    :activator="textareaRef"
    :close-on-content-click="false"
    location="bottom"
    :offset="8"
  >
    <v-card
      v-if="users.length > 0"
      class="mention-dropdown"
      max-height="300"
      min-width="250"
    >
      <v-list density="compact">
        <v-list-item
          v-for="(user, index) in users"
          :key="user.id"
          :class="{ 'bg-primary-lighten-5': selectedIndex === index }"
          @click="selectUser(user)"
        >
          <template #prepend>
            <user-avatar
              :img-src="user.image"
              rounded="circle"
              :size="32"
            />
          </template>
          <v-list-item-title>{{ user.fullName }}</v-list-item-title>
          <v-list-item-subtitle v-if="user.slug">{{ user.slug }}</v-list-item-subtitle>
        </v-list-item>
      </v-list>
    </v-card>
    <v-card
      v-else-if="isLoading"
      class="mention-dropdown"
      min-width="250"
    >
      <v-card-text class="text-center">
        <v-progress-circular
          indeterminate
          size="24"
        />
      </v-card-text>
    </v-card>
  </v-menu>
</template>

<style scoped>
.mention-dropdown {
  max-height: 300px;
  overflow-y: auto;
}
</style>
