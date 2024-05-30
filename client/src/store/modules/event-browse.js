export const namespaced = true;
export const state = {
  page: 1,
  events: [],
  upcomingEvents: [],
};
export const mutations = {
  setPage(state, payload) {
    state.page = payload;
  },
  resetEvents(state) {
    state.events = [];
  },
  setEvents(state, payload) {
    state.events.push(...payload);
  },
  setUpcomingEvents(state, payload) {
    state.upcomingEvents = payload;
  },
  editEvent(state, payload) {
    const targetItemIndex = state.events.findIndex(
      (item) => item.id == payload.id
    );
    if (targetItemIndex === -1) return;
    state.events[targetItemIndex] = {
      ...state.events[targetItemIndex],
      ...payload,
    };
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
        .get("/api/event/getAllEventsByFriends", {
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
  findEvents(
    { commit },
    { searchKeyword, startDate, endDate, category, page }
  ) {
    return new Promise((resolve, reject) => {
      $axios
        .get("/api/event/findBrowseEvents", {
          params: { searchKeyword, startDate, endDate, category, page },
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
  editEvent({ commit }, request) {
    return new Promise((resolve, reject) => {
      $axios
        .post("/api/event/edit", request)
        .then((response) => {
          commit("editEvent", response.data.payload);
          resolve(response);
        })
        .catch((err) => {
          reject(err);
        });
    });
  },
  deleteEvent({ commit }, { eventId, images }) {
    return new Promise((resolve, reject) => {
      $axios
        .get("/api/event/deleteEvent", { params: { eventId, images } })
        .then((response) => {
          commit("removeEvent", eventId);
          if (state.featuredEvent?.id == eventId) {
            commit("setFeaturedEvent", {});
          }
          const upcomingEventsIndex = state.upcomingEvents.findIndex(
            (item) => item.id == eventId
          );
          if (upcomingEventsIndex !== -1) {
            commit("removeUpcomingEvents", upcomingEventsIndex);
          }
          resolve(response);
        })
        .catch((err) => {
          reject(err);
        });
    });
  },
  getUpcomingEvents({ commit }, request) {
    return new Promise((resolve, reject) => {
      $axios
        .get("/api/event/getUpcomingEvents", {
          params: { userId: request.userId, source: request.source },
        })
        .then((response) => {
          commit("setUpcomingEvents", response.data.payload);
          resolve(response);
        })
        .catch((err) => {
          reject(err);
        });
    });
  },
};
export const getters = {
  getMountedEventCategories(state) {
    const uniqueCategories = new Set();
    state.events.forEach((event) => {
      if (event.category) {
        uniqueCategories.add(event.category);
      }
    });
    return Array.from(uniqueCategories);
  },
};
