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
</script>

<template>
  <v-container class="fill-height">
    <v-row align="center" justify="center">
      <v-col cols="12" sm="8" md="6" lg="4" class="text-center">
        <!-- Show lock icon for private content, otherwise show 404 image -->
        <v-icon
          v-if="isPrivateContent"
          size="120"
          color="grey-lighten-1"
          class="mb-4"
        >
          mdi-lock-outline
        </v-icon>
        <div v-else class="bg page_404 mb-4"></div>
        
        <h1 class="text-h4 mb-4">{{ isPrivateContent ? 'Private Content' : status }}</h1>
        <p class="text-body-1 mb-6 text-grey-darken-1">
          {{ message }}
        </p>
        <v-btn
          class="clickable"
          color="primary"
          size="large"
          :to="{ name: 'browse' }"
          variant="flat"
        >
          {{ isPrivateContent ? 'Go to Browse' : 'Go Home' }}
        </v-btn>
        <div class="mt-4">
          <v-btn
            variant="text"
            @click="$router.back()"
          >
            Go Back
          </v-btn>
        </div>
      </v-col>
    </v-row>
  </v-container>
</template>

<style scoped>
.fill-height {
  min-height: 60vh;
}

.bg {
  background-image: url(https://cdn.dribbble.com/users/285475/screenshots/2083086/dribbble_1.gif);
  height: 450px;
  background-position: center;
  background-repeat: no-repeat;
}
</style>
