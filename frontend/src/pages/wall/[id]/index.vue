<script setup>
  import { computed, onMounted, reactive, ref, watch } from 'vue'
  import { useRoute, useRouter } from 'vue-router'
  import { useDisplay } from 'vuetify'
  import { useStore } from 'vuex'
  import CategoryList from '@/components/CategoryList.vue'
  import EventFeatured from '@/components/EventFeatured.vue'
  import EventFilter from '@/components/EventFilter.vue'
  import EventInfinite from '@/components/EventInfinite.vue'
  import EventsUpcoming from '@/components/EventsUpcoming.vue'
  import NameCard from '@/components/NameCard.vue'
  import { isObjEmpty } from '@/others/util.js'

  definePage({
    name: 'wall',
    meta: {
      requiresAuth: true,
      title: 'Wall',
      layout: 'default',
    },
  })

  const { xs } = useDisplay()
  const route = useRoute()
  const router = useRouter()
  const store = useStore()

  const currentUser = store.getters['auth/getCurrentUser']
  const isAdmin = store.getters['auth/isAdmin']
  const isSubscriptionValid = computed(
    () => store.getters['subscription/isSubscriptionValid'],
  )

  async function openAddEvent () {
    await store.dispatch('subscription/fetchPremiumSubscriptionData', {
      userId: currentUser.id,
    })
    return isSubscriptionValid.value
      ? router.push({ name: 'eventAdd' })
      : router.push({ name: 'pricing' })
  }

  const events = computed(() => store.state.eventWall.events)
  const user = computed(() => store.state.eventWall.user)
  const featuredEvent = computed(() => store.state.eventWall.featuredEvent)
  const upcomingEvents = computed(() => store.state.eventWall.upcomingEvents)
  const mountedEventCategories = computed(
    () => store.getters['eventWall/getMountedEventCategories'],
  )

  const settings = computed(() => store.state.user.settings)
  if (isObjEmpty(settings.value?.sort)) {
    store.dispatch('user/setUserSettings')
  }

  const filterActive = ref('none')
  const findFormData = reactive({
    searchKeyword: null,
    startDate: null,
    endDate: null,
    category: null,
    sort: settings.value?.sort,
  })
  const page = computed(() => store.state.eventWall.page)
  let isLoading = false

  async function loadEvents ({ done }) {
    if (isLoading) return
    
    // Prevent refetching page 1 if events already exist when returning from eventSingle
    // This keeps the events in store and maintains scroll position
    const isReturningFromEventSingle = 
      ['eventSingle', 'eventEdit', 'eventEdit-wall'].includes(routeInfo.value.from?.name) &&
      routeInfo.value.actionSource === 'back'
    
    // Only skip if we're returning from eventSingle AND events already exist
    // If events.length is 0, we still need to load them
    if (isReturningFromEventSingle && events.value.length > 0 && page.value === 1 && filterActive.value !== 'findForm') {
      done('ok')
      return
    }
    
    isLoading = true
    try {
      const action
        = filterActive.value === 'findForm' ? 'findEvents' : 'setEvents'

      // Get userId from route params
      const routeId = route.params.id
      let userId = null

      // If routeId is numeric, use it directly
      if (/^\d+$/.test(routeId)) {
        userId = Number.parseInt(routeId, 10)
      } else {
        // It's a slug - verify user in store matches current route
        // setUser and setEvents may fire at same time, so we need to check
        if (user.value?.slug === routeId && user.value?.id) {
          userId = user.value.id
        } else {
          // User not loaded yet or doesn't match route - wait a bit
          await new Promise(resolve => setTimeout(resolve, 100))
          if (user.value?.slug === routeId && user.value?.id) {
            userId = user.value.id
          }
        }
      }

      if (!userId || isNaN(userId)) {
        done('error')
        isLoading = false
        return
      }

      const payload = {
        userId: userId,
        searchKeyword:
          filterActive.value === 'findForm' ? findFormData.searchKeyword : null,
        startDate:
          filterActive.value === 'findForm' ? findFormData.startDate : null,
        endDate: filterActive.value === 'findForm' ? findFormData.endDate : null,
        category: findFormData.category,
        sort: findFormData.sort,
        page: page.value,
      }
      const result = await store.dispatch(`eventWall/${action}`, payload)
      store.commit('eventWall/setPage', page.value + 1)

      done(result && result.data?.payload?.length < 1 ? 'empty' : 'ok')
      await store.dispatch('category/setCategories')
    } catch {
      done('error')
    } finally {
      isLoading = false
    }
  }

  function nullifyFindFormData () {
    findFormData.searchKeyword
      = findFormData.startDate
      = findFormData.endDate
      = findFormData.category
      = null
  }

  function resetPageNEvents () {
    store.commit('eventWall/setPage', 1)
    store.commit('eventWall/resetEvents')
  }

  async function setFindFormData (filterValue, formOrCategory) {
    resetPageNEvents()

    filterActive.value = filterValue
    if (filterValue === 'findForm') {
      Object.assign(findFormData, formOrCategory)
    } else if (filterValue === 'none') {
      nullifyFindFormData()
    }
  }

  const handleResetFindEvents = () => setFindFormData('none')
  const handleFindEvents = form => setFindFormData('findForm', form)
  const handleClickCategory = category => setFindFormData('findForm', { category })

  function handleSort (form) {
    setFindFormData('findForm', form)
    store.dispatch('user/updateSettings', {
      ...settings.value,
      sort: form.sort,
    })
  }

  async function fetchData () {
    resetPageNEvents()

    // Try to fetch user by slug or id
    let userData
    let userId

    try {
      // Check if route.params.id is a number (userId) or string (slug)
      const isNumeric = /^\d+$/.test(route.params.id)

      if (isNumeric) {
        // It's a userId, use getUserById
        const response = await store.dispatch('eventWall/getUserById', route.params.id)
        userData = response.data?.payload
        userId = route.params.id
      } else {
        // It's a slug, use getUserBySlug
        const response = await store.dispatch('eventWall/getUserBySlug', route.params.id)
        userData = response.data?.payload
        userId = userData?.id
      }

      if (!userData) {
        router.push({ name: 'notFound' })
        return
      }

      // Check if current user has access to this profile
      const validFriends = userId == currentUser.id
        ? true
        : await store
          .dispatch('user/checkFriends', userId)
          .then(result => result.data.payload)

      if (validFriends || isAdmin) {
        // Fetch profile data
        await Promise.all([
          store.dispatch('eventWall/getFeaturedEvent', userId),
          store.dispatch('eventWall/getUpcomingEvents', {
            userId: userId,
            source: 'own',
          }),
        ])
      // EventInfinite component will automatically trigger loadEvents via @load event
      } else {
        router.push({
          name: 'notFound',
          params: {
            status: 401,
            message: 'You don\'t have access to the profile!',
          },
        })
      }
    } catch (error) {
      console.error('Error fetching user data:', error)
      router.push({ name: 'notFound' })
    }
  }

  const routeInfo = computed(() => store.state.routeInfo)
  const isOwnProfile = computed(() => user.value?.id === currentUser.id)

  onMounted(() => {
    // fix: going other profile from event single - comment namecard, then return to event single - back btn. dont update new profile info
    if (user.value?.id && user.value?.id != route.params.id) {
      fetchData()
    }
    if (
      ['eventSingle', 'eventEdit', 'eventEdit-wall'].includes(routeInfo.value.from?.name)
      && routeInfo.value.actionSource === 'back'
    ) {
      // Restore scroll position after a brief delay to ensure DOM is ready
      if (routeInfo.value.lastScrollY) {
        setTimeout(() => {
          window.scrollTo(0, routeInfo.value.lastScrollY)
        }, 100)
      }
      return
    }
    fetchData()
  })
  watch(
    () => route.params.id,
    (newItem, oldItem) => {
      if (route.name === 'wall' && newItem && newItem !== oldItem) {
        fetchData()
      }
    },
  )
