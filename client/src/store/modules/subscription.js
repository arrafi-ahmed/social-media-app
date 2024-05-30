export const namespaced = true;

export const state = {
  subscription: {},
  stripeSubscription: {},
  subscriptionPlans: [],
};

export const mutations = {
  setSubscription(state, payload) {
    Object.assign(state.subscription, payload);
  },
  setStripeSubscription(state, payload) {
    Object.assign(state.stripeSubscription, payload);
  },
  resetSubscription(state) {
    state.subscription = {};
  },
  resetStripeSubscription(state) {
    state.stripeSubscription = {};
  },
  setSubscriptionPendingCancel(state, payload) {
    state.subscription.pending_cancel = payload;
  },
  setSubscriptionPlans(state, payload) {
    Object.assign(state.subscriptionPlans, payload);
  },
};

export const actions = {
  setSubscription({ commit }, request) {
    return new Promise((resolve, reject) => {
      $axios
        .get("/api/subscription/getSubscription", {
          params: { userId: request },
        })
        .then((response) => {
          commit("setSubscription", response.data?.payload);
          resolve(response);
        })
        .catch((err) => {
          reject(err);
        });
    });
  },
  setStripeSubscription({ commit }, request) {
    return new Promise((resolve, reject) => {
      $axios
        .get("/api/subscription/getStripeSubscription", {
          params: { subscriptionId: request },
        })
        .then((response) => {
          commit("setStripeSubscription", response.data?.payload);
          resolve(response);
        })
        .catch((err) => {
          reject(err);
        });
    });
  },
  fetchPremiumSubscriptionData({ commit }, request) {
    return new Promise((resolve, reject) => {
      $axios
        .get("/api/subscription/fetchPremiumSubscriptionData", {
          params: {
            userId: request.userId,
          },
        })
        .then((response) => {
          // for basic plan, backend returns null. so,
          // do resetSubscription, resetStripeSubscription
          // set subscription, then check & reset stripeSubscription
          commit("resetSubscription");
          commit("resetStripeSubscription");
          commit("setSubscription", response.data?.payload?.subscription);
          if (
            response.data?.payload?.subscription?.stripe_subscription_id !== "0"
          ) {
            commit(
              "setStripeSubscription",
              response.data?.payload?.stripeSubscription
            );
          } else {
          }

          resolve(response.data?.payload);
        })
        .catch((err) => {
          reject(err);
        });
    });
  },
  setSubscriptionPlans({ commit }) {
    return new Promise((resolve, reject) => {
      $axios
        .get("/api/subscription/getSubscriptionPlans")
        .then((response) => {
          commit("setSubscriptionPlans", response.data?.payload);
          resolve(response);
        })
        .catch((err) => {
          reject(err);
        });
    });
  },
  saveSubscription({ commit }, request) {
    return new Promise((resolve, reject) => {
      $axios
        .get("/api/subscription/saveSubscription", {
          params: { planId: request.id, planTitle: request.title },
        })
        .then((response) => {
          if (request.title === "basic") {
            commit(
              "setSubscription",
              response.data?.payload?.insertedSubscription
            );
          }
          resolve(response.data?.payload);
        })
        .catch((err) => {
          reject(err);
        });
    });
  },
  saveSubscriptionManually({ commit }, request) {
    return new Promise((resolve, reject) => {
      $axios
        .get("/api/subscription/saveSubscriptionManually", {
          params: {
            planId: request.planId,
            planTitle: request.planTitle,
            userId: request.userId,
          },
        })
        .then((response) => {
          resolve(response.data?.payload);
        })
        .catch((err) => {
          reject(err);
        });
    });
  },
  cancelSubscription({ commit }, request) {
    return new Promise((resolve, reject) => {
      $axios
        .get("/api/subscription/cancelSubscription", {
          params: {
            stripeSubscriptionId: request.stripeSubscriptionId,
          },
        })
        .then((response) => {
          if (response.data?.payload === "basic_deleted") {
            commit("resetSubscription");
          } else if (response.data?.payload === "premium_deleted") {
            commit("setSubscriptionPendingCancel", 1);
          }
          resolve(response.data?.payload);
        })
        .catch((err) => {
          reject(err);
        });
    });
  },
  deleteSubscription({ commit }, request) {
    return new Promise((resolve, reject) => {
      $axios
        .get("/api/subscription/deleteSubscription", {
          params: {
            userId: request.userId,
          },
        })
        .then((response) => {
          resolve(response.data?.payload);
        })
        .catch((err) => {
          reject(err);
        });
    });
  },
};

export const getters = {
  isSubscriptionValid(state) {
    return (
      state.subscription &&
      state.subscription.active === 1 &&
      state.stripeSubscription &&
      (state.stripeSubscription.status === "active" ||
        state.stripeSubscription.status === "trialing")
    );
  },
  isSubscriptionActive(state) {
    return state.subscription && state.subscription.active === 1;
  },
  pendingCancel(state) {
    return state.subscription && state.subscription.pending_cancel === 1;
  },
};
