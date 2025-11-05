import { Event, User } from '@/models'
import $axios from '@/plugins/axios'

export const namespaced = true

export const state = {
  page: 1,
  events: [],
  user: {},
  featuredEvent: {},
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
    const events = (payload || []).map(eventData => new Event(eventData || {}))
    state.events.push(...events)
  },
  addEvent (state, payload) {
    const event = payload instanceof Event ? payload : new Event(payload || {})
    state.events.unshift(event)
  },
  setUser (state, payload) {
    state.user = new User(payload || {})
  },
  setFeaturedEvent (state, payload) {
    state.featuredEvent = new Event(payload || {})
  },
  setCategories (state, payload) {
    state.categories = payload
  },
  setUpcomingEvents (state, payload) {
    state.upcomingEvents = (payload || []).map(eventData => new Event(eventData || {}))
  },
  removeUpcomingEvents (state, payload) {
    const targetItemIndex = state.upcomingEvents.findIndex(
      item => item.id === payload,
    )
    if (targetItemIndex === -1) {
      return
    }
    state.upcomingEvents.splice(targetItemIndex, 1)
  },
  editEvent (state, payload) {
    const targetItemIndex = state.events.findIndex(
      item => item.id === payload.id,
    )
    if (targetItemIndex === -1) {
      return
    }
    state.events[targetItemIndex] = new Event(payload || {})
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
  setEventNotification (state, payload) {
    const targetItemIndex = state.events.findIndex(
      item => item.id == payload.eventId,
    )
    if (targetItemIndex === -1) {
      return
    }
    state.events[targetItemIndex].newNotification = payload.payload
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
  setEditingEvent (state, payload) {
    state.editingEvent = new Event(payload || {})
  },
}

export const actions = {
  async addEvent ({ commit }, request) {
    try {
      const response = await $axios.post('/event/save', request)
      commit('addEvent', response.data.payload)
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
      const response = await $axios.get('/event/deleteEvent', {
        params: { eventId, images },
      })
      commit('removeEvent', eventId)
      if (state.featuredEvent?.id == eventId) {
        commit('setFeaturedEvent', {})
      }
      const upcomingEventsIndex = state.upcomingEvents.findIndex(
        item => item.id == eventId,
      )
      if (upcomingEventsIndex !== -1) {
        commit('removeUpcomingEvents', upcomingEventsIndex)
      }
      return response
    } catch (error) {
      throw error
    }
  },
  async setEvents ({ commit }, request) {
    try {
      const response = await $axios.get('/event/getEventsByUserId', {
        params: { userId: request.userId, page: request.page, sort: request.sort },
      })
      commit('setEvents', response.data.payload)
      return response
    } catch (error) {
      throw error
    }
  },
  async getUserById ({ commit }, request) {
    try {
      const response = await $axios.get('/user/getUserById', {
        params: { userId: request },
      })
      commit('setUser', response.data?.payload)
      return response
    } catch (error) {
      throw error
    }
  },
  async getUserBySlug ({ commit }, request) {
    try {
      const response = await $axios.get('/user/getUserBySlug', {
        params: { slug: request },
      })
      commit('setUser', response.data?.payload)
      return response
    } catch (error) {
      throw error
    }
  },
  async getFeaturedEvent ({ commit }, request) {
    try {
      const response = await $axios.get('/event/getFeaturedEvent', {
        params: { payload: true, userId: request },
      })
      commit('setFeaturedEvent', response.data?.payload)
      return response
    } catch (error) {
      throw error
    }
  },
  async setFeaturedEvent ({ commit, state }, request) {
    try {
      const response = await $axios.get('/event/swichFeaturedEvent', {
        params: {
          payload: true,
          oldEventId: state.featuredEvent?.id,
          newEventId: request.eventId,
        },
      })
      const foundFeaturedEvent = state.events.find(
        item => item.id === request.eventId,
      )
      commit('setFeaturedEvent', foundFeaturedEvent)
      return response
    } catch (error) {
      throw error
    }
  },
  async unsetFeaturedEvent ({ commit, state }, request) {
    try {
      const response = await $axios.get('/event/swichFeaturedEvent', {
        params: {
          payload: false,
          oldEventId: null,
          newEventId: request.eventId,
        },
      })
      commit('setFeaturedEvent', {})
      return response
    } catch (error) {
      throw error
    }
  },
  async setEventNotification ({ commit, state }, request) {
    try {
      const response = await $axios.get('/event/setEventNotification', {
        params: { eventId: request.eventId, payload: request.payload },
      })
      commit('setEventNotification', {
        eventId: request.eventId,
        payload: request.payload,
      })
      return response
    } catch (error) {
      throw error
    }
  },
  async getCategories ({ commit }, request) {
    try {
      const response = await $axios.get('/event/getCategories')
      const formattedCategories = response.data?.payload?.map(
        item => item.name,
      )
      commit('setCategories', formattedCategories)
      return response
    } catch (error) {
      throw error
    }
  },
  async findEvents ({ commit }, request) {
    try {
      const response = await $axios.post('/event/findWallEvents', request)
      commit('setEvents', response.data.payload)
      return response
    } catch (error) {
      throw error
    }
  },
  async getUpcomingEvents ({ commit }, request) {
    try {
      const response = await $axios.get('/event/getUpcomingEvents', {
        params: { userId: request.userId, source: request.source },
      })
      commit('setUpcomingEvents', response.data.payload)
      return response
    } catch (error) {
      throw error
    }
  },
  async setEditingEvent ({ commit }, request) {
    try {
      const response = await $axios.get('/event/getEvent', {
        params: { eventId: request },
      })
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
  getFeaturedEvent (state) {
    return state.featuredEvent
  },
}
