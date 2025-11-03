s<script setup>
  import { computed, onMounted } from 'vue'
  import { useRoute, useRouter } from 'vue-router'
  import { useStore } from 'vuex'
  import Lightbox from '@/components/Lightbox.vue'
  import UserAvatar from '@/components/UserAvatar.vue'
  import { formatDateFromTimestamp, getEventImageUrl, getWishlistImageUrl } from '@/others/util.js'

  definePage({
    name: 'wishlistSingle',
    meta: {
      requiresAuth: true,
      title: 'Wishlist',
      layout: 'default',
    },
  })

  const route = useRoute()
  const router = useRouter()
  const store = useStore()
  const event = computed(() => store.state.eventWishlist.event)

  onMounted(() => {
    store.dispatch('eventWishlist/setEvent', route.params.id).finally(() => {
      if (!event.value.id) {
        router.push({ name: 'notFound' })
      }
    })
  })
</script>
<template>
  <v-container>

    <v-row v-if="event" align="center" class="pb-1" justify="space-between">
      <v-col class="d-flex align-center" cols="auto">
        <user-avatar :clickable="false" :img-src="event?.image" />

        <div class="pl-3">
          <h4>{{ event?.fullName }}</h4>
          <small>Posted on {{ formatDateFromTimestamp(event?.createdAt) }}</small>
        </div>
      </v-col>
      <v-col cols="auto">
        <v-btn icon="mdi-arrow-left" variant="text" @click="$router.back()" />
      </v-col>
    </v-row>
    <v-divider class="my-2" />
    <v-row justify="center">
      <v-col cols="12" md="8">
        <h2 class="mt-8">{{ event?.title }}</h2>

        <div class="mt-4">
          <div v-if="event?.location" class="d-flex">
            <v-icon
              class="mt-half"
              color="primary"
              size="small"
            >mdi-map-marker
            </v-icon>
            <span class="ml-3">{{ event?.location }}</span>
          </div>
          <div v-if="event?.category" class="d-flex">
            <v-icon
              class="mt-half"
              color="primary"
              size="small"
            >mdi-list-box
            </v-icon>
            <span class="ml-3">{{ event?.category }}</span>
          </div>
        </div>

        <p v-if="event?.description" class="mt-6 text-pre-wrap">
          {{ event?.description }}
        </p>

        <v-row v-if="event?.images?.length > 0" class="mt-6" justify="start">
          <v-col v-for="(image, index) in event?.images" :key="index" cols="6">
            <lightbox
              :key="image"
              :aspect-ratio="1.45"
              :img-set="event.images.map(img => getWishlistImageUrl(img))"
              :img-src="getWishlistImageUrl(image)"
              :opening-index="index"
            />
          </v-col>
        </v-row>
      </v-col>
    </v-row>
  </v-container>
</template>
<style></style>
