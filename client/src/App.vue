<script setup>
import { Toaster } from "vue-sonner";
import ProgressLoader from "@/components/ProgressLoader.vue";
</script>
<template>
  <progress-loader />
  <Toaster :expand="true" closeButton position="bottom-left" rich-colors />
  <router-view />
</template>
<style>
body {
  font-family: "Oxygen", sans-serif;
}

.clickable {
  cursor: pointer;
}

.v-chip-0-padding {
  padding: 0 !important;
}

.flex-sticky {
  position: sticky;
  align-self: flex-start;
  z-index: 999;
}

.div-sticky {
  position: sticky;
  height: auto;
  z-index: 999;
}

.top-60 {
  top: 60px;
}

.z-index-max {
  z-index: 999999 !important;
}
</style>
