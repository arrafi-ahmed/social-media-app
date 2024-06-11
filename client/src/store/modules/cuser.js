export const namespaced = true;

export const state = {
  token: localStorage.getItem("token") || null,
  currentUser: {
    id: localStorage.getItem("currentUserId") || null,
    name: localStorage.getItem("currentUserName") || null,
    image: localStorage.getItem("currentUserImage") || null,
    role: localStorage.getItem("currentUserRole") || null,
  },
  profile: {},
  settings: JSON.parse(localStorage.getItem("settings")) || {},
  foundUsers: [],
  friends: [],
};

export const mutations = {
  setToken(state, payload) {
    localStorage.setItem("token", payload);
    state.token = payload;
  },
  setCurrentUser(state, payload) {
    localStorage.setItem("currentUserId", payload.id);
    localStorage.setItem("currentUserName", payload.name);
    localStorage.setItem("currentUserImage", payload.image);
    localStorage.setItem("currentUserRole", payload.role);
    state.currentUser = payload;
  },
  setCurrentUserName(state, payload) {
    localStorage.setItem("currentUserName", payload);
    state.currentUser.name = payload;
  },
  setCurrentUserImage(state, payload) {
    localStorage.setItem("currentUserImage", payload);
    state.currentUser.image = payload;
  },
  removeToken(state) {
    localStorage.removeItem("token");
    state.token = null;
  },
  removeCurrentUser(state) {
    localStorage.removeItem("currentUserId");
    localStorage.removeItem("currentUserName");
    localStorage.removeItem("currentUserImage");
    localStorage.removeItem("currentUserRole");
    state.currentUser = {};
  },
  setProfile(state, payload) {
    state.profile = { ...state.profile, ...payload };
  },
  setUserSettings(state, payload) {
    localStorage.setItem("settings", JSON.stringify(payload));
    state.settings = payload;
  },
  setFoundUsers(state, payload) {
    state.foundUsers = payload;
  },
  removeFoundUsers(state) {
    state.foundUsers = [];
  },
  deleteUser(state, payload) {
    const targetItemIndex = state.foundUsers.findIndex(
      (item) => item.id === payload
    );
    if (targetItemIndex === -1) return;
    state.foundUsers.splice(targetItemIndex, 1);
  },
  setFriends(state, payload) {
    state.friends = payload;
  },
  removeFriend(state, payload) {
    const targetItemIndex = state.friends.findIndex(
      (item) => item.friendship_id === payload
    );
    if (targetItemIndex === -1) return;
    state.friends.splice(targetItemIndex, 1);
  },
};

