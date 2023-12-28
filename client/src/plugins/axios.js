import axios from "axios";
import store from "@/store";
import { showToast } from "@/util";

const $axios = axios.create({
  baseURL: import.meta.env.VITE_API_BASE_URL,
});

$axios.interceptors.request.use((config) => {
  store.commit("setProgress", true);
  const token = store.getters["cuser/getToken"];
  if (token) {
    config.headers["Authorization"] = token;
  }
  return config;
});

$axios.interceptors.response.use(
  (response) => {
    store.commit("setProgress", false);

    let color = null;
    if (response.data?.msg) {
      if (response.status >= 200 && response.status <= 299) {
        color = "success";
      } else if (response.status >= 400 && response.status <= 499) {
        color = "error";
      }
      showToast(response.data.msg, color);
    }
    return response;
  },
  (err) => {
    store.commit("setProgress", false);
    if (err.response?.data?.msg) {
      showToast(err.response?.data?.msg, "error");
    }
    return Promise.reject(err);
  }
);

export default $axios;
