// Central config for upload and compress middleware
const defaultConfig = {
  prefix: null,
  maxSize: 5 * 1024 * 1024, // 5MB
  allowedExts: [".jpg", ".jpeg", ".png"],
  maxWidth: 1400,
  format: "jpeg",
  quality: 80,
  dest: null,
  fieldName: null,
  maxCount: 1 // allow 0 or 1 file
};
module.exports = {
  event: {
    ...defaultConfig,
    prefix: "event",
    dest: "event",
    fieldName: "files",
    maxCount: 25
  },
  wishlist: {
    ...defaultConfig,
    prefix: "wishlist",
    dest: "wishlist",
    fieldName: "files",
    maxCount: 2
  },
  user: {
    ...defaultConfig,
    prefix: "user",
    dest: "user",
    fieldName: "files",
    maxCount: 1,
    maxWidth: 400
  },
  blog: {
    ...defaultConfig,
    prefix: "blog",
    dest: "blog",
    fieldName: "files",
    maxCount: 1
  },
  page: {
    ...defaultConfig,
    prefix: "page",
    dest: "page",
    fieldName: "files",
    maxCount: 3
  }

}; 