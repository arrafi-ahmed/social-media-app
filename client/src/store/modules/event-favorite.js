export const namespaced = true;

export const state = {
  page: 1,
  events: [],
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
  resetPage(state) {
    state.page = 1;
  },
};
export const actions = {
  setEvents({ commit }, request) {
    return new Promise((resolve, reject) => {
      $axios
        .get("/api/event/getFavoriteEvents", {
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
};
