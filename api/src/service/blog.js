const db = require("../db");
const { removeImages } = require("../others/util");

exports.saveBlog = (body, files, userId) => {
  const sql =
    "INSERT INTO blog_post (title, description, image, user_id, created_at) VALUES (?, ?, ?, ?, ?);";
  const values = [
    body.title,
    body.description,
    files ? files[0].filename : null,
    userId,
    new Date(),
  ];

  return db.execute(sql, values).then((result) => {
    const sql2 = "SELECT * FROM blog_post WHERE id = ?;";
    return db.getRow(sql2, [result.insertId]);
  });
};

exports.getBlogs = () => {
  const sql =
    "select b.* from blog_post b join cuser c on b.user_id = c.id order by b.id desc";
  return db.getRows(sql, []);
};

exports.editBlog = (body, files) => {
  let sql = "";
  let values = [];
  if (files) {
    sql =
      "UPDATE blog_post SET title = $1, description = $2, image = $3 WHERE id = $4";
    values = [
      body.title,
      body.description,
      files ? files[0].filename : null,
      body.id,
    ];
  } else {
    sql = "UPDATE blog_post SET title = $1, description = $2 WHERE id = $3";
    values = [body.title, body.description, body.id];
  }

  return db.execute(sql, values).then((result) => {
    if (!result) throw new Error();
    const sql = "SELECT * FROM blog_post WHERE id = ?;";

    if (body.rmImage) {
      return Promise.all([
        db.getRow(sql, [body.id]),
        removeImages([body.rmImage]),
      ]).then((results) => results[0]);
    }
    return db.getRow(sql, [body.id]);
  });
};

exports.deleteBlog = (blogId, rmImage) => {
  const sql = "delete from blog_post where id = $1";
  return db.execute(sql, [blogId]).then(async (result) => {
    if (rmImage) await removeImages([rmImage]);
    return result;
  });
};

exports.getBlog = (blogId) => {
  const sql =
    "select b.* from blog_post b join cuser c on b.user_id = c.id where b.id = $1";
  return db.getRow(sql, [blogId]);
};
