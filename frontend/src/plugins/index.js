/**
 * plugins/app.js
 *
 * Automatically included in `./src/main.js`
 */

import { createGtm } from '@gtm-support/vue-gtm'
import { handleRedirect, handleRemoveQueriesNRedirect } from '@/others/util.js'
import $axios from '@/plugins/axios'
import router from '../router'
import store from '../store'
// Plugins
import vuetify from './vuetify'

function handleAuthRoutes (to, isSignedin, userRole) {
  const requiresNoAuth = to.matched.some(r => r.meta.requiresNoAuth)
  const requiresAuth = to.matched.some(r => r.meta.requiresAuth)
  const requiresAdmin = to.matched.some(r => r.meta.requiresAdmin)

  if (requiresNoAuth && isSignedin) {
    return store.getters['auth/calcHome']
  }
  if (requiresAuth && !isSignedin) {
    return { name: 'signin' }
  }
  if (requiresAdmin && !store.getters['auth/isAdmin']) {
    return store.getters['auth/calcHome']
  }
  if (!to.name && isSignedin) {
    return store.getters['auth/calcHome'] // undefined route visited
  }

  return null
}

export function registerPlugins (app) {
  router.beforeEach((to, from, next) => {
    if (
      handleRedirect({
        param: 'backendRedirectUrl',
      })
    ) {
      return // Stop the execution of this guard, as a full page reload is happening
    }
    // save routeinfo to state
    store.commit('setRouteInfo', { to, from })

    const isSignedin = store.getters['auth/signedin']
    const currentUser = store.getters['auth/getCurrentUser']
    const redirectRoute = handleAuthRoutes(to, isSignedin, currentUser.role)
    if (redirectRoute) {
      next(redirectRoute)
    } else {
      if (
        handleRemoveQueriesNRedirect({
          params: ['apiQueryMsg'],
        })
      ) {
        // No need to call next() here, as window.location.replace will trigger a new navigation cycle
        return
      }
      next()
    }
  })

  app.use(vuetify).use(router).use(store)
  app.use(
    createGtm({
      id: 'GTM-TBCVHTXV',
      vueRouter: router,
    }),
  )
  app.provide('$axios', $axios)
  window.$axios = $axios
}
