import { Blog } from '@/models'
import $axios from '@/plugins/axios'

export const namespaced = true

export const state = {
  blogs: [],
  blog: {},
}

export const mutations = {
  setBlogs (state, payload) {
    state.blogs = (payload || []).map(blogData => new Blog(blogData || {}))
  },
  setBlog (state, payload) {
    state.blog = new Blog(payload || {})
  },
  addBlog (state, payload) {
    const blog = payload instanceof Blog ? payload : new Blog(payload || {})
    state.blogs.unshift(blog)
  },
  editBlog (state, payload) {
    const targetItemIndex = state.blogs.findIndex(
      item => item.id === payload.id,
    )
    if (targetItemIndex === -1) {
      return
    }
    state.blogs[targetItemIndex] = new Blog(payload || {})
  },
  deleteBlog (state, payload) {
    const targetItemIndex = state.blogs.findIndex(
      item => item.id === payload.blogId,
    )
    if (targetItemIndex === -1) {
      return
    }
    state.blogs.splice(targetItemIndex, 1)
  },
}

export const actions = {
  async setBlogs ({ commit }, request) {
    try {
      const response = await $axios.get('/blog/getBlogs')
      commit('setBlogs', response.data?.payload)
      return response
    } catch (error) {
      throw error
    }
  },
  async setBlog ({ commit }, request) {
    try {
      const response = await $axios.get('/blog/getBlog', { params: { blogId: request } })
      commit('setBlog', response.data?.payload)
      return response
    } catch (error) {
      throw error
    }
  },
  async addBlog ({ commit }, request) {
    try {
      const response = await $axios.post('/blog/save', request)
      commit('addBlog', response.data.payload)
      return response
    } catch (error) {
      throw error
    }
  },
  async editBlog ({ commit }, request) {
    try {
      const response = await $axios.post('/blog/edit', request)
      commit('editBlog', response.data?.payload)
      return response
    } catch (error) {
      throw error
    }
  },
  async deleteBlog ({ commit }, { blogId, rmImage }) {
    try {
      const response = await $axios.get('/blog/delete', { params: { blogId, rmImage } })
      commit('deleteBlog', { blogId })
      return response
    } catch (error) {
      throw error
    }
  },
}

export const getters = {}
