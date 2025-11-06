<script setup>
  import { computed, onMounted, ref } from 'vue'
  import { useRouter } from 'vue-router'
  import { useStore } from 'vuex'

  const props = defineProps({
    showUpgradeButton: {
      type: Boolean,
      default: true,
    },
    compact: {
      type: Boolean,
      default: false,
    },
  })

  const store = useStore()
  const router = useRouter()

  const limitStatus = ref({
    isPremium: false,
    monthlyCount: 0,
    limit: 5,
    remaining: 0,
  })
  const isLoading = ref(false)

  const statusText = computed(() => {
    if (limitStatus.value.isPremium) {
      return 'Unlimited posts'
    }
    const remaining = limitStatus.value.remaining
    if (remaining === 0) {
      return 'Post limit reached'
    }
    return `${remaining} post${remaining !== 1 ? 's' : ''} remaining this month`
  })

  const statusColor = computed(() => {
    if (limitStatus.value.isPremium) {
      return 'success'
    }
    if (limitStatus.value.remaining === 0) {
      return 'error'
    }
    if (limitStatus.value.remaining <= 2) {
      return 'warning'
    }
    return 'info'
  })

  async function loadLimitStatus () {
    isLoading.value = true
    try {
      const response = await $axios.get('/event/postLimitStatus')
      limitStatus.value = response.data.payload
    } catch (error) {
      console.error('Error loading post limit status:', error)
    } finally {
      isLoading.value = false
    }
  }

  function handleUpgrade () {
    router.push({ name: 'pricing' })
  }

  onMounted(() => {
    loadLimitStatus()
  })

  defineExpose({
    loadLimitStatus,
    limitStatus,
  })
</script>

<template>
  <div v-if="!isLoading" class="post-limit-status">
    <v-alert
      v-if="!limitStatus.isPremium && limitStatus.remaining === 0"
      :color="statusColor"
      density="compact"
      variant="tonal"
    >
      <div class="d-flex align-center justify-space-between">
        <div>
          <strong>Post limit reached!</strong>
          <div class="text-caption">
            You've used all {{ limitStatus.limit }} posts this month. Upgrade to premium for unlimited posts.
          </div>
        </div>
        <v-btn
          v-if="showUpgradeButton"
          color="primary"
          size="small"
          variant="flat"
          @click="handleUpgrade"
        >
          Upgrade
        </v-btn>
      </div>
    </v-alert>
    <v-chip
      v-else-if="!compact"
      :color="statusColor"
      size="small"
      variant="flat"
    >
      <v-icon
        :icon="limitStatus.isPremium ? 'mdi-infinity' : 'mdi-calendar-month'"
        size="small"
        start
      />
      {{ statusText }}
    </v-chip>
    <span v-else class="text-caption" :class="`text-${statusColor}`">
      {{ statusText }}
    </span>
  </div>
</template>

<style scoped>
.post-limit-status {
  width: 100%;
}
</style>

