const { v4: uuidv4 } = require("uuid");
const bcrypt = require("bcrypt");
const db = require("../db");
const CustomError = require("../model/CustomError");
const {
  removeImages,
  adminRole,
  generateSlug
} = require("../others/util");
const emailService = require("../email");

// Helper to generate random string for slug uniqueness
function generateRandomString(length = 6) {
  return uuidv4().replace(/-/g, "").slice(0, length);
}

// Creates a new user and returns the inserted user row
exports.createUser = async (payload) => {
  // Generate a unique slug from the user's full name
  let baseSlug = generateSlug(payload.fullName);
  let slug = baseSlug;
  let counter = 1;
  let isSlugUnique = false;

  // If slug is empty or only numbers, use a fallback
  if (!slug || /^\d+$/.test(slug)) {
    slug = `user${counter}`;
  }

  // Check if slug already exists and make it unique
  while (!isSlugUnique) {
    const existingUser = await getIdBySlug(slug);
    if (!existingUser) {
      isSlugUnique = true;
    } else {
      // Combine base slug with random characters for uniqueness
      if (counter === 1 && baseSlug) {
        slug = `${baseSlug}${generateRandomString(6)}`;
      } else {
        slug = `${baseSlug || "user"}${generateRandomString(6)}`;
      }
      counter++;
      // Fallback if slug still conflicts after many attempts
      if (counter > 100) {
        slug = `user${Date.now()}`;
        isSlugUnique = true;
      }
    }
  }

  const sql = `
    INSERT INTO users (full_name, email, password, date_of_birth, country, role, slug, created_at) 
    VALUES ($1, $2, $3, $4, $5, $6, $7, $8)
    RETURNING *
  `;

  return await db.getRow(sql, [
    payload.fullName,
    payload.email,
    payload.password,
    null, // new Date(payload.dateOfBirth).toISOString().slice(0, 10),
    null, // payload.country,
    payload.role,
    slug,
    new Date()
  ]);
};

exports.addAllUsersToAdminFriendlist = async (adminId) => {
  const users = await exports.getUsers();

  const friends = await exports.getFriends(adminId);
  const notFriends = users.filter(
    (user) =>
      !friends.some((friend) => friend.id === user.id) && user.id !== adminId
  );

  const userToAdd = notFriends.map((notFriend) => ({
    userId1: adminId,
    userId2: notFriend.id
  }));

  await bulkInsertFriendships(userToAdd);
};

exports.getUserById = async (userId) => {
  const sql = `
    SELECT id, full_name, email, date_of_birth, country, image, slug, created_at 
    FROM users 
    WHERE id = $1
  `;
  return await db.getRow(sql, [userId]);
};

exports.getIdByEmail = async (email) => {
  const sql = `SELECT id FROM users WHERE email = $1`;
  return await db.getRow(sql, [email]);
};

// Helper function used internally to check if slug exists
async function getIdBySlug(slug) {
  const sql = `SELECT id FROM users WHERE slug = $1`;
  return await db.getRow(sql, [slug]);
}

exports.getIdsByEmails = async (emails) => {
  const sql = `SELECT id FROM users WHERE email IN ($1)`;
  return await db.getRows(sql, [emails]);
};

exports.getUserBySlug = async (slug) => {
  const sql = `
    SELECT id, full_name, email, date_of_birth, country, image, slug, created_at 
    FROM users 
    WHERE slug = $1
  `;
  return await db.getRow(sql, [slug]);
};

exports.getUserSettings = async (userId) => {
  const sql = `
    SELECT *
    FROM user_settings
    WHERE user_id = $1
  `;
  return await db.getRow(sql, [userId]);
};

exports.getAdmins = async () => {
  const sql = `SELECT * FROM users WHERE role = $1`;
  return await db.getRows(sql, [adminRole]);
};

exports.getUsers = async () => {
  const sql = `SELECT * FROM users ORDER BY created_at DESC`;
  return await db.getRows(sql, []);
};

