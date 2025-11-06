const db = require("../db");
const CustomError = require("../model/CustomError");
const { removeImages, ifAdmin } = require("../others/util");
const emailService = require("../email");
const userService = require("./user");
const mentionService = require("./mention");
const subscriptionService = require("./subscription");

// Valid reaction types
const VALID_REACTION_TYPES = ['like', 'unlike', 'heart', 'laugh', 'sad', 'angry'];

exports.sendPostCreationEmail = async (userId, clientUrl) => {
  // find friends & send notification email to friends
  const [friends, user] = await Promise.all([
    userService.getFriendsWSettings(userId),
    userService.getUserById(userId)
  ]);
  // Generate email and send emails in parallel
  const sendEmailPromises = friends
    .filter((friend) => friend.emailNewEventNotification)
    .map(async (friend) => {
      return emailService.sendEventEmail(friend.email, {
        userName: user.fullName,
        userId: user.id,
        type: "add",
        vueBaseUrl: clientUrl
      });
    });
  // Wait for all emails to be sent
  return Promise.all(sendEmailPromises);
};

exports.sendPostEditEmail = async (userId, clientUrl) => {
  // find friends & send notification email to friends
  const [friends, user] = await Promise.all([
    userService.getFriendsWSettings(userId),
    userService.getUserById(userId)
  ]);
  // Generate email and send emails in parallel
  const sendEmailPromises = friends
    .filter((friend) => friend.emailUpdateEventNotification)
    .map(async (friend) => {
      return emailService.sendEventEmail(friend.email, {
        userName: user.fullName,
        userId: user.id,
        type: "edit",
        vueBaseUrl: clientUrl
      });
    });
  // Wait for all emails to be sent
  return Promise.all(sendEmailPromises);
};

exports.createWelcomeEvent = async (userId) => {
  const currentDate = new Date();
  const eventDate = currentDate.toISOString().split("T")[0];
  const startTime = currentDate.toTimeString().slice(0, 5);

  const sql = `
    INSERT INTO event_post (title, date, start_time, end_time, location, description, category, images, is_featured, user_id, created_at) 
    VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11)
    RETURNING *
  `;

  const values = [
    "Joined WayzAway!",
    eventDate,
    startTime,
    null,
    null,
    "Welcome to WayzAway! Why not start by inviting friends and family members so you can start to share your experiences and get ideas on places to go.",
    "Registration",
    "[]", // No images
    false,
    userId,
    currentDate
  ];

  const event = await db.getRow(sql, values);

  if (!event) {
    return null;
  }
  return event;
};

// Get monthly post count for a user (excluding welcome events)
exports.getMonthlyPostCount = async (userId) => {
  const now = new Date();
  const startOfMonth = new Date(now.getFullYear(), now.getMonth(), 1);
  const sql = `
    SELECT COUNT(*) as count
    FROM event_post
    WHERE user_id = $1
      AND created_at >= $2
      AND created_at < $3
      AND category != 'Registration'
  `;
  const result = await db.getRow(sql, [userId, startOfMonth, now]);
  return parseInt(result.count) || 0;
};

// Get post limit status for a user
exports.getPostLimitStatus = async (userId) => {
  const isPremium = await subscriptionService.isPremiumUser(userId);
  const monthlyCount = await exports.getMonthlyPostCount(userId);
  const limit = 5; // Free users get 5 posts/month
  const remaining = isPremium ? -1 : Math.max(0, limit - monthlyCount); // -1 means unlimited
  
  return {
    isPremium,
    monthlyCount,
    limit,
    remaining
  };
};

