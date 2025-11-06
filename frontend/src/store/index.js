import { createStore } from 'vuex'
import * as auth from './modules/auth.js'
import * as blog from './modules/blog'
import * as category from './modules/category'
import * as eventBrowse from './modules/event-browse'
import * as eventCollection from './modules/event-collection'
import * as eventSingle from './modules/event-single'
import * as group from './modules/group'
import * as eventWall from './modules/event-wall'
import * as eventWishlist from './modules/event-wishlist'
import * as page from './modules/page'
import * as subscription from './modules/subscription'
import * as user from './modules/user.js'

const store = createStore({
  modules: {
    user,
    auth,
    eventSingle,
    eventWall,
    eventBrowse,
    eventCollection,
    eventWishlist,
    group,
    category,
    page,
    blog,
    subscription,
  },
  state: () => ({
    progress: null,
    snackbars: [],
    routeInfo: { to: null, from: null, lastScrollY: null, actionSource: null },
  }),
  mutations: {
    setProgress (state, payload) {
      state.progress = payload
    },
    setRouteInfo (state, payload) {
      state.routeInfo = payload
    },
    addSnackbar (state, payload) {
      state.snackbars.push(payload)
    },
    setSnackbars (state, payload) {
      state.snackbars = payload
    },
    setScrollY (state, payload) {
      state.routeInfo.lastScrollY = payload
    },
    setActionSource (state, payload) {
      state.routeInfo.actionSource = payload
    },
  },
  actions: {},
})

export default store
