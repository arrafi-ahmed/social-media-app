<template>
  <div 
    class="d-flex align-center flex-wrap"
    :class="isCompact ? 'justify-space-between' : ''"
  >
    <div
      v-for="reaction in reactionTypes"
      :key="reaction.type"
      :class="isCompact ? 'mr-1' : 'mr-4'"
    >
      <v-tooltip
        location="top"
        :text="reaction.label"
      >
        <template #activator="{ props: tooltipProps }">
          <v-btn
            :class="{ 
              'reaction-active': userReaction === reaction.type            
            }"          
            :color="userReaction === reaction.type ? reaction.color : 'default'"
            :density="isCompact ? 'comfortable' : 'default'"
            :disabled="loading"        
            v-bind="tooltipProps"
            variant="text"
            icon=""
            @click="handleReaction(reaction.type)"
          >
            <v-icon
              :icon="userReaction === reaction.type ? reaction.iconActive : reaction.icon"
              :size="isCompact ? 'small' : 'default'"
            />
            <span
              v-if="shouldShowCounts"
              :class="isCompact ? 'ml-1 text-caption' : 'ml-1'"
            >{{ (reactions && reactions[reaction.type]) ? reactions[reaction.type] : 0 }}</span>
          </v-btn>
        </template>
      </v-tooltip>
    </div>
  </div>
</template>

<script setup>
  import { computed, ref } from 'vue'
  import { useDisplay } from 'vuetify'
  import { useStore } from 'vuex'
  import $axios from '@/plugins/axios'

  const props = defineProps({
    eventId: {
      type: Number,
      required: true,
    },
    reactions: {
      type: Object,
      default: () => ({ like: 0, unlike: 0, heart: 0, laugh: 0, sad: 0, angry: 0 }),
    },
    userReaction: {
      type: String,
      default: null,
    },
    compact: {
      type: Boolean,
      default: null, // null means auto-detect from screen size
    },
    showCounts: {
      type: Boolean,
      default: null, // null means auto-detect from screen size
    },
    storeModule: {
      type: String,
      default: 'eventSingle',
    },
  })

  const emit = defineEmits(['reaction-toggled'])

  const { xs, sm, mobile } = useDisplay()
  const store = useStore()
  const loading = ref(false)

  // Auto-detect compact mode on mobile if not explicitly set
  const isCompact = computed(() => {
    if (props.compact !== null) return props.compact
    return xs.value || mobile.value
  })

  // Auto-hide counts on very small screens if not explicitly set
  const shouldShowCounts = computed(() => {
    if (props.showCounts !== null) return props.showCounts
    return !xs.value
  })

  const reactionTypes = [
    { type: 'like', icon: 'mdi-thumb-up-outline', iconActive: 'mdi-thumb-up', color: 'primary', label: 'Like' },
    { type: 'unlike', icon: 'mdi-thumb-down-outline', iconActive: 'mdi-thumb-down', color: 'primary', label: 'Unlike' },
    { type: 'heart', icon: 'mdi-heart-outline', iconActive: 'mdi-heart', color: 'error', label: 'Heart' },
    { type: 'laugh', icon: 'mdi-emoticon-lol-outline', iconActive: 'mdi-emoticon-lol', color: 'warning', label: 'Laugh' },
    { type: 'sad', icon: 'mdi-emoticon-sad-outline', iconActive: 'mdi-emoticon-sad', color: 'info', label: 'Sad' },
    {
      type: 'angry',
      icon: 'mdi-emoticon-angry-outline',
      iconActive: 'mdi-emoticon-angry',
      color: 'error',
      label: 'Angry',
    },
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
          reactionType,
        })
      } else {
        // For other stores, call API directly and update store
        const response = await $axios.post('/event/reaction', {
          eventId: props.eventId,
          reactionType,
        })
        const result = response.data.payload

        // Update store mutation
        store.commit(`${props.storeModule}/updateEventReaction`, {
          eventId: props.eventId,
          reactionType: result.reactionType,
          isActive: result.isActive,
          previousReaction: previousReaction,
        })
      }

      emit('reaction-toggled', { reactionType, eventId: props.eventId })
    } catch (error) {
      console.error('Error toggling reaction:', error)
      store.commit('addSnackbar', {
        text: error?.response?.data?.message || 'Failed to update reaction',
        color: 'error',
      })
    } finally {
      loading.value = false
    }
  }
</script>

<style scoped>
.reaction-active {
  opacity: 1;
}

.v-btn:not(.reaction-active) {
  opacity: 0.7;
}

.v-btn:hover:not(:disabled) {
  opacity: 1;
  transform: scale(1.05);
  transition: transform 0.2s;
}

/* Mobile optimizations */
@media (max-width: 600px) {
  .v-btn:hover:not(:disabled) {
    transform: scale(1.02);
  }
}
</style>
