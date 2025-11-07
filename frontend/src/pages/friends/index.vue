<script setup>
  import { computed, onMounted, ref } from 'vue'
  import { useDisplay } from 'vuetify'
  import { useStore } from 'vuex'
  import ConfirmationDialog from '@/components/ConfirmationDialog.vue'
  import NameCard from '@/components/NameCard.vue'
  import NoItems from '@/components/NoItems.vue'
  import PageTitle from '@/components/PageTitle.vue'

  definePage({
    name: 'friends',
    meta: {
      requiresAuth: true,
      title: 'Friends',
      layout: 'default',
    },
  })

  const { mobile } = useDisplay()
  const store = useStore()

  const calcHome = computed(() => store.getters['auth/calcHome'])
  const friends = computed(() => store.state.user.friends)
  const currentUser = computed(() => store.getters['auth/getCurrentUser'])
  const friendSearch = ref('')

  const form = ref(null)
  const isFormValid = ref(true)

  const dialog = ref(false)
  const email = ref(null)
  const message = ref(null)

  async function sendInvite () {
    await form.value.validate()
    if (!isFormValid.value) return

    const invitation = {
      email: email.value,
      message: message.value,
    }

    store.dispatch('user/sendInvite', invitation).then(result => {
      email.value = null
      message.value = null
      dialog.value = false
    })
  }

  function removeFriend (friendshipId) {
    store.dispatch('user/removeFriend', friendshipId)
  }

  onMounted(() => {
    store.dispatch('user/setFriends')
  })
</script>

<template>
  <v-container>
    <v-row justify="center">
      <!-- Main content -->
      <v-col cols="12">
        <page-title :back-url="calcHome" :subtitle="`${friends.length} friends`" title="Friends">
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
                  title="Invite a friend"
                  @click="$router.push({ name: 'friendsInvite' })"
                />
              </v-list>
            </v-menu>
          </template>
        </page-title>

        <div class="page-content">
          <v-row align="center" justify="center">
            <v-col cols="12" md="7">

              <v-data-iterator
                v-if="friends.length > 0"
                :items="friends"
                :items-per-page="10"
                :search="friendSearch"
              >
                <template #header>
                  <v-spacer />
                  <v-text-field
                    v-model="friendSearch"
                    class="mb-2 mb-md-4"
                    clearable
                    hide-details
                    placeholder="Search friends"
                    prepend-inner-icon="mdi-magnify"
                    rounded="sm"
                  />
                </template>

                <template #default="{ items }">
                  <v-list rounded="sm">
                    <v-list-item
                      v-for="({ raw: item }, index) in items"
                      :key="item.id ?? index"
                      :class="{ 'px-1': mobile }"
                      link
                    >
                      <div
                        class="d-flex justify-space-between align-center"
                        @click="
                          $router.push({ name: 'wall', params: { id: item.slug || item.id } })
                        "
                      >
                        <name-card
                          container-class="clickable"
                          img-size="45"
                          :profile="item"
                          rounded="circle"
                        />
                        <confirmation-dialog
                          popup-content="Are you sure?"
                          popup-title="Remove Friend"
                          @confirm="removeFriend(item.friendshipId)"
                        >
                          <template #activator="{ onClick }">
                            <v-btn
                              color="error"
                              icon="mdi-delete"
                              size="small"
                              variant="text"
                              @click.stop="onClick"
                            />
                          </template>
                        </confirmation-dialog>
                      </div>
                    </v-list-item>
                  </v-list>
                </template>

                <template #footer="{ page, pageCount, setPage }">
                  <v-pagination
                    density="compact"
                    :length="pageCount"
                    :model-value="page"
                    :total-visible="3"
                    @update:model-value="setPage"
                  />
                </template>

                <template #no-data>
                  <no-items
                    action-text="Invite a friend"
                    description="Invite someone to get started."
                    icon="mdi-account-multiple-outline"
                    title="No friends yet"
                    @action="$router.push({ name: 'friendsInvite' })"
                  />
                </template>
              </v-data-iterator>

            </v-col>
          </v-row>
        </div>

      </v-col>
    </v-row>
  </v-container>
</template>

<style scoped></style>
