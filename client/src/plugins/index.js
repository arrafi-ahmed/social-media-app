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

export function registerPlugins(app) {
  router.beforeEach((to, from, next) => {
    const signedin = store.getters["cuser/signedin"];
    const isAdmin = store.getters["cuser/isAdmin"];

    store.commit("setRouteInfo", { to, from });

    if (
      to.name === "register" ||
      to.name === "signin" ||
      to.name === "landing"
    ) {
      if (signedin) {
        if (isAdmin) {
          return next({ name: "adminDashboard" });
        } else {
          return next({
            name: "browse",
          });
        }
      }
    } else if (
      to.matched.some((record) => record.meta.requiresAuth) &&
      !signedin
    ) {
      return next({ name: "signin" });
    } else if (
      to.matched.some((record) => record.meta.requiresAdmin) &&
      !isAdmin
    ) {
      return next({ name: "signin" });
    }

    //check if message came from server through query params
    const apiQueryMsg = getQueryParam("apiQueryMsg");

    if (apiQueryMsg) {
      const newUrl = removeQueryParams(window.location.href, ["apiQueryMsg"]);
      localStorage.setItem("apiQueryMsg", apiQueryMsg);
      window.location.href = newUrl;
    }

    next();
  });
  app.provide("$axios", $axios);
  window.$axios = $axios;
  app.use(vuetify).use(router).use(store);
}
