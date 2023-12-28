const router = require("express").Router();
const ApiResponse = require("../model/ApiResponse");
const auth = require("../middleware/auth");
const blogService = require("../service/blog");
const { uploadBlog } = require("../middleware/upload");
const compressImages = require("../middleware/compress");

//check if admin
router.post("/save", auth, uploadBlog, compressImages, (req, res) => {
  const userId = req.currentUser.id;
  blogService
    .saveBlog(req.body, req.files, userId)
    .then((result) => {
      res
        .status(200)
        .json(new ApiResponse("Blog created successfully!", result));
    })
    .catch((err) => {
      res.status(500).json(new ApiResponse("Blog creation failed!", null));
    });
});

router.post("/edit", auth, uploadBlog, compressImages, (req, res) => {
  blogService
    .editBlog(req.body, req.files)
    .then((result) => {
      if (!result) throw new Error();
      res
        .status(200)
        .json(new ApiResponse("Blog updated successfully!", result));
    })
    .catch((err) => {
      res.status(500).json(new ApiResponse("Blog updating failed!", null));
    });
});

router.get("/delete", auth, (req, res) => {
  const blogId = req.query && req.query.blogId;
  const rmImage = req.query && req.query.rmImage;
  blogService
    .deleteBlog(blogId, rmImage)
    .then((result) => {
      if (result) {
        res
          .status(200)
          .json(new ApiResponse("Blog deleted successfully!", result));
      } else {
        throw new Error();
      }
    })
    .catch((err) => {
      res.status(500).json(new ApiResponse("Blog deleting failed!", null));
    });
});

router.get("/getBlogs", (req, res) => {
  blogService
    .getBlogs()
    .then((result) => {
      res.status(200).json(new ApiResponse(null, result));
    })
    .catch((err) => {
      res.status(500).json(new ApiResponse("Blogs loading failed!", null));
    });
});

router.get("/getBlog", (req, res) => {
  const blogId = req.query && req.query.blogId;
  blogService
    .getBlog(blogId)
    .then((result) => {
      res.status(200).json(new ApiResponse(null, result));
    })
    .catch((err) => {
      res.status(500).json(new ApiResponse("Blog loading failed!", null));
    });
});

module.exports = router;