exports.save = async (body, files, userId, clientUrl) => {
  // Check post limit for free users
  const isPremium = await subscriptionService.isPremiumUser(userId);
  if (!isPremium) {
    const monthlyCount = await exports.getMonthlyPostCount(userId);
    const limit = 5;
    if (monthlyCount >= limit) {
      throw new CustomError(
        `You've reached your monthly post limit of ${limit} posts. Upgrade to premium for unlimited posts!`,
        403
      );
    }
  }

  const fileNames = JSON.stringify(files ? files.map((file) => file.filename) : []);
  const eventDate = new Date(body.date).toISOString().split("T")[0];
  
  // Calculate expires_at if autoDeleteDays is provided
  let expiresAt = null;
  if (body.autoDeleteDays && parseInt(body.autoDeleteDays) > 0) {
    const deleteDays = parseInt(body.autoDeleteDays);
    const createdDate = new Date();
    // Use UTC date components to avoid timezone issues, normalize to midnight UTC
    expiresAt = new Date(Date.UTC(createdDate.getUTCFullYear(), createdDate.getUTCMonth(), createdDate.getUTCDate() + deleteDays, 0, 0, 0, 0));
  }
  
  const sql = `
    INSERT INTO event_post (title, date, start_time, end_time, location, description, category, images, is_featured, user_id, created_at, expires_at) 
    VALUES ($1, $2, $3, $4, $5, $6, $7, $8::jsonb, $9, $10, $11, $12)
    RETURNING *
  `;
  const values = [
    body.title,
    eventDate,
    body.startTime,
    body.endTime,
    body.location,
    body.description,
    body.category,
    fileNames,
    JSON.parse(body.isFeatured),
    userId,
    new Date(),
    expiresAt
  ];

  const event = await db.getRow(sql, values);

  if (!event) {
    return null;
  }

  exports.sendPostCreationEmail(userId, clientUrl);
  return event;
};

exports.edit = async (body, files, userId, clientUrl) => {
  const fileNames =
    files ? files.map((file) => file.filename) : [];

  const images = body.images ? JSON.parse(body.images) : [];
  const combinedImages = [...images, ...fileNames];

  const eventDate = new Date(body.date).toISOString().split("T")[0];
  
  // Calculate expires_at if autoDeleteDays is provided
  let expiresAt = null;
  if (body.autoDeleteDays !== undefined && body.autoDeleteDays !== '') {
    if (body.autoDeleteDays && parseInt(body.autoDeleteDays) > 0) {
      const deleteDays = parseInt(body.autoDeleteDays);
      // When editing, calculate from current date (not original created_at)
      // This allows users to reset expiration to X days from now
      const currentDate = new Date();
      // Use UTC date components to avoid timezone issues, normalize to midnight UTC
      expiresAt = new Date(Date.UTC(currentDate.getUTCFullYear(), currentDate.getUTCMonth(), currentDate.getUTCDate() + deleteDays, 0, 0, 0, 0));
    }
    // If autoDeleteDays is empty string or 0, expiresAt remains null (permanent)
  }
  
  let sql = `
    UPDATE event_post 
    SET title=$1, date=$2, start_time=$3, end_time=$4, location=$5, description=$6, category=$7, images=$8::jsonb, expires_at=$9
    WHERE id=$10 RETURNING *
  `;

  const values = [
    body.title,
    eventDate,
    body.startTime,
    body.endTime,
    body.location,
    body.description,
    body.category,
    JSON.stringify(combinedImages),
    expiresAt,
    body.id
  ];

  const result = await db.getRow(sql, values);
  exports.sendPostEditEmail(userId, clientUrl);

  if (!result) {
    return null;
  }

  //remove replaced images
  const rmImages = body.rmImages ? JSON.parse(body.rmImages) : [];
  if (rmImages && rmImages.length > 0) {
    await removeImages(rmImages);
  }
  return result;
};

function getSortingColumn(sort) {
  switch (sort) {
    case "LATEST": {
      return `e.created_at DESC, e.id DESC`;
    }
    case "DESC": {
      return `e.date DESC, e.id DESC`;
    }
    case "ASC": {
      return `e.date ASC, e.id ASC`;
    }
    // No default
  }
}

