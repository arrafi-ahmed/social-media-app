<script setup>
import { formatMonthYear, getUserImageUrl } from "@/util";

const { profile, containerClass, imgClass, imgSize, isDetailed } = defineProps({
  profile: {},
  containerClass: {},
  imgSize: { default: 60 },
  imgClass: {},
  isDetailed: {},
});
</script>

<template>
  <div :class="`d-flex align-center ${containerClass}`">
    <!--    :max-width="80"-->
    <v-img
      :aspect-ratio="1"
      :class="`flex-grow-1 ${imgClass}`"
      :src="getUserImageUrl(profile?.image)"
      :width="imgSize"
      cover
    ></v-img>
    <div class="ml-3">
      <h4>
        {{ profile?.full_name }}
      </h4>
      <small v-if="isDetailed" class="d-block">{{ profile?.email }}</small>
      <small v-if="profile?.created_at" class="d-block"
        >Joined {{ formatMonthYear(profile?.created_at) }}</small
      >
      <!--      <small class="d-block">{{ profile?.country }}</small>-->
    </div>
  </div>
</template>

<style scoped></style>
