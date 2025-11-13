<script setup>
  import { onMounted, ref } from 'vue'
  import { useRoute, useRouter } from 'vue-router'
  import { useStore } from 'vuex'

  definePage({
    name: 'friendsAccept',
    meta: {
      title: 'Friend Invitation',
      layout: 'headerless',
    },
  })

  const route = useRoute()
  const router = useRouter()
  const store = useStore()

  const isLoading = ref(true)
  const statusText = ref('Validating invitation…')

  async function finalizeInvite (token) {
    try {
      const response = await store.dispatch('user/acceptInvite', token)
      localStorage.removeItem('acceptInvite')
      const successMessage = response?.data?.message || 'Friend invitation accepted!'
      localStorage.setItem('apiQueryMsg', successMessage)
      statusText.value = 'Invitation accepted! Redirecting…'
    } catch (error) {
      const message = error?.response?.data?.message || 'Invitation accepting failed!'
      store.commit('addSnackbar', { text: message, color: 'error' })
      localStorage.removeItem('acceptInvite')
      localStorage.setItem('apiQueryMsg', message)
    } finally {
      await router.replace({ name: 'friends' })
    }
  }

  onMounted(async () => {
    const token = route.query?.token
    if (!token) {
      statusText.value = 'Invitation token missing. Redirecting to sign in.'
      isLoading.value = false
      await router.replace({ name: 'signin' })
      return
    }

    try {
      const response = await $axios.get('/user/invite/preview', { params: { token } })
      const payload = response?.data?.payload || {}

      if (payload.alreadyFriends) {
        localStorage.removeItem('acceptInvite')
        localStorage.setItem('apiQueryMsg', 'User already in friendlist!')
        isLoading.value = false
        await router.replace({ name: 'friends' })
        return
      }

      const inviteData = {
        token,
        email: payload.email,
        senderName: payload.senderName,
        receiverExists: payload.receiverExists,
      }
      localStorage.setItem('acceptInvite', JSON.stringify(inviteData))

      if (store.getters['auth/signedin']) {
        await finalizeInvite(token)
        return
      }

      isLoading.value = false
      statusText.value = inviteData.receiverExists
        ? 'Please sign in to accept your invitation.'
        : 'Please register to accept your invitation.'

      const targetRoute = inviteData.receiverExists ? { name: 'signin' } : { name: 'register' }
      await router.replace(targetRoute)
    } catch (error) {
      const message = error?.response?.data?.message || 'Invitation accepting failed!'
      store.commit('addSnackbar', { text: message, color: 'error' })
      localStorage.removeItem('acceptInvite')
      statusText.value = 'Invitation could not be validated. Redirecting to sign in.'
      isLoading.value = false
      await router.replace({ name: 'signin' })
    }
  })
</script>

<template>
  <v-container class="d-flex align-center justify-center fill-height">
    <v-row justify="center">
      <v-col class="text-center" cols="12">
        <div class="mb-4">
          <v-progress-circular
            v-if="isLoading"
            color="primary"
            indeterminate
            size="48"
            width="4"
          />
        </div>
        <p class="text-subtitle-1">
          {{ statusText }}
        </p>
      </v-col>
    </v-row>
  </v-container>
</template>

<style scoped>
.fill-height {
  min-height: 60vh;
}
</style>
