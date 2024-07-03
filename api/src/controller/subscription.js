const router = require("express").Router();
const { raw } = require("express");
const ApiResponse = require("../model/ApiResponse");
const auth = require("../middleware/auth");
const subscriptionService = require("../service/subscription");
const CustomError = require("../model/CustomError");

router.get("/getStripeSubscription", auth, (req, res) => {
  const subscriptionId = req.query && req.query.subscriptionId;
  subscriptionService
    .getStripeSubscription(subscriptionId)
    .then((result) => {
      res.status(200).json(new ApiResponse(null, result));
    })
    .catch((err) => {
      res
        .status(500)
        .json(new ApiResponse("Stripe subscription loading failed!", null));
    });
});

router.get("/getSubscription", (req, res) => {
  const userId = req.query && req.query.userId;
  subscriptionService
    .getSubscription(userId)
    .then((result) => {
      res.status(200).json(new ApiResponse(null, result));
    })
    .catch((err) => {
      res
        .status(500)
        .json(new ApiResponse("Subscription loading failed!", null));
    });
});

router.get("/fetchPremiumSubscriptionData", auth, (req, res) => {
  let userId = (req.query && req.query.userId) || req.currentUser.id;
  if (req.currentUser.role !== "admin") {
    //if user role fetching data, verify query->userid == token->userid
    userId = req.currentUser.id;
  }
  subscriptionService
    .fetchPremiumSubscriptionData(userId)
    .then((result) => {
      res.status(200).json(new ApiResponse(null, result));
    })
    .catch((err) => {
      res
        .status(500)
        .json(new ApiResponse("Subscription data loading failed!", null));
    });
});

router.get("/getSubscriptionPlans", (req, res) => {
  subscriptionService
    .getSubscriptionPlans()
    .then((result) => {
      res.status(200).json(new ApiResponse(null, result));
    })
    .catch((err) => {
      res
        .status(500)
        .json(new ApiResponse("Subscription plans loading failed!", null));
    });
});

router.get("/saveSubscription", auth, (req, res) => {
  const planId = req.query && req.query.planId;
  const planTitle = req.query && req.query.planTitle;
  subscriptionService
    .saveSubscription(planId, planTitle, req.currentUser.id)
    .then((result) => {
      res.status(200).json(new ApiResponse(null, result));
    })
    .catch((err) => {
      if (err instanceof CustomError) {
        res.status(err.statusCode).json(new ApiResponse(err.message, null));
      } else {
        res
          .status(500)
          .json(new ApiResponse("Subscription activation failed!", null));
      }
    });
});

router.get("/saveSubscriptionManually", auth, (req, res) => {
  const planId = req.query && req.query.planId;
  const planTitle = req.query && req.query.planTitle;
  const userId = req.query && req.query.userId;
  subscriptionService
    .saveSubscriptionManually(planId, planTitle, userId)
    .then((result) => {
      res.status(200).json(new ApiResponse("Subscription added!", result));
    })
    .catch((err) => {
      res
        .status(500)
        .json(new ApiResponse("Subscription activation failed!", null));
    });
});

router.get("/cancelSubscription", auth, (req, res) => {
  const stripeSubscriptionId = req.query && req.query.stripeSubscriptionId;
  subscriptionService
    .cancelSubscription(stripeSubscriptionId)
    .then((result) => {
      res.status(200).json(new ApiResponse("Subscription cancelled!", result));
    })
    .catch((err) => {
      res
        .status(500)
        .json(new ApiResponse("Subscription cancelling failed!", null));
    });
});

router.get("/deleteSubscription", auth, (req, res) => {
  const userId = req.query && req.query.userId;
  subscriptionService
    .deleteSubscription(userId)
    .then((result) => {
      res.status(200).json(new ApiResponse("Subscription deleted!", result));
    })
    .catch((err) => {
      res
        .status(500)
        .json(new ApiResponse("Subscription deleting failed!", null));
    });
});

router.post("/stripe-response", async (req, res) => {
  subscriptionService
    .stripeWebhookResponse(req)
    .then((result) => {
      res.status(200).json(new ApiResponse(result, null));
    })
    .catch((err) => {
      if (err instanceof CustomError) {
        res.status(err.statusCode).json(new ApiResponse(err.message, null));
      } else {
        res.status(500).json(new ApiResponse("Stripe action failed!", null));
      }
    });
});

module.exports = router;
