<script setup>
  import { useStore } from 'vuex'

  definePage({
    name: 'signout',
    meta: {
      requiresAuth: true,
      title: 'Signout',
      layout: 'default',
    },
  })

  const store = useStore()
  store.dispatch('auth/signout').then(() => {
    store.commit('addSnackbar', {
      text: 'Signout successful!',
      color: 'success',
    })
    window.location.href = '/'
  })
</script>