exports.getEventsByUserId = async ({ userId, page = 1, sort = "LATEST" }) => {
  const itemsPerPage = 10;
  const offset = (page - 1) * itemsPerPage;

  const sql = `
    SELECT e.*, c.full_name, c.image, c.slug
    FROM event_post e
    JOIN users c ON e.user_id = c.id
    WHERE e.user_id = $1
    ORDER BY ${getSortingColumn(sort)}
    LIMIT $2 OFFSET $3
  `;
  return db.getRows(sql, [userId, itemsPerPage, offset]);
};
exports.getAllEventsByFriends = async ({ userId, page = 1, sort = "LATEST" }) => {
  const itemsPerPage = 10;
  const offset = (page - 1) * itemsPerPage;
  const sql = `
    SELECT DISTINCT e.*, c.full_name, c.image, c.slug
    FROM event_post e
    JOIN users c ON e.user_id = c.id
    WHERE (e.expires_at IS NULL OR e.expires_at > NOW())
      AND (
        -- Events from friends that are NOT shared with any group
        (
          EXISTS (
            SELECT 1
            FROM friendship f
            WHERE (f.user_id_1 = e.user_id AND f.user_id_2 = $1)
               OR (f.user_id_2 = e.user_id AND f.user_id_1 = $1)
               OR e.user_id = $1
          )
          AND NOT EXISTS (
            SELECT 1
            FROM event_group eg
            WHERE eg.event_id = e.id
          )
        )
        -- OR events shared with groups user belongs to (even if creator is not a friend)
        OR EXISTS (
          SELECT 1
          FROM event_group eg
          JOIN group_member gm ON eg.group_id = gm.group_id
          WHERE eg.event_id = e.id
            AND gm.user_id = $1
        )
      )
    ORDER BY ${getSortingColumn(sort)}
    LIMIT $2 OFFSET $3
  `;
  const results = await db.getRows(sql, [userId, itemsPerPage, offset]);
  // Parse the images field for each record
  return results;
};

exports.findWallEvents = async ({
                                  userId,
                                  searchKeyword,
                                  startDate,
                                  endDate,
                                  category,
                                  sort = "LATEST",
                                  page = 1
                                }) => {
  const itemsPerPage = 10;
  const offset = (page - 1) * itemsPerPage;
  const values = [];
  let sql = `
    SELECT e.*, c.full_name, c.image, c.slug
    FROM event_post e
    JOIN users c ON e.user_id = c.id
    WHERE e.user_id = $1 AND (e.expires_at IS NULL OR e.expires_at > NOW())
  `;

  values.push(userId);
  let paramIndex = 2;

  if (searchKeyword) {
    sql += ` and e.title like $${paramIndex++}`;
    values.push("%" + searchKeyword + "%");
  }
  if (startDate) {
    sql += ` and e.date >= $${paramIndex++}`;
    values.push(startDate);
  }
  if (endDate) {
    sql += ` and e.date <= $${paramIndex++}`;
    values.push(endDate);
  }
  if (category) {
    sql += ` and e.category = $${paramIndex++}`;
    values.push(category);
  }
  if (sort) {
    sql += ` order by ${getSortingColumn(sort)} `;
  }
  sql += ` limit $${paramIndex++} offset $${paramIndex++}`;
  values.push(itemsPerPage, offset);
  const results = await db.getRows(sql, values);
  // Parse the images field for each record
  return results;
};