</script>

<template>
  <v-container>
    <div class="d-flex justify-space-between align-center">
      <!--      {{user}}-->
      <name-card
        :img-size="100"
        :is-detailed="false"
        :profile="user"
        rounded="lg"
      />

      <v-divider v-if="xs" inset vertical />

      <v-btn
        v-if="xs && isOwnProfile"
        color="primary"
        icon="mdi-plus"
        rounded        
        variant="flat"
        @click="openAddEvent"
      />
      <v-menu v-else-if="!xs && isOwnProfile">
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
          <v-list-item
            link
            prepend-icon="mdi-calendar-plus"
            title="Add Event"
            @click="openAddEvent"
          />
        </v-list>
      </v-menu>
    </div>
    <v-divider class="my-3" />

    <v-row :no-gutters="!!xs">
      <!-- Sidebar -->
      <v-col
        :class="{ 'flex-sticky top-60': !xs }"
        cols="12"
        lg="3"
        order-lg="2"
      >
        <!--        for xs screen-->
        <div v-if="xs">
          <v-expansion-panels class="mb-4 expansion-pa-0" variant="popout">
            <v-expansion-panel>
              <v-expansion-panel-title>Featured Event</v-expansion-panel-title>
              <v-expansion-panel-text>
                <event-featured
                  v-if="featuredEvent?.id"
                  :event="featuredEvent"
                  type="headerless"
                />
                <div v-else>
                  <small>No featured event set</small>
                </div>
              </v-expansion-panel-text>
            </v-expansion-panel>
            <v-expansion-panel>
              <v-expansion-panel-title>Event Categories
              </v-expansion-panel-title>
              <v-expansion-panel-text>
                <category-list
                  :categories="mountedEventCategories"
                  :selected="findFormData.category"
                  type="headerless"
                  @click-category="handleClickCategory"
                />
              </v-expansion-panel-text>
            </v-expansion-panel>
            <v-expansion-panel>
              <v-expansion-panel-title>Upcoming Events</v-expansion-panel-title>
              <v-expansion-panel-text>
                <events-upcoming :events="upcomingEvents" type="headerless" />
              </v-expansion-panel-text>
            </v-expansion-panel>
            <v-expansion-panel class="find-events">
              <v-expansion-panel-title>Find Events</v-expansion-panel-title>
              <v-expansion-panel-text>
                <event-filter
                  @find-events="handleFindEvents"
                  @reset-find-events="handleResetFindEvents"
                  @sort-events="handleSort"
                />
              </v-expansion-panel-text>
            </v-expansion-panel>
          </v-expansion-panels>
        </div>

        <!--        for large screen-->
        <div v-else>
          <!-- Featured event -->
          <event-featured
            v-if="featuredEvent?.id"
            :event="featuredEvent"
            type="has-header"
          />

          <!-- Categories Section -->
          <category-list
            :categories="mountedEventCategories"
            :selected="findFormData.category"
            type="has-header"
            @click-category="handleClickCategory"
          />

          <!-- Upcoming Events Section -->
          <events-upcoming :events="upcomingEvents" type="has-header" />
        </div>
      </v-col>

      <!-- Main content -->
      <v-col cols="12" lg="9" order-lg="1">
        <!-- Filter Form -->
        <event-filter
          v-if="!xs"
          @find-events="handleFindEvents"
          @reset-find-events="handleResetFindEvents"
          @sort-events="handleSort"
        />

        <!-- Event Posts Feed -->
        <event-infinite
          :events="events"
          :grid="{ sm: 6 }"
          source="wall"
          type="headerless"
          @fetch-events="loadEvents"
        />
      </v-col>
    </v-row>
  </v-container>
</template>

<style scoped></style>
