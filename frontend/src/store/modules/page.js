import { Page } from '@/models'
import $axios from '@/plugins/axios'

export const namespaced = true

export const state = {
  landing: { id: null, title: null, description: null },
  about: { id: null, title: null, description: null },
  terms: { id: null, title: null, description: null },
  privacy: { id: null, title: null, description: null },
}

export const mutations = {
  setPage (state, { pageName, payload }) {
    if (!pageName) {
      return
    }
    state[pageName] = new Page(payload || {})
  },
  // Backwards-compatible specific setters (can be removed later)
  setLanding (state, payload) {
    state.landing = new Page(payload || {})
    console.log(99, payload)
  },
}

export const actions = {
  async setPage ({ commit }, pageName) {
    try {
      const response = await $axios.get('/page/getPage', {
        params: { pageName },
      })
      commit('setPage', { pageName, payload: response.data?.payload })
      return response
    } catch (error) {
      throw error
    }
  },
  async savePage ({ commit }, request) {
    try {
      const response = await $axios.post('/page/updatePage', request)
      const payload = response.data?.payload
      const pageName = payload?.name || request?.pageName
      commit('setPage', { pageName, payload })
      return response
    } catch (error) {
      throw error
    }
  },
}

export const getters = {}
