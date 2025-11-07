import $axios from '@/plugins/axios'

export const namespaced = true
export const state = {
  page: 1,
  events: [],
  upcomingEvents: [],
  editingEvent: {},
}
export const mutations = {
  setPage (state, payload) {
    state.page = payload
  },
  resetEvents (state) {
    state.events = []
  },
  setEvents (state, payload) {
    state.events.push(...payload)
  },
  setUpcomingEvents (state, payload) {
    state.upcomingEvents = payload
  },
  editEvent (state, payload) {
    const targetItemIndex = state.events.findIndex(
      item => item.id === payload.id,
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
  updateEventReaction (state, { eventId, reactionType, isActive, previousReaction }) {
    const targetItemIndex = state.events.findIndex(
      item => item.id == eventId,
    )
    if (targetItemIndex === -1) {
      return
    }
    const event = state.events[targetItemIndex]
    if (!event.reactions) {
      event.reactions = { like: 0, unlike: 0, heart: 0, laugh: 0, sad: 0, angry: 0 }
    }

    // Update user reaction first
    if (isActive && reactionType) {
      // If same reaction was clicked, it means we're removing it
      if (previousReaction === reactionType) {
        event.userReaction = null
        // Remove count only if removing
        if (event.reactions[reactionType] > 0) {
          event.reactions[reactionType]--
        }
      } else {
        // Change to different reaction
        event.userReaction = reactionType
        // Remove previous reaction count
        if (previousReaction && previousReaction !== reactionType && event.reactions[previousReaction] > 0) {
          event.reactions[previousReaction]--
        }
        // Add new reaction count
        event.reactions[reactionType]++
      }
    } else {
      // Remove reaction
      event.userReaction = null
      if (event.reactions[reactionType] > 0) {
        event.reactions[reactionType]--
      }
    }
  },
}
export const actions = {
  async setEvents ({ commit }, request) {
    try {
      const response = await $axios.get('/event/getAllEventsByFriends', {
        params: {
          userId: request.userId,
          page: request.page,
          sort: request.sort,
        },
      })
      commit('setEvents', response.data.payload)
      return response
    } catch (error) {
      throw error
    }
  },
  async findEvents ({ commit }, request) {
    try {
      const response = await $axios.post('/event/findBrowseEvents', request)
      commit('setEvents', response.data.payload)
      return response
    } catch (error) {
      throw error
    }
  },
  async editEvent ({ commit }, request) {
    try {
      const response = await $axios.post('/event/edit', request)
      commit('editEvent', response.data.payload)
      return response
    } catch (error) {
      throw error
    }
  },
  async deleteEvent ({ commit, state }, { eventId, images }) {
    try {
      const response = await $axios.get('/event/deleteEvent', { params: { eventId, images } })
      commit('removeEvent', eventId)
      if (state.featuredEvent?.id == eventId) {
        commit('setFeaturedEvent', {})
      }
      const upcomingEventsIndex = state.upcomingEvents.findIndex(item => item.id == eventId)
      if (upcomingEventsIndex !== -1) {
        commit('removeUpcomingEvents', upcomingEventsIndex)
      }
      return response
    } catch (error) {
      throw error
    }
  },
  async getUpcomingEvents ({ commit }, request) {
    try {
      const response = await $axios.get('/event/getUpcomingEvents', {
        params: {
          userId: request.userId,
          source: request.source,
        },
      })
      commit('setUpcomingEvents', response.data.payload)
      return response
    } catch (error) {
      throw error
    }
  },
  async setEditingEvent ({ commit }, request) {
    try {
      const response = await $axios.get('/event/getEvent', { params: { eventId: request } })
      commit('setEditingEvent', response.data.payload)
      return response
    } catch (error) {
      throw error
    }
  },
}
export const getters = {
  getMountedEventCategories (state) {
    const uniqueCategories = new Set()
    for (const event of state.events) {
      if (event.category) {
        uniqueCategories.add(event.category)
      }
    }
    return Array.from(uniqueCategories)
  },
}
