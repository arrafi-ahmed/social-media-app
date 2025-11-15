import { User, UserSettings } from '@/models'
import { ifAdmin, ifCustomer } from '@/others/util.js'
import $axios from '@/plugins/axios'

export const namespaced = true

export const state = {
  token: localStorage.getItem('token') || null,
  currentUser: JSON.parse(localStorage.getItem('currentUser')) || {},
  profile: {},
  settings: JSON.parse(localStorage.getItem('settings')) || { sort: 'LATEST' },
  foundUsers: [],
  friends: [],
}

export const mutations = {
  setToken (state, payload) {
    localStorage.setItem('token', payload)
    state.token = payload
  },
  setCurrentUser (state, payload) {
    const user = new User(payload || {})
    state.currentUser = user
    localStorage.setItem('currentUser', JSON.stringify(user))
    // Trigger theme update event if theme is available
    if (user.theme) {
      window.dispatchEvent(new CustomEvent('theme-change', { detail: user.theme }))
    }
  },
  setCurrentUserName (state, payload) {
    // Read current user from localStorage to preserve all fields (from auth module)
    const currentUser = JSON.parse(localStorage.getItem('currentUser') || '{}')
    currentUser.fullName = payload
    state.currentUser.fullName = payload
    localStorage.setItem('currentUser', JSON.stringify(currentUser))
  },
  setCurrentUserImage (state, payload) {
    // Read current user from localStorage to preserve all fields (from auth module)
    const currentUser = JSON.parse(localStorage.getItem('currentUser') || '{}')
    currentUser.image = payload
    state.currentUser.image = payload
    localStorage.setItem('currentUser', JSON.stringify(currentUser))
  },
  setCurrentUserSlug (state, payload) {
    // Read current user from localStorage to preserve all fields (from auth module)
    const currentUser = JSON.parse(localStorage.getItem('currentUser') || '{}')
    currentUser.slug = payload
    state.currentUser.slug = payload
    localStorage.setItem('currentUser', JSON.stringify(currentUser))
  },
  setCurrentUserTheme (state, payload) {
    // Read current user from localStorage to preserve all fields (from auth module)
    const currentUser = JSON.parse(localStorage.getItem('currentUser') || '{}')
    currentUser.theme = payload
    state.currentUser.theme = payload
    localStorage.setItem('currentUser', JSON.stringify(currentUser))
    // Trigger theme update event
    window.dispatchEvent(new CustomEvent('theme-change', { detail: payload }))
  },
  removeToken (state) {
    localStorage.removeItem('token')
    state.token = null
  },
  removeCurrentUser (state) {
    localStorage.removeItem('currentUser')
    state.currentUser = new User()
  },
  setProfile (state, payload) {
    state.profile = new User({ ...state.profile, ...payload })
  },
  setUserSettings (state, payload) {
    const settings = new UserSettings(payload || {})
    localStorage.setItem('settings', JSON.stringify(settings))
    state.settings = settings
    // Trigger theme update event if theme is available
    if (settings.theme) {
      window.dispatchEvent(new CustomEvent('theme-change', { detail: settings.theme }))
    }
  },
  setFoundUsers (state, payload) {
    state.foundUsers = (payload || []).map(userData => {
      // Create User object but preserve all raw data including subscription fields
      const user = new User(userData || {})
      // Preserve subscription fields that User model doesn't handle
      if (userData) {
        user.subscriptionActive = userData.subscriptionActive
        user.pendingCancel = userData.pendingCancel
        user.stripeSubscriptionId = userData.stripeSubscriptionId
        user.subscriptionId = userData.subscriptionId
        user.planId = userData.planId
      }
      return user
    })
  },
  removeFoundUsers (state) {
    state.foundUsers = []
  },
  deleteUser (state, payload) {
    const targetItemIndex = state.foundUsers.findIndex(
      item => item.id === payload,
    )
    if (targetItemIndex === -1) {
      return
    }
    state.foundUsers.splice(targetItemIndex, 1)
  },
  updateUserSubscription (state, { userId, subscriptionData }) {
    const userIndex = state.foundUsers.findIndex(user => user.id === userId)
    if (userIndex === -1) {
      return
    }
    const user = state.foundUsers[userIndex]
    // Update subscription fields
    if (subscriptionData) {
      // Adding subscription
      user.subscriptionActive = subscriptionData.active ?? true
      user.stripeSubscriptionId = subscriptionData.stripeSubscriptionId
      user.subscriptionId = subscriptionData.id ?? subscriptionData.subscriptionId
      user.planId = subscriptionData.planId
      user.pendingCancel = subscriptionData.pendingCancel ?? false
    } else {
      // Removing subscription
      user.subscriptionActive = false
      user.stripeSubscriptionId = '0'
      user.subscriptionId = null
      user.planId = null
      user.pendingCancel = false
    }
  },
  setFriends (state, payload) {
    state.friends = (payload || []).map(friendData => new User(friendData || {}))
  },
  removeFriend (state, payload) {
    const targetItemIndex = state.friends.findIndex(
      item => item.friendshipId === payload,
    )
    if (targetItemIndex === -1) {
      return
    }
    state.friends.splice(targetItemIndex, 1)
  },
}

