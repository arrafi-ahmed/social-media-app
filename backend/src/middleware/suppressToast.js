const {HTTP_STATUS} = require("../others/util");

const suppressToastMiddleware = (req, res, next) => {
  // Store the original json method
  const originalJson = res.json;

  // Override the json method to check for suppress toast header
  res.json = function (data) {
    // Check if client wants to suppress toast notifications
    const suppressToast = req.headers["x-suppress-toast"] === "true";

    // Only suppress toast for success responses (2xx) and non-401/440 errors
    // Never suppress 401 authentication errors or 440 token expiry errors as they need to be shown to users
    if (suppressToast && data?.msg && res.statusCode !== 401 && res.statusCode !== HTTP_STATUS.TOKEN_EXPIRED) {
      // Remove the message to suppress toast for success responses and non-401 errors
      const {msg, ...dataWithoutMsg} = data;
      return originalJson.call(this, dataWithoutMsg);
    }

    // Return original response
    return originalJson.call(this, data);
  };

  next();
};

module.exports = suppressToastMiddleware;
