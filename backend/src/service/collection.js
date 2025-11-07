const db = require("../db");
const CustomError = require("../model/CustomError");

// Create a new collection
exports.createCollection = async (userId, name, description = null, color = null, icon = null) => {
  if (!name || name.trim() === "") {
    throw new CustomError("Collection name is required!", 400);
  }

  const sql = `
    INSERT INTO event_collection (user_id, name, description, color, icon, created_at, updated_at)
    VALUES ($1, $2, $3, $4, $5, $6, $7)
    RETURNING *
  `;
  const now = new Date();
  const values = [userId, name.trim(), description, color, icon, now, now];
  return await db.getRow(sql, values);
};

// Update a collection
exports.updateCollection = async (collectionId, userId, updates) => {
  // Verify ownership
  const checkSql = `SELECT id FROM event_collection WHERE id = $1 AND user_id = $2`;
  const collection = await db.getRow(checkSql, [collectionId, userId]);
  if (!collection) {
    throw new CustomError("Collection not found or access denied!", 404);
  }

  const fields = [];
  const values = [];
  let paramIndex = 1;

  if (updates.name !== undefined) {
    if (!updates.name || updates.name.trim() === "") {
      throw new CustomError("Collection name cannot be empty!", 400);
    }
    fields.push(`name = $${paramIndex++}`);
    values.push(updates.name.trim());
  }
  if (updates.description !== undefined) {
    fields.push(`description = $${paramIndex++}`);
    values.push(updates.description);
  }
  if (updates.color !== undefined) {
    fields.push(`color = $${paramIndex++}`);
    values.push(updates.color);
  }
  if (updates.icon !== undefined) {
    fields.push(`icon = $${paramIndex++}`);
    values.push(updates.icon);
  }

  if (fields.length === 0) {
    throw new CustomError("No fields to update!", 400);
  }

  // Always update updated_at
  fields.push(`updated_at = $${paramIndex++}`);
  values.push(new Date());

  values.push(collectionId, userId);
  const sql = `
    UPDATE event_collection 
    SET ${fields.join(", ")}
    WHERE id = $${paramIndex++} AND user_id = $${paramIndex++}
    RETURNING *
  `;
  return await db.getRow(sql, values);
};

// Delete a collection
exports.deleteCollection = async (collectionId, userId) => {
  // Verify ownership
  const checkSql = `SELECT id FROM event_collection WHERE id = $1 AND user_id = $2`;
  const collection = await db.getRow(checkSql, [collectionId, userId]);
  if (!collection) {
    throw new CustomError("Collection not found or access denied!", 404);
  }

  // Delete all events from this collection (event_collection_item entries)
  const deleteEventsSql = `DELETE FROM event_collection_item WHERE collection_id = $1 AND user_id = $2`;
  await db.execute(deleteEventsSql, [collectionId, userId]);

  // Delete the collection
  const sql = `DELETE FROM event_collection WHERE id = $1 AND user_id = $2`;
  const result = await db.execute(sql, [collectionId, userId]);
  return result;
};

// Get all collections for a user
exports.getUserCollections = async (userId) => {
  const sql = `
    SELECT 
      ec.*,
      COUNT(ef.id) as event_count
    FROM event_collection ec
      LEFT JOIN event_collection_item ef ON ec.id = ef.collection_id AND ef.user_id = $1
    WHERE ec.user_id = $1
    GROUP BY ec.id
    ORDER BY ec.created_at DESC
  `;
  return await db.getRows(sql, [userId]);
};

// Get a single collection with events count
exports.getCollection = async (collectionId, userId) => {
  const sql = `
    SELECT 
      ec.*,
      COUNT(ef.id) as event_count
    FROM event_collection ec
    LEFT JOIN event_collection_item ef ON ec.id = ef.collection_id AND ef.user_id = $2
    WHERE ec.id = $1 AND ec.user_id = $2
    GROUP BY ec.id
  `;
  return await db.getRow(sql, [collectionId, userId]);
};

// Get events in a collection
exports.getCollectionEvents = async (collectionId, userId, page = 1) => {
  const itemsPerPage = 10;
  const offset = (page - 1) * itemsPerPage;

  // Verify collection ownership
  const collection = await this.getCollection(collectionId, userId);
  if (!collection) {
    throw new CustomError("Collection not found or access denied!", 404);
  }

  const sql = `
    SELECT e.*, c.full_name, c.image 
    FROM event_post e 
    JOIN event_collection_item ef ON e.id = ef.event_id 
    JOIN users c ON c.id = e.user_id 
    WHERE ef.user_id = $1 
      AND ef.collection_id = $2 
      AND (e.expires_at IS NULL OR e.expires_at > NOW())
    ORDER BY ef.created_at DESC 
    LIMIT $3 OFFSET $4
  `;
  return await db.getRows(sql, [userId, collectionId, itemsPerPage, offset]);
};

// Get all saved events (uncategorized - collection_id IS NULL)
exports.getAllSavedEvents = async (userId, page = 1) => {
  const itemsPerPage = 10;
  const offset = (page - 1) * itemsPerPage;
  const sql = `
    SELECT e.*, c.full_name, c.image 
    FROM event_post e 
    JOIN event_collection_item ef ON e.id = ef.event_id 
    JOIN users c ON c.id = e.user_id 
    WHERE ef.user_id = $1 
      AND ef.collection_id IS NULL
      AND (e.expires_at IS NULL OR e.expires_at > NOW())
    ORDER BY ef.created_at DESC 
    LIMIT $2 OFFSET $3
  `;
  return await db.getRows(sql, [userId, itemsPerPage, offset]);
};

// Get events from all collections (for "All" view)
exports.getAllCollectionsEvents = async (userId, page = 1) => {
  const itemsPerPage = 10;
  const offset = (page - 1) * itemsPerPage;
  const sql = `
    SELECT e.*, c.full_name, c.image 
    FROM event_post e 
    JOIN event_collection_item ef ON e.id = ef.event_id 
    JOIN users c ON c.id = e.user_id 
    WHERE ef.user_id = $1 
      AND (e.expires_at IS NULL OR e.expires_at > NOW())
    ORDER BY ef.created_at DESC 
    LIMIT $2 OFFSET $3
  `;
  return await db.getRows(sql, [userId, itemsPerPage, offset]);
};

