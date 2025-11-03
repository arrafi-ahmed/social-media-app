import $axios from '@/plugins/axios'

export const namespaced = true

export const state = {
  page: 1,
  events: [],
  event: {},
  editingEvent: {},
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
  setEvent (state, payload) {
    state.event = payload
  },
  save (state, payload) {
    state.events.unshift(payload)
  },
  edit (state, payload) {
    const targetItemIndex = state.events.findIndex(
      item => item.id == payload.id,
    )
    if (targetItemIndex === -1) {
      return
    }
    state.events[targetItemIndex] = payload
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
  setEditingEvent (state, payload) {
    state.editingEvent = payload
  },
}

export const actions = {
  async setEvents ({ commit }, request) {
    try {
      const response = await $axios.get('/wishlist/getEvents', { params: { page: request.page } })
      commit('setEvents', response.data.payload)
      return response
    } catch (error) {
      throw error
    }
  },
  async setEvent ({ commit }, request) {
    try {
      const response = await $axios.get('/wishlist/getEvent', { params: { eventId: request } })
      commit('setEvent', response.data.payload)
      return response
    } catch (error) {
      throw error
    }
  },
  async save ({ commit }, request) {
    try {
      const response = await $axios.post('/wishlist/save', request)
      commit('save', response.data?.payload)
      return response
    } catch (error) {
      throw error
    }
  },
  async edit ({ commit }, request) {
    try {
      const response = await $axios.post('/wishlist/edit', request)
      commit('edit', response.data.payload)
      return response
    } catch (error) {
      throw error
    }
  },
  async deleteEvent ({ commit }, request) {
    try {
      const response = await $axios.get('/wishlist/deleteEvent', { params: { eventId: request } })
      commit('removeEvent', request)
      return response
    } catch (error) {
      throw error
    }
  },
  async setEditingEvent ({ commit }, request) {
    try {
      const response = await $axios.get('/wishlist/getEvent', { params: { eventId: request } })
      commit('setEditingEvent', response.data.payload)
      return response
    } catch (error) {
      throw error
    }
  },
}
