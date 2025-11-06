const router = require("express").Router();
const { auth } = require("../middleware/auth");
const ApiResponse = require("../model/ApiResponse");
const CustomError = require("../model/CustomError");
const groupService = require("../service/group");

// Create a new group
router.post("/", auth, async (req, res, next) => {
  try {
    const { name, description, color, icon } = req.body;
    if (!name || name.trim() === '') {
      return next(new CustomError("Group name is required!", 400));
    }
    const result = await groupService.createGroup(
      req.currentUser.id,
      name,
      description,
      color,
      icon
    );
    res.status(200).json(new ApiResponse("Group created successfully!", result));
  } catch (error) {
    return next(error);
  }
});

// Update a group
router.put("/:id", auth, async (req, res, next) => {
  try {
    const groupId = parseInt(req.params.id);
    const { name, description, color, icon } = req.body;
    const updates = {};
    if (name !== undefined) updates.name = name;
    if (description !== undefined) updates.description = description;
    if (color !== undefined) updates.color = color;
    if (icon !== undefined) updates.icon = icon;

    const result = await groupService.updateGroup(
      groupId,
      req.currentUser.id,
      updates
    );
    res.status(200).json(new ApiResponse("Group updated successfully!", result));
  } catch (error) {
    return next(error);
  }
});

// Delete a group
router.delete("/:id", auth, async (req, res, next) => {
  try {
    const groupId = parseInt(req.params.id);
    await groupService.deleteGroup(groupId, req.currentUser.id);
    res.status(200).json(new ApiResponse("Group deleted successfully!", true));
  } catch (error) {
    return next(error);
  }
});

// Get all groups for the current user
router.get("/", auth, async (req, res, next) => {
  try {
    const result = await groupService.getUserGroups(req.currentUser.id);
    res.status(200).json(new ApiResponse(null, result));
  } catch (error) {
    return next(error);
  }
});

// Get a single group
router.get("/:id", auth, async (req, res, next) => {
  try {
    const groupId = parseInt(req.params.id);
    const result = await groupService.getGroupById(groupId, req.currentUser.id);
    res.status(200).json(new ApiResponse(null, result));
  } catch (error) {
    return next(error);
  }
});

// Get group members
router.get("/:id/members", auth, async (req, res, next) => {
  try {
    const groupId = parseInt(req.params.id);
    const result = await groupService.getGroupMembers(groupId, req.currentUser.id);
    res.status(200).json(new ApiResponse(null, result));
  } catch (error) {
    return next(error);
  }
});

// Add member to group
router.post("/:id/member", auth, async (req, res, next) => {
  try {
    const groupId = parseInt(req.params.id);
    const { userId, role } = req.body;
    if (!userId) {
      return next(new CustomError("User ID is required!", 400));
    }
    const result = await groupService.addMember(
      groupId,
      req.currentUser.id,
      userId,
      role || 'member'
    );
    res.status(200).json(new ApiResponse("Member added successfully!", result));
  } catch (error) {
    return next(error);
  }
});

// Remove member from group
router.delete("/:id/member/:memberId", auth, async (req, res, next) => {
  try {
    const groupId = parseInt(req.params.id);
    const memberId = parseInt(req.params.memberId);
    await groupService.removeMember(groupId, req.currentUser.id, memberId);
    res.status(200).json(new ApiResponse("Member removed successfully!", true));
  } catch (error) {
    return next(error);
  }
});

// Get events by group
router.get("/:id/events", auth, async (req, res, next) => {
  try {
    const groupId = parseInt(req.params.id);
    const page = parseInt(req.query.page) || 1;
    const result = await groupService.getEventsByGroup(groupId, req.currentUser.id, page);
    res.status(200).json(new ApiResponse(null, result));
  } catch (error) {
    return next(error);
  }
});

// Share event with group
router.post("/:id/share-event", auth, async (req, res, next) => {
  try {
    const groupId = parseInt(req.params.id);
    const { eventId } = req.body;
    if (!eventId) {
      return next(new CustomError("Event ID is required!", 400));
    }
    const result = await groupService.shareEventWithGroup(
      eventId,
      groupId,
      req.currentUser.id
    );
    res.status(200).json(new ApiResponse("Event shared with group successfully!", result));
  } catch (error) {
    return next(error);
  }
});

// Unshare event from group
router.delete("/:id/unshare-event/:eventId", auth, async (req, res, next) => {
  try {
    const groupId = parseInt(req.params.id);
    const eventId = parseInt(req.params.eventId);
    await groupService.unshareEventFromGroup(eventId, groupId, req.currentUser.id);
    res.status(200).json(new ApiResponse("Event unshared from group successfully!", true));
  } catch (error) {
    return next(error);
  }
});

// Get groups for an event
router.get("/event/:eventId", auth, async (req, res, next) => {
  try {
    const eventId = parseInt(req.params.eventId);
    const result = await groupService.getGroupsForEvent(eventId, req.currentUser.id);
    res.status(200).json(new ApiResponse(null, result));
  } catch (error) {
    return next(error);
  }
});

module.exports = router;

