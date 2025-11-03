const { VUE_BASE_URL, STRIPE_SECRET } = process.env;
const stripe = require("stripe")(STRIPE_SECRET);
const CustomError = require("../model/CustomError");
const db = require("../db");
const subscriptionService = require("./subscription");

exports.getStripeSubscription = (subscriptionId) => {
  return stripe.subscriptions.retrieve(subscriptionId);
};

exports.updateStripeSubscription = (stripeSubscriptionId, payload) => {
  return stripe.subscriptions.update(stripeSubscriptionId, payload);
};

exports.cancelStripeSubscription = (stripeSubscriptionId) => {
  return stripe.subscriptions.cancel(
    stripeSubscriptionId
  );
};

exports.webhook = async (req) => {
  let data;
  let eventType;
  // Check if webhook signing is configured.
  const webhookSecret = process.env.STRIPE_WEBHOOK_SECRET;
  if (webhookSecret) {
    // Retrieve the event by verifying the signature using the raw body and secret.
    let event;
    const signature = req.headers["stripe-signature"];

    try {
      event = stripe.webhooks.constructEvent(
        req.body,
        signature,
        webhookSecret
      );
    } catch (error) {
      throw new CustomError(error.message, 400, error);
    }
    // Extract the object from the event.
    data = event.data;
    eventType = event.type;
  } else {
    // Webhook signing is recommended, but if the secret is not configured in `config.js`,
    // retrieve the event data directly from the request body.
    data = req.body.data;
    eventType = req.body.type;
  }

  let responseMsg = "";
  switch (eventType) {
    // subscription created successfully
    case "checkout.session.completed": {
      const checkoutSessionCompleted = data.object;

      // get subscription expire date
      const expireDate = await subscriptionService.getStripeSubscriptionExpiryDate(
        checkoutSessionCompleted.subscription
      );
      const newSubscription = {
        userId: checkoutSessionCompleted.metadata.userId,
        planId: checkoutSessionCompleted.metadata.planId,
        stripeSubscriptionId: checkoutSessionCompleted.subscription,
        subscriptionAmount: checkoutSessionCompleted.amountTotal / 100,
        activationDate: new Date(checkoutSessionCompleted.created * 1000),
        expireDate,
        active: true,
        pendingCancel: false,
        createdAt: new Date()
      };

      await subscriptionService.upsertSubscription(
        newSubscription,
        checkoutSessionCompleted.metadata.userId
      );

      responseMsg = "Subscription activated!";
      break;
    }

    // fired immediately when customer cancel subscription
    case "customer.subscription.updated": {
      const customerSubscriptionUpdated = data.object;
      // Then define and call a function to handle the event customer.subscription.deleted
      const instantCancel = customerSubscriptionUpdated.metadata.instantCancel;
      if (instantCancel === "false") {
        const sql = `
          UPDATE subscription
          SET pending_cancel = true
          WHERE stripe_subscription_id = $1
        `;
        await db.execute(sql, [customerSubscriptionUpdated.id]);
      }
      responseMsg = instantCancel
        ? "Subscription expired!"
        : "Subscription will expire on end of billing period!";
      break;
    }

    // fired when subscription is deleted (instant cancel or period end)
    case "customer.subscription.deleted": {
      const customerSubscriptionDeleted = data.object;
      // Then define and call a function to handle the event customer.subscription.deleted
      const sql2 = `DELETE
                    FROM subscription
                    WHERE stripe_subscription_id = $1`;
      await db.execute(sql2, [customerSubscriptionDeleted.id]);

      responseMsg = "Subscription deleted!";
      break;
    }

    // subscription auto renewal succeeded
    case "invoice.paid": {
      const invoicePaid = data.object;
      // Then define and call a function to handle the event invoice.paid
      if (invoicePaid.object === "invoice" && invoicePaid.status === "paid") {
        const sql3 = `
          UPDATE subscription
          SET subscription_amount = $1,
              activation_date     = $2,
              expire_date         = $3,
              active              = true,
              pending_cancel      = false
          WHERE stripe_subscription_id = $4
        `;
        const subscriptionAmount = invoicePaid.amountPaid / 100;
        const activationDate = new Date(invoicePaid.created);
        const expireDate = await subscriptionService.getStripeSubscriptionExpiryDate(
          invoicePaid.subscription
        );
        await db.execute(sql3, [
          subscriptionAmount,
          activationDate,
          expireDate,
          invoicePaid.subscription
        ]);
        responseMsg = "Subscription paid!";
      }
      break;
    }

    // subscription auto renewal failed
    case "invoice.paymentFailed": {
      const invoicePaymentFailed = data.object;
      // Then define and call a function to handle the event invoice.payment_failed
      const sql4 = `
        UPDATE subscription
        SET active = false
        WHERE stripe_subscription_id = $1
      `;
      await db.execute(sql4, [invoicePaymentFailed.subscription]);

      responseMsg = "Subscription payment failed!";
      break;
    }

    // ... handle other event types
    default: {
      console.error(`Unhandled event type ${eventType}`);
    }
  }

  return responseMsg;
};
