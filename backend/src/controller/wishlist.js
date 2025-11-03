const router = require("express").Router();
const { auth } = require("../middleware/auth");
const { upload } = require("../middleware/upload");
const { compress } = require("../middleware/compress");
const ApiResponse = require("../model/ApiResponse");
const wishlistService = require("../service/wishlist");

router.get("/getEvents", auth, async (req, res, next) => {
  try {
    const userId = req.query?.userId ? parseInt(req.query.userId, 10) : req.currentUser.id;
    const page = req.query?.page ? parseInt(req.query.page, 10) : 1;
    const result = await wishlistService.getEvents(userId, page);
    res.status(200).json(new ApiResponse(null, result));
  } catch (error) {
    return next(error);
  }
});

router.get("/getEvent", auth, async (req, res, next) => {
  try {
    const eventId = req.query?.eventId;
    const result = await wishlistService.getEvent(eventId);
    res.status(200).json(new ApiResponse(null, result));
  } catch (error) {
    return next(error);
  }
});

router.post("/save", auth, upload("wishlist"), compress("wishlist"), async (req, res, next) => {
  try {
    const result = await wishlistService.save(req.body, req.processedFiles || req.files, req.currentUser.id);
    res.status(200).json(new ApiResponse("Wishlist created successfully!", result));
  } catch (error) {
    return next(error);
  }
});

router.post("/edit", auth, upload("wishlist"), compress("wishlist"), async (req, res, next) => {
  try {
    const result = await wishlistService.edit(req.body, req.processedFiles || req.files, req.currentUser.id);
    res.status(200).json(new ApiResponse("Wishlist edited successfully!", result));
  } catch (error) {
    return next(error);
  }
});

router.get("/deleteEvent", auth, async (req, res, next) => {
  try {
    const eventId = req.query?.eventId ? parseInt(req.query.eventId, 10) : undefined;
    const result = await wishlistService.deleteEvent(eventId, req.currentUser.id, req.currentUser.role);
    if (!result) throw new Error();
    res.status(200).json(new ApiResponse("Event deleted successfuly!", result));
  } catch (error) {
    return next(error);
  }
});

module.exports = router;




