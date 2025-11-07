import $axios from '@/plugins/axios'

export const namespaced = true

export const state = {
  groups: [],
  selectedGroup: null, // null = "All", number = group ID
  page: 1,
  events: [],
  members: {}, // members by groupId
}

export const mutations = {
  setGroups (state, payload) {
    state.groups = payload
  },
  addGroup (state, payload) {
    state.groups.push(payload)
  },
  updateGroup (state, payload) {
    const index = state.groups.findIndex(g => g.id === payload.id)
    if (index !== -1) {
      state.groups[index] = { ...state.groups[index], ...payload }
    }
  },
  removeGroup (state, payload) {
    state.groups = state.groups.filter(g => g.id !== payload)
    if (state.selectedGroup === payload) {
      state.selectedGroup = null
    }
  },
  setSelectedGroup (state, payload) {
    state.selectedGroup = payload
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
  setMembers (state, { groupId, members }) {
    state.members[groupId] = members
  },
  addMember (state, { groupId, member }) {
    if (!state.members[groupId]) {
      state.members[groupId] = []
    }
    state.members[groupId].push(member)
  },
  removeMember (state, { groupId, memberId }) {
    if (state.members[groupId]) {
      state.members[groupId] = state.members[groupId].filter(m => m.userId !== memberId)
    }
  },
}

export const actions = {
  async getGroups ({ commit }) {
    try {
      const response = await $axios.get('/group')
      commit('setGroups', response.data.payload)
      return response
    } catch (error) {
      throw error
    }
  },
  async createGroup ({ commit }, payload) {
    try {
      const response = await $axios.post('/group', payload)
      commit('addGroup', response.data.payload)
      return response
    } catch (error) {
      throw error
    }
  },
  async updateGroup ({ commit }, { id, ...updates }) {
    try {
      const response = await $axios.put(`/group/${id}`, updates)
      commit('updateGroup', response.data.payload)
      return response
    } catch (error) {
      throw error
    }
  },
  async deleteGroup ({ commit }, id) {
    try {
      await $axios.delete(`/group/${id}`)
      commit('removeGroup', id)
      return true
    } catch (error) {
      throw error
    }
  },
  async getGroupMembers ({ commit }, groupId) {
    try {
      const response = await $axios.get(`/group/${groupId}/members`)
      commit('setMembers', { groupId, members: response.data.payload })
      return response
    } catch (error) {
      throw error
    }
  },
  async addMember ({ commit }, { groupId, userId, role }) {
    try {
      const response = await $axios.post(`/group/${groupId}/member`, { userId, role })
      commit('addMember', { groupId, member: response.data.payload })
      return response
    } catch (error) {
      throw error
    }
  },
  async removeMember ({ commit }, { groupId, memberId }) {
    try {
      await $axios.delete(`/group/${groupId}/member/${memberId}`)
      commit('removeMember', { groupId, memberId })
      return true
    } catch (error) {
      throw error
    }
  },
  async setEvents ({ commit, state }, request) {
    try {
      let url = '/event/getAllEventsByFriends'
      if (state.selectedGroup === null) {
        // All events view
        const response = await $axios.get(url, {
          params: {
            userId: request.userId,
            page: request.page,
            sort: request.sort || 'LATEST',
          },
        })
        commit('setEvents', response.data.payload)
        return response
      } else {
        // Specific group view
        url = `/group/${state.selectedGroup}/events`
        const response = await $axios.get(url, {
          params: {
            page: request.page,
          },
        })
        commit('setEvents', response.data.payload)
        return response
      }
    } catch (error) {
      throw error
    }
  },
  async shareEventWithGroup ({ commit }, { eventId, groupId }) {
    try {
      const response = await $axios.post(`/group/${groupId}/share-event`, { eventId })
      return response
    } catch (error) {
      throw error
    }
  },
  async unshareEventFromGroup ({ commit }, { eventId, groupId }) {
    try {
      await $axios.delete(`/group/${groupId}/unshare-event/${eventId}`)
      return true
    } catch (error) {
      throw error
    }
  },
  async getGroupsForEvent ({ commit }, eventId) {
    try {
      const response = await $axios.get(`/group/event/${eventId}`)
      return response
    } catch (error) {
      throw error
    }
  },
}
