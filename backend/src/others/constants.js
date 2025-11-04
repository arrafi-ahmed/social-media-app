// HTTP Status Codes
const HTTP_STATUS = {
  TOKEN_EXPIRED: 440, // Login Time-out (custom status for token expiry)
  UNAUTHORIZED: 401,
  BAD_REQUEST: 400,
  INTERNAL_SERVER_ERROR: 500,
  SUCCESS: 200
};

const ROLES = {
  ADMIN: 10,
  CUSTOMER: 20
};

module.exports = {
  HTTP_STATUS,
  ROLES
};