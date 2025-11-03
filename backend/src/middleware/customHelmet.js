const helmet = require("helmet");
const {excludedSecurityURLs} = require("../others/util");

const customHelmet = (req, res, next) => {
    const isExcluded = excludedSecurityURLs.some((url) =>
        req.originalUrl.includes(url),
    );

    helmet({contentSecurityPolicy: false})(req, res, (err) => {
        if (err) {
            console.warn("[Helmet Error]", err.message, "URL:", req.originalUrl);
            return next(err);
        }

        helmet.crossOriginResourcePolicy({
            policy: isExcluded ? "cross-origin" : "same-site",
        })(req, res, next);
    });
};

module.exports = customHelmet;
