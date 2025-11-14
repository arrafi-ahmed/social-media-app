const router = require("express").Router();
const express = require("express");
const { v4: uuidv4 } = require("uuid");
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

// Facebook Data Deletion Callback
// This endpoint is called by Facebook when a user requests data deletion
// It must be publicly accessible (no auth middleware)
// Facebook sends a POST request with signed_request parameter
// Facebook typically sends as form-encoded data, but we handle both JSON and form data
router.post("/facebook/user-delete", express.urlencoded({ extended: true }), async (req, res, next) => {
  try {
    // Facebook can send signed_request in body (JSON or form-encoded)
    // Try multiple possible field names
    const signedRequest = req.body?.signed_request 
      || req.body?.signedRequest 
      || req.body?.['signed_request'];
    
    if (!signedRequest) {
      return res.status(400).json({
        error: "Missing signed_request parameter"
      });
    }

    const result = await authService.handleFacebookDataDeletion(signedRequest);
    
    // Facebook expects a plain JSON response (not wrapped in ApiResponse)
    res.status(200).json(result);
  } catch (error) {
    console.error("Facebook data deletion error:", error);
    // Even on error, return a valid response format for Facebook
    // Facebook requires a response, so we always return 200 with a confirmation code
    const confirmationCode = uuidv4().replace(/-/g, "").substring(0, 10);
    res.status(200).json({
      url: `${VUE_BASE_URL || "http://localhost:4173"}/user-deletion-status/${confirmationCode}`,
      confirmation_code: confirmationCode
    });
  }
});

module.exports = router;
