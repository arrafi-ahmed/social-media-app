<script setup>
  import { computed, onMounted, ref, watch } from 'vue'
  import { useStore } from 'vuex'
  import NameCard from '@/components/NameCard.vue'
  import $axios from '@/plugins/axios'

  const props = defineProps({
    modelValue: {
      type: Boolean,
      default: false,
    },
    group: {
      type: Object,
      default: null,
    },
  })

  const emit = defineEmits(['update:modelValue', 'updated'])

  const store = useStore()

  const dialog = computed({
    get: () => props.modelValue,
    set: value => emit('update:modelValue', value),
  })

  const friends = computed(() => store.state.user.friends)
  const currentUser = computed(() => store.getters['auth/getCurrentUser'])
  const members = computed(() => {
    if (!props.group) return []
    return store.state.group.members[props.group.id] || []
  })

  const friendSearch = ref('')
  const searchResults = ref([])
  const isSearching = ref(false)
  const isLoading = ref(false)

  const filteredFriends = computed(() => {
    if (!friendSearch.value) return friends.value
    const search = friendSearch.value.toLowerCase()
    return friends.value.filter(friend => 
      friend.fullName?.toLowerCase().includes(search) ||
      friend.email?.toLowerCase().includes(search)
    )
  })

  const availableFriends = computed(() => {
    const memberIds = new Set(members.value.map(m => m.userId))
    return filteredFriends.value.filter(friend => 
      !memberIds.has(friend.id) && friend.id !== currentUser.value?.id
    )
  })

  watch(() => props.modelValue, async newVal => {
    if (newVal && props.group) {
      await loadMembers()
    }
  })

  async function loadMembers () {
    if (!props.group) return
    try {
      isLoading.value = true
      await store.dispatch('group/getGroupMembers', props.group.id)
    } catch (error) {
      console.error('Error loading members:', error)
    } finally {
      isLoading.value = false
    }
  }

  async function addMember (friend) {
    if (!props.group) return
    try {
      await store.dispatch('group/addMember', {
        groupId: props.group.id,
        userId: friend.id,
        role: 'member',
      })
      friendSearch.value = ''
      // Reload members list to get full member data (including name, image, etc.)
      await loadMembers()
      // Refresh groups list to update member count
      await store.dispatch('group/getGroups')
      emit('updated')
    } catch (error) {
      console.error('Error adding member:', error)
    }
  }

  async function removeMember (member) {
    if (!props.group) return
    try {
      await store.dispatch('group/removeMember', {
        groupId: props.group.id,
        memberId: member.userId,
      })
      // Reload members list to reflect the removal
      await loadMembers()
      // Refresh groups list to update member count
      await store.dispatch('group/getGroups')
      emit('updated')
    } catch (error) {
      console.error('Error removing member:', error)
    }
  }

  function getRoleLabel (role) {
    switch (role) {
      case 'owner':
        return 'Owner'
      case 'admin':
        return 'Admin'
      default:
        return 'Member'
    }
  }

  function canRemoveMember (member) {
    const userRole = members.value.find(m => m.userId === currentUser.value?.id)?.role
    return userRole === 'owner' || userRole === 'admin' || member.userId === currentUser.value?.id
  }

  onMounted(() => {
    store.dispatch('user/setFriends')
  })
</script>

<template>
  <v-dialog
    v-model="dialog"
    :width="500"
    @update:model-value="dialog = $event"
  >
    <v-card>
      <v-card-title>
        <span>Manage Members</span>
      </v-card-title>

      <v-card-text>
        <div v-if="group" class="mb-4">
          <div class="text-h6 mb-1">{{ group.name }}</div>
          <div class="text-body-2 text-medium-emphasis">
            {{ members.length }} member{{ members.length !== 1 ? 's' : '' }}
          </div>
        </div>

        <!-- Search and Add Members -->
        <div class="mb-4">
          <v-text-field
            v-model="friendSearch"
            class="mb-2"
            clearable
            density="compact"
            hide-details
            label="Search friends to add"
            prepend-inner-icon="mdi-magnify"
            variant="solo"
          />

          <div v-if="availableFriends.length > 0" class="mt-2">
            <v-list density="compact">
              <v-list-item
                v-for="friend in availableFriends"
                :key="friend.id"
                class="px-0"
              >
                <template #prepend>
                  <name-card
                    container-class="flex-grow-1"
                    img-size="40"
                    :profile="friend"
                    rounded="circle"
                  />
                </template>
                <template #append>
                  <v-btn
                    color="primary"
                    icon="mdi-plus"
                    size="small"
                    variant="text"
                    @click="addMember(friend)"
                  />
                </template>
              </v-list-item>
            </v-list>
          </div>
          <div v-else-if="friendSearch && availableFriends.length === 0" class="text-body-2 text-medium-emphasis mt-2 text-center py-2">
            No friends found matching "{{ friendSearch }}"
          </div>
          <div v-else-if="!friendSearch && friends.length === 0" class="text-body-2 text-medium-emphasis mt-2 text-center py-2">
            You don't have any friends yet. Invite friends to add them to groups.
          </div>
          <div v-else-if="!friendSearch && availableFriends.length === 0 && members.length > 0" class="text-body-2 text-medium-emphasis mt-2 text-center py-2">
            All your friends are already members of this group
          </div>
        </div>

        <v-divider class="my-4" />

        <!-- Current Members -->
        <div>
          <div class="text-subtitle-2 mb-2">Current Members</div>
          <div v-if="isLoading" class="text-center py-4">
            <v-progress-circular
              indeterminate
              color="primary"
              size="24"
            />
          </div>
          <div v-else-if="members.length === 0" class="text-body-2 text-medium-emphasis py-4">
            No members yet
          </div>
          <v-list v-else density="compact">
            <v-list-item
              v-for="member in members"
              :key="member.userId"
              class="px-0"
            >
              <template #prepend>
                <name-card
                  container-class="flex-grow-1"
                  img-size="40"
                  :profile="member"
                  rounded="circle"
                />
              </template>
              <template #append>
                <div class="d-flex align-center gap-2">
                  <v-chip
                    :color="member.role === 'owner' ? 'primary' : 'default'"
                    size="small"
                    variant="flat"
                  >
                    {{ getRoleLabel(member.role) }}
                  </v-chip>
                  <v-btn
                    v-if="canRemoveMember(member)"
                    color="error"
                    icon="mdi-delete"
                    size="small"
                    variant="text"
                    @click="removeMember(member)"
                  />
                </div>
              </template>
            </v-list-item>
          </v-list>
        </div>
      </v-card-text>

      <v-card-actions>
        <v-spacer />
        <v-btn
          color="primary"
          variant="flat"
          @click="dialog = false"
        >
          Close
        </v-btn>
      </v-card-actions>
    </v-card>
  </v-dialog>
</template>

<style scoped></style>

