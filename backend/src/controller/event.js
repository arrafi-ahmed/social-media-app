const router = require("express").Router();
const { auth } = require("../middleware/auth");
const { upload } = require("../middleware/upload");
const ApiResponse = require("../model/ApiResponse");
const CustomError = require("../model/CustomError");
const { VUE_BASE_URL } = require("../others/util");
const eventService = require("../service/event");
const { compress } = require("../middleware/compress");

router.post("/save", auth, upload("event"), compress("event"), async (req, res, next) => {
  try {
    const userId = req.currentUser.id;
    const result = await eventService.save(
      req.body,
      req.processedFiles || req.files,
      userId,
      VUE_BASE_URL
    );
    res
      .status(200)
      .json(new ApiResponse("Event created successfully!", result));
  } catch (error) {
    return next(error);
  }
});

router.post("/edit", auth, upload("event"), compress("event"), async (req, res, next) => {
  try {
    const userId = req.currentUser.id;
    const result = await eventService.edit(
      req.body,
      req.processedFiles || req.files,
      userId,
      VUE_BASE_URL
    );
    res
      .status(200)
      .json(new ApiResponse("Event updated successfully!", result));
  } catch (error) {
    return next(error);
  }
});

router.get("/getEvent", auth, async (req, res, next) => {
  try {
    const eventId = req.query?.eventId ? parseInt(req.query.eventId, 10) : undefined;
    const result = await eventService.getEvent(eventId, req.currentUser.id);
    res.status(200).json(new ApiResponse(null, result));
  } catch (error) {
    return next(error);
  }
});

router.get("/getCommentsByEventId", auth, async (req, res, next) => {
  try {
    const eventId = req.query?.eventId ? parseInt(req.query.eventId, 10) : undefined;
    const result = await eventService.getCommentsByEventId(eventId);
    res.status(200).json(new ApiResponse(null, result));
  } catch (error) {
    return next(error);
  }
});

router.post("/addComment", auth, async (req, res, next) => {
  try {
    const result = await eventService.addComment(req.body, req.currentUser.id);
    res
      .status(200)
      .json(new ApiResponse("Comment posted successfully!", result));
  } catch (error) {
    return next(error);
  }
});

router.get("/deleteComment", auth, async (req, res, next) => {
  try {
    const commentId = req.query?.commentId ? parseInt(req.query.commentId, 10) : undefined;
    const result = await eventService.deleteComment(
      commentId,
      req.currentUser.id,
      req.currentUser.role
    );

    if (!result) {
      throw new Error();
    }

    res
      .status(200)
      .json(new ApiResponse("Comment deleted successfuly!", result));
  } catch (error) {
    return next(error);
  }
});

router.get("/deleteEvent", auth, async (req, res, next) => {
  try {
    const eventId = req.query?.eventId ? parseInt(req.query.eventId, 10) : undefined;
    const images = req.query?.images;
    const result = await eventService.deleteEvent(
      eventId,
      images,
      req.currentUser.id,
      req.currentUser.role
    );

    if (!result) {
      throw new Error();
    }

    res
      .status(200)
      .json(new ApiResponse("Event deleted successfuly!", result));
  } catch (error) {
    return next(error);
  }
});


router.get("/switchFavoriteEvent", auth, async (req, res, next) => {
  try {
    const eventId = req.query?.eventId ? parseInt(req.query.eventId, 10) : undefined;
    const payload = req.query?.payload;
    const collectionId = req.query?.collectionId ? parseInt(req.query.collectionId, 10) : null;
    const result = await eventService.switchFavoriteEvent(
      eventId,
      payload,
      req.currentUser.id,
      collectionId
    );
    res
      .status(200)
      .json(
        new ApiResponse(
          "Event " +
          (result === true ? "saved to" : "removed from") +
          " saved events!",
          result
        )
      );
  } catch (error) {
    return next(error);
  }
});

router.post("/reaction", auth, async (req, res, next) => {
  try {
    const { eventId, reactionType } = req.body;
    if (!eventId || !reactionType) {
      return next(new CustomError("Event ID and reaction type are required!", 400));
    }
    const result = await eventService.toggleReaction(
      parseInt(eventId),
      reactionType,
      req.currentUser.id
    );
    const message = result.isActive
      ? `Reaction ${result.reactionType} added!`
      : "Reaction removed!";
    res.status(200).json(new ApiResponse(message, result));
  } catch (error) {
    return next(error);
  }
});

router.get("/reactions/:eventId", auth, async (req, res, next) => {
  try {
    const eventId = parseInt(req.params.eventId);
    const result = await eventService.getEventReactions(eventId, req.currentUser.id);
    res.status(200).json(new ApiResponse(null, result)); // No message to suppress snackbar
  } catch (error) {
    return next(error);
  }
});

