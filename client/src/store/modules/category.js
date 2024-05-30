export const namespaced = true;

export const state = {
  categories: [],
};

export const mutations = {
  setCategories(state, payload) {
    state.categories = payload.sort((a, b) => a.name.localeCompare(b.name));
  },
  addCategory(state, payload) {
    state.categories.unshift(payload);
    state.categories.sort((a, b) => a.name.localeCompare(b.name));
  },
  editCategory(state, payload) {
    const targetItemIndex = state.categories.findIndex(
      (item) => item.id === payload.id
    );
    if (targetItemIndex === -1) return;
    state.categories[targetItemIndex] = payload;
  },
  deleteCategory(state, payload) {
    const targetItemIndex = state.categories.findIndex(
      (item) => item.id === payload
    );
    if (targetItemIndex === -1) return;
    state.categories.splice(targetItemIndex, 1);
  },
};

export const actions = {
  setCategories({ commit }, request) {
    return new Promise((resolve, reject) => {
      $axios
        .get("/api/category/getCategories")
        .then((response) => {
          commit("setCategories", response.data?.payload);
          resolve(response);
        })
        .catch((err) => {
          reject(err);
        });
    });
  },
  addCategory({ commit }, request) {
    return new Promise((resolve, reject) => {
      $axios
        .post("/api/category/save", request)
        .then((response) => {
          commit("addCategory", response.data?.payload);
          resolve(response);
        })
        .catch((err) => {
          reject(err);
        });
    });
  },
  editCategory({ commit }, request) {
    return new Promise((resolve, reject) => {
      $axios
        .post("/api/category/edit", request)
        .then((response) => {
          commit("editCategory", request);
          resolve(response);
        })
        .catch((err) => {
          reject(err);
        });
    });
  },
  deleteCategory({ commit }, request) {
    return new Promise((resolve, reject) => {
      $axios
        .get("/api/category/delete", { params: { id: request } })
        .then((response) => {
          commit("deleteCategory", request);
          resolve(response);
        })
        .catch((err) => {
          reject(err);
        });
    });
  },
};

export const getters = {};