exports.findBrowseEvents = async ({
                                    userId,
                                    searchKeyword,
                                    startDate,
                                    endDate,
                                    category,
                                    sort = "LATEST",
                                    page = 1
                                  }) => {
  const itemsPerPage = 10;
  const offset = (page - 1) * itemsPerPage;
  const values = [];

  let sql = `
    SELECT DISTINCT e.*, c.full_name, c.image, c.slug 
    FROM event_post e 
    JOIN users c ON e.user_id = c.id
    WHERE (e.expires_at IS NULL OR e.expires_at > NOW())
      AND (
        -- Events from friends that are NOT shared with any group
        (
          EXISTS (
            SELECT 1
            FROM friendship f
            WHERE (f.user_id_1 = e.user_id AND f.user_id_2 = $1)
               OR (f.user_id_2 = e.user_id AND f.user_id_1 = $1)
               OR e.user_id = $1
          )
          AND NOT EXISTS (
            SELECT 1
            FROM event_group eg
            WHERE eg.event_id = e.id
          )
        )
        -- OR events shared with groups user belongs to (even if creator is not a friend)
        OR EXISTS (
          SELECT 1
          FROM event_group eg
          JOIN group_member gm ON eg.group_id = gm.group_id
          WHERE eg.event_id = e.id
            AND gm.user_id = $1
        )
      )
  `;

  values.push(userId);
  let paramIndex2 = 2;

  if (searchKeyword) {
    sql += ` and e.title like $${paramIndex2++}`;
    values.push("%" + searchKeyword + "%");
  }
  if (startDate) {
    sql += ` and e.date >= $${paramIndex2++}`;
    values.push(startDate);
  }
  if (endDate) {
    sql += ` and e.date <= $${paramIndex2++}`;
    values.push(endDate);
  }
  if (category) {
    sql += ` and e.category = $${paramIndex2++}`;
    values.push(category);
  }
  if (sort) {
    sql += ` order by ${getSortingColumn(sort)} `;
  }

  sql += ` limit $${paramIndex2++} offset $${paramIndex2++}`;
  values.push(itemsPerPage, offset);

  return await db.getRows(sql, values);
};

exports.getEvent = async (eventId, userId = null) => {
  const sql = `
    SELECT e.*, c.full_name, c.image, c.slug,
      COALESCE(COUNT(DISTINCT er_like.id), 0) as like_count,
      COALESCE(COUNT(DISTINCT er_heart.id), 0) as heart_count,
      COALESCE(COUNT(DISTINCT er_laugh.id), 0) as laugh_count,
      COALESCE(COUNT(DISTINCT er_unlike.id), 0) as unlike_count,
      COALESCE(COUNT(DISTINCT er_sad.id), 0) as sad_count,
      COALESCE(COUNT(DISTINCT er_angry.id), 0) as angry_count
    FROM event_post e 
    JOIN users c ON e.user_id = c.id 
    LEFT JOIN event_reaction er_like ON e.id = er_like.event_id AND er_like.reaction_type = 'like'
    LEFT JOIN event_reaction er_heart ON e.id = er_heart.event_id AND er_heart.reaction_type = 'heart'
    LEFT JOIN event_reaction er_laugh ON e.id = er_laugh.event_id AND er_laugh.reaction_type = 'laugh'
    LEFT JOIN event_reaction er_unlike ON e.id = er_unlike.event_id AND er_unlike.reaction_type = 'unlike'
    LEFT JOIN event_reaction er_sad ON e.id = er_sad.event_id AND er_sad.reaction_type = 'sad'
    LEFT JOIN event_reaction er_angry ON e.id = er_angry.event_id AND er_angry.reaction_type = 'angry'
    WHERE e.id = $1 AND (e.expires_at IS NULL OR e.expires_at > NOW())
    GROUP BY e.id, c.full_name, c.image, c.slug
  `;
  
  const result = await db.getRow(sql, [eventId]);
  if (!result) {
    return null;
  }

  // Check if event is shared with groups
  const groupCheckSql = `SELECT COUNT(*) as count FROM event_group WHERE event_id = $1`;
  const groupCheck = await db.getRow(groupCheckSql, [eventId]);
  const isSharedWithGroups = groupCheck && parseInt(groupCheck.count) > 0;

  // If event is shared with groups, verify user has access
  if (isSharedWithGroups && userId) {
    // Check if user is the event creator or a member of any group the event is shared with
    // Note: Friends are NOT allowed if event is shared with groups (group-only privacy)
    const accessSql = `
      SELECT 1
      FROM event_post e
      LEFT JOIN event_group eg ON e.id = eg.event_id
      LEFT JOIN group_member gm ON eg.group_id = gm.group_id AND gm.user_id = $2
      WHERE e.id = $1
        AND (e.user_id = $2 OR gm.user_id = $2)
      LIMIT 1
    `;
    const hasAccess = await db.getRow(accessSql, [eventId, userId]);
    if (!hasAccess) {
      throw new CustomError("Event not found or access denied!", 404);
    }
  } else if (isSharedWithGroups && !userId) {
    // Event is shared with groups but no userId provided - deny access
    throw new CustomError("Event not found or access denied!", 404);
  }

  // Format reaction counts
  result.reactions = {
    like: parseInt(result.like_count) || 0,
    heart: parseInt(result.heart_count) || 0,
    laugh: parseInt(result.laugh_count) || 0,
    unlike: parseInt(result.unlike_count) || 0,
    sad: parseInt(result.sad_count) || 0,
    angry: parseInt(result.angry_count) || 0
  };

  // Get user's reaction if userId provided
  if (userId) {
    result.userReaction = await exports.getUserReaction(eventId, userId);
  }

  // Remove temporary count fields
  delete result.like_count;
  delete result.heart_count;
  delete result.laugh_count;
  delete result.unlike_count;
  delete result.sad_count;
  delete result.angry_count;

  return result;
};

