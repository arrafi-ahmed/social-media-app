const jwt = require("jsonwebtoken");
const { ifAdmin, HTTP_STATUS } = require("../others/util");
const ApiResponse = require("../model/ApiResponse");

const auth = (req, res, next) => {
  const token = req.header("authorization");
  if (!token) return res.status(401).json(new ApiResponse("Access denied"));
  try {
    const { currentUser } = jwt.verify(token, process.env.TOKEN_SECRET);
    req.currentUser = currentUser;
    next();
  } catch (error) {
    if (error?.name === "TokenExpiredError") {
      return res.status(HTTP_STATUS.TOKEN_EXPIRED).json(new ApiResponse("Token expired, Please login again!"));
    }
    return res.status(401).json(new ApiResponse("Invalid token"));
  }
};

const isAdmin = (req, res, next) => {
  const currentUser = req.currentUser;
  if (!currentUser) return res.status(401).json(new ApiResponse("Invalid request"));
  try {
    if (ifAdmin(Number.parseInt(currentUser.role))) next();
  } catch (error) {
    return res.status(401).json(new ApiResponse("Invalid request"));
  }
};

const isAuthenticated = (req, res, next) => {
  try {
    const token = req.header("authorization");
    if (!token) throw new Error();
    const decoded = jwt.verify(token, process.env.TOKEN_SECRET);
    req.currentUser = decoded.currentUser;
    req.isLoggedIn = true;
  } catch (error) {
    req.isLoggedIn = false;
  } finally {
    next();
  }
};

module.exports = {
  auth,
  isAdmin,
  isAuthenticated
};