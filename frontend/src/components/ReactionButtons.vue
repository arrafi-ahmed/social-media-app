<template>
  <div class="reaction-buttons" :class="{ 'compact': compact }">
    <v-tooltip
      v-for="reaction in reactionTypes"
      :key="reaction.type"
      :text="reaction.label"
      location="top"
    >
      <template #activator="{ props: tooltipProps }">
        <v-btn
          v-bind="tooltipProps"
          :class="{ 'reaction-active': userReaction === reaction.type }"
          :color="userReaction === reaction.type ? reaction.color : 'default'"
          :disabled="loading"
          :size="compact ? 'default' : 'large'"
          class="reaction-button"
          density="default"
          variant="text"
          @click="handleReaction(reaction.type)"
        >
          <v-icon :icon="userReaction === reaction.type ? reaction.iconActive : reaction.icon" :size="compact ? 'default' : 'x-large'" />
          <span v-if="!compact || showCounts" class="ml-1">{{ (reactions && reactions[reaction.type]) ? reactions[reaction.type] : 0 }}</span>
        </v-btn>
      </template>
    </v-tooltip>
  </div>
</template>

<script setup>
import { ref } from 'vue'
import { useStore } from 'vuex'
import $axios from '@/plugins/axios'

const props = defineProps({
  eventId: {
    type: Number,
    required: true
  },
  reactions: {
    type: Object,
    default: () => ({ like: 0, unlike: 0, heart: 0, laugh: 0, sad: 0, angry: 0 })
  },
  userReaction: {
    type: String,
    default: null
  },
  compact: {
    type: Boolean,
    default: false
  },
  showCounts: {
    type: Boolean,
    default: true
  },
  storeModule: {
    type: String,
    default: 'eventSingle'
  }
})

const emit = defineEmits(['reaction-toggled'])

const store = useStore()
const loading = ref(false)

const reactionTypes = [
  { type: 'like', icon: 'mdi-thumb-up-outline', iconActive: 'mdi-thumb-up', color: 'primary', label: 'Like' },
  { type: 'unlike', icon: 'mdi-thumb-down-outline', iconActive: 'mdi-thumb-down', color: 'primary', label: 'Unlike' },
  { type: 'heart', icon: 'mdi-heart-outline', iconActive: 'mdi-heart', color: 'error', label: 'Heart' },
  { type: 'laugh', icon: 'mdi-emoticon-lol-outline', iconActive: 'mdi-emoticon-lol', color: 'warning', label: 'Laugh' },
  { type: 'sad', icon: 'mdi-emoticon-sad-outline', iconActive: 'mdi-emoticon-sad', color: 'info', label: 'Sad' },
  { type: 'angry', icon: 'mdi-emoticon-angry-outline', iconActive: 'mdi-emoticon-angry', color: 'error', label: 'Angry' }
]

async function handleReaction (reactionType) {
  if (loading.value) return
  
  loading.value = true
  const previousReaction = props.userReaction
  
  try {
    // For eventSingle store, use the action
    if (props.storeModule === 'eventSingle') {
      await store.dispatch(`${props.storeModule}/toggleReaction`, {
        eventId: props.eventId,
        reactionType
      })
    } else {
      // For other stores, call API directly and update store
      const response = await $axios.post('/event/reaction', {
        eventId: props.eventId,
        reactionType
      })
      const result = response.data.payload
      
      // Update store mutation
      store.commit(`${props.storeModule}/updateEventReaction`, {
        eventId: props.eventId,
        reactionType: result.reactionType,
        isActive: result.isActive,
        previousReaction: previousReaction
      })
    }
    
    emit('reaction-toggled', { reactionType, eventId: props.eventId })
  } catch (error) {
    console.error('Error toggling reaction:', error)
    store.commit('addSnackbar', {
      text: error?.response?.data?.message || 'Failed to update reaction',
      color: 'error'
    })
  } finally {
    loading.value = false
  }
}
</script>

<style scoped>
.reaction-buttons {
  display: flex;
  gap: 4px;
  align-items: center;
}

.reaction-buttons.compact {
  gap: 2px;
}

.reaction-button {
  min-width: auto;
  padding: 8px 16px;
  height: auto;
}

.reaction-button.reaction-active {
  opacity: 1;
}

.reaction-button:not(.reaction-active) {
  opacity: 0.7;
}

.reaction-button:hover:not(:disabled) {
  opacity: 1;
  transform: scale(1.1);
  transition: transform 0.2s;
}
</style>

