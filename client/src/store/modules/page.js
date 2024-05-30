export const namespaced = true;

export const state = {
  landing: { id: null, title: null, description: null },
  about: { id: null, title: null, description: null },
  terms: { id: null, title: null, description: null },
  privacy: { id: null, title: null, description: null },
};

export const mutations = {
  setLanding(state, payload) {
    Object.assign(state.landing, payload);
  },
  setAbout(state, payload) {
    Object.assign(state.about, payload);
  },
  setTerms(state, payload) {
    Object.assign(state.terms, payload);
  },
  setPrivacy(state, payload) {
    Object.assign(state.privacy, payload);
  },
};

export const actions = {
  setLanding({ commit }) {
    return new Promise((resolve, reject) => {
      $axios
        .get("/api/page/getPage", { params: { pageName: "landing" } })
        .then((response) => {
          commit("setLanding", response.data?.payload);
          resolve(response);
        })
        .catch((err) => {
          reject(err);
        });
    });
  },
  setAbout({ commit }) {
    return new Promise((resolve, reject) => {
      $axios
        .get("/api/page/getPage", { params: { pageName: "about" } })
        .then((response) => {
          commit("setAbout", response.data?.payload);
          resolve(response);
        })
        .catch((err) => {
          reject(err);
        });
    });
  },
  setTerms({ commit }) {
    return new Promise((resolve, reject) => {
      $axios
        .get("/api/page/getPage", { params: { pageName: "terms" } })
        .then((response) => {
          commit("setTerms", response.data?.payload);
          resolve(response);
        })
        .catch((err) => {
          reject(err);
        });
    });
  },
  setPrivacy({ commit }) {
    return new Promise((resolve, reject) => {
      $axios
        .get("/api/page/getPage", { params: { pageName: "privacy" } })
        .then((response) => {
          commit("setPrivacy", response.data?.payload);
          resolve(response);
        })
        .catch((err) => {
          reject(err);
        });
    });
  },
  updateLanding({ commit }, request) {
    return new Promise((resolve, reject) => {
      $axios
        .post("/api/page/updatePage", request)
        .then((response) => {
          commit("setLanding", response.data?.payload);
          resolve(response);
        })
        .catch((err) => {
          reject(err);
        });
    });
  },
  updateAbout({ commit }, request) {
    return new Promise((resolve, reject) => {
      $axios
        .post("/api/page/updatePage", request)
        .then((response) => {
          commit("setAbout", response.data?.payload);
          resolve(response);
        })
        .catch((err) => {
          reject(err);
        });
    });
  },
  updatePrivacy({ commit }, request) {
    return new Promise((resolve, reject) => {
      $axios
        .post("/api/page/updatePage", request)
        .then((response) => {
          commit("setPrivacy", response.data?.payload);
          resolve(response);
        })
        .catch((err) => {
          reject(err);
        });
    });
  },
  updateTerms({ commit }, request) {
    return new Promise((resolve, reject) => {
      $axios
        .post("/api/page/updatePage", request)
        .then((response) => {
          commit("setTerms", response.data?.payload);
          resolve(response);
        })
        .catch((err) => {
          reject(err);
        });
    });
  },
};

export const getters = {};
