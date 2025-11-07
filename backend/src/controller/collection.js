const router = require("express").Router();
const { auth } = require("../middleware/auth");
const ApiResponse = require("../model/ApiResponse");
const CustomError = require("../model/CustomError");
const collectionService = require("../service/collection");

// Create a new collection
router.post("/", auth, async (req, res, next) => {
  try {
    const { name, description, color, icon } = req.body;
    if (!name || name.trim() === "") {
      return next(new CustomError("Collection name is required!", 400));
    }
    const result = await collectionService.createCollection(
      req.currentUser.id,
      name,
      description,
      color,
      icon
    );
    res.status(200).json(new ApiResponse("Collection created successfully!", result));
  } catch (error) {
    return next(error);
  }
});

// Update a collection
router.put("/:id", auth, async (req, res, next) => {
  try {
    const collectionId = parseInt(req.params.id);
    const { name, description, color, icon } = req.body;
    const updates = {};
    if (name !== undefined) updates.name = name;
    if (description !== undefined) updates.description = description;
    if (color !== undefined) updates.color = color;
    if (icon !== undefined) updates.icon = icon;

    const result = await collectionService.updateCollection(
      collectionId,
      req.currentUser.id,
      updates
    );
    res.status(200).json(new ApiResponse("Collection updated successfully!", result));
  } catch (error) {
    return next(error);
  }
});

// Delete a collection
router.delete("/:id", auth, async (req, res, next) => {
  try {
    const collectionId = parseInt(req.params.id);
    await collectionService.deleteCollection(collectionId, req.currentUser.id);
    res.status(200).json(new ApiResponse("Collection deleted successfully!", true));
  } catch (error) {
    return next(error);
  }
});

// Get all collections for the current user
router.get("/", auth, async (req, res, next) => {
  try {
    const result = await collectionService.getUserCollections(req.currentUser.id);
    res.status(200).json(new ApiResponse(null, result));
  } catch (error) {
    return next(error);
  }
});

// Get a single collection
router.get("/:id", auth, async (req, res, next) => {
  try {
    const collectionId = parseInt(req.params.id);
    const result = await collectionService.getCollection(collectionId, req.currentUser.id);
    res.status(200).json(new ApiResponse(null, result));
  } catch (error) {
    return next(error);
  }
});

// Get events in a collection
router.get("/:id/events", auth, async (req, res, next) => {
  try {
    const collectionId = parseInt(req.params.id);
    const page = req.query?.page ? parseInt(req.query.page, 10) : 1;
    const result = await collectionService.getCollectionEvents(
      collectionId,
      req.currentUser.id,
      page
    );
    res.status(200).json(new ApiResponse(null, result));
  } catch (error) {
    return next(error);
  }
});

// Get all saved events (uncategorized)
router.get("/all/events", auth, async (req, res, next) => {
  try {
    const page = req.query?.page ? parseInt(req.query.page, 10) : 1;
    const result = await collectionService.getAllSavedEvents(req.currentUser.id, page);
    res.status(200).json(new ApiResponse(null, result));
  } catch (error) {
    return next(error);
  }
});

// Get all events from all collections (for "All" view)
router.get("/all/collections/events", auth, async (req, res, next) => {
  try {
    const page = req.query?.page ? parseInt(req.query.page, 10) : 1;
    const result = await collectionService.getAllCollectionsEvents(req.currentUser.id, page);
    res.status(200).json(new ApiResponse(null, result));
  } catch (error) {
    return next(error);
  }
});

module.exports = router;

