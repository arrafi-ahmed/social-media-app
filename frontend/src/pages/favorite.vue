<script setup>
  import { computed, onMounted } from 'vue'
  import { useStore } from 'vuex'
  import EventInfinite from '@/components/EventInfinite.vue'
  import PageTitle from '@/components/PageTitle.vue'

  definePage({
    name: 'favorite',
    meta: {
      requiresAuth: true,
      title: 'Favorites',
      layout: 'default',
    },
  })

  const store = useStore()
  const calcHome = computed(() => store.getters['auth/calcHome'])
  const events = computed(() => store.state.eventFavorite.events)

  const page = computed(() => store.state.eventFavorite.page)
  let isLoading = false

  async function loadEvents ({ done }) {
    if (isLoading) return
    isLoading = true

    const payload = { page: page.value }
    try {
      const result = await store.dispatch('eventFavorite/setEvents', payload)
      store.commit('eventFavorite/setPage', page.value + 1)
      done(result && result.data?.payload?.length < 1 ? 'empty' : 'ok')
    } catch {
      done('error')
    } finally {
      isLoading = false
    }
  }

  const routeInfo = computed(() => store.state.routeInfo)

  onMounted(() => {
    if (
      ['eventSingle'].includes(routeInfo.value.from?.name)
      && routeInfo.value.actionSource === 'back'
    ) {
      if (routeInfo.value.lastScrollY)
        window.scrollTo(0, routeInfo.value.lastScrollY)
      return
    }
    store.commit('eventFavorite/resetEvents')
    store.commit('eventFavorite/resetPage')
  })
</script>

<template>
  <v-container>
    <v-row v-if="events">
      <!-- Main content -->
      <v-col cols="12">
        <page-title :back-url="calcHome" subtitle="Your saved events" title="Favourite" />

        <!-- Event Card Feed -->
        <event-infinite
          :events="events"
          :grid="{ sm: 6, md: 4 }"
          source="favorite"
          type="has-header"
          @fetch-events="loadEvents"
        />
      </v-col>
    </v-row>
  </v-container>
</template>

<style scoped></style>
