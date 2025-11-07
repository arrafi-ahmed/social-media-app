const cron = require("node-cron");
const userService = require("./../service/user");
const eventService = require("./../service/event");

function scheduleTasks() {
  //send new comment notification email to users every 24 hours
  cron.schedule("0 0 * * *", async () => {
    userService.sendNewCommentEmail(process.env.VUE_BASE_URL);
    userService.sendTodaysEventEmail(process.env.VUE_BASE_URL);

    // Delete expired temporary posts
    try {
      const deletedCount = await eventService.deleteExpiredEvents();
      if (deletedCount > 0) {
        console.log(`Deleted ${deletedCount} expired temporary posts`);
      }
    } catch (error) {
      console.error("Error deleting expired events:", error);
    }
  });
}

module.exports = scheduleTasks;
