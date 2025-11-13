<script setup>
  import { computed, onMounted, ref } from 'vue'
  import { useStore } from 'vuex'
  import EventInfinite from '@/components/EventInfinite.vue'
  import GroupDialog from '@/components/GroupDialog.vue'
  import GroupMemberDialog from '@/components/GroupMemberDialog.vue'
  import PageTitle from '@/components/PageTitle.vue'

  definePage({
    name: 'groups',
    meta: {
      requiresAuth: true,
      title: 'Groups',
      layout: 'default',
    },
  })

  const store = useStore()
  const calcHome = computed(() => store.getters['auth/calcHome'])
  const groups = computed(() => store.state.group.groups)
  const selectedGroup = computed(() => store.state.group.selectedGroup)
  const events = computed(() => store.state.group.events)
  const page = computed(() => store.state.group.page)

  const dialogOpen = ref(false)
  const editingGroup = ref(null)
  const deletingGroup = ref(null)
  const deleteDialogOpen = ref(false)
  const memberDialogOpen = ref(false)
  const managingGroup = ref(null)

  let isLoading = false

  async function loadEvents ({ done }) {
    if (isLoading) return
    isLoading = true

    const payload = { page: page.value }
    try {
      const currentUser = store.getters['auth/getCurrentUser']
      const result = await store.dispatch('group/setEvents', {
        ...payload,
        userId: currentUser.id,
        sort: 'LATEST',
      })
      store.commit('group/setPage', page.value + 1)
      done(result && result.data?.payload?.length < 1 ? 'empty' : 'ok')
    } catch {
      done('error')
    } finally {
      isLoading = false
    }
  }

  function selectGroup (groupId) {
    store.commit('group/setSelectedGroup', groupId)
    store.commit('group/resetEvents')
    store.commit('group/resetPage')
    // Load events for the selected group
    loadEvents({
      done: () => {},
    })
  }

  function openCreateDialog () {
    editingGroup.value = null
    dialogOpen.value = true
  }

  function openEditDialog (group) {
    editingGroup.value = group
    dialogOpen.value = true
  }

  function openMemberDialog (group) {
    managingGroup.value = group
    memberDialogOpen.value = true
  }

  function handleSaved () {
    // Refresh groups list
    store.dispatch('group/getGroups')
    // If we're viewing the edited group, refresh events
    if (editingGroup.value && selectedGroup.value === editingGroup.value.id) {
      store.commit('group/resetEvents')
      store.commit('group/resetPage')
      loadEvents({
        done: () => {},
      })
    }
  }

  async function handleDeleteGroup () {
    if (!deletingGroup.value) return
    try {
      await store.dispatch('group/deleteGroup', deletingGroup.value.id)
      // Refresh groups list
      await store.dispatch('group/getGroups')
      // If we were viewing the deleted group, switch to "All"
      if (selectedGroup.value === deletingGroup.value.id) {
        selectGroup(null)
      }
      deletingGroup.value = null
      deleteDialogOpen.value = false
    } catch (error) {
      console.error('Error deleting group:', error)
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
    // Load groups
    await store.dispatch('group/getGroups')
    // Reset to "All" view
    selectGroup(null)
  })
</script>

<template>
  <v-container>
    <v-row>
      <!-- Main content -->
      <v-col cols="12">
        <page-title :back-url="calcHome" subtitle="Share events with private groups" title="Groups">
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
                  prepend-icon="mdi-account-plus"
                  title="Add Group"
                  @click="openCreateDialog"
                />
              </v-list>
            </v-menu>
          </template>
          <template #mobile-actions>
            <v-btn
              color="primary"
              icon="mdi-account-plus"
              rounded
              variant="flat"
              @click="openCreateDialog"
            />
          </template>
        </page-title>

        <div class="page-content">
          <!-- Groups List -->
          <div class="d-flex align-center" style="gap: 8px; flex-wrap: wrap;">
            <!-- All Chip -->
            <v-chip
              class="clickable"
              :color="selectedGroup === null ? 'primary' : 'default'"
              size="large"
              :variant="selectedGroup === null ? 'flat' : 'outlined'"
              @click="selectGroup(null)"
            >
              <v-icon icon="mdi-view-grid" start />
              All
            </v-chip>
            <!-- Group Chips -->
            <v-chip
              v-for="group in groups"
              :key="group.id"
              class="clickable"
              :color="selectedGroup === group.id ? (group.color || 'primary') : 'default'"
              size="large"
              :variant="selectedGroup === group.id ? 'flat' : 'outlined'"
              @click="selectGroup(group.id)"
            >
              <v-icon :icon="group.icon || 'mdi-account-group'" start />
              {{ group.name }}
              <span v-if="group.memberCount > 0" class="ml-1">({{ group.memberCount }})</span>

              <!-- Group Menu -->
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
                  <v-list-item
                    prepend-icon="mdi-account-multiple"
                    @click="openMemberDialog(group)"
                  >
                    <v-list-item-title>Manage Members</v-list-item-title>
                  </v-list-item>
                  <v-list-item
                    prepend-icon="mdi-pencil"
                    @click="openEditDialog(group)"
                  >
                    <v-list-item-title>Edit</v-list-item-title>
                  </v-list-item>
                  <v-divider />
                  <v-list-item
                    class="text-error"
                    prepend-icon="mdi-delete"
                    @click="() => { deletingGroup = group; deleteDialogOpen = true }"
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
            source="group"
            type="has-header"
            @fetch-events="loadEvents"
          />
        </div>
      </v-col>
    </v-row>

    <!-- Group Dialog -->
    <group-dialog
      v-model="dialogOpen"
      :group="editingGroup"
      @saved="handleSaved"
    />

    <!-- Group Member Dialog -->
    <group-member-dialog
      v-model="memberDialogOpen"
      :group="managingGroup"
      @updated="handleSaved"
    />

    <!-- Delete Confirmation Dialog -->
    <v-dialog
      v-model="deleteDialogOpen"
      :width="400"
    >
      <v-card>
        <v-card-title>Delete Group</v-card-title>
        <v-card-text>
          Are you sure you want to delete this group? All events shared with this group will remain, but the group will
          be removed.
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
            @click="handleDeleteGroup"
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
