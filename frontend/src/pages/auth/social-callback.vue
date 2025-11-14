<script setup>
import { computed, onMounted, ref } from 'vue'
import { useRoute, useRouter } from 'vue-router'
import { useStore } from 'vuex'
import { showApiQueryMsg } from '@/others/util'
import { handleInviteAfterAuth } from '@/others/onboarding'

definePage({
  name: 'socialCallback',
  meta: {
    layout: 'headerless',
    requiresNoAuth: true,
    title: 'Signing you in...',
  },
})

const route = useRoute()
const router = useRouter()
const store = useStore()

const statusMessage = ref('Finishing sign in…')
const errorMessage = ref(null)

function decodeBase64Payload (payload) {
  try {
    if (!payload) return null
    let normalized = payload.replace(/-/g, '+').replace(/_/g, '/')
    while (normalized.length % 4 !== 0) {
      normalized += '='
    }
    const decoded = atob(normalized)
    return JSON.parse(decoded)
  } catch (error) {
    console.error('Failed to decode user payload:', error)
    return null
  }
}

const hasError = computed(() => !!errorMessage.value)

onMounted(async () => {
  const token = route.query.token
  const userPayload = route.query.user
  const onboardingPayload = route.query.onboarding
  const redirect = route.query.redirect
  const error = route.query.error

  if (error) {
    errorMessage.value = error
    statusMessage.value = 'Unable to sign in'
    return
  }

  if (!token || !userPayload) {
    errorMessage.value = 'Missing login response. Please try again.'
    statusMessage.value = 'Unable to sign in'
    return
  }

  const currentUser = decodeBase64Payload(userPayload)
  if (!currentUser) {
    errorMessage.value = 'Could not verify login response. Please try again.'
    statusMessage.value = 'Unable to sign in'
    return
  }

  const onboardingData = decodeBase64Payload(onboardingPayload)

  store.commit('auth/setToken', token)
  store.commit('auth/setCurrentUser', currentUser)
  // Load settings from database after social login
  await store.dispatch('user/setUserSettings')
  statusMessage.value = 'Signed in successfully!'

  if (onboardingData?.welcomeEvent) {
    store.commit('eventWall/addEvent', onboardingData.welcomeEvent)
  }

  if (onboardingData?.newFriendsCount) {
    store.commit('addSnackbar', {
      text: `You've accepted ${onboardingData.newFriendsCount} new friend invitation!`,
      color: 'success',
    })
  }

  let inviteHandled = false
  if (onboardingData?.isNewUser) {
    inviteHandled = await handleInviteAfterAuth(currentUser)
  }

  const target = (() => {
    if (onboardingData?.isNewUser) {
      return inviteHandled
        ? { name: 'friends' }
        : { name: 'friendsInvite', query: { ref: 'register' } }
    }
    return redirect
      ? { path: redirect }
      : store.getters['auth/calcHome']
  })()

  showApiQueryMsg()
  await router.replace(target)
})
</script>

<template>
  <v-container class="fill-height">
    <v-row align="center" justify="center">
      <v-col cols="12" sm="8" md="6" lg="4">
        <v-card class="pa-6" elevation="2">
          <v-card-title class="text-h6 text-center">
            {{ hasError ? 'Social Login' : 'Signing you in' }}
          </v-card-title>
          <v-card-text class="text-center">
            <div class="d-flex justify-center mb-4">
              <v-progress-circular
                v-if="!hasError"
                indeterminate
                color="primary"
                size="48"
              />
              <v-icon
                v-else
                color="error"
                size="48"
              >
                mdi-alert-circle-outline
              </v-icon>
            </div>
            <p class="text-body-1 mb-2">
              {{ statusMessage }}
            </p>
            <p
              v-if="hasError"
              class="text-body-2 text-medium-emphasis"
            >
              {{ errorMessage }}
            </p>
            <div v-if="hasError" class="mt-4">
              <v-btn
                color="primary"
                variant="flat"
                @click="router.push({ name: 'signin' })"
              >
                Back to Login
              </v-btn>
            </div>
          </v-card-text>
        </v-card>
      </v-col>
    </v-row>
  </v-container>
</template>

