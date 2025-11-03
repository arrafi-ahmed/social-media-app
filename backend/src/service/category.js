const db = require("../db");

exports.getCategories = () => {
  const sql = `SELECT * FROM event_category ORDER BY id DESC`;
  return db.getRows(sql, []);
};

exports.saveCategory = (body) => {
  const sql = `INSERT INTO event_category (name) VALUES ($1) RETURNING *`;
  return db.getRow(sql, [body.name]);
};

exports.editCategory = (body) => {
  const sql = `UPDATE event_category SET name = $1 WHERE id = $2 RETURNING *`;
  return db.getRow(sql, [body.name, body.id]);
};

exports.deleteCategory = (id) => {
  const sql = `DELETE FROM event_category WHERE id = $1`;
  return db.execute(sql, [id]);
};
