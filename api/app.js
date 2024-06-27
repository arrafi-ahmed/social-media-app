require("dotenv").config({ path: `.env.${process.env.NODE_ENV}` });
process.env.TZ = "UTC";
const express = require("express");
const app = express();
const path = require("path");
const customCors = require("./src/middleware/customCors");
const {
  globalErrHandler,
  uncaughtErrHandler,
} = require("./src/middleware/errHandler");
const scheduleTasks = require("./src/others/scheduler");
const port = process.env.PORT || 3000;

//middlewares
app.use(customCors);
app.use("/api/public", express.static(path.join(__dirname, "public")));
// stripe webhook needs raw req.body
app.use(
  "/api/webhook",
  express.raw({ type: "application/json" }),
  require("./src/controller/subscription")
);
app.use(express.json());

//routes
app.use("/api/user", require("./src/controller/user"));
app.use("/api/event", require("./src/controller/event"));
app.use("/api/category", require("./src/controller/category"));
app.use("/api/page", require("./src/controller/page"));
app.use("/api/blog", require("./src/controller/blog"));
app.use("/api/subscription", require("./src/controller/subscription"));

app.get("/api/version", function (req, res) {
  res.status(200).json({ version: 1.5 });
});

const server = app.listen(port, (err) => {
  if (err) return console.error(err);
  console.log(`Server started at ${port} - ${new Date().toISOString()}`);
});

scheduleTasks();
uncaughtErrHandler();
app.use(globalErrHandler);

//for dev purpose only, fix nodemon bug EADDRINUSE
process.once("SIGUSR2", function () {
  process.kill(process.pid, "SIGUSR2");
});