router.get("/getFavoriteEvents", auth, async (req, res, next) => {
  try {
    const userId = req.query?.userId ? parseInt(req.query.userId, 10) : req.currentUser.id;
    const page = req.query?.page ? parseInt(req.query.page, 10) : 1;
    const result = await eventService.getFavoriteEvents(userId, page);
    res.status(200).json(new ApiResponse(null, result));
  } catch (error) {
    return next(error);
  }
});

router.get("/isFavorite", auth, async (req, res, next) => {
  try {
    const userId = req.currentUser.id;
    const eventId = req.query?.eventId;
    const result = await eventService.isFavorite(eventId, userId);
    res.status(200).json(new ApiResponse(null, result));
  } catch (error) {
    return next(error);
  }
});


router.get("/getEventsByUserId", auth, async (req, res, next) => {
  try {
    const userId = req.query?.userId ? parseInt(req.query.userId, 10) : req.currentUser.id;
    const page = req.query?.page ? parseInt(req.query.page, 10) : 1;
    const sort = req.query?.sort || "LATEST";
    const result = await eventService.getEventsByUserId({ userId, page, sort });
    res.status(200).json(new ApiResponse(null, result));
  } catch (error) {
    return next(error);
  }
});

router.get("/getAllEventsByFriends", auth, async (req, res, next) => {
  try {
    const userId = req.query?.userId ? parseInt(req.query.userId, 10) : req.currentUser.id;
    const page = req.query?.page ? parseInt(req.query.page, 10) : 1;
    const sort = req.query?.sort || "LATEST";
    const result = await eventService.getAllEventsByFriends({ userId, page, sort });
    res.status(200).json(new ApiResponse(null, result));
  } catch (error) {
    return next(error);
  }
});

router.get("/getUpcomingEvents", auth, async (req, res, next) => {
  try {
    const userId = req.query?.userId ? parseInt(req.query.userId, 10) : req.currentUser.id;
    const source = req.query?.source;
    const result = await eventService.getUpcomingEvents(userId, source);
    res.status(200).json(new ApiResponse(null, result));
  } catch (error) {
    return next(error);
  }
});

router.post("/findWallEvents", auth, async (req, res, next) => {
  try {
    req.body.userId = req.body?.userId ? parseInt(req.body.userId, 10) : req.currentUser.id;
    const result = await eventService.findWallEvents(req.body);
    res.status(200).json(new ApiResponse(null, result));
  } catch (error) {
    return next(error);
  }
});

router.post("/findBrowseEvents", auth, async (req, res, next) => {
  try {
    req.body.userId = req.body?.userId ? parseInt(req.body.userId, 10) : req.currentUser.id;
    const result = await eventService.findBrowseEvents(req.body);
    res.status(200).json(new ApiResponse(null, result));
  } catch (error) {
    return next(error);
  }
});

router.get("/getFeaturedEvent", auth, async (req, res, next) => {
  try {
    const userId = req.query?.userId ? parseInt(req.query.userId, 10) : req.currentUser.id;
    const result = await eventService.getFeaturedEvent(userId);
    res.status(200).json(new ApiResponse(null, result));
  } catch (error) {
    return next(error);
  }
});

router.get("/swichFeaturedEvent", auth, async (req, res, next) => {
  try {
    const payload = req.query?.payload;
    const newEventId = req.query?.newEventId;
    const oldEventId = req.query?.oldEventId;
    const userId = req.query?.userId || req.currentUser.id;

    const result = await eventService.swichFeaturedEvent(
      payload,
      newEventId,
      oldEventId,
      userId
    );

    const message = result ? "Event featured successfully!" : "Event unfeatured successfully!";
    res.status(200).json(new ApiResponse(message, result));
  } catch (error) {
    return next(error);
  }
});

router.get("/setEventNotification", auth, async (req, res, next) => {
  try {
    const eventId = req.query?.eventId;
    const payload = req.query?.payload;
    const userId = req.query?.userId || req.currentUser.id;
    const result = await eventService.setEventNotification(eventId, payload);
    res.status(200).json(new ApiResponse(null, result));
  } catch (error) {
    return next(error);
  }
});

router.get("/postLimitStatus", auth, async (req, res, next) => {
  try {
    const userId = req.currentUser.id;
    const result = await eventService.getPostLimitStatus(userId);
    res.status(200).json(new ApiResponse(null, result));
  } catch (error) {
    return next(error);
  }
});

module.exports = router;
