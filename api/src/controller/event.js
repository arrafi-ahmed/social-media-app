const router = require("express").Router();
const eventService = require("../service/event");
const { uploadEvent, compressImage } = require("../middleware/upload");
const auth = require("../middleware/auth");
const ApiResponse = require("../model/ApiResponse");
const CustomError = require("../model/CustomError");
const compressImages = require("../middleware/compress");

router.post("/save", auth, uploadEvent, compressImages, (req, res) => {
  const userId = req.currentUser.id;
  eventService
    .saveEvent(req.body, req.files, userId, req.CLIENT_BASE_URL)
    .then((result) => {
      res
        .status(200)
        .json(new ApiResponse("Event created successfully!", result));
    })
    .catch((err) => {
      res.status(500).json(new ApiResponse("Event creation failed!", null));
    });
});

router.post("/edit", auth, uploadEvent, compressImages, (req, res) => {
  const userId = req.currentUser.id;

  eventService
    .editEvent(req.body, req.files, userId, req.CLIENT_BASE_URL)
    .then((result) => {
      res
        .status(200)
        .json(new ApiResponse("Event updated successfully!", result));
    })
    .catch((err) => {
      res.status(500).json(new ApiResponse("Event updating failed!", null));
    });
});

router.get("/getEvent", auth, (req, res) => {
  const eventId = req.query && req.query.eventId;
  eventService
    .getEvent(eventId)
    .then((result) => {
      res.status(200).json(new ApiResponse(null, result));
    })
    .catch((err) => {
      res.status(500).json(new ApiResponse("Event loading failed!", null));
    });
});

router.get("/getCommentsByEventId", auth, (req, res) => {
  const eventId = req.query && req.query.eventId;
  eventService
    .getCommentsByEventId(eventId)
    .then((result) => {
      res.status(200).json(new ApiResponse(null, result));
    })
    .catch((err) => {
      res.status(500).json(new ApiResponse("Comment loading failed!", null));
    });
});

router.post("/addComment", auth, (req, res) => {
  eventService
    .addComment(req.body, req.currentUser.id)
    .then((result) => {
      res
        .status(200)
        .json(new ApiResponse("Comment posted successfully!", result));
    })
    .catch((err) => {
      res.status(500).json(new ApiResponse("Comment loading failed!", null));
    });
});

router.get("/deleteComment", auth, (req, res) => {
  const commentId = req.query && req.query.commentId;
  eventService
    .deleteComment(commentId, req.currentUser.id, req.currentUser.role)
    .then((result) => {
      if (result)
        res
          .status(200)
          .json(new ApiResponse("Comment deleted successfuly!", result));
      else throw new Error();
    })
    .catch((err) => {
      res.status(500).json(new ApiResponse("Comment deleting failed!", null));
    });
});

router.get("/deleteEvent", auth, (req, res) => {
  const eventId = req.query && req.query.eventId;
  const images = req.query && req.query.images;
  eventService
    .deleteEvent(eventId, images, req.currentUser.id, req.currentUser.role)
    .then((result) => {
      if (result)
        res
          .status(200)
          .json(new ApiResponse("Event deleted successfuly!", result));
      else throw new Error();
    })
    .catch((err) => {
      res.status(500).json(new ApiResponse("Event deleting failed!", null));
    });
});

router.get("/deleteWishlistEvent", auth, (req, res) => {
  const eventId = req.query && req.query.eventId;
  eventService
    .deleteWishlistEvent(eventId, req.currentUser.id, req.currentUser.role)
    .then((result) => {
      if (result)
        res
          .status(200)
          .json(new ApiResponse("Event deleted successfuly!", result));
      else throw new Error();
    })
    .catch((err) => {
      res.status(500).json(new ApiResponse("Event deleting failed!", null));
    });
});

router.get("/switchFavoriteEvent", auth, (req, res) => {
  const eventId = req.query && req.query.eventId;
  const payload = req.query && req.query.payload;
  eventService
    .switchFavoriteEvent(eventId, payload, req.currentUser.id)
    .then((result) => {
      res
        .status(200)
        .json(
          new ApiResponse(
            "Event " +
              (result === true ? "added to" : "removed from") +
              " favourites!",
            result
          )
        );
    })
    .catch((err) => {
      if (err instanceof CustomError) {
        res.status(err.statusCode).json(new ApiResponse(err.message, null));
      } else {
        res.status(500).json(new ApiResponse("Action failed!", null));
      }
    });
});

router.get("/getFavoriteEvents", auth, (req, res) => {
  const userId = (req.query && req.query.userId) || req.currentUser.id;
  const page = req.query && req.query.page;
  eventService
    .getFavoriteEvents(userId, page)
    .then((result) => {
      res.status(200).json(new ApiResponse(null, result));
    })
    .catch((err) => {
      res.status(500).json(new ApiResponse("Event loading failed!", null));
    });
});

router.get("/isFavorite", auth, (req, res) => {
  const userId = req.currentUser.id;
  const eventId = req.query && req.query.eventId;
  eventService
    .isFavorite(eventId, userId)
    .then((result) => {
      res.status(200).json(new ApiResponse(null, result));
    })
    .catch((err) => {
      res.status(500).json(new ApiResponse("Action failed!", null));
    });
});

