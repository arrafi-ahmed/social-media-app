<script setup>
  import { computed, onMounted } from 'vue'
  import { useRouter } from 'vue-router'
  import { useDisplay } from 'vuetify'
  import { useStore } from 'vuex'
  import EventInfinite from '@/components/EventInfinite.vue'
  import PageTitle from '@/components/PageTitle.vue'

  definePage({
    name: 'wishlist',
    meta: {
      requiresAuth: true,
      title: 'Wishlist',
      layout: 'default',
    },
  })

  const { xs } = useDisplay()
  const store = useStore()

  const calcHome = computed(() => store.getters['auth/calcHome'])
  const events = computed(() => store.state.eventWishlist.events)
  const router = useRouter()
  const currentUser = store.getters['auth/getCurrentUser']

  const page = computed(() => store.state.eventWishlist.page)
  let isLoading = false

  async function loadEvents ({ done }) {
    if (isLoading) return
    isLoading = true
    try {
      const payload = { page: page.value }
      const result = await store.dispatch('eventWishlist/setEvents', payload)
      store.commit('eventWishlist/setPage', page.value + 1)
      done(result && result.data?.payload?.length < 1 ? 'empty' : 'ok')
    } catch {
      done('error')
    } finally {
      isLoading = false
    }
  }

  const routeInfo = computed(() => store.state.routeInfo)

  function openAddEvent () {
    router.push({ name: 'wishlistAdd', params: { id: currentUser.slug || currentUser.id } })
  }

  onMounted(() => {
    if (['wishlistSingle', 'wishlistEdit'].includes(routeInfo.value.from?.name)) {
      if (routeInfo.value.lastScrollY)
        window.scrollTo(0, routeInfo.value.lastScrollY)
      return
    }
    // store.commit("eventWishlist/resetEvents");
    store.dispatch('category/setCategories')
  })
</script>

<template>
  <v-container>
    <v-row v-if="events">
      <!-- Main content -->
      <v-col cols="12">
        <page-title :back-url="calcHome" subtitle="Your future plans" title="Wishlist">
          <v-btn
            v-if="xs"
            color="primary"
            icon="mdi-plus-circle-outline"
            rounded
            tile
            variant="text"
            @click="openAddEvent"
          />
          <v-menu v-else>
            <template #activator="{ props: menuProps }">
              <v-btn
                icon="mdi-dots-vertical"
                location="top end"
                rounded
                v-bind="menuProps"
                variant="text"
              />
            </template>
            <v-list density="compact">
              <v-list-item link title="Add Event" @click="openAddEvent" />
            </v-list>
          </v-menu>
        </page-title>

        <!-- Event Card Feed -->
        <event-infinite
          :events="events"
          :grid="{ sm: 6, md: 4 }"
          source="wishlist"
          type="headerless"
          @fetch-events="loadEvents"
        />
      </v-col>
    </v-row>
  </v-container>
</template>

<style scoped></style>
