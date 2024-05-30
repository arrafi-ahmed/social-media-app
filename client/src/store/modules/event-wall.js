export const namespaced = true;

export const state = {
  page: 1,
  events: [],
  user: {},
  featuredEvent: {},
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
  addEvent(state, payload) {
    state.events.unshift(payload);
  },
  setUser(state, payload) {
    state.user = payload;
  },
  setFeaturedEvent(state, payload) {
    state.featuredEvent = payload;
  },
  setCategories(state, payload) {
    state.categories = payload;
  },
  setUpcomingEvents(state, payload) {
    state.upcomingEvents = payload;
  },
  removeUpcomingEvents(state, payload) {
    const targetItemIndex = state.upcomingEvents.findIndex(
      (item) => item.id == payload
    );
    if (targetItemIndex === -1) return;
    state.upcomingEvents.splice(targetItemIndex, 1);
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
  setEventNotification(state, payload) {
    const targetItemIndex = state.events.findIndex(
      (item) => item.id == payload.eventId
    );
    if (targetItemIndex === -1) return;
    state.events[targetItemIndex].new_notification = payload.payload;
  },
};

export const actions = {
  addEvent({ commit }, request) {
    return new Promise((resolve, reject) => {
      $axios
        .post("/api/event/save", request)
        .then((response) => {
          commit("addEvent", response.data.payload);
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
  setEvents({ commit }, { userId, page }) {
    return new Promise((resolve, reject) => {
      $axios
        .get("/api/event/getEventsByUserId", {
          params: { userId, page },
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
  getUserById({ commit }, request) {
    return new Promise((resolve, reject) => {
      $axios
        .get("/api/user/getUserById", { params: { userId: request } })
        .then((response) => {
          commit("setUser", response.data?.payload);
          resolve(response);
        })
        .catch((err) => {
          reject(err);
        });
    });
  },
  getFeaturedEvent({ commit }, request) {
    return new Promise((resolve, reject) => {
      $axios
        .get("/api/event/getFeaturedEvent", {
          params: { payload: true, userId: request },
        })
        .then((response) => {
          commit("setFeaturedEvent", response.data?.payload);
          resolve(response);
        })
        .catch((err) => {
          reject(err);
        });
    });
  },
  setFeaturedEvent({ commit, state }, request) {
    return new Promise((resolve, reject) => {
      $axios
        .get("/api/event/swichFeaturedEvent", {
          params: {
            payload: true,
            oldEventId: state.featuredEvent?.id,
            newEventId: request.eventId,
          },
        })
        .then((response) => {
          const foundFeaturedEvent = state.events.find(
            (item) => item.id === request.eventId
          );
          commit("setFeaturedEvent", foundFeaturedEvent);
          resolve(response);
        })
        .catch((err) => {
          reject(err);
        });
    });
  },
  unsetFeaturedEvent({ commit, state }, request) {
    return new Promise((resolve, reject) => {
      $axios
        .get("/api/event/swichFeaturedEvent", {
          params: {
            payload: false,
            oldEventId: null,
            newEventId: request.eventId,
          },
        })
        .then((response) => {
          commit("setFeaturedEvent", {});
          resolve(response);
        })
        .catch((err) => {
          reject(err);
        });
    });
  },
  setEventNotification({ commit, state }, request) {
    return new Promise((resolve, reject) => {
      $axios
        .get("/api/event/setEventNotification", {
          params: { eventId: request.eventId, payload: request.payload },
        })
        .then((response) => {
          commit("setEventNotification", {
            eventId: request.eventId,
            payload: request.payload,
          });
          resolve(response);
        })
        .catch((err) => {
          reject(err);
        });
    });
  },
  getCategories({ commit }, request) {
    return new Promise((resolve, reject) => {
      $axios
        .get("/api/event/getCategories")
        .then((response) => {
          const formattedCategories = response.data?.payload?.map(
            (item) => item.name
          );
          commit("setCategories", formattedCategories);
          resolve(response);
        })
        .catch((err) => {
          reject(err);
        });
    });
  },
  findEvents(
    { commit },
    { userId, searchKeyword, startDate, endDate, category, page }
  ) {
    return new Promise((resolve, reject) => {
      $axios
        .get("/api/event/findWallEvents", {
          params: { userId, searchKeyword, startDate, endDate, category, page },
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
  getFeaturedEvent(state) {
    return state.featuredEvent;
  },
};
