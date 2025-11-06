import { Subscription, SubscriptionPlan } from '@/models'
import $axios from '@/plugins/axios'

export const namespaced = true

// Initialize post limit status from localStorage if available
const getInitialPostLimitStatus = () => {
  if (typeof window !== 'undefined') {
    const stored = localStorage.getItem('postLimitStatus')
    if (stored) {
      try {
        return JSON.parse(stored)
      } catch (e) {
        // Ignore parse errors
      }
    }
  }
  return {
    isPremium: false,
    monthlyCount: 0,
    limit: 5,
    remaining: 0,
  }
}

export const state = {
  subscription: {},
  stripeSubscription: {},
  subscriptionPlans: [],
  postLimitStatus: getInitialPostLimitStatus(),
}

export const mutations = {
  setSubscription (state, payload) {
    state.subscription = new Subscription(payload || {})
  },
  setStripeSubscription (state, payload) {
    Object.assign(state.stripeSubscription, payload)
  },
  resetSubscription (state) {
    state.subscription = {}
  },
  resetStripeSubscription (state) {
    state.stripeSubscription = {}
  },
  setSubscriptionPendingCancel (state, payload) {
    state.subscription.pendingCancel = payload
  },
  setSubscriptionPlans (state, payload) {
    state.subscriptionPlans = (payload || []).map(
      planData => new SubscriptionPlan(planData || {}),
    )
  },
  setPostLimitStatus (state, payload) {
    state.postLimitStatus = payload || {
      isPremium: false,
      monthlyCount: 0,
      limit: 5,
      remaining: 0,
    }
    // Store in localStorage
    if (typeof window !== 'undefined') {
      localStorage.setItem('postLimitStatus', JSON.stringify(state.postLimitStatus))
    }
  },
  resetPostLimitStatus (state) {
    state.postLimitStatus = {
      isPremium: false,
      monthlyCount: 0,
      limit: 5,
      remaining: 0,
    }
    if (typeof window !== 'undefined') {
      localStorage.removeItem('postLimitStatus')
    }
  },
}

export const actions = {
  async setSubscription ({ commit }, request) {
    try {
      const response = await $axios.get('/subscription/getSubscription', { params: { userId: request } })
      commit('setSubscription', response.data?.payload)
      return response
    } catch (error) {
      throw error
    }
  },
  async setStripeSubscription ({ commit }, request) {
    try {
      const response = await $axios.get('/subscription/getStripeSubscription', { params: { subscriptionId: request } })
      commit('setStripeSubscription', response.data?.payload)
      return response
    } catch (error) {
      throw error
    }
  },
  async fetchPremiumSubscriptionData ({ commit, dispatch }, request) {
    try {
      const response = await $axios.get('/subscription/fetchPremiumSubscriptionData', { params: { userId: request.userId } })
      commit('resetSubscription')
      commit('resetStripeSubscription')
      commit('setSubscription', response.data?.payload?.subscription)
      if (response.data?.payload?.subscription?.stripeSubscriptionId !== '0') {
        commit('setStripeSubscription', response.data?.payload?.stripeSubscription)
      }
      // Load post limit status
      await dispatch('fetchPostLimitStatus', request.userId)
      return response.data?.payload
    } catch (error) {
      throw error
    }
  },
  async fetchPostLimitStatus ({ commit }, userId) {
    try {
      const response = await $axios.get('/event/postLimitStatus')
      commit('setPostLimitStatus', response.data?.payload)
      return response.data?.payload
    } catch (error) {
      // If error, try to load from localStorage
      if (typeof window !== 'undefined') {
        const stored = localStorage.getItem('postLimitStatus')
        if (stored) {
          try {
            commit('setPostLimitStatus', JSON.parse(stored))
          } catch (e) {
            // Ignore parse errors
          }
        }
      }
      throw error
    }
  },
  async setSubscriptionPlans ({ commit }) {
    try {
      const response = await $axios.get('/subscription/getSubscriptionPlans')
      commit('setSubscriptionPlans', response.data?.payload)
      return response
    } catch (error) {
      throw error
    }
  },
  async saveSubscription ({ commit }, request) {
    try {
      const response = await $axios.get('/subscription/saveSubscription', { params: { planId: request.id, planTitle: request.title } })
      if (request.title === 'basic') {
        commit('setSubscription', response.data?.payload?.insertedSubscription)
      }
      return response.data?.payload
    } catch (error) {
      throw error
    }
  },
  async saveSubscriptionManually ({ commit }, request) {
    try {
      const response = await $axios.get('/subscription/saveSubscriptionManually', { params: { planId: request.planId, planTitle: request.planTitle, userId: request.userId } })
      return response.data?.payload
    } catch (error) {
      throw error
    }
  },
  async cancelSubscription ({ commit }, request) {
    try {
      const response = await $axios.get('/subscription/cancelSubscription', { params: { stripeSubscriptionId: request.stripeSubscriptionId } })
      if (response.data?.payload === 'basic_deleted') {
        commit('resetSubscription')
      } else if (response.data?.payload === 'premium_deleted') {
        commit('setSubscriptionPendingCancel', true)
      }
      return response.data?.payload
    } catch (error) {
      throw error
    }
  },
  async deleteSubscription ({ commit }, request) {
    try {
      const response = await $axios.get('/subscription/deleteSubscription', { params: { userId: request.userId } })
      return response.data?.payload
    } catch (error) {
      throw error
    }
  },
}

export const getters = {
  isSubscriptionValid (state) {
    // Premium users (Standard/Ultimate) - check Stripe status
    if (state.subscription?.active && state.subscription?.planId !== 3) {
      return ['active', 'trialing'].includes(state.stripeSubscription?.status)
    }
    // Basic plan users (planId = 3) - check if they have remaining posts
    if (state.subscription?.active && state.subscription?.planId === 3) {
      return state.postLimitStatus?.remaining > 0 || state.postLimitStatus?.isPremium === true
    }
    // No subscription - check if they have remaining posts (for new users)
    return state.postLimitStatus?.remaining > 0 || state.postLimitStatus?.isPremium === true
  },
  isSubscriptionActive (state) {
    console.log(4, state.subscription?.active)
    return state.subscription?.active === true
  },
  pendingCancel (state) {
    return state.subscription?.pendingCancel === true
  },
  postLimitStatus (state) {
    return state.postLimitStatus
  },
}
