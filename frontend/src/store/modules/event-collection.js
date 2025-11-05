import $axios from '@/plugins/axios'

export const namespaced = true

export const state = {
  collections: [],
  selectedCollection: null, // null = "All", number = collection ID
  page: 1,
  events: [],
}

export const mutations = {
  setCollections (state, payload) {
    state.collections = payload
  },
  addCollection (state, payload) {
    state.collections.push(payload)
  },
  updateCollection (state, payload) {
    const index = state.collections.findIndex(c => c.id === payload.id)
    if (index !== -1) {
      state.collections[index] = { ...state.collections[index], ...payload }
    }
  },
  removeCollection (state, payload) {
    state.collections = state.collections.filter(c => c.id !== payload)
    if (state.selectedCollection === payload) {
      state.selectedCollection = null
    }
  },
  setSelectedCollection (state, payload) {
    state.selectedCollection = payload
  },
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
    if (targetItemIndex !== -1) {
      state.events.splice(targetItemIndex, 1)
    }
  },
}

export const actions = {
  async getCollections ({ commit }) {
    try {
      const response = await $axios.get('/collection')
      commit('setCollections', response.data.payload)
      return response
    } catch (error) {
      throw error
    }
  },
  async createCollection ({ commit }, payload) {
    try {
      const response = await $axios.post('/collection', payload)
      commit('addCollection', response.data.payload)
      return response
    } catch (error) {
      throw error
    }
  },
  async updateCollection ({ commit }, { id, ...updates }) {
    try {
      const response = await $axios.put(`/collection/${id}`, updates)
      commit('updateCollection', response.data.payload)
      return response
    } catch (error) {
      throw error
    }
  },
  async deleteCollection ({ commit }, id) {
    try {
      await $axios.delete(`/collection/${id}`)
      commit('removeCollection', id)
      return true
    } catch (error) {
      throw error
    }
  },
  async setEvents ({ commit, state }, request) {
    try {
      let url = '/collection/all/collections/events'
      if (state.selectedCollection === null) {
        // "All" view - all events from all collections
        url = '/collection/all/collections/events'
      } else if (state.selectedCollection === 'uncategorized') {
        // Uncategorized events only
        url = '/collection/all/events'
      } else {
        // Specific collection
        url = `/collection/${state.selectedCollection}/events`
      }

      const response = await $axios.get(url, { params: { page: request.page } })
      commit('setEvents', response.data.payload)
      return response
    } catch (error) {
      throw error
    }
  },
}
