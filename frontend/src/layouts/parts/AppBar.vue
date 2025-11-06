<script setup>
  import { computed, ref } from 'vue'
  import { useRouter } from 'vue-router'
  import { useDisplay } from 'vuetify'
  import { useStore } from 'vuex'
  import Logo from '@/components/Logo.vue'
  import UserAvatar from '@/components/UserAvatar.vue'
  import { getToLink } from '@/others/util.js'

  const store = useStore()
  const { smAndUp } = useDisplay()
  const router = useRouter()
  const signedin = computed(() => store.getters['auth/signedin'])
  const currentUser = computed(() => store.getters['auth/getCurrentUser'])

  const drawer = ref(false)

  const calcHome = computed(() => store.getters['auth/calcHome'])
  const menuItemsAdmin = computed(() => [
    { title: 'Dashboard', to: { name: 'adminDashboard' } },
  ])
  const menuItemsUser = computed(() => [
    { title: 'Browse', to: { name: 'browse' } },
  ])
  const menuItemsCommon = computed(() =>
    [
      {
        title: 'Wall',
        to: { name: 'wall', params: { id: currentUser.value?.slug || currentUser.value?.id } },
      },
      { title: 'Friends', to: { name: 'friends' } },
      { title: 'Collections', to: { name: 'collection' } },
      { title: 'Groups', to: { name: 'groups' } },
      { title: 'Wishlist', to: { name: 'wishlist' } },
      { title: 'Settings', to: { name: 'settings' } },
    ].filter(Boolean),
  )
  const menuItems = computed(() => {
    if (store.getters['auth/isAdmin']) {
      return [...menuItemsAdmin.value, ...menuItemsCommon.value]
    } else if (store.getters['auth/isCustomer']) {
      return [...menuItemsUser.value, ...menuItemsCommon.value]
    } else {
      return []
    }
  })
  const getFirstName = computed(() => currentUser.value.fullName?.split(' ')[0])
  const getGreetings = computed(() => {
    const hour = new Date().getHours()
    return `Good ${hour < 12 ? 'morning' : (hour < 18 ? 'afternoon' : 'evening')}!`
  })
</script>

<template>
  <v-app-bar
    class="px-2 px-md-5"
    dense
    flat
    :order="1"
  >
    <logo custom-class="clickable" @click="router.push(calcHome)" />

    <template #append>
      <v-btn
        v-if="signedin"
        rounded="pill"
        :size="smAndUp ? 'large' : 'default'"
        variant="elevated"
        @click="drawer = !drawer"
      >
        <template #prepend>
          <v-avatar :size="25">
            <v-icon color="primary" :size="25">
              mdi-account-circle
            </v-icon>
          </v-avatar>
        </template>
        <template
          v-if="smAndUp"
          #default
        >
          <span
            class="text-capitalize"
            style="font-size: 0.8rem"
          >{{
            currentUser.fullName ? currentUser.fullName.split(" ")[0] : ""
          }}</span>
        </template>
        <template #append>
          <v-icon :icon="drawer ? 'mdi-chevron-up' : 'mdi-chevron-down'" />
        </template>
      </v-btn>
    </template>
  </v-app-bar>
  <v-navigation-drawer
    v-if="signedin"
    v-model="drawer"
    location="end"
    temporary
    :width="220"
  >
    <v-list>
      <v-list-item>
        <div class="d-flex justify-start align-center">
          <user-avatar
            :img-src="currentUser.image"
            @click-avatar="drawer = !drawer"
          />
          <div class="ml-3">
            <small>
              {{ getGreetings }}
            </small>
            <div>
              {{ getFirstName }}
            </div>
          </div>
        </div>
      </v-list-item>
      <v-divider class="mt-2 mb-2" />
      <v-list-item
        v-for="(item, index) in menuItems"
        :key="index"
        :to="getToLink(item)"
      >
        <v-list-item-title>{{ item.title }}</v-list-item-title>
      </v-list-item>
    </v-list>
    <template #append>
      <div class="ma-5">
        <v-btn
          block
          color="primary"
          prepend-icon="mdi-exit-to-app"
          :to="{ name: 'signout' }"
        >Signout
        </v-btn>
      </div>
    </template>
  </v-navigation-drawer>
</template>

<style scoped>
/* Add styling as needed */
</style>