router.get("/getWishlistEvents", auth, (req, res) => {
  const userId = (req.query && req.query.userId) || req.currentUser.id;
  const page = req.query && req.query.page;
  eventService
    .getWishlistEvents(userId, page)
    .then((result) => {
      res.status(200).json(new ApiResponse(null, result));
    })
    .catch((err) => {
      res.status(500).json(new ApiResponse("Event loading failed!", null));
    });
});

router.get("/getWishlistEvent", auth, (req, res) => {
  const eventId = req.query && req.query.eventId;
  eventService
    .getWishlistEvent(eventId)
    .then((result) => {
      res.status(200).json(new ApiResponse(null, result));
    })
    .catch((err) => {
      res.status(500).json(new ApiResponse("Event loading failed!", null));
    });
});

router.post(
  "/addWishlistEvent",
  auth,
  uploadEvent,
  compressImages,
  (req, res) => {
    eventService
      .addWishlistEvent(req.body, req.files, req.currentUser.id)
      .then((result) => {
        res
          .status(200)
          .json(new ApiResponse("Event created successfully!", result));
      })
      .catch((err) => {
        res.status(500).json(new ApiResponse("Event creation failed!", null));
      });
  }
);

router.post(
  "/editWishlistEvent",
  auth,
  uploadEvent,
  compressImages,
  (req, res) => {
    eventService
      .editWishlistEvent(req.body, req.files, req.currentUser.id)
      .then((result) => {
        res
          .status(200)
          .json(new ApiResponse("Event edited successfully!", result));
      })
      .catch((err) => {
        res.status(500).json(new ApiResponse("Event editing failed!", null));
      });
  }
);

router.get("/getEventsByUserId", auth, (req, res) => {
  req.query.payload.userId = req.query?.payload?.userId || req.currentUser.id;

  eventService
    .getEventsByUserId(req.query?.payload)
    .then((result) => {
      res.status(200).json(new ApiResponse(null, result));
    })
    .catch((err) => {
      res.status(500).json(new ApiResponse("Event loading failed!", null));
    });
});

router.get("/getAllEventsByFriends", auth, (req, res) => {
  const userId = (req.query && req.query.userId) || req.currentUser.id;
  const page = req.query && req.query.page;
  eventService
    .getAllEventsByFriends(userId, page)
    .then((result) => {
      res.status(200).json(new ApiResponse(null, result));
    })
    .catch((err) => {
      res.status(500).json(new ApiResponse("Event loading failed!", null));
    });
});

router.get("/getUpcomingEvents", auth, (req, res) => {
  const userId = (req.query && req.query.userId) || req.currentUser.id;
  const source = req.query && req.query.source;
  eventService
    .getUpcomingEvents(userId, source)
    .then((result) => {
      res.status(200).json(new ApiResponse(null, result));
    })
    .catch((err) => {
      res
        .status(500)
        .json(new ApiResponse("Upcoming Events loading failed!", null));
    });
});

router.post("/findWallEvents", auth, (req, res) => {
  req.body.userId = (req.body && req.body.userId) || req.currentUser.id;
  eventService
    .findWallEvents(req.body)
    .then((result) => {
      res.status(200).json(new ApiResponse(null, result));
    })
    .catch((err) => {
      res.status(500).json(new ApiResponse("Event loading failed!", null));
    });
});

router.post("/findBrowseEvents", auth, (req, res) => {
  req.body.userId = (req.body && req.body.userId) || req.currentUser.id;
  eventService
    .findBrowseEvents(req.body)
    .then((result) => {
      res.status(200).json(new ApiResponse(null, result));
    })
    .catch((err) => {
      res.status(500).json(new ApiResponse("Event loading failed!", null));
    });
});

router.get("/getFeaturedEvent", auth, (req, res) => {
  const userId = (req.query && req.query.userId) || req.currentUser.id;
  eventService
    .getFeaturedEvent(userId)
    .then((result) => {
      res.status(200).json(new ApiResponse(null, result));
    })
    .catch((err) => {
      res
        .status(500)
        .json(new ApiResponse("Featured Event loading failed!", null));
    });
});

router.get("/swichFeaturedEvent", auth, (req, res) => {
  const payload = req.query && req.query.payload;
  const newEventId = req.query && req.query.newEventId;
  const oldEventId = req.query && req.query.oldEventId;
  const userId = (req.query && req.query.userId) || req.currentUser.id;

  eventService
    .swichFeaturedEvent(payload, newEventId, oldEventId, userId)
    .then((result) => {
      if (result) {
        res
          .status(200)
          .json(new ApiResponse("Event featured successfully!", result));
      } else {
        res
          .status(200)
          .json(new ApiResponse("Event unfeatured successfully!", result));
      }
    })
    .catch((err) => {
      res.status(500).json(new ApiResponse("Action failed!", null));
    });
});

router.get("/setEventNotification", auth, (req, res) => {
  const eventId = req.query && req.query.eventId;
  const payload = req.query && req.query.payload;
  const userId = (req.query && req.query.userId) || req.currentUser.id;
  eventService
    .setEventNotification(eventId, payload)
    .then((result) => {
      res.status(200).json(new ApiResponse(null, result));
    })
    .catch((err) => {
      res
        .status(500)
        .json(new ApiResponse("Setting event notification failed!", null));
    });
});

module.exports = router;
