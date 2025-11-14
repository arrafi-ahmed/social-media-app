const router = require("express").Router();
const ApiResponse = require("../model/ApiResponse");
const CustomError = require("../model/CustomError");
const { VUE_BASE_URL } = require("../others/util");
const authService = require("../service/auth");

router.post("/register", async (req, res, next) => {
  try {
    const result = await authService.register({ ...req.body, role: 20 }, VUE_BASE_URL);

    if (!result?.authData?.token) {
      throw new Error();
    }

    const responseData = {
      currentUser: result.authData.currentUser,
      welcomeEvent: result.welcomeEvent
    };

    if (result.newFriendsCount) {
      responseData.newFriendsCount = result.newFriendsCount;
    }

    res
      .status(201)
      .header("authorization", result.authData.token)
      .json(new ApiResponse("Registration successful!", responseData));
  } catch (error) {
    return next(error);
  }
});

router.post("/signin", async (req, res, next) => {
  try {
    const { token, currentUser } = await authService.signin(req.body);
    res
      .status(200)
      .header("authorization", token)
      .json(new ApiResponse("Sign in successful!", { currentUser }));
  } catch (error) {
    return next(error);
  }
});

router.get("/google", (req, res, next) => {
  try {
    const authUrl = authService.getGoogleAuthUrl({
      redirect: req.query?.redirect
    });
    return res.redirect(302, authUrl);
  } catch (error) {
    return next(error);
  }
});

router.get("/google/callback", async (req, res) => {
  try {
    const redirectUrl = await authService.handleGoogleCallback({
      code: req.query?.code,
      state: req.query?.state
    });
    return res.redirect(302, redirectUrl);
  } catch (error) {
    const fallback = authService.buildSocialErrorRedirect(req.query?.state, error);
    return res.redirect(302, fallback);
  }
});

router.get("/facebook", (req, res, next) => {
  try {
    const authUrl = authService.getFacebookAuthUrl({
      redirect: req.query?.redirect
    });
    return res.redirect(302, authUrl);
  } catch (error) {
    return next(error);
  }
});

router.get("/facebook/callback", async (req, res) => {
  try {
    const redirectUrl = await authService.handleFacebookCallback({
      code: req.query?.code,
      state: req.query?.state
    });
    return res.redirect(302, redirectUrl);
  } catch (error) {
    const fallback = authService.buildSocialErrorRedirect(req.query?.state, error);
    return res.redirect(302, fallback);
  }
});

router.post("/requestResetPass", async (req, res, next) => {
  try {
    const result = await authService.requestResetPass(
      req.body.resetEmail,
      VUE_BASE_URL
    );
    res
      .status(200)
      .json(new ApiResponse("Password reset link sent to your email!", result));
  } catch (error) {
    return next(error);
  }
});

router.post("/submitResetPass", async (req, res, next) => {
  try {
    const result = await authService.submitResetPass(req.body);
    res.status(200).json(new ApiResponse("Password reset successful!", result));
  } catch (error) {
    return next(error);
  }
});

module.exports = router;