// Export users to CSV
exports.exportUsersToCSV = (users) => {
  if (!users || users.length === 0) {
    return "No users found";
  }

  // CSV Header
  const headers = [
    "ID",
    "Full Name",
    "Email",
    "Date of Birth",
    "Country",
    "Role",
    "Slug",
    "Created At"
  ];

  // CSV Rows
  const rows = users.map(user => {
    const escapeCSV = (value) => {
      if (value === null || value === undefined) return "";
      const str = String(value);
      if (str.includes(",") || str.includes("\"") || str.includes("\n")) {
        return `"${str.replace(/"/g, "\"\"")}"`;
      }
      return str;
    };

    const role = user.role === 10 ? "Admin" : user.role === 20 ? "User" : user.role;

    return [
      escapeCSV(user.id),
      escapeCSV(user.fullName || user.full_name),
      escapeCSV(user.email),
      escapeCSV(user.dateOfBirth || user.date_of_birth || ""),
      escapeCSV(user.country || ""),
      escapeCSV(role),
      escapeCSV(user.slug || ""),
      escapeCSV(user.createdAt ? new Date(user.createdAt).toISOString() : "")
    ].join(",");
  });

  return [headers.join(","), ...rows].join("\n");
};

exports.checkFriends = async (id1, id2) => {
  const sql = `
    SELECT id 
    FROM friendship 
    WHERE (user_id_1 = $1 AND user_id_2 = $2) OR (user_id_1 = $3 AND user_id_2 = $4)
  `;
  return await db.getRow(sql, [id1, id2, id2, id1]);
};

exports.sendInvite = async (body, userId) => {
  const emails = Array.isArray(body.email) ? body.email : [body.email];
  const senderId = userId;

  const validations = emails.map(async (email) => {
    //check if initation sent already
    const existingInvite = await db.getRow(
      `SELECT * FROM invitation WHERE sender_id = $1 AND receiver_email = $2`,
      [userId, email]
    );
    if (existingInvite && existingInvite.id) {
      throw new CustomError("Already sent invitation!", 409, email);
    }

    //find receiver's id from email
    const receiver = await exports.getIdByEmail(email);

    // if email exist
    if (receiver && receiver.id) {
      //cant send invitation to ownself
      if (receiver.id === userId) {
        throw new CustomError(
          "Can't send invitation to own email!",
          400,
          email
        );
      }
      const isFriend = await exports.checkFriends(receiver.id, senderId);
      // check if they are friends already
      if (isFriend) {
        throw new CustomError("User already in friend list!", 409, email);
      }
    }

    //if not friends, insert in invitation
    const token = uuidv4();
    await db.execute(
      `INSERT INTO invitation (sender_id, receiver_email, token, is_accepted, created_at) VALUES ($1, $2, $3, $4, $5)`,
      [senderId, email, token, false, new Date()]
    );
    const { fullName } = await exports.getUserById(senderId);
    return { senderData: { fullName }, token, email };
  });

  const results = await Promise.allSettled(validations);

  const successfulInvites = results
    .filter((result) => result.status === "fulfilled")
    .map((result) => {
      return result.value;
    });

  const failedInvites = results
    .filter((result) => result.status === "rejected")
    .map((result) => ({
      email: result.reason.payload,
      errorMessage: result.reason.message || "Unknown error" // Provide default message
    }));

  const emailPromises = successfulInvites.map(
    ({ senderData, token, email }) => {
      return emailService.sendInvitationEmail(email, {
        senderName: senderData.fullName,
        message: body.message,
        token,
        vueBaseUrl: process.env.VUE_BASE_URL
      });
    }
  );

  await Promise.all(emailPromises);

  return { successfulInvites, failedInvites }; // Return details of successful invitations
};

