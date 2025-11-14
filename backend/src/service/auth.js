const jwt = require("jsonwebtoken");
const { v4: uuidv4 } = require("uuid");
const bcrypt = require("bcrypt");
const crypto = require("crypto");
const { OAuth2Client } = require("google-auth-library");
const fetch = require("node-fetch");
const db = require("../db");
const CustomError = require("../model/CustomError");
const eventService = require("./event");
const emailService = require("../email");
const userService = require("./user");
const { VUE_BASE_URL, customerRole } = require("../others/util");

const {
  GOOGLE_CLIENT_ID,
  GOOGLE_CLIENT_SECRET,
  GOOGLE_CALLBACK_URL,
  FACEBOOK_APP_ID,
  FACEBOOK_APP_SECRET,
  FACEBOOK_CALLBACK_URL,
  SOCIAL_LOGIN_REDIRECT_URL
} = process.env;

const SOCIAL_REDIRECT_URL =
  SOCIAL_LOGIN_REDIRECT_URL ||
  (VUE_BASE_URL ? `${VUE_BASE_URL}/auth/social-callback` : "http://localhost:4173/auth/social-callback");

exports.register = async (payload, clientUrl) => {
  const existingUser = await userService.getIdByEmail(payload.email);
  if (existingUser) {
    throw new CustomError("Email already taken!", 409);
  }

  // Hash password before creating user
  const hashedPassword = await bcrypt.hash(payload.password, 10);
  const insertedUser = await userService.createUser({ ...payload, password: hashedPassword, role: 20 });
  // insert into user settings
  await userService.createUserSettings(insertedUser.id);

  // Send welcome email (non-blocking - don't fail registration if email fails)
  emailService.sendWelcomeEmail(payload.email, {
    name: payload.fullName,
    id: insertedUser.id,
    vueBaseUrl: clientUrl
  }).catch((error) => {
    // Log email error but don't throw - registration should succeed even if email fails
    console.error("Failed to send welcome email:", error);
  });

  const admins = await userService.getAdmins();

  //add new user to all admins friend list
  const records = admins.map((admin) => ({
    userId1: admin.id,
    userId2: insertedUser.id
  }));
  await bulkInsertFriendships(records);

  // Generate authentication data
  const authData = generateAuthData(insertedUser);

  const onboardingData = await buildNewUserOnboardingPayload(insertedUser);
  if (!onboardingData.newFriendsCount) {
    return { authData, welcomeEvent: onboardingData.welcomeEvent };
  }

  return {
    authData,
    welcomeEvent: onboardingData.welcomeEvent,
    newFriendsCount: onboardingData.newFriendsCount
  };
};

exports.signin = async (payload) => {
  // First, get user by email to retrieve stored password (case insensitive)
  const sql = `
    SELECT u.id, u.full_name, u.image, u.email, u.password, u.role, u.slug, us.theme
    FROM users u
    LEFT JOIN user_settings us ON u.id = us.user_id
    WHERE LOWER(u.email) = LOWER($1)
  `;
  const result = await db.getRow(sql, [payload.email]);

  if (!result) {
    throw new CustomError("User not found!", 401);
  }

  // Compare provided password with hashed password
  const isPasswordValid = await bcrypt.compare(payload.password, result.password);

  if (!isPasswordValid) {
    throw new CustomError("Incorrect email/password!", 401);
  }

  return generateAuthData(result);
};

exports.requestResetPass = async (resetEmail, clientUrl) => {
  const result = await userService.getIdByEmail(resetEmail);
  if (!result) {
    throw new CustomError("User doesn't exist!");
  }

  const sql = `
    INSERT INTO password_reset (email, token, created_at) 
    VALUES ($1, $2, $3)
  `;
  const token = uuidv4();
  const values = [resetEmail, token, new Date()];

  const passwordResetRecord = await db.getRow(sql + " RETURNING *", values);

  return await emailService.sendPasswordResetEmail(resetEmail, {
    token: passwordResetRecord.token,
    vueBaseUrl: clientUrl
  });
};

exports.submitResetPass = async ({ token, newPass }) => {
  const sql = `SELECT * FROM password_reset WHERE token = $1`;
  const result = await db.getRow(sql, [token]);

  if (!result) {
    throw new CustomError("Invalid request!");
  }

  const createdAtMillis = result.createdAt.getTime();

  // Calculate the expiration time (expiration time 1 hour)
  const expirationMillis = createdAtMillis + 1 * 60 * 60 * 1000;
  const now = new Date();

  if (expirationMillis < now) {
    throw new CustomError("Password reset link expired!");
  }

  // Hash the new password before updating
  const hashedPassword = await bcrypt.hash(newPass, 10);
  const updateSql = `UPDATE users SET password = $1 WHERE LOWER(email) = LOWER($2)`;
  await db.execute(updateSql, [hashedPassword, result.email]);

  const deleteSql = `DELETE FROM password_reset WHERE token = $1`;
  return await db.execute(deleteSql, [token]);
};

