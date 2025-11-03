<script setup>
  import { computed } from 'vue'
  import { useStore } from 'vuex'

  const store = useStore()
  const progress = computed(() => store.state.progress)
</script>

<template>
  <div class="position-relative" style="z-index: 9999">
    <v-progress-linear
      absolute
      :active="progress"
      class="position-fixed"
      color="primary"
      :height="5"
      indeterminate
      reverse
      rounded
    />
  </div>
</template>

<style scoped></style>
