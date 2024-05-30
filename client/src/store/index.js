import { createStore } from "vuex";
import * as cuser from "./modules/cuser";
import * as eventSingle from "./modules/event-single";
import * as eventWall from "./modules/event-wall";
import * as eventBrowse from "./modules/event-browse";
import * as eventFavorite from "./modules/event-favorite";
import * as eventWishlist from "./modules/event-wishlist";
import * as category from "./modules/category";
import * as page from "./modules/page";
import * as blog from "./modules/blog";
import * as subscription from "./modules/subscription";

const store = createStore({
  modules: {
    cuser,
    eventSingle,
    eventWall,
    eventBrowse,
    eventFavorite,
    eventWishlist,
    category,
    page,
    blog,
    subscription,
  },
  state: () => ({
    progress: null,
    routeInfo: {},
  }),
  mutations: {
    setProgress(state, payload) {
      state.progress = payload;
    },
    setRouteInfo(state, payload) {
      state.routeInfo = payload;
    },
  },
  actions: {},
});

export default store;
