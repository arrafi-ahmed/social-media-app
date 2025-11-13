<script setup>
  import { computed, onMounted, reactive, ref } from 'vue'
  import { useDisplay } from 'vuetify'
  import { useStore } from 'vuex'
  import EventFilter from '@/components/EventFilter.vue'
  import EventInfinite from '@/components/EventInfinite.vue'
  import EventsUpcoming from '@/components/EventsUpcoming.vue'
  import { isObjEmpty } from '@/others/util.js'

  definePage({
    name: 'browse',
    meta: {
      requiresAuth: true,
      layout: 'default',
      title: 'Browse',
    },
  })

  const { mobile } = useDisplay()
  const store = useStore()

  const isAdmin = computed(() => store.getters['auth/isAdmin'])
  const moduleName = computed(() =>
    isAdmin.value ? 'eventWall' : 'eventBrowse',
  )
  const moduleCore = computed(() =>
    isAdmin.value ? store.state.eventWall : store.state.eventBrowse,
  )
  const events = computed(() => moduleCore.value.events)
  const upcomingEvents = computed(() => moduleCore.value.upcomingEvents)

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
  const page = computed(() => moduleCore.value.page)
  let isLoading = false

  async function loadEvents ({ done }) {
    if (isLoading) return
    isLoading = true
    try {
      const action
        = filterActive.value === 'findForm' ? 'findEvents' : 'setEvents'

      const payload = {
        searchKeyword:
          filterActive.value === 'findForm' ? findFormData.searchKeyword : null,
        startDate:
          filterActive.value === 'findForm' ? findFormData.startDate : null,
        endDate: filterActive.value === 'findForm' ? findFormData.endDate : null,
        category: findFormData.category,
        sort: findFormData.sort,
        page: page.value,
      }

      const result = await store.dispatch(
        `${moduleName.value}/${action}`,
        payload,
      )
      store.commit(`${moduleName.value}/setPage`, page.value + 1)

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
    store.commit(`${moduleName.value}/setPage`, 1)
    store.commit(`${moduleName.value}/resetEvents`)
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

  function handleSort (form) {
    setFindFormData('findForm', form)
    store.dispatch('user/updateSettings', {
      ...settings.value,
      sort: form.sort,
    })
  }

  async function fetchData () {
    resetPageNEvents()

    await store.dispatch(`${moduleName.value}/getUpcomingEvents`, {
      userId: store.getters['user/getCurrentUserId'],
      source: 'friends',
    })
  }

  const routeInfo = computed(() => store.state.routeInfo)

  onMounted(() => {
    const cameFromEventContext = ['eventSingle', 'eventEdit'].includes(routeInfo.value.from?.name)
    const shouldRestore = cameFromEventContext && ['back', 'edit'].includes(routeInfo.value.actionSource)

    if (shouldRestore) {
      if (events.value.length === 0) {
        fetchData()
      } else if (routeInfo.value.lastScrollY != null) {
        window.scrollTo(0, routeInfo.value.lastScrollY)
      }
      return
    }

    fetchData()
  })
</script>

<template>
  <v-container>
    <v-row :no-gutters="!!mobile">
      <!-- Sidebar -->
      <v-col
        :class="{ 'flex-sticky top-60': !mobile }"
        cols="12"
        lg="3"
        order-lg="2"
      >
        <!--        for mobile screen-->
        <div v-if="mobile">
          <v-expansion-panels class="mb-4 expansion-pa-0" variant="popout">
            <v-expansion-panel>
              <v-expansion-panel-title>Upcoming Events</v-expansion-panel-title>
              <v-expansion-panel-text>
                <events-upcoming :events="upcomingEvents" type="headerless" />
              </v-expansion-panel-text>
            </v-expansion-panel>
            <v-expansion-panel>
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
          <!-- Upcoming Events Section -->
          <events-upcoming :events="upcomingEvents" type="has-header" />
        </div>
      </v-col>

      <!-- Main content -->
      <v-col cols="12" lg="9" order-lg="1">
        <!-- Filter Form -->
        <event-filter
          v-if="!mobile"
          @find-events="handleFindEvents"
          @reset-find-events="handleResetFindEvents"
          @sort-events="handleSort"
        />

        <!-- Event Posts Feed -->
        <event-infinite
          :events="events"
          :grid="{ sm: 6 }"
          source="browse"
          type="has-header"
          @fetch-events="loadEvents"
        />
      </v-col>
    </v-row>
  </v-container>
</template>

<style></style>
