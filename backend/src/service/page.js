const db = require("../db");
const CustomError = require("../model/CustomError");
const { removeImages } = require("../others/util");

exports.getPage = (pageName) => {
  const sql = `SELECT * FROM pages WHERE name = $1`;
  return db.getRow(sql, [pageName]);
};

function safeJsonParse(value, fallback) {
  try {
    if (value == null || value === "") return fallback;
    // If value is already an object (from JSON column), return it directly
    if (typeof value === "object") return value;
    // If value is a string, parse it
    return JSON.parse(value);
  } catch (e) {
    return fallback;
  }
}

exports.updatePage = async (body, files) => {
  const sql = `SELECT * FROM pages WHERE name = $1`;

  // Convert description to consistent object format for all pages
  if (body.pageName === "landing") {
    // const descriptionInit = safeJsonParse(body.descriptionInit, []);
    const description = safeJsonParse(body.description, []);
    const updatingLandingImages = JSON.parse(body.updatingLandingImages);
    const rmImages = [];

    if (updatingLandingImages?.length > 0) {
      updatingLandingImages.forEach((item, index) => {
        if (item) {
          let parsedItem = item;
          // Only parse if item is a string, otherwise it's already an object
          if (typeof item === "string") {
            try {
              parsedItem = JSON.parse(item);
              updatingLandingImages[index] = parsedItem;
            } catch (e) {
              console.error("Failed to parse updatingLandingImages item:", e);
              return; // Skip this item if parsing fails
            }
          }

          if (parsedItem.rmImage) {
            rmImages.push(parsedItem.rmImage);
          }
          if (parsedItem.newImage && parsedItem.index !== undefined) {
            const foundUploadedNewImage = files.find(file => file.originalname === parsedItem.newImage);
            if (foundUploadedNewImage && description[parsedItem.index]) {
              description[parsedItem.index].image = foundUploadedNewImage.filename;
            }
          }
        }
      });
    }

    // Store description as object for database insertion (PostgreSQL will handle JSON conversion)
    body.description = description;
    if (rmImages && rmImages.length > 0) {
      await removeImages(rmImages);
    }
  } else {
    // For other pages (about/terms/privacy), convert string to minimal object
    body.description = {
      content: body.description || ""
    };
  }
  const result = await db.getRow(sql, [body.pageName]);

  // Convert description to JSON string for PostgreSQL JSONB column
  const descriptionJson = typeof body.description === 'string' 
    ? body.description 
    : JSON.stringify(body.description);

  if (result) {
    const updateSql = `
      UPDATE pages 
      SET title = $1, description = $2::jsonb 
      WHERE name = $3
      RETURNING *
    `;
    const row = await db.getRow(updateSql, [body.title, descriptionJson, body.pageName]);
    if (!row) {
      throw new CustomError("Page update failed!", 500);
    }
    return row;
  } else {
    const insertSql = `
      INSERT INTO pages (title, description, name) 
      VALUES ($1, $2::jsonb, $3)
      RETURNING *
    `;
    return await db.getRow(insertSql, [body.title, descriptionJson, body.pageName]);
  }
};
