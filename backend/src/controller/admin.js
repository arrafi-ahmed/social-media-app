const router = require("express").Router();
const { auth, isAdmin } = require("../middleware/auth");
const ApiResponse = require("../model/ApiResponse");
const userService = require("../service/user");
const eventService = require("../service/event");

// Export all users to CSV
router.get("/export/users", auth, isAdmin, async (req, res, next) => {
  try {
    const users = await userService.getUsers();
    const csv = userService.exportUsersToCSV(users);
    
    res.setHeader('Content-Type', 'text/csv');
    res.setHeader('Content-Disposition', `attachment; filename="users_export_${new Date().toISOString().split('T')[0]}.csv"`);
    res.send(csv);
  } catch (error) {
    return next(error);
  }
});

// Export all events to CSV
router.get("/export/events", auth, isAdmin, async (req, res, next) => {
  try {
    const events = await eventService.getAllEvents();
    const csv = eventService.exportEventsToCSV(events);
    
    res.setHeader('Content-Type', 'text/csv');
    res.setHeader('Content-Disposition', `attachment; filename="events_export_${new Date().toISOString().split('T')[0]}.csv"`);
    res.send(csv);
  } catch (error) {
    return next(error);
  }
});

module.exports = router;

