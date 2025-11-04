const db = require("../db");
const { removeImages } = require("../others/util");

exports.deleteEvent = async (eventId, userId, userRole) => {
  // Admin can delete any; users can only delete their own
  let sql = `DELETE FROM event_wishlist WHERE id = $1`;
  const values = [eventId];
  if (!(userRole && (userRole === "admin" || userRole === "super"))) {
    sql += ` AND user_id = $2`;
    values.push(userId);
  }
  return await db.execute(sql, values);
};

exports.getEvents = async (userId, page = 1) => {
  const itemsPerPage = 10;
  const offset = (page - 1) * itemsPerPage;
  const sql = `
    SELECT * FROM event_wishlist 
    WHERE user_id = $1 
    ORDER BY created_at DESC 
    LIMIT $2 OFFSET $3
  `;
  return db.getRows(sql, [userId, itemsPerPage, offset]);
};

exports.getEvent = async (eventId) => {
  const sql = `
    SELECT ew.*, c.full_name, c.image 
    FROM event_wishlist ew 
    JOIN users c ON ew.user_id = c.id 
    WHERE ew.id = $1
  `;
  return db.getRow(sql, [eventId]);
};

exports.save = async (body, files, userId) => {
  const { title, location, description, category } = body;
  const sql = `
    INSERT INTO event_wishlist (title, location, description, category, user_id, created_at, images) 
    VALUES ($1, $2, $3, $4, $5, $6, $7::jsonb)
    RETURNING *
  `;
  const fileNames = JSON.stringify(files ? files.map((file) => file.filename) : []);
  const values = [
    title,
    location,
    description,
    category,
    userId,
    new Date(),
    fileNames
  ];
  return await db.getRow(sql, values);
};

exports.edit = async (body, files, userId) => {
  const fileNames =
    files ? files.map((file) => file.filename) : [];

  const images = body.images ? JSON.parse(body.images) : [];
  const combinedImages = [...images, ...fileNames];

  let sql = `
    UPDATE event_wishlist 
    SET title=$1, location=$2, description=$3, category=$4, images=$5::jsonb
    WHERE id=$6 RETURNING *`;

  const values = [
    body.title,
    body.location,
    body.description,
    body.category,
    JSON.stringify(combinedImages),
    body.id
  ];

  const result = await db.getRow(sql, values);

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




