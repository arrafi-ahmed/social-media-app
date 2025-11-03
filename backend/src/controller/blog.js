const router = require("express").Router();
const { auth } = require("../middleware/auth");
const { upload } = require("../middleware/upload");
const ApiResponse = require("../model/ApiResponse");
const blogService = require("../service/blog");
const { compress } = require("../middleware/compress");

//check if admin
router.post("/save", auth, upload("blog"), compress("blog"), async (req, res, next) => {
  try {
    const userId = req.currentUser.id;
    const result = await blogService.saveBlog(req.body, req.processedFiles, userId);
    res.status(200).json(new ApiResponse("Blog created successfully!", result));
  } catch (error) {
    return next(error);
  }
});

router.post("/edit", auth, upload("blog"), compress("blog"), async (req, res, next) => {
  try {
    const result = await blogService.editBlog(req.body, req.files);
    if (!result) {
      throw new Error();
    }
    res.status(200).json(new ApiResponse("Blog updated successfully!", result));
  } catch (error) {
    return next(error);
  }
});

router.get("/delete", auth, async (req, res, next) => {
  try {
    const blogId = req.query?.blogId;
    const rmImage = req.query?.rmImage;
    const result = await blogService.deleteBlog(blogId, rmImage);

    if (!result) {
      throw new Error();
    }

    res
      .status(200)
      .json(new ApiResponse("Blog deleted successfully!", result));
  } catch (error) {
    return next(error);
  }
});

router.get("/getBlogs", async (req, res, next) => {
  try {
    const result = await blogService.getBlogs();
    res.status(200).json(new ApiResponse(null, result));
  } catch (error) {
    return next(error);
  }
});

router.get("/getBlog", async (req, res, next) => {
  try {
    const blogId = req.query?.blogId;
    const result = await blogService.getBlog(blogId);
    res.status(200).json(new ApiResponse(null, result));
  } catch (error) {
    return next(error);
  }
});

module.exports = router;
