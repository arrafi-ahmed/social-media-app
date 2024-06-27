import axios from "axios";
import store from "@/store";
import { toast } from "vue-sonner";

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

    let action = "info";
    if (response.data?.msg) {
      if (response.status >= 200 && response.status <= 299) {
        action = "success";
      } else if (response.status >= 400 && response.status <= 499) {
        action = "error";
      }
      toast[action](response.data.msg);
    }
    return response;
  },
  (err) => {
    store.commit("setProgress", false);
    if (err.response?.data?.msg) {
      toast.error(err.response?.data?.msg);
    }
    return Promise.reject(err);
  }
);

export default $axios;