exports.getCommentsByEventId = async (eventId) => {
  const sql = `
    SELECT ec.id, ec.user_id, ec.text, ec.created_at, u.full_name, u.image, u.slug 
    FROM event_comment ec 
    JOIN users u ON ec.user_id = u.id 
    WHERE ec.event_id = $1 
    ORDER BY ec.created_at DESC
  `;
  const comments = await db.getRows(sql, [eventId]);
  
  // Load mentions for all comments
  if (comments && comments.length > 0) {
    const commentIds = comments.map(c => c.id);
    const mentionsByComment = await mentionService.getCommentsMentions(commentIds);
    
    // Add mentions to each comment
    // Ensure we match by both string and number to handle type differences
    comments.forEach(comment => {
      const commentId = comment.id;
      // Try both string and number keys in case of type mismatch
      const key = Number(commentId) || commentId;
      comment.mentions = mentionsByComment[key] || 
                         mentionsByComment[String(key)] || 
                         mentionsByComment[Number(key)] || 
                         [];
    });
  }
  
  return comments;
};

exports.addComment = async (newComment, userId) => {
  const sql = `
    INSERT INTO event_comment (event_id, user_id, text, created_at) 
    VALUES ($1, $2, $3, $4)
    RETURNING *
  `;
  const values = [newComment.eventId, userId, newComment.text, new Date()];
  const comment = await db.getRow(sql, values);
  
  // Parse and save mentions
  if (comment && comment.id) {
    const mentionTexts = mentionService.parseMentions(newComment.text);
    if (mentionTexts.length > 0) {
      const mentionedUserIds = await mentionService.findMentionedUsers(mentionTexts);
      if (mentionedUserIds.length > 0) {
        await mentionService.saveMentions(comment.id, mentionedUserIds);
        // Load mentions for the response
        comment.mentions = await mentionService.getCommentMentions(comment.id);
      } else {
        comment.mentions = [];
      }
    } else {
      comment.mentions = [];
    }
  } else {
    if (comment) comment.mentions = [];
  }
  
  return comment;
};

exports.deleteComment = async (commentId, userId, userRole) => {
  let sql = `DELETE FROM event_comment WHERE id = $1`;
  const values = [commentId];

  // if not admin add constraint
  if (!ifAdmin(userRole)) {
    sql += ` AND user_id = $2`;
    values.push(userId);
  }
  return await db.execute(sql, values);
};

exports.deleteEvent = async (eventId, images, userId, userRole) => {
  let sql = `DELETE FROM event_post WHERE id = $1`;
  const values = [eventId];

  // if not admin add constraint
  if (!ifAdmin(userRole)) {
    sql += ` AND user_id = $2`;
    values.push(userId);
  }
  const result = await db.execute(sql, values);
  if (images && images.length > 0) {
    await removeImages(images);
  }
  return result;
};

// wishlist-specific functions moved to wishlist service

