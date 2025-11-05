const db = require("../db");
const CustomError = require("../model/CustomError");

// Parse mentions from comment text
// Supports formats: @username, @Full Name, @John Doe
// Stops at first space after the mention name
exports.parseMentions = (text) => {
  if (!text || typeof text !== 'string') {
    return [];
  }

  // Match @mentions - supports @username, @Full Name, @John Doe
  // Pattern: @ followed by word characters, spaces, or hyphens
  // Stops at first space after the name (non-greedy)
  const mentionPattern = /@([\w\s-]+?)(?=\s|$)/g;
  const matches = [];
  let match;

  while ((match = mentionPattern.exec(text)) !== null) {
    const mentionText = match[1].trim();
    if (mentionText.length > 0) {
      matches.push(mentionText);
    }
  }

  // Remove duplicates
  return [...new Set(matches)];
};

// Find user IDs from mention text
// Supports matching by slug, full_name, or email
exports.findMentionedUsers = async (mentionTexts) => {
  if (!mentionTexts || mentionTexts.length === 0) {
    return [];
  }

  const userIds = [];
  
  // Search for each mention
  for (const mentionText of mentionTexts) {
    // Try to match by slug first (exact match)
    let sql = `
      SELECT id FROM users 
      WHERE LOWER(slug) = LOWER($1)
      LIMIT 1
    `;
    let user = await db.getRow(sql, [mentionText]);
    
    // If not found by slug, try matching by full_name (case-insensitive, partial match)
    if (!user) {
      sql = `
        SELECT id FROM users 
        WHERE LOWER(full_name) LIKE LOWER($1)
        LIMIT 1
      `;
      user = await db.getRow(sql, [`%${mentionText}%`]);
    }
    
    // If still not found, try exact match on full_name
    if (!user) {
      sql = `
        SELECT id FROM users 
        WHERE LOWER(TRIM(full_name)) = LOWER(TRIM($1))
        LIMIT 1
      `;
      user = await db.getRow(sql, [mentionText]);
    }
    
    if (user && user.id) {
      userIds.push(user.id);
    }
  }

  // Remove duplicates
  return [...new Set(userIds)];
};

// Save mentions to database
exports.saveMentions = async (commentId, mentionedUserIds) => {
  if (!mentionedUserIds || mentionedUserIds.length === 0) {
    return [];
  }

  const savedMentions = [];
  
  for (const userId of mentionedUserIds) {
    try {
      const sql = `
        INSERT INTO comment_mention (comment_id, mentioned_user_id, created_at)
        VALUES ($1, $2, $3)
        ON CONFLICT (comment_id, mentioned_user_id) DO NOTHING
        RETURNING *
      `;
      const mention = await db.getRow(sql, [commentId, userId, new Date()]);
      if (mention) {
        savedMentions.push(mention);
      }
    } catch (error) {
      // Ignore individual mention errors, continue with others
      console.error(`Error saving mention for user ${userId}:`, error);
    }
  }

  return savedMentions;
};

// Get mentions for a comment
exports.getCommentMentions = async (commentId) => {
  const sql = `
    SELECT 
      cm.id,
      cm.mentioned_user_id,
      u.full_name,
      u.slug,
      u.image
    FROM comment_mention cm
    JOIN users u ON cm.mentioned_user_id = u.id
    WHERE cm.comment_id = $1
    ORDER BY cm.created_at ASC
  `;
  const mentions = await db.getRows(sql, [commentId]);
  
  // Format to match getCommentsMentions format
  return mentions.map(mention => ({
    id: mention.id,
    userId: mention.mentioned_user_id || mention.mentionedUserId,
    fullName: mention.full_name || mention.fullName,
    slug: mention.slug,
    image: mention.image
  }));
};

// Get all mentions for multiple comments (for batch loading)
exports.getCommentsMentions = async (commentIds) => {
  if (!commentIds || commentIds.length === 0) {
    return {};
  }

  const placeholders = commentIds.map((_, index) => `$${index + 1}`).join(',');
  const sql = `
    SELECT 
      cm.comment_id,
      cm.id,
      cm.mentioned_user_id,
      u.full_name,
      u.slug,
      u.image
    FROM comment_mention cm
    JOIN users u ON cm.mentioned_user_id = u.id
    WHERE cm.comment_id IN (${placeholders})
    ORDER BY cm.comment_id, cm.created_at ASC
  `;
  const mentions = await db.getRows(sql, commentIds);
  
  // Group by comment_id
  // Handle both camelCase (from db.js conversion) and snake_case
  const grouped = {};
  mentions.forEach(mention => {
    // db.js converts comment_id to commentId, so use commentId
    const commentId = mention.commentId || mention.comment_id;
    if (!commentId) {
      console.warn('Mention missing commentId:', mention);
      return;
    }
    
    // Ensure consistent key type (use number for IDs)
    const key = Number(commentId) || commentId;
    
    if (!grouped[key]) {
      grouped[key] = [];
    }
    grouped[key].push({
      id: mention.id,
      userId: mention.mentionedUserId || mention.mentioned_user_id,
      fullName: mention.fullName || mention.full_name,
      slug: mention.slug,
      image: mention.image
    });
  });
  
  return grouped;
};

