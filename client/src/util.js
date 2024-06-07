import { countries } from "@/country-list";
import router from "@/router";
import { toast } from "vue-sonner";

export const apiBaseUrl = import.meta.env.VITE_API_BASE_URL;
export const baseUrl = import.meta.env.VITE_BASE_URL;
export const isProd = import.meta.env.PROD;

export const to12hTime = (time24) => {
  let [h, m] = time24.split(":").map(Number);
  const period = h < 12 ? "AM" : "PM";
  h = (h % 12 || 12).toString().padStart(2, "0");
  m = m.toString().padStart(2, "0");
  return `${h}:${m} ${period}`;
};

// get iso datetime offset with timezone
export const toLocalISOString = (inputDate) => {
  const date = new Date(inputDate);
  const tzoffset = date.getTimezoneOffset() * 60000; // offset in milliseconds
  const localISOTime = new Date(date - tzoffset).toISOString().slice(0, -1);
  return localISOTime;
};

export const formatDate = (inputDate) => {
  const date = new Date(inputDate);
  const day = `0${date.getDate()}`.slice(-2);
  const month = `0${date.getMonth() + 1}`.slice(-2);
  const year = date.getFullYear();
  return `${day}/${month}/${year}`;
};

export const formatDateFromTimestamp = (timestamp) => {
  const date = new Date(timestamp);
  const year = date.getFullYear();
  const month = String(date.getMonth() + 1).padStart(2, "0"); // Months are 0-indexed
  const day = String(date.getDate()).padStart(2, "0");

  return `${day}-${month}-${year}`;
};

export const getCurrentDate = () => {
  const timestamp = new Date();
  return new Date(
    timestamp.getFullYear(),
    timestamp.getMonth(),
    timestamp.getDate()
  );
};

export const isObjEmpty = (obj) =>
  Object.keys(obj).length === 0 && obj.constructor === Object;

export const formatTimeFromDate = (currentDate) => {
  return `${currentDate.getHours()}:${currentDate.getMinutes()}`;
};

export const formatTimeFromTime = (time) => {
  return time?.slice(0, 5);
};

export const getDate = (date) => {
  const eventDate = new Date(date);
  return eventDate.getDate();
};

export const formatMonthYear = (date) => {
  const eventDate = new Date(date);
  const options = { year: "numeric", month: "long" };
  return eventDate.toLocaleDateString("en-US", options);
};

export const formatMonthDate = (date) => {
  const eventDate = new Date(date);
  const options = { day: "numeric", month: "long" };
  return eventDate.toLocaleDateString("en-US", options);
};

export const loadEventThumb = (imageName, category) => {
  if (category?.toLowerCase() === "registration") {
    return getClientPublicImgUrl("default-registration.jpeg");
  } else {
    return getEventImageUrl(imageName || null);
  }
};

export const getClientPublicImgUrl = (imageName) =>
  imageName ? `/img/${imageName}` : null;

export const getApiPublicImgUrl = (imageName, type) =>
  `${apiBaseUrl}/api/public/${type}/${imageName}`;

export const getEventImageUrl = (imageName) => {
  return imageName == null || !imageName
    ? getClientPublicImgUrl("default-event.jpg")
    : getApiPublicImgUrl(imageName, "event");
};

export const getBlogImageUrl = (imageName) => {
  return imageName == null || !imageName
    ? getClientPublicImgUrl("default-blog.jpg")
    : getApiPublicImgUrl(imageName, "blog");
};

export const getPageImageUrl = (imageName) => {
  return imageName == null || !imageName
    ? getClientPublicImgUrl("default-blog.jpg")
    : getApiPublicImgUrl(imageName, "page");
};

export const getUserImageUrl = (imageName) => {
  return imageName === "null" || !imageName
    ? getClientPublicImgUrl("default-user.jpg")
    : getApiPublicImgUrl(imageName, "user");
};

export const goUserProfile = (id) => {
  router.push({ name: "wall", params: { id } });
};

export const getToLink = (item) => {
  if (item.to.params) {
    const paramKey = Object.keys(item.to.params)[0];
    const paramVal = item.to.params[paramKey];
    return {
      name: item.to.name,
      params: { [paramKey]: paramVal },
    };
  }
  return item.to;
};

export const getCountryList = (filterName) => {
  if (filterName === "both") return countries;
  return countries.map((item) => item[filterName]);
};

export const getQueryParam = (param) => {
  const queryParams = new URLSearchParams(window.location.search);
  return queryParams.get(param);
};

export const removeQueryParams = (url, paramsToRemove) => {
  const parsedUrl = new URL(url);

  // Create a URLSearchParams object from the URL's search parameters
  const searchParams = new URLSearchParams(parsedUrl.search);

  // Remove the specified query parameters
  paramsToRemove.forEach((param) => {
    searchParams.delete(param);
  });

  // Construct the new URL with the updated search parameters
  parsedUrl.search = searchParams.toString();

  // Return the updated URL as a string
  return parsedUrl.toString();
};

export const isValidEmail = (email) => {
  const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
  return emailRegex.test(email);
};

export const isValidImage = (file) => {
  const allowedTypes = ["image/jpeg", "image/jpg", "image/png"];
  return allowedTypes.includes(file.type);
};

export const isValidPass = [
  (v) => !!v || "Password is required!",
  (v) => v.length >= 8 || "Password must be 8 or more characters!",
  (v) => /\d/.test(v) || "Password must include at least one number!",
];

export const showToast = (msg, color) => {
  if (color === "success") {
    toast.success(msg);
  } else if (color === "error") {
    toast.error(msg);
  } else if (color === "info") {
    toast.info(msg);
  } else if (color === "warning") {
    toast.warning(msg);
  } else {
    toast(msg);
  }
};

export const showApiQueryMsg = (color = "info") => {
  if (localStorage.hasOwnProperty("apiQueryMsg")) {
    showToast(localStorage.getItem("apiQueryMsg"), color);
    localStorage.removeItem("apiQueryMsg");
  }
};