exports.previewInvite = async (token) => {
  if (!token) {
    throw new CustomError("Invalid invitation!", 400);
  }

  const invitation = await db.getRow(
    `SELECT id, sender_id, receiver_email FROM invitation WHERE token = $1`,
    [token]
  );

  if (!invitation) {
    throw new CustomError("Invalid invitation!");
  }

  const sender = await exports.getUserById(invitation.senderId);
  const receiver = await exports.getIdByEmail(invitation.receiverEmail);

  let alreadyFriends = false;
  if (receiver?.id) {
    const friendship = await exports.checkFriends(invitation.senderId, receiver.id);
    alreadyFriends = !!friendship;
  }

  return {
    token,
    email: invitation.receiverEmail,
    senderName: sender?.fullName || null,
    receiverExists: !!receiver?.id,
    alreadyFriends
  };
};

exports.acceptInvite = async (token, currentUserId) => {
  if (!token) {
    throw new CustomError("Invalid invitation!", 400);
  }

  const invitation = await db.getRow(
    `SELECT id, sender_id, receiver_email FROM invitation WHERE token = $1`,
    [token]
  );

  if (!invitation) {
    throw new CustomError("Invalid invitation!");
  }

  const receiver = await exports.getUserById(currentUserId);
  if (!receiver) {
    throw new CustomError("User not found!", 404);
  }

  const normalizedReceiverEmail = receiver.email?.toLowerCase();
  if (normalizedReceiverEmail !== invitation.receiverEmail?.toLowerCase()) {
    throw new CustomError("This invitation doesn't belong to your account!", 403);
  }

  const friendship = await exports.checkFriends(invitation.senderId, receiver.id);
  if (friendship) {
    throw new CustomError("User already in friendlist!");
  }

  await db.execute(
    `INSERT INTO friendship (user_id_1, user_id_2, created_at) VALUES ($1, $2, $3)`,
    [invitation.senderId, receiver.id, new Date()]
  );

  await db.execute(`DELETE FROM invitation WHERE id = $1`, [invitation.id]);

  return { newFriendsCount: 1 };
};

exports.getFriends = async (userId) => {
  const sql = `
    SELECT f.id as friendship_id, c.id, c.full_name, c.image, c.email, c.slug 
    FROM users c 
    JOIN (
      SELECT id, user_id_1 as friend_id, created_at 
      FROM friendship 
      WHERE user_id_2 = $1 
      UNION 
      SELECT id, user_id_2 as friend_id, created_at 
      FROM friendship 
      WHERE user_id_1 = $2
    ) as f ON c.id = f.friend_id 
    ORDER BY f.created_at DESC
  `;
  return await db.getRows(sql, [userId, userId]);
};

exports.getFriendsWSettings = async (userId) => {
  const sql = `
    SELECT f.id as friendship_id, c.id, c.full_name, c.image, c.email, 
           us.email_new_event_notification, us.email_update_event_notification, 
           us.email_new_comment_notification 
    FROM users c 
    JOIN (
      SELECT id, user_id_1 as friend_id, created_at 
      FROM friendship 
      WHERE user_id_2 = $1 
      UNION 
      SELECT id, user_id_2 as friend_id, created_at 
      FROM friendship 
      WHERE user_id_1 = $2
    ) as f ON c.id = f.friend_id 
    JOIN user_settings us ON c.id = us.user_id
  `;
  return await db.getRows(sql, [userId, userId]);
};

exports.removeFriend = async (userId, friendshipId) => {
  // First verify the friendship exists and belongs to the user
  const checkSql = `SELECT id FROM friendship WHERE id = $1 AND (user_id_1 = $2 OR user_id_2 = $2)`;
  const checkResult = await db.getRow(checkSql, [friendshipId, userId]);
  
  if (!checkResult) {
    // Return a result with rowCount 0 to indicate no rows were found
    return { rowCount: 0 };
  }
  
  // Delete the friendship
  const sql = `DELETE FROM friendship WHERE id = $1 AND (user_id_1 = $2 OR user_id_2 = $2)`;
  return await db.execute(sql, [friendshipId, userId]);
};

