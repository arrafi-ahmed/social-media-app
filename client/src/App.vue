<script setup>
import { Toaster } from "vue-sonner";
import ProgressLoader from "@/components/ProgressLoader.vue";

import { watch } from "vue";
import { useRoute } from "vue-router";
import { appInfo } from "@/util";

const route = useRoute();

watch(route, (to) => {
  const tail = appInfo.name + " | Private Travel and Activity Journal";
  document.title = (to.meta.title && to.meta.title + " | " + tail) || tail;
});
</script>
<template>
  <progress-loader />
  <Toaster
    :expand="true"
    class="custom-toast text-pre-wrap"
    closeButton
    position="bottom-left"
    richColors
    theme="dark"
  />
  <router-view />
</template>
<style>
body,
.custom-toast {
  font-family: "Oxygen", sans-serif !important;
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

.vertical-baseline {
  vertical-align: baseline !important;
}

.limit-max-width-xl {
  max-width: 1400px !important;
}
</style>
