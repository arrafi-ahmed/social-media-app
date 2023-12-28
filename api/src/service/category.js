const db = require("../db");

exports.getCategories = () => {
  const sql = "select * from event_category order by id desc";
  return db.getRows(sql, []);
};

exports.saveCategory = (body) => {
  const sql = "INSERT INTO event_category (name) VALUES (?);";
  return db.execute(sql, [body.name]).then((result) => {
    const sql2 = "SELECT * FROM event_category WHERE id = ?;";
    return db.getRow(sql2, [result.insertId]);
  });
};

exports.editCategory = (body) => {
  const sql = "update event_category set name = $1 where id = $2";
  return db.getRow(sql, [body.name, body.id]);
};

exports.deleteCategory = (id) => {
  const sql = "delete from event_category where id = $1";
  return db.execute(sql, [id]);
};
