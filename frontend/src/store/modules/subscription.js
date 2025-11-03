import { Subscription, SubscriptionPlan } from '@/models'
import $axios from '@/plugins/axios'

export const namespaced = true

export const state = {
  subscription: {},
  stripeSubscription: {},
  subscriptionPlans: [],
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
  async fetchPremiumSubscriptionData ({ commit }, request) {
    try {
      const response = await $axios.get('/subscription/fetchPremiumSubscriptionData', { params: { userId: request.userId } })
      commit('resetSubscription')
      commit('resetStripeSubscription')
      commit('setSubscription', response.data?.payload?.subscription)
      if (response.data?.payload?.subscription?.stripeSubscriptionId !== '0') {
        commit('setStripeSubscription', response.data?.payload?.stripeSubscription)
      }
      return response.data?.payload
    } catch (error) {
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
    return state.subscription?.active
      && ['active', 'trialing'].includes(state.stripeSubscription?.status)
  },
  isSubscriptionActive (state) {
    console.log(4, state.subscription?.active)
    return state.subscription?.active === true
  },
  pendingCancel (state) {
    return state.subscription?.pendingCancel === true
  },
}
