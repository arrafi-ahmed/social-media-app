export const namespaced = true;
export const state = {
  event: {
    comments: [],
    isFavorite: false,
  },
};
export const mutations = {
  setEvent(state, payload) {
    if (state.event) {
      Object.assign(state.event, payload);
      state.event.comments = payload?.comments || [];
    }
  },
  setCommentsByEventId(state, payload) {
    state.event.comments = payload;
  },
  addComment(state, payload) {
    state.event.comments.unshift(payload);
  },
  removeComment(state, payload) {
    const targetItemIndex = state.event.comments.findIndex(
      (item) => item.id == payload
    );
    if (targetItemIndex === -1) return;
    state.event.comments.splice(targetItemIndex, 1);
  },
  setIsFavorite(state, payload) {
    state.event.isFavorite = payload;
  },
};
export const actions = {
  getEvent({ commit }, request) {
    return new Promise((resolve, reject) => {
      $axios
        .get("/api/event/getEvent", {
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
  getCommentsByEventId({ commit }, request) {
    return new Promise((resolve, reject) => {
      $axios
        .get("/api/event/getCommentsByEventId", {
          params: { eventId: request },
        })
        .then((response) => {
          commit("setCommentsByEventId", response.data.payload);

          resolve(response);
        })
        .catch((err) => {
          reject(err);
        });
    });
  },
  addComment({ commit }, request) {
    return new Promise((resolve, reject) => {
      $axios
        .post("/api/event/addComment", request)
        .then((response) => {
          const savedComment = response.data.payload;
          savedComment.full_name = request.full_name;
          savedComment.image = request.image;

          commit("addComment", savedComment);
          resolve(response);
        })
        .catch((err) => {
          reject(err);
        });
    });
  },
  deleteComment({ commit }, request) {
    return new Promise((resolve, reject) => {
      $axios
        .get("/api/event/deleteComment", { params: { commentId: request } })
        .then((response) => {
          commit("removeComment", request);
          resolve(response);
        })
        .catch((err) => {
          reject(err);
        });
    });
  },
  switchFavoriteEvent({ commit, state }, request) {
    return new Promise((resolve, reject) => {
      $axios
        .get("/api/event/switchFavoriteEvent", {
          params: { eventId: request.eventId, payload: request.payload },
        })
        .then((response) => {
          commit("setIsFavorite", response.data.payload);

          console.log(0, request.payload);
          // update favorites page without reloading
          request.payload
            ? commit(`eventFavorite/addEvent`, state.event, {
                root: true,
              })
            : commit(`eventFavorite/removeEvent`, state.event?.id, {
                root: true,
              });
          resolve(response);
        })
        .catch((err) => {
          reject(err);
        });
    });
  },
  setIsFavorite({ commit }, request) {
    return new Promise((resolve, reject) => {
      $axios
        .get("/api/event/isFavorite", { params: { eventId: request } })
        .then((response) => {
          commit("setIsFavorite", response.data?.payload);
          resolve(response);
        })
        .catch((err) => {
          reject(err);
        });
    });
  },
};
