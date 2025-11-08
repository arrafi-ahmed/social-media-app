<script setup>
  import { ref, watch } from 'vue'
  import { formatMonthYear, getUserImageUrl } from '@/others/util.js'

  const { profile, containerClass, imgClass, imgSize, rounded, isDetailed } = defineProps({
    profile: {},
    containerClass: {},
    imgSize: { default: 60 },
    imgClass: {},
    rounded: {},
    isDetailed: {},
  })

  const showFallback = ref(false)

  watch(
    () => profile?.image,
    () => {
      showFallback.value = !profile?.image
    },
    { immediate: true },
  )
</script>

<template>
  <div :class="`d-flex align-center ${containerClass}`">
    <v-avatar color="secondary" :rounded="rounded" :size="imgSize">
      <div v-if="showFallback">
        <v-icon color="white" icon="mdi-account" :size="imgSize-15" />
      </div>
      <v-img
        v-else
        :aspect-ratio="1"
        :class="`flex-grow-1 ${imgClass}`"
        cover
        :src="getUserImageUrl(profile?.image)"
        @error="showFallback = true"
      />
    </v-avatar>
    <div class="ml-3">
      <h4>
        {{ profile?.fullName }}
      </h4>
      <small v-if="isDetailed" class="d-block">{{ profile?.email }}</small>
      <small
        v-if="profile?.createdAt"
        class="d-block"
      >Joined {{ formatMonthYear(profile?.createdAt) }}</small>
      <!--      <small class="d-block">{{ profile?.country }}</small>-->
    </div>
  </div>
</template>

<style scoped></style>