exports.searchUser = async (requestedUser) => {
  let sql = `SELECT id, full_name, email, date_of_birth, country, image, slug FROM users`;
  sql += requestedUser
    ? ` WHERE ((CASE WHEN $1 ~ '^[0-9]+$' THEN id = CAST($1 AS INT) ELSE FALSE END)
          OR LOWER(email) = $2
          OR LOWER(full_name) LIKE '%' || $3 || '%')`
    : "";

  const params = requestedUser
    ? [requestedUser, requestedUser.toLowerCase(), requestedUser.toLowerCase()]
    : [];
  return await db.getRows(sql, params);
};

// Search users for mention autocomplete (friends only)
exports.searchUsers = async (query, userId, limit = 10) => {
  const trimmedQuery = query ? query.trim() : "";

  let sql;
  let params;

  if (trimmedQuery.length === 0) {
    // Show all friends when query is empty
    sql = `
      SELECT 
        u.id, 
        u.full_name, 
        u.slug, 
        u.image, 
        u.email
      FROM users u
      JOIN (
        SELECT user_id_1 as friend_id
        FROM friendship
        WHERE user_id_2 = $1
        UNION
        SELECT user_id_2 as friend_id
        FROM friendship
        WHERE user_id_1 = $2
      ) as friends ON u.id = friends.friend_id
      ORDER BY u.full_name ASC
      LIMIT $3
    `;
    params = [userId, userId, limit];
  } else {
    // Filter friends by search query
    const searchTerm = `%${trimmedQuery}%`;
    sql = `
      SELECT 
        u.id, 
        u.full_name, 
        u.slug, 
        u.image, 
        u.email
      FROM users u
      JOIN (
        SELECT user_id_1 as friend_id
        FROM friendship
        WHERE user_id_2 = $3
        UNION
        SELECT user_id_2 as friend_id
        FROM friendship
        WHERE user_id_1 = $4
      ) as friends ON u.id = friends.friend_id
      WHERE (LOWER(u.full_name) LIKE LOWER($1)
         OR LOWER(u.slug) LIKE LOWER($1)
         OR LOWER(u.email) LIKE LOWER($1))
      ORDER BY 
        CASE 
          WHEN LOWER(u.slug) = LOWER($2) THEN 1
          WHEN LOWER(u.full_name) LIKE LOWER($2) THEN 2
          ELSE 3
        END,
        u.full_name ASC
      LIMIT $5
    `;
    params = [searchTerm, trimmedQuery, userId, userId, limit];
  }

  return await db.getRows(sql, params);
};

exports.deleteUser = async (userId, rmImage) => {
  const sql = `SELECT images FROM event_post WHERE user_id = $1`;
  const sql1 = `DELETE FROM event_collection_item WHERE user_id = $1`;
  const sql2 = `DELETE FROM event_comment WHERE user_id = $1`;
  const sql3 = `DELETE FROM event_wishlist WHERE user_id = $1`;
  const sql4 = `DELETE FROM event_post WHERE user_id = $1`;
  const sql5 = `DELETE FROM friendship WHERE user_id_1 = $1 OR user_id_2 = $2`;
  const sql6 = `DELETE FROM users WHERE id = $1`;

  const results = await Promise.all([
    db.getRows(sql, [userId]),
    db.execute(sql1, [userId]),
    db.execute(sql2, [userId]),
    db.execute(sql3, [userId]),
    db.execute(sql4, [userId]),
    db.execute(sql5, [userId, userId]),
    db.execute(sql6, [userId])
  ]);

  // remove all events images
  const rows = results[0];
  if (rows.length > 0) {
    let rmImages = [];
    for (const row of rows) {
      let images;
      try {
        images = JSON.parse(row.images);
      } catch {
        console.error("deleteUser() - Invalid JSON:", row);
        continue; // Skip this row
      }
      // const images = JSON.parse(row);
      if (images.length > 0) {
        // Ignore empty arrays
        rmImages = rmImages.concat(images);
      }
    }

    if (rmImage) {
      await removeImages([rmImage]);
    } //remove user img
    if (rmImages.length > 0) {
      await removeImages(rmImages);
    } //remove all event images by user
  }
  return results;
};