exports.getGoogleAuthUrl = (options = {}) => {
  const client = createGoogleClient();
  if (!client) {
    throw new CustomError("Google login is not configured!", 503);
  }
  const statePayload = encodeStatePayload({
    redirect: sanitizeRedirectPath(options.redirect)
  });
  return client.generateAuthUrl({
    access_type: "offline",
    prompt: "consent",
    scope: ["openid", "email", "profile"],
    state: statePayload
  });
};

exports.handleGoogleCallback = async ({ code, state }) => {
  if (!code) {
    throw new CustomError("Missing authorization code", 400);
  }
  const client = createGoogleClient();
  if (!client) {
    throw new CustomError("Google login is not configured!", 503);
  }
  const statePayload = decodeStatePayload(state);

  const { tokens } = await client.getToken(code);
  client.setCredentials(tokens);
  const response = await client.request({
    url: "https://www.googleapis.com/oauth2/v2/userinfo"
  });
  const profile = response.data;
  const socialResult = await handleSocialLogin({
    provider: "google",
    providerUserId: profile.id,
    email: profile.email,
    fullName: profile.name || [profile.given_name, profile.family_name].filter(Boolean).join(" "),
    image: profile.picture
  });

  return buildSocialRedirect({
    token: socialResult.authData.token,
    currentUser: socialResult.authData.currentUser,
    redirect: statePayload.redirect,
    onboarding: socialResult.isNewUser
      ? {
        isNewUser: true,
        welcomeEvent: socialResult.welcomeEvent,
        newFriendsCount: socialResult.newFriendsCount
      }
      : undefined
  });
};

exports.getFacebookAuthUrl = (options = {}) => {
  validateFacebookConfig();
  const statePayload = encodeStatePayload({
    redirect: sanitizeRedirectPath(options.redirect)
  });
  const authUrl = new URL("https://www.facebook.com/v19.0/dialog/oauth");
  authUrl.searchParams.set("client_id", FACEBOOK_APP_ID);
  authUrl.searchParams.set("redirect_uri", FACEBOOK_CALLBACK_URL);
  authUrl.searchParams.set("state", statePayload);
  authUrl.searchParams.set("scope", "email,public_profile");
  authUrl.searchParams.set("response_type", "code");
  return authUrl.toString();
};

exports.handleFacebookCallback = async ({ code, state }) => {
  if (!code) {
    throw new CustomError("Missing authorization code", 400);
  }
  validateFacebookConfig();
  const statePayload = decodeStatePayload(state);

  const tokenResponse = await fetch(
    `https://graph.facebook.com/v19.0/oauth/access_token?client_id=${FACEBOOK_APP_ID}` +
      `&redirect_uri=${encodeURIComponent(FACEBOOK_CALLBACK_URL)}` +
      `&client_secret=${FACEBOOK_APP_SECRET}` +
      `&code=${encodeURIComponent(code)}`
  );
  const tokenJson = await tokenResponse.json();
  if (tokenJson.error) {
    throw new CustomError(tokenJson.error.message || "Facebook login failed!", 400);
  }

  const profileResponse = await fetch(
    `https://graph.facebook.com/me?fields=id,name,email,picture&access_token=${tokenJson.access_token}`
  );
  const profileJson = await profileResponse.json();
  if (profileJson.error) {
    throw new CustomError(profileJson.error.message || "Failed to fetch Facebook profile!", 400);
  }

  const socialResult = await handleSocialLogin({
    provider: "facebook",
    providerUserId: profileJson.id,
    email: profileJson.email,
    fullName: profileJson.name,
    image: profileJson.picture?.data?.url
  });

  return buildSocialRedirect({
    token: socialResult.authData.token,
    currentUser: socialResult.authData.currentUser,
    redirect: statePayload.redirect,
    onboarding: socialResult.isNewUser
      ? {
        isNewUser: true,
        welcomeEvent: socialResult.welcomeEvent,
        newFriendsCount: socialResult.newFriendsCount
      }
      : undefined
  });
};

exports.buildSocialErrorRedirect = (state, error) => {
  const statePayload = decodeStatePayload(state);
  const message = error instanceof CustomError
    ? error.message
    : "Unable to complete social login!";
  return buildSocialRedirect({
    redirect: statePayload.redirect,
    error: message
  });
};

