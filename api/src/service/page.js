const db = require("../db");
const { removeImages } = require("../others/util");

exports.getPage = (pageName) => {
  const sql = "select * from pages where name = $1";
  return db.getRow(sql, [pageName]);
};

exports.updatePage = async (body, files) => {
  const sql = "select * from pages where name = $1";

  if (body.pageName === "landing") {
    const descriptionInit = JSON.parse(body.descriptionInit);
    let description = JSON.parse(body.description);
    const rmImages = [];

    let fileMarker = 0;

    //find new uploads and rmImages
    description.forEach((item, index) => {
      if (item.image && typeof item.image === "object") {
        // if obj = {}, set to null, for converting obj -> str properly
        if (Object.keys(item).length === 0) {
          description[index].image = null;
        }
        //new upload
        if (files && fileMarker < files.length) {
          description[index].image = files[fileMarker].filename;
          if (descriptionInit[index].image)
            rmImages.push(descriptionInit[index].image);
          fileMarker++;
        }
      }
    });

    body.description = JSON.stringify(description);
    if (rmImages && rmImages.length > 0) await removeImages(rmImages);
  }
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