export const actions = {
  async signin ({ commit, dispatch }, request) {
    try {
      const response = await $axios.post('/auth/signin', request)
      commit('setToken', response.headers?.authorization)
      commit('setCurrentUser', response.data?.payload?.currentUser)
      // Load settings from database after signin
      await dispatch('setUserSettings')
      return response
    } catch (error) {
      throw error
    }
  },
  async signout ({ commit }) {
    commit('removeToken')
    commit('removeCurrentUser')
    // Clear all localStorage items
    localStorage.removeItem('token')
    localStorage.removeItem('currentUser')
    localStorage.removeItem('settings')
    localStorage.removeItem('postLimitStatus')
    localStorage.removeItem('acceptInvite')
    localStorage.removeItem('apiQueryMsg')
    localStorage.removeItem('subscription_success')
    // Note: Not clearing 'vuetify:dynamic-reload' as it's for Vuetify dev mode
  },
  async setProfile ({ commit }) {
    try {
      const response = await $axios.get('/user/getUserById')
      commit('setProfile', response.data?.payload)
      return response
    } catch (error) {
      throw error
    }
  },
  async setProfileWSettings ({ commit }) {
    try {
      const response = await $axios.get('/user/getProfileWSettings')
      commit('setProfile', response.data?.payload)
      commit('setUserSettings', response.data?.payload)
      return response
    } catch (error) {
      throw error
    }
  },
  async updateProfile ({ commit, rootState }, request) {
    try {
      const response = await $axios.post('/user/updateProfile', request)
      const payload = response.data?.payload

      // Update user module state
      commit('setProfile', payload)
      commit('setCurrentUserName', payload?.fullName)
      commit('setCurrentUserImage', payload?.image)
      commit('setCurrentUserSlug', payload?.slug)

      // Also update auth module's currentUser so AppBar reflects changes immediately
      commit('auth/setCurrentUser', {
        fullName: payload?.fullName,
        image: payload?.image,
        slug: payload?.slug,
      }, { root: true })

      return response
    } catch (error) {
      throw error
    }
  },
  async updateSettings ({ commit }, request) {
    try {
      const response = await $axios.post('/user/updateSettings', request)
      commit('setUserSettings', request)
      // If theme is updated, also update currentUser
      if (request.theme !== undefined) {
        commit('setCurrentUserTheme', request.theme)
        // Also update auth module's currentUser so it reflects changes immediately
        commit('auth/setCurrentUser', { theme: request.theme }, { root: true })
      }
      return response
    } catch (error) {
      throw error
    }
  },
  async updateEmailNewEventNotification ({ commit, state }, request) {
    try {
      const response = await $axios.get(
        '/user/updateEmailNewEventNotification',
        { params: { payload: request } },
      )
      commit('setProfile', { emailNewEventNotification: request })
      // Also update settings state and localStorage
      const updatedSettings = { ...state.settings, emailNewEventNotification: request }
      commit('setUserSettings', updatedSettings)
      return response
    } catch (error) {
      throw error
    }
  },
  async updateEmailNewCommentNotification ({ commit, state }, request) {
    try {
      const response = await $axios.get(
        '/user/updateEmailNewCommentNotification',
        { params: { payload: request } },
      )
      commit('setProfile', { emailNewCommentNotification: request })
      // Also update settings state and localStorage
      const updatedSettings = { ...state.settings, emailNewCommentNotification: request }
      commit('setUserSettings', updatedSettings)
      return response
    } catch (error) {
      throw error
    }
  },
  async updateEmailUpdateEventNotification ({ commit, state }, request) {
    try {
      const response = await $axios.get(
        '/user/updateEmailUpdateEventNotification',
        { params: { payload: request } },
      )
      commit('setProfile', { emailUpdateEventNotification: request })
      // Also update settings state and localStorage
      const updatedSettings = { ...state.settings, emailUpdateEventNotification: request }
      commit('setUserSettings', updatedSettings)
      return response
    } catch (error) {
      throw error
    }
  },
  async searchUser ({ commit }, request) {
    try {
      const response = await $axios.get('/user/searchUser', {
        params: { requestedUser: request },
      })
      commit('setFoundUsers', response.data?.payload)
      return response
    } catch (error) {
      throw error
    }
  },
  async deleteAccount ({ commit }, { rmImage }) {
    try {
      const response = await $axios.get('/user/deleteUser', {
        params: { rmImage },
      })
      return response
    } catch (error) {
      throw error
    }
  },
  async deleteUser ({ commit }, request) {
    try {
      const response = await $axios.get('/user/deleteUser', {
        params: { userId: request },
      })
      commit('deleteUser', request)
      return response
    } catch (error) {
      throw error
    }
  },
  async setFriends ({ commit }, request) {
    try {
      const response = await $axios.get('/user/getFriends', {
        params: { userId: request },
      })
      commit('setFriends', response.data?.payload)
      return response
    } catch (error) {
      throw error
    }
  },
  async removeFriend ({ commit }, request) {
    try {
      const response = await $axios.get('/user/removeFriend', {
        params: { friendshipId: request },
      })
      commit('removeFriend', request)
      return response
    } catch (error) {
      throw error
    }
  },
  async checkFriends ({ commit }, request) {
    try {
      const response = await $axios.get('/user/checkFriends', {
        params: { otherUser: request },
      })
      return response
    } catch (error) {
      throw error
    }
  },
  async sendInvite ({ commit }, request) {
    try {
      const response = await $axios.post('/user/sendInvite', request)
      return response
    } catch (error) {
      throw error
    }
  },
  async acceptInvite ({ dispatch }, token) {
    try {
      const response = await $axios.post('/user/acceptInvite', { token })
      await dispatch('setFriends')
      return response
    } catch (error) {
      throw error
    }
  },
  async requestResetPass ({ commit }, request) {
    try {
      const response = await $axios.post('/auth/requestResetPass', {
        resetEmail: request.resetEmail,
      })
      return response
    } catch (error) {
      throw error
    }
  },
  async submitResetPass ({ commit }, request) {
    try {
      const response = await $axios.post(
        '/auth/submitResetPass',
        request,
      )
      return response
    } catch (error) {
      throw error
    }
  },
  async addAllUsersToAdminFriendlist () {
    try {
      const response = await $axios.get(
        '/user/addAllUsersToAdminFriendlist',
      )
      return response
    } catch (error) {
      throw error
    }
  },
  async setUserSettings ({ commit }) {
    try {
      const response = await $axios.get('/user/getUserSettings')
      const settings = response.data?.payload
      commit('setUserSettings', settings)
      // Also update currentUser theme if theme is in settings
      if (settings?.theme) {
        commit('setCurrentUserTheme', settings.theme)
        // Also update auth module's currentUser so it reflects changes immediately
        commit('auth/setCurrentUser', { theme: settings.theme }, { root: true })
      }
      return response
    } catch (error) {
      throw error
    }
  },
}

export const getters = {
  getToken (state) {
    return state.token
  },
  getCurrentUser (state) {
    return state.currentUser
  },
  getCurrentUserId (state) {
    return state.currentUser.id
  },
  getCurrentUserRole (state) {
    return state.currentUser.role
  },
  isAdmin (state) {
    return ifAdmin(state.currentUser.role)
  },
  isCustomer (state) {
    return ifCustomer(state.currentUser.role)
  },
  signedin (state) {
    return !!state.token
  },
  calcHome (state) {
    return ifAdmin(state.currentUser.role)
      ? { name: 'adminDashboard' }
      : (ifCustomer(state.currentUser.role)
          ? { name: 'browse' }
          : { name: 'signout' })
  },
}
