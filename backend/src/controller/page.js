const router = require("express").Router();
const {auth} = require("../middleware/auth");
const { upload } = require("../middleware/upload");
const ApiResponse = require("../model/ApiResponse");
const pageService = require("../service/page");
const { compress } = require("../middleware/compress");

router.get("/getPage", async (req, res, next) => {
  try {
    const pageName = req.query?.pageName;
    const result = await pageService.getPage(pageName);
    res.status(200).json(new ApiResponse(null, result));
  } catch (error) {
    return next(error);
  }
});

router.post(
  "/updatePage",
  auth,
  upload("page"), compress("page"),
  async (req, res, next) => {
    try {
      const result = await pageService.updatePage(req.body, req.processedFiles);
      res
        .status(200)
        .json(new ApiResponse("Page updated successfully!", result));
    } catch (error) {
      return next(error);
    }
  },
);

module.exports = router;
