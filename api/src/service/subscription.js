const db = require("../db");
const CustomError = require("../model/CustomError");
const stripe = require("stripe")(process.env.STRIPE_SECRET);

exports.getSubscription = (userId) => {
  const sql = "select * from subscription where user_id = ?";
  return db.getRow(sql, [userId]);
};

exports.getStripeSubscription = (subscriptionId) => {
  return stripe.subscriptions.retrieve(subscriptionId);
};

exports.fetchPremiumSubscriptionData = async (userId) => {
  const subscription = await exports.getSubscription(userId);
  // check if no subscription, return null
  if (!subscription) {
    return null;
  }
  // check if basic subscription
  if (subscription && subscription.stripe_subscription_id == 0) {
    return { subscription };
  }
  const stripeSubscription = await exports.getStripeSubscription(
    subscription.stripe_subscription_id
  );
  return { subscription, stripeSubscription };
};

exports.getSubscriptionPlans = () => {
  const sql = "select * from subscription_plan";
  return db.getRows(sql);
};

// instantCancel = false
exports.cancelSubscription = async (stripeSubscriptionId) => {
  // if basic plan cancelled, delete the subscription entry from db
  if (stripeSubscriptionId === "0") {
    const sql = "delete from subscription where stripe_subscription_id = ?";
    let result = await db.execute(sql, [stripeSubscriptionId]);
    return result.affectedRows > 0 ? "basic_deleted" : null;
  }
  const subscription = await stripe.subscriptions.update(stripeSubscriptionId, {
    cancel_at_period_end: true,
    metadata: {
      instantCancel: false,
    },
  });
  return subscription ? "premium_deleted" : null;
};

// instantCancel = true
exports.deleteSubscription = async (userId) => {
  const subscription = await exports.getSubscription(userId);
  // if basic plan cancelled, delete the subscription entry from db
  if (subscription.stripe_subscription_id === "0") {
    const sql = "delete from subscription where stripe_subscription_id = ?";
    let result = await db.execute(sql, [subscription.stripe_subscription_id]);
    return result.affectedRows > 0 ? "basic_deleted" : null;
  }
  const deletedSubscription = await stripe.subscriptions.cancel(
    subscription.stripe_subscription_id
  );
  return deletedSubscription ? "premium_deleted" : null;
};

exports.updateSubscription = (subscription, subscriptionId) => {
  const sql = `
        UPDATE subscription
        SET user_id                = ?,
            plan_id                = ?,
            stripe_subscription_id = ?,
            subscription_amount    = ?,
            activation_date        = ?,
            expire_date            = ?,
            active                 = ?,
            pending_cancel         = ?,
            created_at             = ?
        WHERE id = ?;`;
  return db
    .execute(sql, [...Object.values(subscription), subscriptionId])
    .then(() => {
      return { ...subscription, id: subscriptionId };
    });
};

exports.insertSubscription = (subscription) => {
  const sql = `insert into subscription (user_id, plan_id, stripe_subscription_id, subscription_amount,
                                           activation_date, expire_date, active, pending_cancel, created_at)
                 values (?, ?, ?, ?, ?, ?, ?, ?, ?);`;
  return db.execute(sql, Object.values(subscription)).then((result) => {
    const sql2 = "SELECT * FROM subscription WHERE id = ?;";
    return db.getRow(sql2, [result.insertId]).then((result) => {
      return result;
    });
  });
};

exports.upsertSubscription = async (newSubscription, userId) => {
  const foundSubscription = await exports.getSubscription(userId);

  if (foundSubscription) {
    return exports.updateSubscription(newSubscription, foundSubscription.id);
  } else {
    return exports.insertSubscription(newSubscription);
  }
};
exports.getPriceId = async (planTitle) => {
  const prices =
    planTitle.toLowerCase() === "standard"
      ? await stripe.prices.list({
          lookup_keys: ["standard_monthly"],
        })
      : planTitle === "ultimate"
      ? await stripe.prices.list({
          lookup_keys: ["ultimate_yearly"],
        })
      : null;
  return prices && prices.data && prices.data[0] && prices.data[0].id;
};

exports.saveSubscriptionManually = async (planId, planTitle, userId) => {
  const existingSubscription = await exports.getSubscription(userId);
  if (existingSubscription && existingSubscription.pending_cancel === 0)
    throw new CustomError("Already have a subscription!", 409);

  let priceId = await exports.getPriceId(planTitle.toLowerCase());
  const customer = await stripe.customers.create();

  const subscription = await stripe.subscriptions.create({
    customer: customer.id,
    items: [
      {
        price: priceId,
      },
    ],
    trial_period_days: 730, // Set the trial period days
    payment_behavior: "default_incomplete", // Defer the first payment attempt

    trial_settings: {
      end_behavior: {
        missing_payment_method: "cancel", // Subscription will be canceled if no payment method is provided by the end of the trial
      },
    },
  });
  const expireDate = await exports.getStripeSubscriptionExpiryDate(
    subscription.id
  );
  const newSubscription = {
    user_id: userId,
    plan_id: planId,
    stripe_subscription_id: subscription.id,
    subscription_amount: 0,
    activation_date: new Date(),
    expire_date: expireDate,
    active: 1,
    pending_cancel: 0,
    created_at: new Date(),
  };
  const insertedSubscription = await exports.upsertSubscription(
    newSubscription,
    userId
  );
  return { insertedSubscription };
};

