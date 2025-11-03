const db = require("../db");
const CustomError = require("../model/CustomError");
const { removeImages, generatePostCreationContent, ifAdmin } = require("../others/util");
const { sendMail } = require("./sendMail");
const userService = require("./user");

exports.sendPostCreationEmail = async (userId, clientUrl) => {
  // find friends & send notification email to friends
  const [friends, user] = await Promise.all([
    userService.getFriendsWSettings(userId),
    userService.getUserById(userId),
  ]);
  // Generate email and send emails in parallel
  const sendEmailPromises = friends
    .filter((friend) => friend.emailNewEventNotification)
    .map(async (friend) => {
      const to = friend.email;
      const subject = `${user.fullName} has added an event to WayzAway!`;
      const html = generatePostCreationContent(user, "add", clientUrl);
      return sendMail(to, subject, html);
    });
  // Wait for all emails to be sent
  return Promise.all(sendEmailPromises);
};

exports.sendPostEditEmail = async (userId, clientUrl) => {
  // find friends & send notification email to friends
  const [friends, user] = await Promise.all([
    userService.getFriendsWSettings(userId),
    userService.getUserById(userId),
  ]);
  // Generate email and send emails in parallel
  const sendEmailPromises = friends
    .filter((friend) => friend.emailUpdateEventNotification)
    .map(async (friend) => {
      const to = friend.email;
      const subject = `${user.fullName} has edited an event to WayzAway!`;
      const html = generatePostCreationContent(user, "edit", clientUrl);
      return sendMail(to, subject, html);
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
    currentDate,
  ];

  const event = await db.getRow(sql, values);
  
  if (!event) {
    return null;
  }
  return event;
};

exports.save = async (body, files, userId, clientUrl) => {
  const fileNames = JSON.stringify(files ? files.map((file) => file.filename) : [])
  const eventDate = new Date(body.date).toISOString().split("T")[0];
  const sql = `
    INSERT INTO event_post (title, date, start_time, end_time, location, description, category, images, is_featured, user_id, created_at) 
    VALUES ($1, $2, $3, $4, $5, $6, $7, $8::jsonb, $9, $10, $11)
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
  ];

  const event = await db.getRow(sql, values);
  
  if (!event) {
    return null;
  }

  exports.sendPostCreationEmail(userId, "add", clientUrl);
  return event;
};

exports.edit = async (body, files, userId, clientUrl) => {
  const fileNames =
    files ? files.map((file) => file.filename) : []

  const images = body.images ? JSON.parse(body.images) : [];
  const combinedImages = [...images, ...fileNames];

  const eventDate = new Date(body.date).toISOString().split("T")[0];
  let sql = `
    UPDATE event_post 
    SET title=$1, date=$2, start_time=$3, end_time=$4, location=$5, description=$6, category=$7, images=$8::jsonb
    WHERE id=$9 RETURNING *
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
    body.id
  ];

  const result = await db.getRow(sql, values);
  exports.sendPostEditEmail(userId, "edit", clientUrl);
  
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
    SELECT e.*, c.full_name, c.image, c.slug
    FROM event_post e
    JOIN (
      SELECT user_id_1 as friendId
      FROM friendship
      WHERE user_id_2 = $1
      UNION
      SELECT user_id_2 as friendId
      FROM friendship
      WHERE user_id_1 = $2
      UNION
      SELECT $3 as friendId
    ) as friends ON e.user_id = friends.friendId
    JOIN users c ON e.user_id = c.id
    ORDER BY ${getSortingColumn(sort)}
    LIMIT $4 OFFSET $5
  `;
  const results = await db.getRows(sql, [userId, userId, userId, itemsPerPage, offset]);
  // Parse the images field for each record
  return results
};

exports.findWallEvents = async ({
  userId,
  searchKeyword,
  startDate,
  endDate,
  category,
  sort = "LATEST",
  page = 1,
}) => {
  const itemsPerPage = 10;
  const offset = (page - 1) * itemsPerPage;
  const values = [];
  let sql = `
    SELECT e.*, c.full_name, c.image, c.slug
    FROM event_post e
    JOIN users c ON e.user_id = c.id
    WHERE e.user_id = $1
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
  page = 1,
}) => {
  const itemsPerPage = 10;
  const offset = (page - 1) * itemsPerPage;
  const values = [];

  let sql = `
    SELECT e.*, c.full_name, c.image, c.slug 
    FROM event_post e 
    JOIN (
      SELECT user_id_1 as friendId 
      FROM friendship 
      WHERE user_id_2 = $1
      UNION 
      SELECT user_id_2 as friendId 
      FROM friendship 
      WHERE user_id_1 = $2
      UNION 
      SELECT $3 as friendId
    ) as friends ON e.user_id = friends.friendId
    JOIN users c ON e.user_id = c.id
  `;

  values.push(userId, userId, userId);
  let paramIndex2 = 4;

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

exports.getEvent = async (eventId) => {
  const sql = `
    SELECT e.*, c.full_name, c.image, c.slug 
    FROM event_post e 
    JOIN users c ON e.user_id = c.id 
    WHERE e.id = $1
  `;
  const result = await db.getRow(sql, [eventId]);
  if (!result) {
    return null;
  }

  return result;
};

exports.getCommentsByEventId = (eventId) => {
  const sql = `
    SELECT ec.id, ec.user_id, ec.text, ec.created_at, u.full_name, u.image, u.slug 
    FROM event_comment ec 
    JOIN users u ON ec.user_id = u.id 
    WHERE ec.event_id = $1 
    ORDER BY ec.created_at DESC
  `;
  return db.getRows(sql, [eventId]);
};

exports.addComment = async (newComment, userId) => {
  const sql = `
    INSERT INTO event_comment (event_id, user_id, text, created_at) 
    VALUES ($1, $2, $3, $4)
    RETURNING *
  `;
  const values = [newComment.eventId, userId, newComment.text, new Date()];
  return await db.getRow(sql, values);
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

exports.getFavoriteEvents = async (userId, page = 1) => {
  const itemsPerPage = 10;
  const offset = (page - 1) * itemsPerPage;
  const sql = `
    SELECT e.*, c.full_name, c.image 
    FROM event_post e 
    JOIN event_favorite ef ON e.id = ef.event_id 
    JOIN users c ON c.id = e.user_id 
    WHERE ef.user_id = $1 
    ORDER BY ef.created_at DESC 
    LIMIT $2 OFFSET $3
  `;
  return db.getRows(sql, [userId, itemsPerPage, offset]);
};

exports.isFavorite = async (eventId, userId) => {
  const sql = `SELECT id FROM event_favorite WHERE event_id = $1 AND user_id = $2`;
  const result = await db.getRow(sql, [eventId, userId]);
  return !!result;
};

// wishlist-specific functions moved to wishlist service

// wishlist-specific functions moved to wishlist service

// wishlist-specific functions moved to wishlist service

// wishlist-specific functions moved to wishlist service

exports.switchFavoriteEvent = async (eventId, payload, userId) => {
  const sql = `SELECT * FROM event_favorite WHERE user_id = $1 AND event_id = $2`;
  const res = await db.getRow(sql, [userId, eventId]);
  let sql2 = "";
  const values = [];
  if (res && res.id && payload == "false") {
    // entry found and payload is false, so remove from db
    sql2 = `DELETE FROM event_favorite WHERE id = $1`;
    values.push(res.id);
  } else if (!res && payload == "true") {
    // entry not found and payload is true, so insert
    sql2 = `INSERT INTO event_favorite(user_id, event_id, created_at) VALUES ($1, $2, $3)`;
    values.push(userId, eventId);
    values.push(new Date());
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
      .filter((friendId) => friendId != null && friendId !== '')
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
  const sql = `SELECT * FROM event_post WHERE user_id = $1 AND is_featured = true`;
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

exports.swichFeaturedEvent = async (payload, newEventId, oldEventId, userId) => {
  const updatePromises = [
    exports.updateFeaturedEvent(payload, newEventId, userId),
  ];

  if (oldEventId) {
    updatePromises.push(
      exports.updateFeaturedEvent(!payload, oldEventId, userId),
    );
  }

  await Promise.all(updatePromises);
  return JSON.parse(payload);
};

exports.setEventNotification = (eventId, payload) => {
  const sql = `UPDATE event_post SET new_notification = $1 WHERE id = $2`;
  return db.execute(sql, [JSON.parse(payload), eventId]);
};