exports.getFavoriteEvents = async (userId, page = 1, collectionId = null) => {
  const itemsPerPage = 10;
  const offset = (page - 1) * itemsPerPage;
  let sql = `
    SELECT e.*, c.full_name, c.image 
    FROM event_post e 
    JOIN event_collection_item ef ON e.id = ef.event_id 
    JOIN users c ON c.id = e.user_id 
    WHERE ef.user_id = $1 AND (e.expires_at IS NULL OR e.expires_at > NOW())
  `;
  const values = [userId];
  let paramIndex = 2;
  
  if (collectionId !== null && collectionId !== undefined) {
    sql += ` AND ef.collection_id = $${paramIndex++}`;
    values.push(collectionId);
  } else {
    // If collectionId is explicitly null, get only uncategorized events
    // If not provided, get all events (backward compatibility)
    // This will be handled by collection service for better control
  }
  
  sql += ` ORDER BY ef.created_at DESC LIMIT $${paramIndex++} OFFSET $${paramIndex++}`;
  values.push(itemsPerPage, offset);
  
  return db.getRows(sql, values);
};

exports.isFavorite = async (eventId, userId) => {
  const sql = `SELECT id FROM event_collection_item WHERE event_id = $1 AND user_id = $2`;
  const result = await db.getRow(sql, [eventId, userId]);
  return !!result;
};

// wishlist-specific functions moved to wishlist service

// wishlist-specific functions moved to wishlist service

// wishlist-specific functions moved to wishlist service

// wishlist-specific functions moved to wishlist service

exports.switchFavoriteEvent = async (eventId, payload, userId, collectionId = null) => {
  const sql = `SELECT * FROM event_collection_item WHERE user_id = $1 AND event_id = $2`;
  const res = await db.getRow(sql, [userId, eventId]);
  let sql2 = "";
  const values = [];
  if (res && res.id && payload == "false") {
    // entry found and payload is false, so remove from db
    sql2 = `DELETE FROM event_collection_item WHERE id = $1`;
    values.push(res.id);
  } else if (!res && payload == "true") {
    // entry not found and payload is true, so insert
    sql2 = `INSERT INTO event_collection_item(user_id, event_id, collection_id, created_at) VALUES ($1, $2, $3, $4)`;
    values.push(userId, eventId, collectionId);
    values.push(new Date());
  } else if (res && res.id && payload == "true") {
    // entry found and payload is true, update collection_id
    sql2 = `UPDATE event_collection_item SET collection_id = $1 WHERE id = $2`;
    values.push(collectionId, res.id);
  } else {
    throw new CustomError("Invalid favorite toggle request!", 400);
  }
  const result = await db.execute(sql2, values);
  //action successfull, return the payload
  if (result) {
    return JSON.parse(payload);
  } else {
    throw new CustomError("Favorite toggle failed!", 500);
  }
};

// Reaction functions
exports.toggleReaction = async (eventId, reactionType, userId) => {
  // Validate reaction type
  if (!VALID_REACTION_TYPES.includes(reactionType)) {
    throw new CustomError("Invalid reaction type!", 400);
  }

  // Check if user has existing reaction
  const existingSql = `SELECT * FROM event_reaction WHERE user_id = $1 AND event_id = $2`;
  const existing = await db.getRow(existingSql, [userId, eventId]);
  
  // db.js converts snake_case to camelCase, so reaction_type becomes reactionType
  if (existing && existing.reactionType === reactionType) {
    // Same reaction - remove it
    const deleteSql = `DELETE FROM event_reaction WHERE id = $1`;
    await db.execute(deleteSql, [existing.id]);
    const updatedReactions = await exports.getEventReactions(eventId, userId);
    return { 
      reactionType: null, 
      isActive: false,
      counts: updatedReactions.counts,
      userReaction: updatedReactions.userReaction
    };
  } else if (existing) {
    // Different reaction - update it
    const updateSql = `UPDATE event_reaction SET reaction_type = $1, created_at = $2 WHERE id = $3`;
    await db.execute(updateSql, [reactionType, new Date(), existing.id]);
    const updatedReactions = await exports.getEventReactions(eventId, userId);
    return { 
      reactionType, 
      isActive: true,
      counts: updatedReactions.counts,
      userReaction: updatedReactions.userReaction
    };
  } else {
    // No existing reaction - add it
    const insertSql = `INSERT INTO event_reaction (user_id, event_id, reaction_type, created_at) VALUES ($1, $2, $3, $4)`;
    await db.execute(insertSql, [userId, eventId, reactionType, new Date()]);
    const updatedReactions = await exports.getEventReactions(eventId, userId);
    return { 
      reactionType, 
      isActive: true,
      counts: updatedReactions.counts,
      userReaction: updatedReactions.userReaction
    };
  }
};

