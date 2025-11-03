const router = require("express").Router();
const stripeService = require("../service/stripe");
const ApiResponse = require("../model/ApiResponse");

// router.post("/createCheckout", async (req, res, next) => {
//     try {
//         const results = await stripeService.createCheckout({payload: req.body});
//         res.status(200).json(new ApiResponse({ payload: results }));
//     } catch (err) {
//         next(err);
//     }
// });
//
// router.post("/createStripeCheckoutIfNeeded", async (req, res, next) => {
//     try {
//         const results = await stripeService.createStripeCheckoutIfNeeded({payload: req.body});
//         res.status(200).json(new ApiResponse({ payload: results }));
//     } catch (err) {
//         next(err);
//     }
// });
//
// router.get("/sessionStatus", async (req, res, next) => {
//     try {
//         const result = await stripeService.sessionStatus({sessionId: req.query.sessionId});
//         res.status(200).json(new ApiResponse({ payload: result }));
//     } catch (err) {
//         next(err);
//     }
// });

const webhook = async (req, res, next) => {
    try {
        const result = await stripeService.webhook(req);
        res.status(200).json(new ApiResponse({ payload: result }));
    } catch (err) {
        next(err);
    }
};

module.exports = {router, webhook};
