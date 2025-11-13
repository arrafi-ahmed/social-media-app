<script setup>
  import { computed, onMounted, ref } from 'vue'
  import { useStore } from 'vuex'
  import CollectionDialog from '@/components/CollectionDialog.vue'
  import EventInfinite from '@/components/EventInfinite.vue'
  import PageTitle from '@/components/PageTitle.vue'

  definePage({
    name: 'collection',
    meta: {
      requiresAuth: true,
      title: 'Collections',
      layout: 'default',
    },
  })

  const store = useStore()
  const calcHome = computed(() => store.getters['auth/calcHome'])
  const collections = computed(() => store.state.eventCollection.collections)
  const selectedCollection = computed(() => store.state.eventCollection.selectedCollection)
  const events = computed(() => store.state.eventCollection.events)
  const page = computed(() => store.state.eventCollection.page)

  const dialogOpen = ref(false)
  const editingCollection = ref(null)
  const deletingCollection = ref(null)
  const deleteDialogOpen = ref(false)

  let isLoading = false

  async function loadEvents ({ done }) {
    if (isLoading) return
    isLoading = true

    const payload = { page: page.value }
    try {
      const result = await store.dispatch('eventCollection/setEvents', payload)
      store.commit('eventCollection/setPage', page.value + 1)
      done(result && result.data?.payload?.length < 1 ? 'empty' : 'ok')
    } catch {
      done('error')
    } finally {
      isLoading = false
    }
  }

  function selectCollection (collectionId) {
    store.commit('eventCollection/setSelectedCollection', collectionId)
    store.commit('eventCollection/resetEvents')
    store.commit('eventCollection/resetPage')
    // Load events for the selected collection
    loadEvents({
      done: () => {},
    })
  }

  function openCreateDialog () {
    editingCollection.value = null
    dialogOpen.value = true
  }

  function openEditDialog (collection) {
    editingCollection.value = collection
    dialogOpen.value = true
  }

  function handleSaved () {
    // Refresh collections list
    store.dispatch('eventCollection/getCollections')
    // If we're viewing the edited collection, refresh events
    if (editingCollection.value && selectedCollection.value === editingCollection.value.id) {
      store.commit('eventCollection/resetEvents')
      store.commit('eventCollection/resetPage')
      loadEvents({
        done: () => {},
      })
    }
  }

  async function handleDeleteCollection () {
    if (!deletingCollection.value) return
    try {
      await store.dispatch('eventCollection/deleteCollection', deletingCollection.value.id)
      // Refresh collections list
      await store.dispatch('eventCollection/getCollections')
      // If we were viewing the deleted collection, switch to "All"
      if (selectedCollection.value === deletingCollection.value.id) {
        selectCollection(null)
      }
      deletingCollection.value = null
      deleteDialogOpen.value = false
    } catch (error) {
      console.error('Error deleting collection:', error)
      deleteDialogOpen.value = false
    }
  }

  const routeInfo = computed(() => store.state.routeInfo)

  onMounted(async () => {
    if (
      ['eventSingle'].includes(routeInfo.value.from?.name)
      && routeInfo.value.actionSource === 'back'
    ) {
      if (routeInfo.value.lastScrollY)
        window.scrollTo(0, routeInfo.value.lastScrollY)
      return
    }
    // Load collections
    await store.dispatch('eventCollection/getCollections')
    // Reset to "All" view
    selectCollection(null)
  })
</script>

<template>
  <v-container>
    <v-row>
      <!-- Main content -->
      <v-col cols="12">
        <page-title :back-url="calcHome" subtitle="Organize your saved events" title="Collections">
          <template #actions>
            <v-menu>
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
                  prepend-icon="mdi-folder-plus"
                  title="Add Collection"
                  @click="openCreateDialog"
                />
              </v-list>
            </v-menu>
          </template>
          <template #mobile-actions>
            <v-btn
              color="primary"
              icon="mdi-folder-plus"
              rounded
              variant="flat"
              @click="openCreateDialog"
            />
          </template>
        </page-title>

        <div class="page-content">
          <!-- Collections List -->
          <div class="d-flex align-center" style="gap: 8px; flex-wrap: wrap;">
            <!-- All Chip -->
            <v-chip
              class="clickable"
              :color="selectedCollection === null ? 'primary' : 'default'"
              size="large"
              :variant="selectedCollection === null ? 'flat' : 'outlined'"
              @click="selectCollection(null)"
            >
              <v-icon icon="mdi-view-grid" start />
              All
            </v-chip>
            <!-- Collection Chips -->
            <v-chip
              v-for="collection in collections"
              :key="collection.id"
              class="clickable"
              :color="selectedCollection === collection.id ? (collection.color || 'primary') : 'default'"
              size="large"
              :variant="selectedCollection === collection.id ? 'flat' : 'outlined'"
              @click="selectCollection(collection.id)"
            >
              <v-icon :icon="collection.icon || 'mdi-folder'" start />
              {{ collection.name }}
              <span v-if="collection.event_count > 0" class="ml-1">({{ collection.event_count }})</span>

              <!-- Collection Menu -->
              <v-menu location="bottom">
                <template #activator="{ props: menuProps }">
                  <v-icon
                    class="ml-1"
                    size="small"
                    v-bind="menuProps"
                    @click.stop
                  >mdi-dots-vertical
                  </v-icon>
                </template>
                <v-list density="compact">
                  <v-list-item @click="openEditDialog(collection)">
                    <v-list-item-title>Edit</v-list-item-title>
                  </v-list-item>
                  <v-divider />
                  <v-list-item
                    class="text-error"
                    @click="() => { deletingCollection = collection; deleteDialogOpen = true }"
                  >
                    <v-list-item-title>Delete</v-list-item-title>
                  </v-list-item>
                </v-list>
              </v-menu>
            </v-chip>
          </div>

          <!-- Event Card Feed -->
          <event-infinite
            v-if="events"
            :events="events"
            :grid="{ sm: 6, md: 4 }"
            source="collection"
            type="has-header"
            @fetch-events="loadEvents"
          />
        </div>
      </v-col>
    </v-row>

    <!-- Collection Dialog -->
    <collection-dialog
      v-model="dialogOpen"
      :collection="editingCollection"
      @saved="handleSaved"
    />

    <!-- Delete Confirmation Dialog -->
    <v-dialog
      v-model="deleteDialogOpen"
      :width="400"
    >
      <v-card>
        <v-card-title>Delete Collection</v-card-title>
        <v-card-text>
          Are you sure you want to delete this collection? All events in this collection will be removed.
        </v-card-text>
        <v-card-actions>
          <v-spacer />
          <v-btn
            variant="text"
            @click="deleteDialogOpen = false"
          >
            Cancel
          </v-btn>
          <v-btn
            color="error"
            variant="flat"
            @click="handleDeleteCollection"
          >
            Delete
          </v-btn>
        </v-card-actions>
      </v-card>
    </v-dialog>
  </v-container>
</template>

<style scoped>
.clickable {
  cursor: pointer;
}
</style>
