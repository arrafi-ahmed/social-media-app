<script setup>
  import { computed } from 'vue'
  import { useRoute } from 'vue-router'

  definePage({
    name: 'notFound',
    meta: {
      title: 'Not Found',
      layout: 'default',
    },
  })

  const route = useRoute()
  // Support both params and query for status and message (computed for reactivity)
  const status = computed(() => route.params.status || route.query.status || route.query.errcode || 404)
  const message = computed(() => route.params.message || route.query.message || 'Looks like you\'re lost!')

  // Determine if this is a private content error (403) or not found (404)
  const isPrivateContent = computed(() => status.value == 403 || status.value == '403')

  // Get appropriate title and button text based on error type
  const errorTitle = computed(() => isPrivateContent.value ? 'Private Group' : status.value)
  const buttonText = computed(() => isPrivateContent.value ? 'Back to Browse' : 'Go Home')
</script>

<template>
  <v-container class="fill-height">
    <v-row align="center" justify="center">
      <v-col
        class="text-center"
        cols="12"
        lg="5"
        md="6"
        sm="8"
      >
        <!-- Error code and message above animation -->
        <v-card class="mx-auto mb-4 error-header" elevation="2">
          <v-card-text class="pa-4">
            <h1 class="text-h4 mb-2">{{ errorTitle }}</h1>
            <p class="text-body-1 text-grey-darken-1 mb-0">
              {{ message }}
            </p>
          </v-card-text>
        </v-card>

        <!-- Animation -->
        <div class="bg page_404 mb-4" />

        <!-- Action buttons -->
        <v-btn
          class="clickable mb-2"
          color="primary"
          size="large"
          :to="{ name: 'browse' }"
          variant="flat"
        >
          {{ buttonText }}
        </v-btn>
      </v-col>
    </v-row>
  </v-container>
</template>

<style scoped>
.fill-height {
  min-height: 60vh;
}

.error-header {
  background-color: rgba(var(--v-theme-surface), 0.8);
}

.bg {
  background-image: url(https://cdn.dribbble.com/users/285475/screenshots/2083086/dribbble_1.gif);
  height: 300px;
  background-position: center;
  background-repeat: no-repeat;
  background-size: contain;
}
</style>
