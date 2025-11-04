const fs = require("node:fs").promises;
const path = require("node:path");
const { ROLES } = require("./constants");
const { API_BASE_URL, VUE_BASE_URL, NODE_ENV } = process.env;

const excludedSecurityURLs = [
  "/user/acceptInvite"
];
const HTTP_STATUS = {
  TOKEN_EXPIRED: 440, // Login Time-out (custom status for token expiry)
  UNAUTHORIZED: 401,
  BAD_REQUEST: 400,
  INTERNAL_SERVER_ERROR: 500
};

const isProd = NODE_ENV === "production";
const adminRole = 10;
const customerRole = 20;

const ifAdmin = (role) => role === ROLES.ADMIN;
const ifCustomer = (role) => role === ROLES.CUSTOMER;

const dirMap = {
  event: path.join(__dirname, "..", "..", "public", "event"),
  user: path.join(__dirname, "..", "..", "public", "user"),
  blog: path.join(__dirname, "..", "..", "public", "blog"),
  page: path.join(__dirname, "..", "..", "public", "page"),
  temp: path.join(__dirname, "..", "..", "public", "temp"),
  wishlist: path.join(__dirname, "..", "..", "public", "wishlist")
};

function getPrefix(filename) {
  return filename.split("-")[0];
}

function getDirPath(prefix) {
  return dirMap[prefix];
}

function getFilePath(filename, prefix) {
  const calcPrefix = prefix || getPrefix(filename);
  return path.join(dirMap[calcPrefix], filename);
}

const removeImages = async (imageArr) => {
  if (!Array.isArray(imageArr) || imageArr.length === 0) {
    return [];
  }

  const deletionResults = await Promise.all(
    imageArr.map(async (image) => {
      const filePath = getFilePath(image);
      if (!filePath) {
        console.error("Invalid file path for image:", image);
        return false;
      }

      try {
        await fs.unlink(filePath);
        return true;
      } catch (error) {
        console.error(`Failed to delete file: ${filePath}. Error:`, error);
        return false;
      }
    })
  );

  return deletionResults; // Array of booleans
};

function moveImage(sourcePath, destinationPath) {
  return fs.rename(sourcePath, destinationPath);
}

const applink = `
  <a href="https://play.google.com/store/apps/details?id=app.wayzaway.online&pcampaignid=web_share" target="_blank">
    <img src="${VUE_BASE_URL}/img/badge-google-play.png" alt="Download on Google Play" width="110" height="40">
  </a><br>
  <a href="https://apps.apple.com/us/app/wayzaway-lifestyle-journal/id6497877312" target="_blank">
    <img src="${VUE_BASE_URL}/img/badge-app-store.png" alt="Download on App Store" width="105" height="35">
  </a>
`;

const appInfo = { name: "WayzAway", version: 1.6 };

/**
 * Generate a URL-friendly slug from a string
 * @param {string} text - The text to convert to a slug
 * @returns {string} - The generated slug
 */
function generateSlug(text) {
  if (!text) return "";

  return text
    .toString()
    .toLowerCase()
    .trim()
    .replace(/\s+/g, "-")        // Replace spaces with hyphens
    .replace(/[^\w\s-]/g, "")    // Remove special characters
    .replace(/[-]+/g, "-")       // Replace multiple hyphens with single hyphen
    .replace(/^-+|-+$/g, "");    // Remove leading/trailing hyphens
}

module.exports = {
  API_BASE_URL,
  VUE_BASE_URL,
  adminRole,
  customerRole,
  ifAdmin,
  ifCustomer,
  isProd,
  appInfo,
  generateSlug,
  moveImage,
  getFilePath,
  getDirPath,
  getPrefix,
  removeImages,
  excludedSecurityURLs
};