export const actions = {
  signin({ commit }, request) {
    return new Promise((resolve, reject) => {
      $axios
        .post("/api/user/signin", request)
        .then((response) => {
          commit("setToken", response.headers?.authorization);
          commit("setCurrentUser", response.data?.payload?.currentUser);
          resolve(response);
        })
        .catch((err) => {
          reject(err);
        });
    });
  },
  signout({ commit }) {
    return new Promise((resolve) => {
      commit("removeToken");
      commit("removeCurrentUser");
      resolve();
    });
  },
  setProfile({ commit }) {
    return new Promise((resolve, reject) => {
      $axios
        .get("/api/user/getUserById")
        .then((response) => {
          commit("setProfile", response.data?.payload);
          resolve(response);
        })
        .catch((err) => {
          reject(err);
        });
    });
  },
  setProfileWSettings({ commit }) {
    return new Promise((resolve, reject) => {
      $axios
        .get("/api/user/getProfileWSettings")
        .then((response) => {
          commit("setProfile", response.data?.payload);
          resolve(response);
        })
        .catch((err) => {
          reject(err);
        });
    });
  },
  updateProfile({ commit }, request) {
    return new Promise((resolve, reject) => {
      $axios
        .post("/api/user/updateProfile", request)
        .then((response) => {
          commit("setProfile", response.data?.payload);
          commit("setCurrentUserName", response.data?.payload?.full_name);
          commit("setCurrentUserImage", response.data?.payload?.image);
          resolve(response);
        })
        .catch((err) => {
          reject(err);
        });
    });
  },
  updateSettings({ commit }, request) {
    return new Promise((resolve, reject) => {
      $axios
        .post("/api/user/updateSettings", request)
        .then((response) => {
          commit("setUserSettings", request);
          resolve(response);
        })
        .catch((err) => {
          reject(err);
        });
    });
  },
  updateEmailNewEventNotification({ commit }, request) {
    return new Promise((resolve, reject) => {
      $axios
        .get("/api/user/updateEmailNewEventNotification", {
          params: { payload: request },
        })
        .then((response) => {
          commit("setProfile", { email_new_event_notification: request });
          resolve(response);
        })
        .catch((err) => {
          reject(err);
        });
    });
  },
  updateEmailNewCommentNotification({ commit }, request) {
    return new Promise((resolve, reject) => {
      $axios
        .get("/api/user/updateEmailNewCommentNotification", {
          params: { payload: request },
        })
        .then((response) => {
          commit("setProfile", { email_new_comment_notification: request });
          resolve(response);
        })
        .catch((err) => {
          reject(err);
        });
    });
  },
  updateEmailUpdateEventNotification({ commit }, request) {
    return new Promise((resolve, reject) => {
      $axios
        .get("/api/user/updateEmailUpdateEventNotification", {
          params: { payload: request },
        })
        .then((response) => {
          commit("setProfile", { email_update_event_notification: request });
          resolve(response);
        })
        .catch((err) => {
          reject(err);
        });
    });
  },

  deleteAccount({ commit }, { rmImage }) {
    return new Promise((resolve, reject) => {
      $axios
        .get("/api/user/deleteUser", { params: { rmImage } })
        .then((response) => {
          resolve(response);
        })
        .catch((err) => {
          reject(err);
        });
    });
  },
  searchUser({ commit }, request) {
    return new Promise((resolve, reject) => {
      $axios
        .get("/api/user/searchUser", { params: { requestedUser: request } })
        .then((response) => {
          commit("setFoundUsers", response.data?.payload);
          resolve(response);
        })
        .catch((err) => {
          reject(err);
        });
    });
  },
  deleteUser({ commit }, request) {
    return new Promise((resolve, reject) => {
      $axios
        .get("/api/user/deleteUser", { params: { userId: request } })
        .then((response) => {
          commit("deleteUser", request);
          resolve(response);
        })
        .catch((err) => {
          reject(err);
        });
    });
  },
  setFriends({ commit }, request) {
    return new Promise((resolve, reject) => {
      $axios
        .get("/api/user/getFriends", { params: { userId: request } })
        .then((response) => {
          commit("setFriends", response.data?.payload);
          resolve(response);
        })
        .catch((err) => {
          reject(err);
        });
    });
  },
  removeFriend({ commit }, request) {
    return new Promise((resolve, reject) => {
      $axios
        .get("/api/user/removeFriend", { params: { friendshipId: request } })
        .then((response) => {
          commit("removeFriend", request);
          resolve(response);
        })
        .catch((err) => {
          reject(err);
        });
    });
  },
  checkFriends({ commit }, request) {
    return new Promise((resolve, reject) => {
      $axios
        .get("/api/user/checkFriends", { params: { otherUser: request } })
        .then((response) => {
          resolve(response);
        })
        .catch((err) => {
          reject(err);
        });
    });
  },
  sendInvite({ commit }, request) {
    return new Promise((resolve, reject) => {
      $axios
        .post("/api/user/sendInvite", request)
        .then((response) => {
          resolve(response);
        })
        .catch((err) => {
          reject();
        });
    });
  },
  requestResetPass({ commit }, request) {
    return new Promise((resolve, reject) => {
      $axios
        .post("/api/user/requestResetPass", { resetEmail: request })
        .then((response) => {
          resolve(response);
        })
        .catch((err) => {
          reject();
        });
    });
  },
  submitResetPass({ commit }, request) {
    return new Promise((resolve, reject) => {
      $axios
        .post("/api/user/submitResetPass", request)
        .then((response) => {
          resolve(response);
        })
        .catch((err) => {
          reject();
        });
    });
  },
  addAllUsersToAdminFriendlist() {
    return new Promise((resolve, reject) => {
      $axios
        .get("/api/user/addAllUsersToAdminFriendlist")
        .then((response) => {
          resolve(response);
        })
        .catch((err) => {
          reject();
        });
    });
  },
  setUserSettings({ commit }) {
    return new Promise((resolve, reject) => {
      $axios
        .get("/api/user/getUserSettings")
        .then((response) => {
          commit("setUserSettings", response.data?.payload);
          resolve(response);
        })
        .catch((err) => {
          reject();
        });
    });
  },
};

export const getters = {
  getToken(state) {
    return state.token;
  },
  getCurrentUser(state) {
    return state.currentUser;
  },
  getCurrentUserId(state) {
    return state.currentUser.id;
  },
  getCurrentUserRole(state) {
    return state.currentUser.role;
  },
  isAdmin(state) {
    return state.currentUser.role === "admin";
  },
  signedin(state) {
    return !!state.token;
  },
};