exports.updateProfile = async (body, files, userId) => {
  let sql = "UPDATE users SET";
  const values = [];
  const columns = [];

  if (body.fullName !== undefined) {
    columns.push("full_name");
    values.push(body.fullName);
  }
  if (body.email !== undefined) {
    columns.push("email");
    values.push(body.email);
  }
  if (body.password !== undefined) {
    // Hash password before updating
    const hashedPassword = await bcrypt.hash(body.password, 10);
    columns.push("password");
    values.push(hashedPassword);
  }
  if (body.slug !== undefined) {
    // Validate slug uniqueness before updating
    const existingUser = await getIdBySlug(body.slug);
    if (existingUser && existingUser.id !== userId) {
      throw new CustomError("Slug already taken! Please choose a different one.", 409);
    }
    columns.push("slug");
    values.push(body.slug);
  }
  if (files) {
    columns.push("image");
    values.push(files[0].filename);
  } else if (body.rmImage && !files) {
    // If rmImage is provided but no new file, set image to null in database
    columns.push("image");
    values.push(null);
  }

  if (columns.length === 0) {
    // No fields to update
    return await exports.getUserById(userId);
  }

  sql += " " + columns.map((col, index) => `${col} = $${index + 1}`).join(", ");
  values.push(userId);
  sql += ` WHERE id = $${values.length} RETURNING full_name, email, image, slug`;

  const updated = await db.getRow(sql, values);
  if (!updated) {
    throw new CustomError("Profile update failed!", 500);
  }
  if (body.rmImage) {
    await removeImages([body.rmImage]);
  }
  return updated;
};

exports.getUsersWNewCommentsInDays = async (day) => {
  const sql = `
    SELECT c.id, c.full_name, c.email, us.email_new_comment_notification, 
           COUNT(event_comment.id) as comment_count 
    FROM event_comment 
    JOIN event_post ON event_comment.event_id = event_post.id 
    JOIN users c ON event_post.user_id = c.id 
    JOIN user_settings us ON us.user_id = c.id 
    WHERE event_comment.created_at > CURRENT_TIMESTAMP - INTERVAL '$1 days' 
      AND event_comment.user_id != event_post.user_id 
    GROUP BY c.id, us.email_new_comment_notification
  `;

  return await db.getRows(sql, [day]);
};

exports.getUsersPostedEventsToday = async () => {
  const currentDate = new Date().toISOString().split("T")[0];
  const sql = `
    SELECT DISTINCT c.id, c.email
    FROM users as c
    JOIN event_post as e ON c.id = e.user_id
    WHERE DATE(e.date) = $1
  `;

  return await db.getRows(sql, [currentDate]);
};

exports.sendNewCommentEmail = async (clientUrl) => {
  // find friends & send notification email to friends
  const users = await exports.getUsersWNewCommentsInDays(1);
  // Generate email and send emails in parallel
  const sendEmailPromises = users
    .filter((user) => user.emailNewCommentNotification)
    .map(async (user) => {
      return emailService.sendNewCommentEmail(user.email, {
        userId: user.id,
        vueBaseUrl: clientUrl
      });
    });
  // Wait for all emails to be sent
  return await Promise.all(sendEmailPromises);
};

exports.sendTodaysEventEmail = async (clientUrl) => {
  // find friends & send notification email to friends
  const users = await exports.getUsersPostedEventsToday();
  // Generate email and send emails in parallel
  const sendEmailPromises = users.map(async (user) => {
    return emailService.sendTodaysEventEmail(user.email, {
      userId: user.id,
      vueBaseUrl: clientUrl
    });
  });
  // Wait for all emails to be sent
  return await Promise.all(sendEmailPromises);
};