exports.getEventReactions = async (eventId, userId = null) => {
  // Get reaction counts grouped by type
  const countsSql = `
    SELECT reaction_type, COUNT(*) as count
    FROM event_reaction
    WHERE event_id = $1
    GROUP BY reaction_type
  `;
  const counts = await db.getRows(countsSql, [eventId]);

  // Initialize counts object
  const reactionCounts = {
    like: 0,
    heart: 0,
    laugh: 0,
      unlike: 0,
    sad: 0,
    angry: 0
  };

  // Populate counts - only include valid reaction types
  // Note: db.js converts snake_case to camelCase, so reaction_type becomes reactionType
  counts.forEach(row => {
    if (row.reactionType && VALID_REACTION_TYPES.includes(row.reactionType)) {
      reactionCounts[row.reactionType] = parseInt(row.count) || 0;
    }
  });

  // Get user's reaction if userId provided
  const userReaction = userId ? await exports.getUserReaction(eventId, userId) : null;

  return {
    counts: reactionCounts,
    userReaction
  };
};

exports.getUserReaction = async (eventId, userId) => {
  const sql = `SELECT reaction_type FROM event_reaction WHERE user_id = $1 AND event_id = $2`;
  const result = await db.getRow(sql, [userId, eventId]);
  // db.js converts snake_case to camelCase, so reaction_type becomes reactionType
  if (result && result.reactionType && VALID_REACTION_TYPES.includes(result.reactionType)) {
    return result.reactionType;
  }
  return null;
};

exports.getUpcomingEvents = async (userId, source) => {
  let friends = [];
  const currentDate = new Date();
  const formattedCurrentDate = currentDate.toISOString().slice(0, 10); // YYYY-MM-DD
  const formattedCurrentTime = currentDate.toISOString().slice(11, 19); // HH:mm:ss

  if (source === "friends") {
    // get upcoming events from friends and ownself
    const sql = `
      SELECT user_id_1 AS friendId FROM friendship WHERE user_id_2 = $1 
      UNION 
      SELECT user_id_2 AS friendId FROM friendship WHERE user_id_1 = $2 
      UNION 
      SELECT $3 as friendId
    `;

    const res = await db.getRows(sql, [userId, userId, userId]);
    friends = res
      .map((item) => item.friendId)
      .filter((friendId) => friendId != null && friendId !== "")
      .map((friendId) => Number.parseInt(friendId))
      .filter((friendId) => !isNaN(friendId));
  } else {
    // get events from ownself
    const parsedUserId = Number.parseInt(userId);
    if (!isNaN(parsedUserId)) {
      friends.push(parsedUserId);
    }
  }

  // If no valid friends found, return empty array
  if (friends.length === 0) {
    return [];
  }

  const inPlaceholders = friends.map((_, index) => `$${index + 1}`).join(", ");

  const sql = `
    SELECT e.*, c.full_name, c.image, c.slug
    FROM event_post e
    JOIN users c ON e.user_id = c.id
    WHERE e.user_id IN (${inPlaceholders})
      AND (e.expires_at IS NULL OR e.expires_at > NOW())
      AND (
        e.date > '${formattedCurrentDate}'
        OR (
          e.date = '${formattedCurrentDate}'
          AND e.start_time > '${formattedCurrentTime}'
        )
      )
    ORDER BY e.date, e.start_time
    LIMIT 3
  `;

  return db.getRows(sql, friends);
};

