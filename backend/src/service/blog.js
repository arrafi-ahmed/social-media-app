const db = require("../db");
const CustomError = require("../model/CustomError");
const { removeImages } = require("../others/util");

exports.saveBlog = (body, files, userId) => {
  const sql = `
    INSERT INTO blog_post (title, description, image, user_id, created_at) 
    VALUES ($1, $2, $3, $4, $5)
  `;
  const values = [
    body.title,
    body.description,
    files ? files[0].filename : null,
    userId,
    new Date(),
  ];

  return db.getRow(sql + ' RETURNING *', values);
};

exports.getBlogs = () => {
  const sql = `
    SELECT b.* 
    FROM blog_post b 
    JOIN users c ON b.user_id = c.id 
    ORDER BY b.id DESC
  `;
  return db.getRows(sql, []);
};

exports.editBlog = async (body, files) => {
  let sql = "";
  let values = [];
  if (files) {
    sql = `
      UPDATE blog_post 
      SET title = $1, description = $2, image = $3 
      WHERE id = $4
      RETURNING *
    `;
    values = [
      body.title,
      body.description,
      files ? files[0].filename : null,
      body.id,
    ];
  } else {
    sql = `UPDATE blog_post SET title = $1, description = $2 WHERE id = $3 RETURNING *`;
    values = [body.title, body.description, body.id];
  }

  const updated = await db.getRow(sql, values);
  if (!updated) {
    throw new CustomError("Blog update failed!", 500);
  }
  if (body.rmImage) {
    await removeImages([body.rmImage]);
  }
  return updated;
};

exports.deleteBlog = async (blogId, rmImage) => {
  const sql = `DELETE FROM blog_post WHERE id = $1`;
  const result = await db.execute(sql, [blogId]);
  if (rmImage) {
    await removeImages([rmImage]);
  }
  return result;
};

exports.getBlog = (blogId) => {
  const sql = `
    SELECT b.* 
    FROM blog_post b 
    JOIN users c ON b.user_id = c.id 
    WHERE b.id = $1
  `;
  return db.getRow(sql, [blogId]);
};
