import $axios from '@/plugins/axios'

export const namespaced = true
export const state = {
  event: null,
  editingEvent: {},
}
export const mutations = {
  setEvent (state, payload) {
    if (!payload) {
      state.event = null
      return
    }
    
    // Initialize event if it doesn't exist
    if (!state.event) {
      state.event = {
        comments: [],
        isFavorite: false,
        reactions: { like: 0, unlike: 0, heart: 0, laugh: 0, sad: 0, angry: 0 },
        userReaction: null,
      }
    }
    
    // Store reactions and userReaction from payload BEFORE Object.assign
    const reactions = payload.reactions || state.event.reactions || { like: 0, unlike: 0, heart: 0, laugh: 0, sad: 0, angry: 0 }
    const userReaction = payload.userReaction !== undefined ? payload.userReaction : (state.event.userReaction || null)
    const comments = payload.comments || state.event.comments || []
    
    // Assign all properties (this might overwrite reactions, so we'll set them again)
    Object.assign(state.event, payload)
    
    // Ensure reactions and userReaction are properly set AFTER Object.assign
    state.event.reactions = {
      like: parseInt(reactions.like) || 0,
      heart: parseInt(reactions.heart) || 0,
      laugh: parseInt(reactions.laugh) || 0,
      unlike: parseInt(reactions.unlike) || 0,
      sad: parseInt(reactions.sad) || 0,
      angry: parseInt(reactions.angry) || 0
    }
    state.event.userReaction = userReaction
    state.event.comments = comments
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
  setEditingEvent (state, payload) {
    state.editingEvent = payload || {}
  },
  updateEvent (state, payload) {
    if (state.event && payload) {
      Object.assign(state.event, payload)
      // Preserve comments and isFavorite
      state.event.comments = payload?.comments || state.event.comments || []
      state.event.isFavorite = payload?.isFavorite === undefined ? state.event.isFavorite : payload.isFavorite
    }
  },
  setReactions (state, payload) {
    if (!state.event || !payload) {
      return
    }
    
    // Handle both formats: { counts, userReaction } or direct object
    if (payload.counts) {
      // Only include valid reaction types, filter out any invalid keys
      state.event.reactions = {
        like: parseInt(payload.counts.like) || 0,
        heart: parseInt(payload.counts.heart) || 0,
        laugh: parseInt(payload.counts.laugh) || 0,
        unlike: parseInt(payload.counts.unlike) || 0,
        sad: parseInt(payload.counts.sad) || 0,
        angry: parseInt(payload.counts.angry) || 0
      }
    } else if (payload.reactions) {
      state.event.reactions = {
        like: parseInt(payload.reactions.like) || 0,
        heart: parseInt(payload.reactions.heart) || 0,
        laugh: parseInt(payload.reactions.laugh) || 0,
        unlike: parseInt(payload.reactions.unlike) || 0,
        sad: parseInt(payload.reactions.sad) || 0,
        angry: parseInt(payload.reactions.angry) || 0
      }
    }
    
    // Update userReaction - only set if it's a valid reaction type
    const validTypes = ['like', 'unlike', 'heart', 'laugh', 'sad', 'angry'];
    if (payload.userReaction !== undefined) {
      state.event.userReaction = (payload.userReaction && validTypes.includes(payload.userReaction)) 
        ? payload.userReaction 
        : null
    }
  },
  updateReaction (state, { reactionType, isActive, previousReaction }) {
    if (!state.event || !state.event.reactions) {
      if (!state.event) return
      state.event.reactions = { like: 0, unlike: 0, heart: 0, laugh: 0, sad: 0, angry: 0 }
    }
    
    // If reaction is being activated
    if (isActive && reactionType) {
      // If same reaction was clicked, it means we're removing it
      if (previousReaction === reactionType) {
        state.event.userReaction = null
        // Remove count
        if (state.event.reactions[reactionType] > 0) {
          state.event.reactions[reactionType]--
        }
      } else {
        // Adding new reaction or changing to different reaction
        state.event.userReaction = reactionType
        
        // Remove previous reaction count (if switching from one reaction to another)
        if (previousReaction && previousReaction !== reactionType) {
          if (state.event.reactions[previousReaction] > 0) {
            state.event.reactions[previousReaction]--
          }
        }
        
        // Add new reaction count (either new reaction or switched reaction)
        state.event.reactions[reactionType] = (state.event.reactions[reactionType] || 0) + 1
      }
    } else {
      // Removing reaction (isActive is false)
      state.event.userReaction = null
      if (state.event.reactions[reactionType] > 0) {
        state.event.reactions[reactionType]--
      }
    }
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
  async editEvent ({ commit }, request) {
    try {
      const response = await $axios.post('/event/edit', request)
      commit('updateEvent', response.data.payload)
      return response
    } catch (error) {
      throw error
    }
  },
  async toggleReaction ({ commit, state, dispatch }, { eventId, reactionType }) {
    try {
      const previousReaction = state.event?.userReaction
      const isRemoving = previousReaction === reactionType
      
      // Optimistic update first for immediate UI feedback
      commit('updateReaction', { 
        reactionType: reactionType, 
        isActive: !isRemoving, 
        previousReaction 
      })
      
      // Call API - it now returns updated counts and userReaction
      const response = await $axios.post('/event/reaction', { eventId, reactionType })
      const result = response.data.payload
      
      // Update with actual counts and userReaction from backend response
      if (result && result.counts) {
        commit('setReactions', {
          counts: result.counts,
          userReaction: result.userReaction
        })
      } else {
        // Fallback: refresh from backend if counts not in response
        await dispatch('getReactions', eventId)
      }
      
      return response
    } catch (error) {
      // Rollback on error - refresh from backend
      await dispatch('getReactions', eventId).catch(() => {})
      throw error
    }
  },
  async getReactions ({ commit }, eventId) {
    try {
      const response = await $axios.get(`/event/reactions/${eventId}`, {
        suppressToast: true // Suppress snackbar for this API call
      })
      commit('setReactions', response.data.payload)
      return response
    } catch (error) {
      throw error
    }
  },
}
