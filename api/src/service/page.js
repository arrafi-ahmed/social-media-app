const db = require("../db");

exports.getPage = (pageName) => {
  const sql = "select * from pages where name = $1";
  return db.getRow(sql, [pageName]);
};

exports.updatePage = (body) => {
  const sql = "select * from pages where name = $1";
  return db.getRow(sql, [body.pageName]).then((result) => {
    if (result) {
      const sql =
        "update pages set title = $1, description = $2 where name = $3;";
      return db
        .execute(sql, [body.title, body.description, body.pageName])
        .then((result) => {
          if (!result) throw new Error();
          const sql = "select * from pages where id = $1;";
          return db.getRow(sql, [body.id]);
        });
    } else {
      const sql =
        "insert into pages (title, description, name) values($1, $2, $3);";
      return db
        .execute(sql, [body.title, body.description, body.pageName])
        .then((result) => {
          const sql2 = "SELECT * FROM pages WHERE id = ?;";
          return db.getRow(sql2, [result.insertId]).then((result) => {
            return result;
          });
        });
    }
  });
};
