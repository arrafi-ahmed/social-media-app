const cors = require("cors");

const excludedUrls = ["/api/user/acceptInvite"];

const customCors = (req, res, next) => {
  const corsOptions = {
    origin: (origin, callback) => {
      const allowedOrigins = [
        req.CLIENT_BASE_URL,
        `https://www.${req.CLIENT_BASE_URL.slice(8)}`,
      ];
      if (allowedOrigins.includes(origin)) {
        callback(null, true);
      } else {
        callback(new Error("Not allowed by CORS"));
      }
    },
    exposedHeaders: "authorization",
    credentials: true,
  };
  const isExcluded = excludedUrls.some((url) => req.originalUrl.includes(url));
  if (isExcluded) {
    return next();
  }
  return cors(corsOptions)(req, res, next);
};

module.exports = customCors;