exports.getProfileWSettings = async (userId) => {
  const sql = `
    SELECT c.id, c.full_name, c.email, c.date_of_birth, c.country, c.image, c.slug, c.created_at,
           COALESCE(us.email_new_event_notification, true) as email_new_event_notification,
           COALESCE(us.email_update_event_notification, true) as email_update_event_notification, 
           COALESCE(us.email_new_comment_notification, true) as email_new_comment_notification,
           COALESCE(us.theme, 'light') as theme,
           us.user_id as settings_user_id
    FROM users as c
    LEFT JOIN user_settings as us ON c.id = us.user_id
    WHERE c.id = $1
  `;
  const result = await db.getRow(sql, [userId]);
  
  // If user exists but has no settings record, create default settings
  if (result && !result.settingsUserId) {
    await exports.createUserSettings(userId);
    // Re-fetch with the newly created settings (without the check field)
    const refetchSql = `
      SELECT c.id, c.full_name, c.email, c.date_of_birth, c.country, c.image, c.slug, c.created_at,
             us.email_new_event_notification, us.email_update_event_notification, 
             us.email_new_comment_notification, us.theme
      FROM users as c
      JOIN user_settings as us ON c.id = us.user_id
      WHERE c.id = $1
    `;
    return await db.getRow(refetchSql, [userId]);
  }
  
  // Remove the check field from result before returning
  if (result && result.settingsUserId !== undefined) {
    delete result.settingsUserId;
  }
  
  return result;
};

exports.updateEmailNewEventNotification = async (payload, userId) => {
  const sql = `UPDATE user_settings SET email_new_event_notification = $1 WHERE user_id = $2`;
  return await db.execute(sql, [payload, userId]);
};

exports.updateEmailUpdateEventNotification = async (payload, userId) => {
  const sql = `UPDATE user_settings SET email_update_event_notification = $1 WHERE user_id = $2`;
  return await db.execute(sql, [payload, userId]);
};

exports.updateEmailNewCommentNotification = async (payload, userId) => {
  const sql = `UPDATE user_settings SET email_new_comment_notification = $1 WHERE user_id = $2`;
  return await db.execute(sql, [payload, userId]);
};

exports.getPendingInvitation = async (email) => {
  const sql = `SELECT * FROM invitation WHERE receiver_email = $1 AND is_accepted = true`;
  return await db.getRows(sql, [email]);
};

exports.createUserSettings = async (userId) => {
  // Create user settings with all email notifications enabled by default
  // All 3 email notifications are set to true for new users:
  // - email_new_event_notification: true
  // - email_update_event_notification: true
  // - email_new_comment_notification: true
  const sql = `
    INSERT INTO user_settings (
      email_new_event_notification, email_update_event_notification,
      email_new_comment_notification, sort, theme, user_id
    )
    VALUES ($1, $2, $3, $4, $5, $6)
  `;
  return await db.execute(sql, [true, true, true, "DESC", "light", userId]);
};

exports.updateSettings = async (payload, userId) => {
  let sql = "UPDATE user_settings SET";
  const values = [];
  let paramIndex = 1;

  if (payload.emailNewEventNotification !== undefined) {
    sql += ` email_new_event_notification = $${paramIndex++},`;
    values.push(payload.emailNewEventNotification);
  }
  if (payload.emailUpdateEventNotification !== undefined) {
    sql += ` email_update_event_notification = $${paramIndex++},`;
    values.push(payload.emailUpdateEventNotification);
  }
  if (payload.emailNewCommentNotification !== undefined) {
    sql += ` email_new_comment_notification = $${paramIndex++},`;
    values.push(payload.emailNewCommentNotification);
  }
  if (payload.sort !== undefined) {
    sql += ` sort = $${paramIndex++},`;
    values.push(payload.sort);
  }
  if (payload.theme !== undefined) {
    sql += ` theme = $${paramIndex++},`;
    values.push(payload.theme);
  }

  // Remove the trailing comma and add the WHERE clause
  sql = sql.slice(0, -1) + ` WHERE user_id = $${paramIndex}`;
  values.push(userId);

  return await db.execute(sql, values);
};

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
