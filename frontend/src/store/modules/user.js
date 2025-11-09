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
  },
  setCurrentUserName (state, payload) {
    state.currentUser.fullName = payload
    localStorage.setItem('currentUser', JSON.stringify(state.currentUser))
  },
  setCurrentUserImage (state, payload) {
    state.currentUser.image = payload
    localStorage.setItem('currentUser', JSON.stringify(state.currentUser))
  },
  setCurrentUserSlug (state, payload) {
    state.currentUser.slug = payload
    localStorage.setItem('currentUser', JSON.stringify(state.currentUser))
  },
  setCurrentUserTheme (state, payload) {
    state.currentUser.theme = payload
    localStorage.setItem('currentUser', JSON.stringify(state.currentUser))
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
  },
  setFoundUsers (state, payload) {
    state.foundUsers = (payload || []).map(userData => new User(userData || {}))
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
  async signin ({ commit }, request) {
    try {
      const response = await $axios.post('/auth/signin', request)
      commit('setToken', response.headers?.authorization)
      commit('setCurrentUser', response.data?.payload?.currentUser)
      return response
    } catch (error) {
      throw error
    }
  },
  async signout ({ commit }) {
    commit('removeToken')
    commit('removeCurrentUser')
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
      return response
    } catch (error) {
      throw error
    }
  },
  async updateProfile ({ commit }, request) {
    try {
      const response = await $axios.post('/user/updateProfile', request)
      commit('setProfile', response.data?.payload)
      commit('setCurrentUserName', response.data?.payload?.fullName)
      commit('setCurrentUserImage', response.data?.payload?.image)
      commit('setCurrentUserSlug', response.data?.payload?.slug)
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
      }
      return response
    } catch (error) {
      throw error
    }
  },
  async updateEmailNewEventNotification ({ commit }, request) {
    try {
      const response = await $axios.get(
        '/user/updateEmailNewEventNotification',
        { params: { payload: request } },
      )
      commit('setProfile', { emailNewEventNotification: request })
      return response
    } catch (error) {
      throw error
    }
  },
  async updateEmailNewCommentNotification ({ commit }, request) {
    try {
      const response = await $axios.get(
        '/user/updateEmailNewCommentNotification',
        { params: { payload: request } },
      )
      commit('setProfile', { emailNewCommentNotification: request })
      return response
    } catch (error) {
      throw error
    }
  },
  async updateEmailUpdateEventNotification ({ commit }, request) {
    try {
      const response = await $axios.get(
        '/user/updateEmailUpdateEventNotification',
        { params: { payload: request } },
      )
      commit('setProfile', { emailUpdateEventNotification: request })
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
      commit('setUserSettings', response.data?.payload)
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