exports.getFeaturedEvent = async (userId) => {
  const sql = `SELECT * FROM event_post WHERE user_id = $1 AND is_featured = true AND (expires_at IS NULL OR expires_at > NOW())`;
  const result = await db.getRow(sql, [userId]);
  if (!result) {
    return null;
  }
  return result;
};
exports.updateFeaturedEvent = (payload, eventId, userId) => {
  const sql = `UPDATE event_post SET is_featured = $1 WHERE id = $2 AND user_id = $3`;
  return db.execute(sql, [JSON.parse(payload), eventId, userId]);
};

exports.deleteExpiredEvents = async () => {
  // Get all expired events with their images
  const sql = `
    SELECT id, images 
    FROM event_post 
    WHERE expires_at IS NOT NULL AND expires_at <= NOW()
  `;
  
  const expiredEvents = await db.getRows(sql, []);
  
  if (!expiredEvents || expiredEvents.length === 0) {
    return 0;
  }
  
  // Collect all images to delete
  const allImages = [];
  expiredEvents.forEach(event => {
    if (event.images && Array.isArray(event.images)) {
      allImages.push(...event.images);
    }
  });
  
  // Delete images from filesystem
  if (allImages.length > 0) {
    await removeImages(allImages);
  }
  
  // Delete expired events from database
  const deleteSql = `
    DELETE FROM event_post 
    WHERE expires_at IS NOT NULL AND expires_at <= NOW()
  `;
  
  await db.execute(deleteSql, []);
  
  return expiredEvents.length;
};

exports.swichFeaturedEvent = async (payload, newEventId, oldEventId, userId) => {
  const updatePromises = [
    exports.updateFeaturedEvent(payload, newEventId, userId)
  ];

  if (oldEventId) {
    updatePromises.push(
      exports.updateFeaturedEvent(!payload, oldEventId, userId)
    );
  }

  await Promise.all(updatePromises);
  return JSON.parse(payload);
};

exports.setEventNotification = (eventId, payload) => {
  const sql = `UPDATE event_post SET new_notification = $1 WHERE id = $2`;
  return db.execute(sql, [JSON.parse(payload), eventId]);
};

// Get all events for admin export
exports.getAllEvents = async () => {
  const sql = `
    SELECT e.*, u.full_name as user_full_name, u.email as user_email, u.slug as user_slug
    FROM event_post e
    JOIN users u ON e.user_id = u.id
    ORDER BY e.created_at DESC
  `;
  return await db.getRows(sql, []);
};

// Export events to CSV
exports.exportEventsToCSV = (events) => {
  if (!events || events.length === 0) {
    return 'No events found';
  }

  // CSV Header
  const headers = [
    'ID',
    'Title',
    'Date',
    'Start Time',
    'End Time',
    'Location',
    'Category',
    'Description',
    'Featured',
    'User Name',
    'User Email',
    'User Slug',
    'Created At',
    'Expires At'
  ];

  // CSV Rows
  const rows = events.map(event => {
    const escapeCSV = (value) => {
      if (value === null || value === undefined) return '';
      const str = String(value);
      if (str.includes(',') || str.includes('"') || str.includes('\n')) {
        return `"${str.replace(/"/g, '""')}"`;
      }
      return str;
    };

    return [
      escapeCSV(event.id),
      escapeCSV(event.title),
      escapeCSV(event.date ? new Date(event.date).toISOString().split('T')[0] : ''),
      escapeCSV(event.startTime || ''),
      escapeCSV(event.endTime || ''),
      escapeCSV(event.location),
      escapeCSV(event.category),
      escapeCSV(event.description ? event.description.replace(/\n/g, ' ') : ''),
      escapeCSV(event.isFeatured ? 'Yes' : 'No'),
      escapeCSV(event.userFullName || event.user_full_name),
      escapeCSV(event.userEmail || event.user_email),
      escapeCSV(event.userSlug || event.user_slug),
      escapeCSV(event.createdAt ? new Date(event.createdAt).toISOString() : ''),
      escapeCSV(event.expiresAt ? new Date(event.expiresAt).toISOString() : '')
    ].join(',');
  });

  return [headers.join(','), ...rows].join('\n');
};
