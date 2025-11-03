import $axios from '@/plugins/axios'

export const namespaced = true
export const state = {
  event: {
    comments: [],
    isFavorite: false,
  },
}
export const mutations = {
  setEvent (state, payload) {
    if (state.event) {
      Object.assign(state.event, payload)
      state.event.comments = payload?.comments || []
    }
  },
  setCommentsByEventId (state, payload) {
    state.event.comments = payload
  },
  addComment (state, payload) {
    state.event.comments.unshift(payload)
  },
  removeComment (state, payload) {
    const targetItemIndex = state.event.comments.findIndex(
      item => item.id == payload,
    )
    if (targetItemIndex === -1) {
      return
    }
    state.event.comments.splice(targetItemIndex, 1)
  },
  setIsFavorite (state, payload) {
    state.event.isFavorite = payload
  },
}
export const actions = {
  async getEvent ({ commit }, request) {
    try {
      const response = await $axios.get('/event/getEvent', { params: { eventId: request } })
      commit('setEvent', response.data.payload)
      return response
    } catch (error) {
      throw error
    }
  },
  async getCommentsByEventId ({ commit }, request) {
    try {
      const response = await $axios.get('/event/getCommentsByEventId', { params: { eventId: request } })
      commit('setCommentsByEventId', response.data.payload)
      return response
    } catch (error) {
      throw error
    }
  },
  async addComment ({ commit }, request) {
    try {
      const response = await $axios.post('/event/addComment', request)
      const savedComment = response.data.payload
      savedComment.fullName = request.fullName
      savedComment.image = request.image
      commit('addComment', savedComment)
      return response
    } catch (error) {
      throw error
    }
  },
  async deleteComment ({ commit }, request) {
    try {
      const response = await $axios.get('/event/deleteComment', { params: { commentId: request } })
      commit('removeComment', request)
      return response
    } catch (error) {
      throw error
    }
  },
  async switchFavoriteEvent ({ commit, state }, request) {
    try {
      const response = await $axios.get('/event/switchFavoriteEvent', { params: { eventId: request.eventId, payload: request.payload } })
      commit('setIsFavorite', response.data.payload)
      request.payload
        ? commit(`eventFavorite/addEvent`, state.event, { root: true })
        : commit(`eventFavorite/removeEvent`, state.event?.id, { root: true })
      return response
    } catch (error) {
      throw error
    }
  },
  async setIsFavorite ({ commit }, request) {
    try {
      const response = await $axios.get('/event/isFavorite', { params: { eventId: request } })
      commit('setIsFavorite', response.data?.payload)
      return response
    } catch (error) {
      throw error
    }
  },
}
