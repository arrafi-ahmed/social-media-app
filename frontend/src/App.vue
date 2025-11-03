<script setup>
  import { computed, watch } from 'vue'

  import { useRoute } from 'vue-router'
  import { useStore } from 'vuex'
  import ProgressLoader from '@/components/ProgressLoader.vue'
  import { appInfo } from '@/others/util'

  const route = useRoute()
  const store = useStore()

  const snackbars = computed(() => store.state.snackbars)

  // Handle Vuetify's update
  function setSnackbars (val) {
    store.commit('setSnackbars', val)
  }

  watch(route, to => {
    const tail = appInfo.name + ' | Private Travel and Activity Journal'
    document.title = (to.meta.title && to.meta.title + ' | ' + tail) || tail
  })
</script>
<template>
  <progress-loader />
  <v-snackbar-queue
    closable
    location="bottom start"
    :model-value="snackbars"
    :timeout="4000"
    timer
    @update:model-value="setSnackbars"
  />
  <router-view />
</template>
<style>
/* Global utility classes that extend Vuetify */
.clickable {
  cursor: pointer;
}

/* Custom z-index utilities (Vuetify doesn't have these specific values) */
.z-index-max {
  z-index: 999999 !important;
}

.high-z-index {
  z-index: 999 !important;
}

/* Custom positioning utilities */
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

/* Custom layout utilities */
.vertical-baseline {
  vertical-align: baseline !important;
}

.limit-max-width-xl {
  max-width: 1400px !important;
}

/* Custom component overrides */
.v-chip-0-padding {
  padding: 0 !important;
}
</style>
