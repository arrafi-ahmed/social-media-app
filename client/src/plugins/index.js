/**
 * plugins/app.js
 *
 * Automatically included in `./src/main.js`
 */

// Plugins
import vuetify from "./vuetify";
import router from "../router";
import store from "../store";
import $axios from "@/plugins/axios";
import { getQueryParam, removeQueryParams } from "@/util";
import { createGtm } from "@gtm-support/vue-gtm";

function handleApiQueryMsg() {
  //check if message came from server through query params
  const apiQueryMsg = getQueryParam("apiQueryMsg");

  if (apiQueryMsg) {
    const newUrl = removeQueryParams(window.location.href, ["apiQueryMsg"]);
    localStorage.setItem("apiQueryMsg", apiQueryMsg);
    window.location.href = newUrl;
  }
}

function handleAuthRoutes(to, isSignedin, userRole) {
  if (to.matched.some((record) => record.meta.requiresNoAuth) && isSignedin) {
    return store.getters["cuser/calcHome"];
  } else if (
    to.matched.some((record) => record.meta.requiresAuth) &&
    !isSignedin
  ) {
    return { name: "signin" };
  } else if (
    to.matched.some((record) => record.meta.requiresAdmin) &&
    userRole !== "admin"
  ) {
    return store.getters["cuser/calcHome"];
  } else if (!to.name && isSignedin) {
    return store.getters["cuser/calcHome"]; //undefined routes visited
  }
  return null;
}

export function registerPlugins(app) {
  router.beforeEach((to, from, next) => {
    //save routeinfo to state
    store.commit("setRouteInfo", { to, from });

    const isSignedin = store.getters["cuser/signedin"];
    const currentUser = store.getters["cuser/getCurrentUser"];
    const redirectRoute = handleAuthRoutes(to, isSignedin, currentUser.role);
    if (redirectRoute) {
      next(redirectRoute);
    }
    handleApiQueryMsg();
    next();
  });

  app.use(vuetify).use(router).use(store);
  // app.use(
  //   createGtm({
  //     id: "GTM-TBCVHTXV",
  //     vueRouter: router,
  //   })
  // );
  app.provide("$axios", $axios);
  window.$axios = $axios;
}
