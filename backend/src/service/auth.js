const jwt = require("jsonwebtoken");
const { v4: uuidv4 } = require("uuid");
const bcrypt = require("bcrypt");
const db = require("../db");
const CustomError = require("../model/CustomError");
const eventService = require("./event");
const emailService = require("../email");
const userService = require("./user");

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

  // Create welcome event for the new user
  const welcomeEvent = await eventService.createWelcomeEvent(insertedUser.id);

  // Get pending invitations for the registered user
  const pendingInvitations = await userService.getPendingInvitation(
    insertedUser.email
  );

  // if no invitation return only registered data
  if (pendingInvitations?.length === 0) {
    return { authData, welcomeEvent };
  }
  // if pending invitation
  else {
    const pendingInvitationIds = pendingInvitations.map((item) => item.id);

    // Prepare friendship records for bulk insertion
    const friendshipRecords = pendingInvitations.map((item) => ({
      userId1: insertedUser.id,
      userId2: item.senderId
    }));

    await Promise.all([
      bulkInsertFriendships(friendshipRecords),
      bulkDeleteInvitations(pendingInvitationIds)
    ]);
    return {
      newFriendsCount: friendshipRecords.length,
      authData,
      welcomeEvent
    };
  }
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
