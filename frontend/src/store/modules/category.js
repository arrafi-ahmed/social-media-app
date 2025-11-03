import { Category } from '@/models'
import $axios from '@/plugins/axios'

export const namespaced = true

export const state = {
  categories: [],
}

export const mutations = {
  setCategories (state, payload) {
    const categories = (payload || []).map(
      categoryData => new Category(categoryData || {}),
    )
    state.categories = categories.sort((a, b) => a.name.localeCompare(b.name))
  },
  addCategory (state, payload) {
    const category
      = payload instanceof Category ? payload : new Category(payload || {})
    state.categories.unshift(category)
    state.categories.sort((a, b) => a.name.localeCompare(b.name))
  },
  editCategory (state, payload) {
    const targetItemIndex = state.categories.findIndex(
      item => item.id === payload.id,
    )
    if (targetItemIndex === -1) {
      return
    }
    state.categories[targetItemIndex] = new Category(payload || {})
  },
  deleteCategory (state, payload) {
    const targetItemIndex = state.categories.findIndex(
      item => item.id === payload,
    )
    if (targetItemIndex === -1) {
      return
    }
    state.categories.splice(targetItemIndex, 1)
  },
}

export const actions = {
  async setCategories ({ commit }, request) {
    try {
      const response = await $axios.get('/category/getCategories')
      commit('setCategories', response.data?.payload)
      return response
    } catch (error) {
      throw error
    }
  },
  async addCategory ({ commit }, request) {
    try {
      const response = await $axios.post('/category/save', request)
      commit('addCategory', response.data?.payload)
      return response
    } catch (error) {
      throw error
    }
  },
  async editCategory ({ commit }, request) {
    try {
      const response = await $axios.post('/category/edit', request)
      commit('editCategory', request)
      return response
    } catch (error) {
      throw error
    }
  },
  async deleteCategory ({ commit }, request) {
    try {
      const response = await $axios.get('/category/delete', { params: { id: request } })
      commit('deleteCategory', request)
      return response
    } catch (error) {
      throw error
    }
  },
}

export const getters = {}
