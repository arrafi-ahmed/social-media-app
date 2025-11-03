import $axios from '@/plugins/axios'

export const namespaced = true

export const state = {
  page: 1,
  events: [],
}
export const mutations = {
  setPage (state, payload) {
    state.page = payload
  },
  setEvents (state, payload) {
    state.events.push(...payload)
  },
  resetEvents (state) {
    state.events = []
  },
  resetPage (state) {
    state.page = 1
  },
  addEvent (state, payload) {
    state.events.unshift(payload)
  },
  removeEvent (state, payload) {
    const targetItemIndex = state.events.findIndex(
      item => item.id === payload,
    )
    if (targetItemIndex === -1) {
      return
    }
    state.events.splice(targetItemIndex, 1)
  },
}
export const actions = {
  async setEvents ({ commit }, request) {
    try {
      const response = await $axios.get('/event/getFavoriteEvents', { params: { page: request.page } })
      commit('setEvents', response.data.payload)
      return response
    } catch (error) {
      throw error
    }
  },
}
