const db = require("../db");
const CustomError = require("../model/CustomError");

// Create a new group
exports.createGroup = async (userId, name, description = null, color = null, icon = null) => {
  if (!name || name.trim() === "") {
    throw new CustomError("Group name is required!", 400);
  }

  const sql = `
    INSERT INTO user_group (user_id, name, description, color, icon, created_at)
    VALUES ($1, $2, $3, $4, $5, $6)
    RETURNING *
  `;
  const values = [userId, name.trim(), description, color, icon, new Date()];
  const group = await db.getRow(sql, values);

  // Add creator as owner
  if (group) {
    await exports.addMember(group.id, userId, userId, "owner");
  }

  return group;
};

// Update a group
exports.updateGroup = async (groupId, userId, updates) => {
  // Verify user is owner or admin
  const checkSql = `
    SELECT ug.id, gm.role
    FROM user_group ug
    LEFT JOIN group_member gm ON ug.id = gm.group_id AND gm.user_id = $2
    WHERE ug.id = $1 AND (ug.user_id = $2 OR gm.role IN ('owner', 'admin'))
  `;
  const check = await db.getRow(checkSql, [groupId, userId]);
  if (!check) {
    throw new CustomError("Group not found or access denied!", 404);
  }

  const fields = [];
  const values = [];
  let paramIndex = 1;

  if (updates.name !== undefined) {
    if (!updates.name || updates.name.trim() === "") {
      throw new CustomError("Group name cannot be empty!", 400);
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

  values.push(groupId);
  const sql = `
    UPDATE user_group 
    SET ${fields.join(", ")}
    WHERE id = $${paramIndex++}
    RETURNING *
  `;
  return await db.getRow(sql, values);
};

// Delete a group
exports.deleteGroup = async (groupId, userId) => {
  // Verify ownership
  const checkSql = `SELECT id FROM user_group WHERE id = $1 AND user_id = $2`;
  const group = await db.getRow(checkSql, [groupId, userId]);
  if (!group) {
    throw new CustomError("Group not found or access denied!", 404);
  }

  // Delete the group (cascade will handle members and event_group entries)
  const sql = `DELETE FROM user_group WHERE id = $1 AND user_id = $2`;
  await db.execute(sql, [groupId, userId]);
  return { success: true };
};

// Get all groups for a user (groups they own or are a member of)
exports.getUserGroups = async (userId) => {
  const sql = `
    SELECT DISTINCT
      ug.*,
      gm.role,
      COUNT(DISTINCT gm2.user_id) as member_count,
      COUNT(DISTINCT eg.event_id) as event_count
    FROM user_group ug
    LEFT JOIN group_member gm ON ug.id = gm.group_id AND gm.user_id = $1
    LEFT JOIN group_member gm2 ON ug.id = gm2.group_id
    LEFT JOIN event_group eg ON ug.id = eg.group_id
    WHERE ug.user_id = $1 OR gm.user_id = $1
    GROUP BY ug.id, gm.role
    ORDER BY ug.created_at DESC
  `;
  return await db.getRows(sql, [userId]);
};

// Get group by ID (with membership check)
exports.getGroupById = async (groupId, userId) => {
  const sql = `
    SELECT 
      ug.*,
      gm.role,
      COUNT(DISTINCT gm2.user_id) as member_count,
      COUNT(DISTINCT eg.event_id) as event_count
    FROM user_group ug
    LEFT JOIN group_member gm ON ug.id = gm.group_id AND gm.user_id = $2
    LEFT JOIN group_member gm2 ON ug.id = gm2.group_id
    LEFT JOIN event_group eg ON ug.id = eg.group_id
    WHERE ug.id = $1 AND (ug.user_id = $2 OR gm.user_id = $2)
    GROUP BY ug.id, gm.role
  `;
  const group = await db.getRow(sql, [groupId, userId]);
  if (!group) {
    throw new CustomError("Group not found or access denied!", 404);
  }
  return group;
};

// Add member to group
exports.addMember = async (groupId, userId, memberUserId, role = "member") => {
  // Verify user is owner or admin
  const checkSql = `
    SELECT ug.id, gm.role
    FROM user_group ug
    LEFT JOIN group_member gm ON ug.id = gm.group_id AND gm.user_id = $2
    WHERE ug.id = $1 AND (ug.user_id = $2 OR gm.role IN ('owner', 'admin'))
  `;
  const check = await db.getRow(checkSql, [groupId, userId]);
  if (!check) {
    throw new CustomError("Access denied! Only owners and admins can add members.", 403);
  }

  // Check if member is already in group
  const existingSql = `SELECT id FROM group_member WHERE group_id = $1 AND user_id = $2`;
  const existing = await db.getRow(existingSql, [groupId, memberUserId]);
  if (existing) {
    throw new CustomError("User is already a member of this group!", 400);
  }

  const sql = `
    INSERT INTO group_member (group_id, user_id, role, joined_at)
    VALUES ($1, $2, $3, $4)
    RETURNING *
  `;
  return await db.getRow(sql, [groupId, memberUserId, role, new Date()]);
};

// Remove member from group
exports.removeMember = async (groupId, userId, memberUserId) => {
  // Verify user is owner or admin (or removing themselves)
  const checkSql = `
    SELECT ug.id, gm.role
    FROM user_group ug
    LEFT JOIN group_member gm ON ug.id = gm.group_id AND gm.user_id = $2
    WHERE ug.id = $1 AND (ug.user_id = $2 OR gm.role IN ('owner', 'admin') OR $2 = $3)
  `;
  const check = await db.getRow(checkSql, [groupId, userId, memberUserId]);
  if (!check) {
    throw new CustomError("Access denied!", 403);
  }

  // Don't allow removing the owner
  const ownerCheck = await db.getRow(
    `SELECT role FROM group_member WHERE group_id = $1 AND user_id = $2`,
    [groupId, memberUserId]
  );
  if (ownerCheck && ownerCheck.role === "owner") {
    throw new CustomError("Cannot remove the group owner!", 400);
  }

  const sql = `DELETE FROM group_member WHERE group_id = $1 AND user_id = $2`;
  await db.execute(sql, [groupId, memberUserId]);
  return { success: true };
};

// Get group members
exports.getGroupMembers = async (groupId, userId) => {
  // Verify user is a member
  const checkSql = `
    SELECT ug.id, gm.role
    FROM user_group ug
    LEFT JOIN group_member gm ON ug.id = gm.group_id AND gm.user_id = $2
    WHERE ug.id = $1 AND (ug.user_id = $2 OR gm.user_id = $2)
  `;
  const check = await db.getRow(checkSql, [groupId, userId]);
  if (!check) {
    throw new CustomError("Group not found or access denied!", 404);
  }

  const sql = `
    SELECT 
      gm.*,
      u.full_name,
      u.email,
      u.image,
      u.slug
    FROM group_member gm
    JOIN users u ON gm.user_id = u.id
    WHERE gm.group_id = $1
    ORDER BY 
      CASE gm.role 
        WHEN 'owner' THEN 1 
        WHEN 'admin' THEN 2 
        ELSE 3 
      END,
      gm.joined_at ASC
  `;
  return await db.getRows(sql, [groupId]);
};

// Share event with group
exports.shareEventWithGroup = async (eventId, groupId, userId) => {
  // Verify user is a member of the group
  const checkSql = `
    SELECT ug.id, gm.role
    FROM user_group ug
    LEFT JOIN group_member gm ON ug.id = gm.group_id AND gm.user_id = $2
    WHERE ug.id = $1 AND (ug.user_id = $2 OR gm.user_id = $2)
  `;
  const check = await db.getRow(checkSql, [groupId, userId]);
  if (!check) {
    throw new CustomError("Group not found or access denied!", 404);
  }

  // Verify user owns the event
  const eventCheck = await db.getRow(
    `SELECT user_id FROM event_post WHERE id = $1`,
    [eventId]
  );
  if (!eventCheck || eventCheck.userId !== userId) {
    throw new CustomError("You can only share your own events!", 403);
  }

  // Check if already shared
  const existing = await db.getRow(
    `SELECT id FROM event_group WHERE event_id = $1 AND group_id = $2`,
    [eventId, groupId]
  );
  if (existing) {
    throw new CustomError("Event is already shared with this group!", 400);
  }

  const sql = `
    INSERT INTO event_group (event_id, group_id, shared_by, created_at)
    VALUES ($1, $2, $3, $4)
    RETURNING *
  `;
  return await db.getRow(sql, [eventId, groupId, userId, new Date()]);
};

// Unshare event from group
exports.unshareEventFromGroup = async (eventId, groupId, userId) => {
  // Verify user owns the event
  const eventCheck = await db.getRow(
    `SELECT user_id FROM event_post WHERE id = $1`,
    [eventId]
  );
  if (!eventCheck || eventCheck.userId !== userId) {
    throw new CustomError("You can only unshare your own events!", 403);
  }

  const sql = `DELETE FROM event_group WHERE event_id = $1 AND group_id = $2`;
  await db.execute(sql, [eventId, groupId]);
  return { success: true };
};

// Get events by group
exports.getEventsByGroup = async (groupId, userId, page = 1) => {
  const itemsPerPage = 10;
  const offset = (page - 1) * itemsPerPage;

  // Verify user is a member
  const checkSql = `
    SELECT ug.id, gm.role
    FROM user_group ug
    LEFT JOIN group_member gm ON ug.id = gm.group_id AND gm.user_id = $2
    WHERE ug.id = $1 AND (ug.user_id = $2 OR gm.user_id = $2)
  `;
  const check = await db.getRow(checkSql, [groupId, userId]);
  if (!check) {
    throw new CustomError("Group not found or access denied!", 404);
  }

  const sql = `
    SELECT 
      e.*,
      c.full_name,
      c.image,
      c.slug
    FROM event_post e
    JOIN event_group eg ON e.id = eg.event_id
    JOIN users c ON e.user_id = c.id
    WHERE eg.group_id = $1
      AND (e.expires_at IS NULL OR e.expires_at > NOW())
    ORDER BY e.created_at DESC
    LIMIT $2 OFFSET $3
  `;
  return await db.getRows(sql, [groupId, itemsPerPage, offset]);
};

// Get groups for an event
exports.getGroupsForEvent = async (eventId, userId) => {
  // Verify user owns the event or is a member of groups
  const sql = `
    SELECT 
      ug.*,
      gm.role,
      COUNT(DISTINCT gm2.user_id) as member_count
    FROM event_group eg
    JOIN user_group ug ON eg.group_id = ug.id
    LEFT JOIN group_member gm ON ug.id = gm.group_id AND gm.user_id = $2
    LEFT JOIN group_member gm2 ON ug.id = gm2.group_id
    WHERE eg.event_id = $1
      AND (eg.shared_by = $2 OR gm.user_id = $2)
    GROUP BY ug.id, gm.role
    ORDER BY ug.name ASC
  `;
  return await db.getRows(sql, [eventId, userId]);
};

