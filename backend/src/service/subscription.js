const db = require("../db");
const CustomError = require("../model/CustomError");
const stripeService = require("./stripe");
const stripe = require("stripe")(process.env.STRIPE_SECRET);

exports.getSubscription = (userId) => {
  const sql = `SELECT *
               FROM subscription
               WHERE user_id = $1`;
  return db.getRow(sql, [userId]);
};

exports.fetchPremiumSubscriptionData = async (userId) => {
  const subscription = await exports.getSubscription(userId);
  // check if no subscription, return null
  if (!subscription) {
    return null;
  }
  // check if basic subscription
  if (subscription && subscription.stripeSubscriptionId == 0) {
    return { subscription };
  }
  const stripeSubscription = await stripeService.getStripeSubscription(
    subscription.stripeSubscriptionId
  );
  return { subscription, stripeSubscription };
};

exports.getSubscriptionPlans = () => {
  const sql = `SELECT *
               FROM subscription_plan`;
  return db.getRows(sql);
};

// instantCancel = false
exports.cancelSubscription = async (stripeSubscriptionId) => {
  // if basic plan cancelled, delete the subscription entry from db
  if (stripeSubscriptionId === "0") {
    const sql = `DELETE
                 FROM subscription
                 WHERE stripe_subscription_id = $1`;
    const result = await db.execute(sql, [stripeSubscriptionId]);
    return result.rowCount > 0 ? "basic_deleted" : null;
  }
  const subscription = await stripeService.updateStripeSubscription(stripeSubscriptionId, {
    cancel_at_period_end: true,
    metadata: {
      instantCancel: false
    }
  });
  return subscription ? "premium_deleted" : null;
};

// instantCancel = true
exports.deleteSubscription = async (userId) => {
  const subscription = await exports.getSubscription(userId);
  // if basic plan cancelled, delete the subscription entry from db
  if (subscription.stripeSubscriptionId === "0") {
    const sql = `DELETE
                 FROM subscription
                 WHERE stripe_subscription_id = $1`;
    const result = await db.execute(sql, [subscription.stripeSubscriptionId]);
    return result.rowCount > 0 ? "basic_deleted" : null;
  }
  const deletedSubscription = await stripeService.cancelStripeSubscription(subscription.stripeSubscriptionId);

  return deletedSubscription ? "premium_deleted" : null;
};

exports.updateSubscription = (subscription, subscriptionId) => {
  const sql = `
    UPDATE subscription
    SET user_id                = $1,
        plan_id                = $2,
        stripe_subscription_id = $3,
        subscription_amount    = $4,
        activation_date        = $5,
        expire_date            = $6,
        active                 = $7,
        pending_cancel         = $8,
        created_at             = $9
    WHERE id = $10
    RETURNING *
  `;
  return db.getRow(sql, [...Object.values(subscription), subscriptionId]);
};

exports.insertSubscription = (subscription) => {
  const sql = `
    INSERT INTO subscription (user_id, plan_id, stripe_subscription_id, subscription_amount,
                              activation_date, expire_date, active, pending_cancel, created_at)
    VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9)
  `;
  const sqlWithReturning = sql + " RETURNING *";
  return db.getRow(sqlWithReturning, Object.values(subscription));
};

exports.upsertSubscription = async (newSubscription, userId) => {
  const foundSubscription = await exports.getSubscription(userId);

  return foundSubscription
    ? exports.updateSubscription(newSubscription, foundSubscription.id)
    : exports.insertSubscription(newSubscription);
};
exports.getPriceId = async (planTitle) => {
  const prices =
    planTitle.toLowerCase() === "standard"
      ? await stripe.prices.list({
        lookup_keys: ["standard_monthly"]
      })
      : (planTitle === "ultimate"
        ? await stripe.prices.list({
          lookup_keys: ["ultimate_yearly"]
        })
        : null);
  return prices && prices.data && prices.data[0] && prices.data[0].id;
};

exports.saveSubscriptionManually = async (planId, planTitle, userId) => {
  const existingSubscription = await exports.getSubscription(userId);
  if (existingSubscription && existingSubscription.pendingCancel === false) {
    throw new CustomError("Already have a subscription!", 409);
  }

  const priceId = await exports.getPriceId(planTitle.toLowerCase());
  const customer = await stripe.customers.create();

  const subscription = await stripe.subscriptions.create({
    customer: customer.id,
    items: [
      {
        price: priceId
      }
    ],
    trial_period_days: 730, // Set the trial period days
    payment_behavior: "default_incomplete", // Defer the first payment attempt

    trial_settings: {
      end_behavior: {
        missing_payment_method: "cancel" // Subscription will be canceled if no payment method is provided by the end of the trial
      }
    }
  });
  const expireDate = await exports.getStripeSubscriptionExpiryDate(
    subscription.id
  );
  const newSubscription = {
    userId,
    planId,
    stripeSubscriptionId: subscription.id,
    subscriptionAmount: 0,
    activationDate: new Date(),
    expireDate,
    active: true,
    pendingCancel: false,
    createdAt: new Date()
  };
  const insertedSubscription = await exports.upsertSubscription(
    newSubscription,
    userId
  );
  return { insertedSubscription };
};

exports.saveSubscription = async (planId, planTitle, userId) => {
  const existingSubscription = await exports.getSubscription(userId);
  if (existingSubscription && existingSubscription.pendingCancel === false) {
    throw new CustomError("Already have a subscription!", 409);
  }

  planTitle = planTitle.toLowerCase();
  if (planTitle === "basic") {
    const newSubscription = {
      userId,
      planId,
      stripeSubscriptionId: 0,
      subscriptionAmount: 0,
      activationDate: new Date(),
      expireDate: new Date(2034, 11, 30),
      active: true,
      pendingCancel: false,
      createdAt: new Date()
    };
    const insertedSubscription = await exports.upsertSubscription(
      newSubscription,
      userId
    );
    return {
      insertedSubscription,
      url: `${process.env.VUE_BASE_URL}/pricing?subscription_success=1` // to show notif in vue
    };
  }
  const priceId = await exports.getPriceId(planTitle.toLowerCase());

  const session = await stripe.checkout.sessions.create({
    billing_address_collection: "auto",
    line_items: [
      {
        price: priceId,
        quantity: 1
      }
    ],
    mode: "subscription",
    success_url: `${process.env.VUE_BASE_URL}/pricing?subscription_success=1&session_id={CHECKOUT_SESSION_ID}`,
    metadata: {
      planId,
      planTitle,
      userId
    }
  });

  return session;
};

exports.getStripeSubscriptionExpiryDate = async (subscriptionId) => {
  const stripeSubscription =
    await stripeService.getStripeSubscription(subscriptionId);
  return new Date(stripeSubscription.current_period_end * 1000);
};