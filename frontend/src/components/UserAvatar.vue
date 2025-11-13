<script setup>
  import { ref, watch } from 'vue'
  import { getUserImageUrl } from '@/others/util.js'

  const { imgSrc, clickable } = defineProps({
    imgSrc: {},
    clickable: { default: true },
  })

  const showFallback = ref(false)

  watch(
    () => imgSrc,
    () => {
      showFallback.value = !imgSrc
    },
    { immediate: true },
  )
</script>

<template>
  <v-avatar
    :class="{ clickable }"
    color="secondary"
    rounded
    size="45"
    @click="clickable ? $emit('clickAvatar') : undefined"
  >
    <template v-if="showFallback">
      <v-icon color="white" icon="mdi-account" size="30" />
    </template>
    <v-img
      v-else
      alt="User Avatar"
      :aspect-ratio="1"
      cover
      :src="getUserImageUrl(imgSrc)"
      @error="showFallback = true"
    />
  </v-avatar>
</template>

<style scoped></style>
