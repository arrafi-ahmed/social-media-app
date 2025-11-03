import { ifAdmin, ifCustomer } from '@/others/util'
import $axios from '@/plugins/axios'

export const namespaced = true

export const state = {
  token: localStorage.getItem('token') || null,
  currentUser: JSON.parse(localStorage.getItem('currentUser')) || {},
}

export const mutations = {
  setToken (state, payload) {
    localStorage.setItem('token', payload)
    state.token = payload
  },
  setCurrentUser (state, payload) {
    state.currentUser = { ...state.currentUser, ...payload }
    const existing = JSON.parse(localStorage.getItem('currentUser') || '{}')
    localStorage.setItem('currentUser', JSON.stringify({ ...existing, ...payload }))
  },
  removeToken (state) {
    localStorage.removeItem('token')
    state.token = null
  },
  removeCurrentUser (state) {
    localStorage.removeItem('currentUser')
    state.currentUser = {}
  },
}

export const actions = {
  async signin ({ commit }, request) {
    const response = await $axios.post('/auth/signin', request)
    commit('setToken', response.headers?.authorization)
    commit('setCurrentUser', response.data?.payload?.currentUser)
    return response
  },
  async signout ({ commit }) {
    commit('removeToken')
    commit('removeCurrentUser')
  },
  async register ({ commit }, request) {
    const response = await $axios.post('/auth/register', request)
    commit('setToken', response.headers?.authorization)
    commit('setCurrentUser', response.data?.payload?.currentUser)
    return response
  },
}

export const getters = {
  getToken (state) {
    return state.token
  },
  getCurrentUser (state) {
    return state.currentUser
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
  calcHome (state, getters) {
    console.log(10, getters.isAdmin, getters.isCustomer)
    return getters.isAdmin
      ? { name: 'adminDashboard' }
      : (getters.isCustomer
          ? { name: 'browse' }
          : { name: 'signout' })
  },
}
