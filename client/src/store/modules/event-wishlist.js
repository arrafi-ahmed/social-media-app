export const namespaced = true;

export const state = {
  page: 1,
  events: [],
  event: {},
};

export const mutations = {
  setPage(state, payload) {
    state.page = payload;
  },
  setEvents(state, payload) {
    state.events.push(...payload);
  },
  resetEvents(state) {
    state.events = [];
  },
  setEvent(state, payload) {
    state.event = payload;
  },
  addEvent(state, payload) {
    state.events.unshift(payload);
  },
  editEvent(state, payload) {
    const targetItemIndex = state.events.findIndex(
      (item) => item.id == payload.id
    );
    if (targetItemIndex === -1) return;
    state.events[targetItemIndex] = payload;
  },
  removeEvent(state, payload) {
    const targetItemIndex = state.events.findIndex(
      (item) => item.id == payload
    );
    if (targetItemIndex === -1) return;
    state.events.splice(targetItemIndex, 1);
  },
};

export const actions = {
  setEvents({ commit }, request) {
    return new Promise((resolve, reject) => {
      $axios
        .get("/api/event/getWishlistEvents", {
          params: { page: request.page },
        })
        .then((response) => {
          commit("setEvents", response.data.payload);
          resolve(response);
        })
        .catch((err) => {
          reject(err);
        });
    });
  },
  setEvent({ commit }, request) {
    return new Promise((resolve, reject) => {
      $axios
        .get("/api/event/getWishlistEvent", {
          params: { eventId: request },
        })
        .then((response) => {
          commit("setEvent", response.data.payload);
          resolve(response);
        })
        .catch((err) => {
          reject(err);
        });
    });
  },
  addEvent({ commit, state }, request) {
    return new Promise((resolve, reject) => {
      $axios
        .post("/api/event/addWishlistEvent", request)
        .then((response) => {
          commit("addEvent", response.data?.payload);
          resolve(response);
        })
        .catch((err) => {
          reject(err);
        });
    });
  },
  editEvent({ commit }, request) {
    return new Promise((resolve, reject) => {
      $axios
        .post("/api/event/editWishlistEvent", request)
        .then((response) => {
          commit("editEvent", response.data.payload);
          resolve(response);
        })
        .catch((err) => {
          reject(err);
        });
    });
  },
  deleteEvent({ commit }, request) {
    return new Promise((resolve, reject) => {
      $axios
        .get("/api/event/deleteWishlistEvent", { params: { eventId: request } })
        .then((response) => {
          commit("removeEvent", request);
          resolve(response);
        })
        .catch((err) => {
          reject(err);
        });
    });
  },
};
