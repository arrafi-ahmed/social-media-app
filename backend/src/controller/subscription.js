const router = require("express").Router();
const { raw } = require("express");
const {auth} = require("../middleware/auth");
const ApiResponse = require("../model/ApiResponse");
const CustomError = require("../model/CustomError");
const subscriptionService = require("../service/subscription");
const stripeService = require("../service/stripe");
const { ifAdmin } = require("../others/util");

router.get("/getStripeSubscription", auth, async (req, res, next) => {
  try {
    const subscriptionId = req.query?.subscriptionId;
    const result =
      await stripeService.getStripeSubscription(subscriptionId);
    res.status(200).json(new ApiResponse(null, result));
  } catch (error) {
    return next(error);
  }
});

router.get("/getSubscription", async (req, res, next) => {
  try {
    const userId = req.query?.userId;
    const result = await subscriptionService.getSubscription(userId);
    res.status(200).json(new ApiResponse(null, result));
  } catch (error) {
    return next(error);
  }
});

router.get("/fetchPremiumSubscriptionData", auth, async (req, res, next) => {
  try {
    let userId = (req.query?.userId) || req.currentUser.id;
    if (!ifAdmin(req.currentUser.role)) {
      //if user role fetching data, verify query->userid == token->userid
      userId = req.currentUser.id;
    }
    const result =
      await subscriptionService.fetchPremiumSubscriptionData(userId);
    res.status(200).json(new ApiResponse(null, result));
  } catch (error) {
    return next(error);
  }
});

router.get("/getSubscriptionPlans", async (req, res, next) => {
  try {
    const result = await subscriptionService.getSubscriptionPlans();
    res.status(200).json(new ApiResponse(null, result));
  } catch (error) {
    return next(error);
  }
});

router.get("/saveSubscription", auth, async (req, res, next) => {
  try {
    const planId = req.query?.planId;
    const planTitle = req.query?.planTitle;
    const result = await subscriptionService.saveSubscription(
      planId,
      planTitle,
      req.currentUser.id,
    );
    res.status(200).json(new ApiResponse(null, result));
  } catch (error) {
    return next(error);
  }
});

router.get("/saveSubscriptionManually", auth, async (req, res, next) => {
  try {
    const planId = req.query?.planId;
    const planTitle = req.query?.planTitle;
    const userId = req.query?.userId;
    const result = await subscriptionService.saveSubscriptionManually(
      planId,
      planTitle,
      userId,
    );
    res.status(200).json(new ApiResponse("Subscription added!", result));
  } catch (error) {
    return next(error);
  }
});

router.get("/cancelSubscription", auth, async (req, res, next) => {
  try {
    const stripeSubscriptionId = req.query?.stripeSubscriptionId;
    const result =
      await subscriptionService.cancelSubscription(stripeSubscriptionId);
      
    res.status(200).json(new ApiResponse("Subscription cancelled!", result));
  } catch (error) {
    return next(error);
  }
});

router.get("/deleteSubscription", auth, async (req, res, next) => {
  try {
    const userId = req.query?.userId;
    const result = await subscriptionService.deleteSubscription(userId);
    res.status(200).json(new ApiResponse("Subscription deleted!", result));
  } catch (error) {
    return next(error);
  }
});

module.exports = router;
