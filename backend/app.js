require("dotenv").config({
  path:
    process.env.NODE_ENV === "production"
      ? ".env.production"
      : ".env.development",
});
process.env.TZ = "UTC";

const express = require("express");
const app = express();
const path = require("path");

const customHelmet = require("./src/middleware/customHelmet");
const customCors = require("./src/middleware/customCors");
const {
  globalErrHandler,
  uncaughtErrHandler,
} = require("./src/middleware/errHandler");
const suppressToastMiddleware = require("./src/middleware/suppressToast");
const { appInfo } = require("./src/others/util");
const scheduleTasks = require("./src/others/scheduler");
const port = process.env.PORT || 3000;

// Uncomment if Stripe webhook is needed
app.post(
  "/stripe/webhook",
  express.raw({ type: "application/json" }),
  require("./src/controller/stripe").webhook,
);
//middlewares
app.use(customHelmet);
app.use(customCors);

app.use(express.static(path.join(__dirname, "public")));
app.use(express.json());

app.use(suppressToastMiddleware);

//routes
app.use("/auth", require("./src/controller/auth"));
app.use("/user", require("./src/controller/user"));
app.use("/event", require("./src/controller/event"));
app.use("/wishlist", require("./src/controller/wishlist"));
app.use("/category", require("./src/controller/category"));
app.use("/page", require("./src/controller/page"));
app.use("/blog", require("./src/controller/blog"));
app.use("/subscription", require("./src/controller/subscription"));
app.use("/stripe", require("./src/controller/stripe").router);

app.get("/info", function (req, res) {
  res.status(200).json(appInfo);
});

app.listen(port, (err) => {
  if (err) return console.error(err);
  console.log(`Server started at ${port} - ${new Date()}`);
});

scheduleTasks();
uncaughtErrHandler();
app.use(globalErrHandler);