exports.saveSubscription = async (planId, planTitle, userId) => {
  const existingSubscription = await exports.getSubscription(userId);
  if (existingSubscription && existingSubscription.pending_cancel === 0)
    throw new CustomError("Already have a subscription!", 409);

  planTitle = planTitle.toLowerCase();
  if (planTitle === "basic") {
    const newSubscription = {
      user_id: userId,
      plan_id: planId,
      stripe_subscription_id: 0,
      subscription_amount: 0,
      activation_date: new Date(),
      expire_date: new Date(2034, 11, 30),
      active: 1,
      pending_cancel: 0,
      created_at: new Date(),
    };
    const insertedSubscription = await exports.upsertSubscription(
      newSubscription,
      userId
    );
    return {
      insertedSubscription,
      url: `${process.env.VUE_BASE_URL}/pricing?subscription_success=1`, // to show notif in vue
    };
  }
  let priceId = await exports.getPriceId(planTitle.toLowerCase());

  const session = await stripe.checkout.sessions.create({
    billing_address_collection: "auto",
    line_items: [
      {
        price: priceId,
        quantity: 1,
      },
    ],
    mode: "subscription",
    success_url: `${process.env.VUE_BASE_URL}/pricing?subscription_success=1&session_id={CHECKOUT_SESSION_ID}`,
    metadata: {
      planId,
      planTitle,
      userId,
    },
  });

  return session;
};

exports.getStripeSubscriptionExpiryDate = async (subscriptionId) => {
  const stripeSubscription = await exports.getStripeSubscription(
    subscriptionId
  );
  return new Date(stripeSubscription.current_period_end * 1000);
};

exports.stripeWebhookResponse = async (req) => {
  let data;
  let eventType;
  // Check if webhook signing is configured.
  const webhookSecret = process.env.STRIPE_WEBHOOK_SECRET;
  if (webhookSecret) {
    // Retrieve the event by verifying the signature using the raw body and secret.
    let event;
    let signature = req.headers["stripe-signature"];

    try {
      event = stripe.webhooks.constructEvent(
        req.body,
        signature,
        webhookSecret
      );
    } catch (err) {
      throw new CustomError(err.message, 400, err);
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
    case "checkout.session.completed":
      const checkoutSessionCompleted = data.object;

      // get subscription expire date
      const expireDate = await exports.getStripeSubscriptionExpiryDate(
        checkoutSessionCompleted.subscription
      );
      const newSubscription = {
        user_id: checkoutSessionCompleted.metadata.userId,
        plan_id: checkoutSessionCompleted.metadata.planId,
        stripe_subscription_id: checkoutSessionCompleted.subscription,
        subscription_amount: checkoutSessionCompleted.amount_total / 100,
        activation_date: new Date(checkoutSessionCompleted.created * 1000),
        expire_date: expireDate,
        active: 1,
        pending_cancel: 0,
        created_at: new Date(),
      };

      await exports.upsertSubscription(
        newSubscription,
        checkoutSessionCompleted.metadata.userId
      );

      responseMsg = "Subscription activated!";
      break;

    // fired immediately when customer cancel subscription
    case "customer.subscription.updated":
      const customerSubscriptionUpdated = data.object;
      // Then define and call a function to handle the event customer.subscription.deleted
      const instantCancel = customerSubscriptionUpdated.metadata.instantCancel;
      if (instantCancel === "false") {
        const sql =
          "update subscription set pending_cancel = 1 where stripe_subscription_id = ?";
        await db.execute(sql, [customerSubscriptionUpdated.id]);
      }
      responseMsg = !instantCancel
        ? "Subscription will expire on end of billing period!"
        : "Subscription expired!";
      break;

    // fired at end of period when subscription expired
    case "customer.subscription.deleted":
      const customerSubscriptionDeleted = data.object;
      // Then define and call a function to handle the event customer.subscription.deleted
      const sql2 = "delete from subscription where stripe_subscription_id = ?";
      await db.execute(sql2, [customerSubscriptionDeleted.id]);

      responseMsg = "Subscription deleted!";
      break;

    // subscription auto renewal succeeded
    case "invoice.paid":
      const invoicePaid = data.object;
      // Then define and call a function to handle the event invoice.paid
      if (invoicePaid.object === "invoice" && invoicePaid.status === "paid") {
        const sql3 = `
                    UPDATE subscription
                    SET subscription_amount = ?,
                        activation_date     = ?,
                        expire_date         = ?,
                        active              = 1,
                        pending_cancel      = 0
                    WHERE stripe_subscription_id = ?
                `;
        const subscriptionAmount = invoicePaid.amount_paid / 100;
        const activationDate = new Date(invoicePaid.created);
        const expireDate = await exports.getStripeSubscriptionExpiryDate(
          invoicePaid.subscription
        );
        await db.execute(sql3, [
          subscriptionAmount,
          activationDate,
          expireDate,
          invoicePaid.subscription,
        ]);
        responseMsg = "Subscription paid!";
      }
      break;

    // subscription auto renewal failed
    case "invoice.payment_failed":
      const invoicePaymentFailed = data.object;
      // Then define and call a function to handle the event invoice.payment_failed
      const sql4 = `
                UPDATE subscription
                SET active = 0
                WHERE stripe_subscription_id = ?
            `;
      await db.execute(sql4, [invoicePaymentFailed.subscription]);

      responseMsg = "Subscription payment failed!";
      break;

    // ... handle other event types
    default:
      console.error(`Unhandled event type ${eventType}`);
  }

  return responseMsg;
};
