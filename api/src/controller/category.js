const router = require("express").Router();
const ApiResponse = require("../model/ApiResponse");
const auth = require("../middleware/auth");
const categoryService = require("../service/category");

//check if admin
router.post("/save", auth, (req, res) => {
  categoryService
    .saveCategory(req.body)
    .then((result) => {
      res
        .status(200)
        .json(new ApiResponse("Category created successfully!", result));
    })
    .catch((err) => {
      res.status(500).json(new ApiResponse("Category creation failed!", null));
    });
});

router.post("/edit", auth, (req, res) => {
  categoryService
    .editCategory(req.body)
    .then((result) => {
      res
        .status(200)
        .json(new ApiResponse("Category edited successfully!", result));
    })
    .catch((err) => {
      res.status(500).json(new ApiResponse("Category editing failed!", null));
    });
});

router.get("/delete", auth, (req, res) => {
  categoryService
    .deleteCategory(req.query && req.query.id)
    .then((result) => {
      if (result) {
        res
          .status(200)
          .json(new ApiResponse("Category deleted successfully!", result));
      } else {
        throw new Error();
      }
    })
    .catch((err) => {
      res.status(500).json(new ApiResponse("Category deleting failed!", null));
    });
});

router.get("/getCategories", auth, (req, res) => {
  categoryService
    .getCategories()
    .then((result) => {
      res.status(200).json(new ApiResponse(null, result));
    })
    .catch((err) => {
      res.status(500).json(new ApiResponse("Categories loading failed!", null));
    });
});

module.exports = router;
