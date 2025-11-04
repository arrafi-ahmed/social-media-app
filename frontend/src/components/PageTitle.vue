<script setup>
  import { computed } from 'vue'
  import { useRouter } from 'vue-router'
  import { useDisplay } from 'vuetify'

  // Props
  const props = defineProps({
    title: {
      type: String,
      required: true,
    },
    subtitle: {
      type: String,
      default: '',
    },
    showBackButton: {
      type: Boolean,
      default: true,
    },
    backUrl: {
      type: Object,
      default: null,
    },
  })

  const router = useRouter()

  // Computed
  const { mobile } = useDisplay()
  const isMobile = computed(() => mobile.value)

  function handleBack () {
    if (props.backUrl) {
      router.push(props.backUrl)
    } else {
      router.back()
    }
  }
</script>

<template>
  <div class="page-title-container">
    <!-- Row 1: Back Button + Page Title + Action Buttons -->
    <div class="d-flex align-center justify-space-between gap-4 mb-2">
      <!-- Left Side: Back Button + Prepend Slot + Page Title -->
      <div class="d-flex align-center gap-3 flex-grow-1 min-width-0">
        <v-btn
          v-if="showBackButton"
          icon="mdi-arrow-left"
          size="large"
          variant="text"
          @click="handleBack"
        />
        <slot name="prepend" />
        <div>
          <h2 class="font-weight-bold mb-0">
            {{ title }}
          </h2>
          <p class="text-body-1 text-medium-emphasis mb-0">
            {{ subtitle }}
          </p>
        </div>
      </div>

      <!-- Spacer to push append content to the right -->
      <v-spacer v-if="!isMobile" />

      <!-- Right Side: Append Slot + Action Buttons -->
      <div class="d-flex flex-shrink-0 gap-2">
        <slot name="append" />
        <!-- Desktop: Full buttons -->
        <template v-if="!isMobile">
          <slot name="actions" />
        </template>

        <!-- Mobile: Icon buttons -->
        <template v-else>
          <slot name="mobile-actions" />
        </template>
      </div>
    </div>
  </div>
</template>

<style scoped>
.page-title-container {
  width: 100%;
}

.min-width-0 {
  min-width: 0 !important;
}

.flex-shrink-0 {
  flex-shrink: 0 !important;
}

/* Responsive adjustments */
@media (max-width: 768px) {
  .page-title-container h1 {
    font-size: 1.5rem !important;
    line-height: 1.2 !important;
  }
}
</style>
