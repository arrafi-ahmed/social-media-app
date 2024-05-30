const cron = require("node-cron");
const userService = require("./../service/user");

const scheduleTasks = () => {
  //send new comment notification email to users every 24 hours
  cron.schedule("0 0 * * *", async () => {
    userService.sendNewCommentEmail(process.env.VUE_BASE_URL);
    userService.sendTodaysEventEmail(process.env.VUE_BASE_URL);
  });
};

module.exports = scheduleTasks;
