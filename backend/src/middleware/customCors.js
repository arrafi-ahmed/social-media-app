const cors = require("cors");
const {excludedSecurityURLs} = require("../others/util");

const customCors = (req, res, next) => {
    const baseUrl = process.env.VUE_BASE_URL;
    const hostname = new URL(baseUrl).hostname;
    const corsOptions = {
        origin: (origin, callback) => {
            let urlwww = `https://www.${hostname}`;
            const allowedOrigins = [baseUrl];
            if (urlwww) {
                allowedOrigins.push(urlwww);
            }
            if (!origin || allowedOrigins.includes(origin)) {
                callback(null, true);
            } else {
                console.warn(
                    `[CORS Error]: Origin ${origin} not allowed for ${req.originalUrl}`,
                );
                return res.status(403).send("Not allowed by CORS");
            }
        },
        exposedHeaders: ["Content-Disposition", "authorization"],
        credentials: true,
    };

    const isExcluded = excludedSecurityURLs.some((url) =>
        req.originalUrl.includes(url),
    ); // Uses directly

    if (isExcluded) {
        res.header("Access-Control-Allow-Origin", "*");
        res.header(
            "Access-Control-Allow-Methods",
            "GET, POST, PUT, DELETE, OPTIONS",
        );
        res.header("Access-Control-Allow-Headers", "Content-Type, Authorization");
        if (req.method === "OPTIONS") {
            return res.sendStatus(204); // Respond to preflight immediately
        }
        return next();
    }
    return cors(corsOptions)(req, res, next);
};

module.exports = customCors;
