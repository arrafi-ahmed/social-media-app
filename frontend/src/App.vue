<script setup>
  import { computed, onMounted, watch } from 'vue'

  import { useRoute } from 'vue-router'
  import { useStore } from 'vuex'
  import { useTheme } from 'vuetify'
  import ProgressLoader from '@/components/ProgressLoader.vue'
  import { appInfo } from '@/others/util'

  const route = useRoute()
  const store = useStore()
  const theme = useTheme()

  const snackbars = computed(() => store.state.snackbars)
  const currentUser = computed(() => store.getters['auth/getCurrentUser'])

  // Handle Vuetify's update
  function setSnackbars (val) {
    store.commit('setSnackbars', val)
  }

  // Watch for theme changes and apply to Vuetify
  function handleThemeChange (event) {
    if (event?.detail) {
      theme.global.name.value = event.detail
    }
  }

  // Watch currentUser theme changes
  watch(() => currentUser.value?.theme, (newTheme) => {
    if (newTheme) {
      theme.global.name.value = newTheme
    }
  }, { immediate: true })

  // Listen for theme change events
  onMounted(() => {
    window.addEventListener('theme-change', handleThemeChange)
    // Apply theme from currentUser on mount
    if (currentUser.value?.theme) {
      theme.global.name.value = currentUser.value.theme
    }
  })

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