function generateAuthData(result) {
  let token = "";
  let currentUser = {};
  if (result) {
    currentUser = {
      id: result.id,
      role: result.role,
      fullName: result.fullName,
      image: result.image,
      slug: result.slug,
      theme: result.theme || "light"
    };
    token = jwt.sign({ currentUser }, process.env.TOKEN_SECRET);
  }
  return { token, currentUser };
}

function createGoogleClient() {
  if (!GOOGLE_CLIENT_ID || !GOOGLE_CLIENT_SECRET || !GOOGLE_CALLBACK_URL) {
    return null;
  }
  return new OAuth2Client(GOOGLE_CLIENT_ID, GOOGLE_CLIENT_SECRET, GOOGLE_CALLBACK_URL);
}

function validateFacebookConfig() {
  if (!FACEBOOK_APP_ID || !FACEBOOK_APP_SECRET || !FACEBOOK_CALLBACK_URL) {
    throw new CustomError("Facebook login is not configured!", 503);
  }
}

function encodeBase64Url(value) {
  return Buffer.from(value)
    .toString("base64")
    .replace(/\+/g, "-")
    .replace(/\//g, "_")
    .replace(/=+$/g, "");
}

function decodeBase64Url(value) {
  if (!value) return "";
  let base64 = value.replace(/-/g, "+").replace(/_/g, "/");
  while (base64.length % 4) {
    base64 += "=";
  }
  return Buffer.from(base64, "base64").toString("utf8");
}

function encodeStatePayload(payload = {}) {
  return encodeBase64Url(JSON.stringify(payload));
}

function decodeStatePayload(encoded) {
  if (!encoded) return {};
  try {
    return JSON.parse(decodeBase64Url(encoded));
  } catch (error) {
    return {};
  }
}

function sanitizeRedirectPath(redirect) {
  if (!redirect || typeof redirect !== "string") {
    return "";
  }
  if (!redirect.startsWith("/") || redirect.startsWith("//")) {
    return "";
  }
  return redirect;
}

function buildSocialRedirect({ token, currentUser, redirect, onboarding, error }) {
  const target = new URL(SOCIAL_REDIRECT_URL);
  const safeRedirect = sanitizeRedirectPath(redirect);
  if (safeRedirect) {
    target.searchParams.set("redirect", safeRedirect);
  }
  if (token) {
    target.searchParams.set("token", token);
  }
  if (currentUser) {
    target.searchParams.set("user", encodeBase64Url(JSON.stringify(currentUser)));
  }
  if (onboarding) {
    target.searchParams.set("onboarding", encodeBase64Url(JSON.stringify(onboarding)));
  }
  if (error) {
    target.searchParams.set("error", error);
  }
  return target.toString();
}

async function handleSocialLogin(profile) {
  const provider = (profile.provider || "").toLowerCase();
  if (!provider || !profile.providerUserId) {
    throw new CustomError("Invalid social profile received!", 400);
  }

  const socialIdentity = await userService.getSocialIdentity(
    provider,
    profile.providerUserId
  );
  let userRecord = null;
  let isNewUser = false;
  const email = profile.email ? profile.email.toLowerCase() : null;

  if (socialIdentity) {
    userRecord = await userService.getUserById(socialIdentity.userId);
  } else {
    if (email) {
      userRecord = await userService.getUserByEmail(email);
    }
    if (!userRecord) {
      if (!email) {
        throw new CustomError(
          `No email returned from ${provider}. Please grant email permission and try again.`,
          400
        );
      }
      const newUser = await userService.createUser({
        fullName: profile.fullName || deriveFullName(email),
        email,
        password: null,
        role: customerRole
      });
      await userService.createUserSettings(newUser.id);
      const admins = await userService.getAdmins();
      if (admins?.length) {
        const friendRecords = admins.map((admin) => ({
          userId1: admin.id,
          userId2: newUser.id
        }));
        await bulkInsertFriendships(friendRecords);
      }
      userRecord = newUser;
      isNewUser = true;
    }
    await userService.createOrUpdateSocialIdentity({
      userId: userRecord.id,
      provider,
      providerUserId: profile.providerUserId,
      email
    });
  }

  let onboardingData = null;
  if (isNewUser && userRecord) {
    onboardingData = await buildNewUserOnboardingPayload(userRecord);
  }

  const authData = generateAuthData(userRecord);
  return {
    authData,
    welcomeEvent: onboardingData?.welcomeEvent,
    newFriendsCount: onboardingData?.newFriendsCount,
    isNewUser
  };
}

async function buildNewUserOnboardingPayload(userRecord) {
  const welcomeEvent = await eventService.createWelcomeEvent(userRecord.id);
  let newFriendsCount;

  if (userRecord.email) {
    const pendingInvitations = await userService.getPendingInvitation(userRecord.email);
    if (pendingInvitations?.length) {
      const pendingInvitationIds = pendingInvitations.map((item) => item.id);
      const friendshipRecords = pendingInvitations.map((item) => ({
        userId1: userRecord.id,
        userId2: item.senderId
      }));

      await Promise.all([
        bulkInsertFriendships(friendshipRecords),
        bulkDeleteInvitations(pendingInvitationIds)
      ]);

      newFriendsCount = friendshipRecords.length;
    }
  }

  return {
    welcomeEvent,
    newFriendsCount
  };
}

function deriveFullName(email) {
  if (!email) {
    return "WayzAway member";
  }
  return email.split("@")[0] || "WayzAway member";
}

async function bulkInsertFriendships(records) {
  if (records.length === 0) {
    return;
  }

  const values = [];
  const placeholders = [];
  let paramIndex = 1;

  for (const record of records) {
    placeholders.push(`($${paramIndex++}, $${paramIndex++}, $${paramIndex++})`);
    values.push(record.userId1, record.userId2, new Date());
  }

  const query = `
    INSERT INTO friendship (user_id_1, user_id_2, created_at)
    VALUES ${placeholders.join(", ")}
  `;
  return await db.execute(query, values);
}

async function bulkDeleteInvitations(invitationIds) {
  if (invitationIds.length === 0) {
    return;
  }

  const inPlaceholders = invitationIds
    .map((_, index) => `$${index + 1}`)
    .join(", ");
  const queryText = `
    DELETE FROM invitation 
    WHERE id IN (${inPlaceholders})
  `;
  return await db.execute(queryText, invitationIds);
}

/**
 * Verifies Facebook's signed request
 * @param {string} signedRequest - The signed_request parameter from Facebook
 * @returns {object|null} - Decoded payload if valid, null otherwise
 */
function verifyFacebookSignedRequest(signedRequest) {
  if (!signedRequest || !FACEBOOK_APP_SECRET) {
    return null;
  }

  try {
    const parts = signedRequest.split(".");
    if (parts.length !== 2) {
      return null;
    }

    const [signature, payload] = parts;

    // Decode the payload
    const decodedPayload = decodeBase64Url(payload);
    const payloadData = JSON.parse(decodedPayload);

    // Verify the signature
    const expectedSignature = crypto
      .createHmac("sha256", FACEBOOK_APP_SECRET)
      .update(payload)
      .digest("base64")
      .replace(/\+/g, "-")
      .replace(/\//g, "_")
      .replace(/=+$/, "");

    if (signature !== expectedSignature) {
      return null;
    }

    return payloadData;
  } catch (error) {
    console.error("Error verifying Facebook signed request:", error);
    return null;
  }
}

/**
 * Handles Facebook data deletion callback
 * @param {string} signedRequest - The signed_request parameter from Facebook
 * @returns {object} - Response with confirmation_code and url
 */
exports.handleFacebookDataDeletion = async (signedRequest) => {
  validateFacebookConfig();

  // Verify the signed request
  const payload = verifyFacebookSignedRequest(signedRequest);
  if (!payload || !payload.user_id) {
    throw new CustomError("Invalid signed request", 400);
  }

  const facebookUserId = payload.user_id;

  // Find the user by Facebook provider_user_id
  const socialIdentity = await userService.getSocialIdentity(
    "facebook",
    facebookUserId
  );

  if (!socialIdentity) {
    // User not found, but we still need to return a valid response
    // Generate a confirmation code for tracking
    const confirmationCode = uuidv4().replace(/-/g, "").substring(0, 10);
    return {
      url: `${VUE_BASE_URL || "http://localhost:3000"}/user-deletion-status/${confirmationCode}`,
      confirmation_code: confirmationCode
    };
  }

  const userId = socialIdentity.userId;

  // Delete the user and all associated data
  try {
    // Get user image before deletion
    const user = await userService.getUserById(userId);
    const userImage = user?.image || null;

    // Delete the user (this will cascade delete related data)
    await userService.deleteUser(userId, userImage);

    // Generate confirmation code
    const confirmationCode = uuidv4().replace(/-/g, "").substring(0, 10);

    return {
      url: `${VUE_BASE_URL || "http://localhost:3000"}/user-deletion-status/${confirmationCode}`,
      confirmation_code: confirmationCode
    };
  } catch (error) {
    console.error("Error deleting Facebook user:", error);
    // Still return a response even if deletion fails
    // Facebook expects a response, and we can handle the error internally
    const confirmationCode = uuidv4().replace(/-/g, "").substring(0, 10);
    return {
      url: `${VUE_BASE_URL || "http://localhost:3000"}/user-deletion-status/${confirmationCode}`,
      confirmation_code: confirmationCode
    };
  }
};
