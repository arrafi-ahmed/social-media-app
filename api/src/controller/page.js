const router = require("express").Router();
const ApiResponse = require("../model/ApiResponse");
const auth = require("../middleware/auth");
const pageService = require("../service/page");
const { uploadPage } = require("../middleware/upload");
const compressImages = require("../middleware/compress");

router.get("/getPage", (req, res) => {
  const pageName = req.query && req.query.pageName;
  pageService
    .getPage(pageName)
    .then((result) => {
      res.status(200).json(new ApiResponse(null, result));
    })
    .catch((err) => {
      res.status(500).json(new ApiResponse("Page load failed!", null));
    });
});

router.post("/updatePage", auth, uploadPage, compressImages, (req, res) => {
  pageService
    .updatePage(req.body, req.files)
    .then((result) => {
      res
        .status(200)
        .json(new ApiResponse("Page updated successfully!", result));
    })
    .catch((err) => {
      res.status(500).json(new ApiResponse("Page update failed!", null));
    });
});

module.exports = router;
