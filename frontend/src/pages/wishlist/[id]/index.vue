<script setup>
  import { computed, onMounted } from 'vue'
  import { useRoute, useRouter } from 'vue-router'
  import { useStore } from 'vuex'
  import DOMPurify from 'dompurify'
  import Lightbox from '@/components/Lightbox.vue'
  import UserAvatar from '@/components/UserAvatar.vue'
  import { formatDateFromTimestamp, getWishlistImageUrl, goUserProfile } from '@/others/util.js'

  // Helper to check if content is HTML and sanitize it
  function getSanitizedDescription(html) {
    if (!html) return ''
    // Check if content contains HTML tags (from rich editor)
    const hasHtmlTags = /<[a-z][\s\S]*>/i.test(html)
    if (hasHtmlTags) {
      return DOMPurify.sanitize(html, {
        ALLOWED_TAGS: ['p', 'br', 'strong', 'em', 'u', 'h1', 'h2', 'h3', 'ul', 'ol', 'li', 'a'],
        ALLOWED_ATTR: ['href', 'target', 'rel'],
        ALLOW_DATA_ATTR: false
      })
    }
    // Plain text - escape HTML and convert newlines to <br>
    const escaped = html
      .replace(/&/g, '&amp;')
      .replace(/</g, '&lt;')
      .replace(/>/g, '&gt;')
    return escaped.replace(/\n/g, '<br>')
  }

  const sanitizedDescription = computed(() => getSanitizedDescription(event.value?.description))

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
  const currentUser = computed(() => store.getters['auth/getCurrentUser'])

  const isEventOwner = computed(() => event.value?.userId === currentUser.value?.id)
  const isAdmin = computed(() => currentUser.value?.role === 10)

  function goBack () {
    store.commit('setActionSource', 'back')
    router.back()
  }

  function goEditWishlist () {
    store.commit('setScrollY', window.scrollY)
    store.commit('eventWishlist/setEditingEvent', event.value)
    router.push({ name: 'wishlistEdit', params: { id: event.value.id } })
  }

  function goUserProfileHandler () {
    if (event.value?.slug) {
      goUserProfile(event.value.slug)
    } else if (event.value?.userId) {
      goUserProfile(event.value.userId)
    }
  }

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
        <v-btn icon="mdi-arrow-left" variant="text" @click="goBack" />
        <user-avatar
          class="ml-2"
          :img-src="event?.image"
          @click-avatar="goUserProfileHandler"
        />

        <div class="pl-3">
          <h4 class="clickable" @click="goUserProfileHandler">{{ event?.fullName }}</h4>
          <small>Posted on {{ formatDateFromTimestamp(event?.createdAt) }}</small>
        </div>
      </v-col>
      <v-col class="d-flex align-center justify-end" cols="auto">
        <v-btn
          v-if="isEventOwner || isAdmin"
          color="primary"
          icon="mdi-pencil"
          variant="text"
          @click="goEditWishlist"
        />
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

        <div
          v-if="event?.description"
          class="mt-6 rich-text-content"
          v-html="sanitizedDescription"
        />

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
<style scoped>
.rich-text-content {
  line-height: 1.6;
}

.rich-text-content :deep(h1),
.rich-text-content :deep(h2),
.rich-text-content :deep(h3) {
  font-weight: 600;
  line-height: 1.2;
  margin-top: 1em;
  margin-bottom: 0.5em;
}

.rich-text-content :deep(h1) {
  font-size: 2em;
}

.rich-text-content :deep(h2) {
  font-size: 1.5em;
}

.rich-text-content :deep(h3) {
  font-size: 1.25em;
}

.rich-text-content :deep(p) {
  margin-bottom: 0.75em;
}

.rich-text-content :deep(ul),
.rich-text-content :deep(ol) {
  padding-left: 1.5em;
  margin-bottom: 0.75em;
}

.rich-text-content :deep(ul) {
  list-style-type: disc;
}

.rich-text-content :deep(ol) {
  list-style-type: decimal;
}

.rich-text-content :deep(li) {
  margin-bottom: 0.25em;
}

.rich-text-content :deep(a) {
  color: rgb(var(--v-theme-primary));
  text-decoration: underline;
}

.rich-text-content :deep(a:hover) {
  opacity: 0.8;
}
</style>
