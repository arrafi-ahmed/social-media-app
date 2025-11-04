const router = require("express").Router();
const { auth } = require("../middleware/auth");
const ApiResponse = require("../model/ApiResponse");
const categoryService = require("../service/category");

//check if admin
router.post("/save", auth, async (req, res, next) => {
  try {
    const result = await categoryService.saveCategory(req.body);
    res
      .status(200)
      .json(new ApiResponse("Category created successfully!", result));
  } catch (error) {
    return next(error);
  }
});

router.post("/edit", auth, async (req, res, next) => {
  try {
    const result = await categoryService.editCategory(req.body);
    res
      .status(200)
      .json(new ApiResponse("Category edited successfully!", result));
  } catch (error) {
    return next(error);
  }
});

router.get("/delete", auth, async (req, res, next) => {
  try {
    const result = await categoryService.deleteCategory(
      req.query?.id
    );

    if (!result) {
      throw new Error();
    }

    res
      .status(200)
      .json(new ApiResponse("Category deleted successfully!", result));
  } catch (error) {
    return next(error);
  }
});

router.get("/getCategories", auth, async (req, res, next) => {
  try {
    const result = await categoryService.getCategories();
    res.status(200).json(new ApiResponse(null, result));
  } catch (error) {
    return next(error);
  }
});

module.exports = router;
