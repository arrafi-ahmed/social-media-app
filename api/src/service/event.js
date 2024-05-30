const db = require("../db");
const { removeImages, generatePostCreationContent } = require("../others/util");
const userService = require("./user");
const { sendMail } = require("./sendMail");

exports.sendPostCreationEmail = async (userId, clientUrl) => {
  // find friends & send notification email to friends
  const [friends, user] = await Promise.all([
    userService.getFriendsWSettings(userId),
    userService.getUserById(userId),
  ]);
  // Generate email and send emails in parallel
  const sendEmailPromises = friends
    .filter((friend) => friend.email_new_event_notification)
    .map(async (friend) => {
      const to = friend.email;
      const subject = `${user.full_name} has added an event to WayzAway!`;
      const html = generatePostCreationContent(user, "add", clientUrl);
      return sendMail(to, subject, html);
    });
  // Wait for all emails to be sent
  return Promise.all(sendEmailPromises);
};

exports.sendPostEditEmail = async (userId, clientUrl) => {
  // find friends & send notification email to friends
  const [friends, user] = await Promise.all([
    userService.getFriendsWSettings(userId),
    userService.getUserById(userId),
  ]);
  // Generate email and send emails in parallel
  const sendEmailPromises = friends
    .filter((friend) => friend.email_update_event_notification)
    .map(async (friend) => {
      const to = friend.email;
      const subject = `${user.full_name} has edited an event to WayzAway!`;
      const html = generatePostCreationContent(user, "edit", clientUrl);
      return sendMail(to, subject, html);
    });
  // Wait for all emails to be sent
  return Promise.all(sendEmailPromises);
};

exports.saveEvent = (body, files, userId, clientUrl) => {
  const fileNames = JSON.stringify(
    files ? files.map((file) => file.filename) : []
  );
  const eventDate = new Date(body.date).toISOString().split("T")[0];
  const sql =
    "INSERT INTO event_post (title, date, start_time, end_time, location, description, category, images," +
    " is_featured, user_id, created_at) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11)";
  const values = [
    body.title,
    eventDate,
    body.start_time,
    body.end_time,
    body.location,
    body.description,
    body.category,
    fileNames,
    JSON.parse(body.is_featured),
    userId,
    new Date(),
  ];

  return db
    .execute(sql, values)
    .then(async (result) => {
      exports.sendPostCreationEmail(userId, "add", clientUrl);

      // return inserted event
      const sql2 = "SELECT * FROM event_post WHERE id = ?;";
      return db.getRow(sql2, [result.insertId]);
    })
    .then((result) => {
      if (!result) return null;
      result.images = JSON.parse(result.images);
      return result;
    });
};

exports.editEvent = (body, files, userId, clientUrl) => {
  const newUploads = JSON.parse(body.newUploads);

  let filesArrIndex = 0;
  newUploads.forEach((item, index) => {
    if (item === "new") {
      if (files[filesArrIndex] && files[filesArrIndex].filename) {
        newUploads[index] = files[filesArrIndex].filename;
        filesArrIndex++;
      }
    }
  });

  const filteredUploads = newUploads.filter((item) => item !== null);
  const filenames = newUploads ? JSON.stringify(filteredUploads) : "[]";

  const eventDate = new Date(body.date).toISOString().split("T")[0];
  let sql =
    "update event_post set title=$1, date=$2, start_time=$3, end_time=$4, location=$5, description=$6, category=$7";
  let values = [
    body.title,
    eventDate,
    body.start_time,
    body.end_time,
    body.location,
    body.description,
    body.category,
  ];
  if (newUploads.length > 0) {
    sql += ", images=$8";
    values.push(filenames);
  }
  sql += " where id=$9";
  values.push(body.id);

  return db
    .execute(sql, values)
    .then((result) => {
      exports.sendPostEditEmail(userId, "edit", clientUrl);

      const sql2 = "SELECT * FROM event_post WHERE id = ?;";
      return db.getRow(sql2, [body.id]);
    })
    .then(async (result) => {
      if (!result) return null;
      result.images = JSON.parse(result.images);

      //remove replaced images

      if (body.rmImages && body.rmImages.length > 0)
        await removeImages(JSON.parse(body.rmImages));
      return result;
    });
};

exports.getEventsByUserId = (userId, page) => {
  const itemsPerPage = 10;
  const offset = (page - 1) * itemsPerPage;

  const sql =
    "select e.*, c.full_name, c.image from event_post e join cuser c on e.user_id = c.id where e.user_id = $1 order by" +
    " e.id desc limit $2 offset $3";
  return db.getRows(sql, [userId, itemsPerPage, offset]).then((results) => {
    return results.map((result) => {
      result.images = result.images ? JSON.parse(result.images) : [];
      return result;
    });
  });
};

exports.getEvent = (eventId) => {
  const sql =
    "select e.*, c.full_name, c.image from event_post e join cuser c on e.user_id = c.id where e.id = $1";
  return db.getRow(sql, [eventId]).then((result) => {
    if (!result) return null;
    result.images = JSON.parse(result.images);
    return result;
  });
};

exports.getCommentsByEventId = (eventId) => {
  const sql =
    "SELECT ec.id, ec.user_id, ec.text, ec.created_at, u.full_name, u.image FROM event_comment ec JOIN cuser u ON" +
    " ec.user_id = u.id WHERE ec.event_id = $1 order by ec.created_at desc;";
  return db.getRows(sql, [eventId]);
};

exports.addComment = (newComment, userId) => {
  const sql =
    "INSERT INTO event_comment (event_id, user_id, text, created_at) VALUES ($1, $2, $3, $4);";
  const values = [newComment.event_id, userId, newComment.text, new Date()];
  return db.execute(sql, values).then((result) => {
    const sql2 = "SELECT * FROM event_comment WHERE id = ?;";
    return db.getRow(sql2, [result.insertId]);
  });
};

exports.deleteComment = (commentId, userId, userRole) => {
  let sql = "delete from event_comment where id = $1";
  let values = [commentId];

  // if not admin add constraint
  if (userRole !== "admin") {
    sql += " and user_id = $2";
    values.push(userId);
  }
  return db.execute(sql, values);
};

exports.deleteEvent = (eventId, images, userId, userRole) => {
  let sql = "delete from event_post where id = $1";
  let values = [eventId];

  // if not admin add constraint
  if (userRole !== "admin") {
    sql += " and user_id = $2";
    values.push(userId);
  }
  return db.execute(sql, values).then(async (result) => {
    if (images && images.length > 0) await removeImages(images);
    return result;
  });
};

exports.deleteWishlistEvent = (eventId, userId, userRole) => {
  let sql = "delete from event_wishlist where id = $1";
  let values = [eventId];

  // if not admin add constraint
  if (userRole !== "admin") {
    sql += " and user_id = $2";
    values.push(userId);
  }
  return db.execute(sql, values);
};

exports.getFavoriteEvents = (userId, page) => {
  const itemsPerPage = 10;
  const offset = (page - 1) * itemsPerPage;
  const sql =
    "select e.*, c.full_name, c.image from event_post e join event_favorite ef on e.id = ef.event_id join cuser c on" +
    " c.id = e.user_id where ef.user_id = $1 order by ef.created_at desc limit $2 offset $3";
  return db.getRows(sql, [userId, itemsPerPage, offset]).then((results) => {
    // Parse the images field for each record
    return results.map((result) => {
      result.images = result.images ? JSON.parse(result.images) : [];
      return result;
    });
  });
};

exports.isFavorite = (eventId, userId) => {
  const sql =
    "select id from event_favorite where event_id = $1 and user_id = $2";
  return db.getRow(sql, [eventId, userId]).then((result) => !!result);
};

exports.getWishlistEvents = (userId, page) => {
  const itemsPerPage = 10;
  const offset = (page - 1) * itemsPerPage;

  const sql =
    "select * from event_wishlist where user_id = $1 order by created_at desc limit $2 offset $3";
  return db.getRows(sql, [userId, itemsPerPage, offset]).then((results) => {
    return results.map((result) => {
      result.images = result.images ? JSON.parse(result.images) : [];
      return result;
    });
  });
};

exports.getWishlistEvent = (eventId) => {
  const sql =
    "select ew.*, c.full_name, c.image from event_wishlist ew join cuser c on ew.user_id = c.id where ew.id = $1";
  return db.getRow(sql, [eventId]).then((result) => {
    if (!result) return null;
    result.images = JSON.parse(result.images);
    return result;
  });
};

exports.addWishlistEvent = (body, files, userId) => {
  const { title, location, description, category } = body;
  const sql =
    "INSERT INTO event_wishlist (title, location, description, category, user_id, created_at, images) VALUES ($1, $2," +
    " $3, $4, $5, $6, $7);";

  const fileNames = JSON.stringify(
    files ? files.map((file) => file.filename) : []
  );
  const values = [
    title,
    location,
    description,
    category,
    userId,
    new Date(),
    fileNames,
  ];

  return db.execute(sql, values).then((result) => {
    const sql2 = "SELECT * FROM event_wishlist WHERE id = ?;";
    return db.getRow(sql2, [result.insertId]).then((result) => {
      result.images = result.images ? JSON.parse(result.images) : [];
      return result;
    });
  });
};

exports.editWishlistEvent = async (body, files, userId) => {
  const { id, title, location, description, category, imagesInit, images } =
    body;

  const parsedImagesInit = JSON.parse(imagesInit);
  const parsedImages = JSON.parse(images);
  let filesMarker = 0;
  let rmImages = [];

  parsedImagesInit.forEach((item, index) => {
    //add new item
    if (parsedImages[index] && typeof parsedImages[index] === "object") {
      parsedImagesInit[index] = files[filesMarker].filename;
      filesMarker++;
    }
    //remove item
    else if (item && !parsedImages[index]) {
      rmImages.push(item);
    }
  });
  const filteredParsedImages = parsedImagesInit.filter(
    (item) => item && !rmImages.includes(item)
  ); // This creates a new array with the items that are truthy and not in rmImages

  const sql =
    "update event_wishlist set title=$1, location=$2, description=$3, category=$4, images=$5 where id = $6 and" +
    " user_id = $7;";

  const values = [
    title,
    location,
    description,
    category,
    JSON.stringify(filteredParsedImages),
    id,
    userId,
  ];

  const updatedEvent = db.execute(sql, values).then((result) => {
    const sql2 = "SELECT * FROM event_wishlist WHERE id = ?;";
    return db.getRow(sql2, [id]).then((result) => {
      result.images = result.images ? JSON.parse(result.images) : [];
      return result;
    });
  });

  if (rmImages && rmImages.length > 0) await removeImages(rmImages);

  return updatedEvent;
};

exports.switchFavoriteEvent = (eventId, payload, userId) => {
  const sql =
    "select * from event_favorite where user_id = $1 and event_id = $2";
  return db.getRow(sql, [userId, eventId]).then((res) => {
    let sql = "";
    let values = [];
    if (res && res.id && payload == "false") {
      // entry found and payload is false, so remove from db
      sql = "delete from event_favorite where id = $1";
      values.push(res.id);
    } else if (!res && payload == "true") {
      // entry not found and payload is true, so insert
      sql =
        "insert into event_favorite(user_id, event_id, created_at) values($1, $2, $3)";
      values.push(userId);
      values.push(eventId);
      values.push(new Date());
    } else {
      // something went wrong
      throw new Error();
    }
    return db.execute(sql, values).then((res) => {
      //action successfull, return the payload
      if (res) {
        return JSON.parse(payload);
      } else {
        throw new Error();
      }
    });
  });
};

exports.getUpcomingEvents = async (userId, source) => {
  let friends = [];
  const currentDate = new Date();
  const formattedCurrentDate = currentDate.toISOString().slice(0, 10); // YYYY-MM-DD
  const formattedCurrentTime = currentDate.toISOString().slice(11, 19); // HH:mm:ss

  if (source === "friends") {
    // get upcoming events from friends and ownself
    const sql =
      "SELECT user_id_1 AS friend_id FROM friendship WHERE user_id_2 = ? UNION SELECT user_id_2 AS friend_id FROM" +
      " friendship WHERE user_id_1 = ? UNION SELECT ? as friend_id";

    const res = await db.getRows(sql, [userId, userId, userId]);
    friends = res.map((item) => parseInt(item.friend_id));
  } else {
    // get events from ownself
    friends.push(parseInt(userId));
  }

  const inPlaceholders = friends.map(() => "?").join(", ");

  const sql = `
        SELECT e.*,
               c.full_name,
               c.image
        FROM event_post e
                 JOIN
             cuser c
             ON
                 e.user_id = c.id
        WHERE e.user_id
            IN (${inPlaceholders})
          AND (
                    e.date > '${formattedCurrentDate}'
                OR
                    (e.date = '${formattedCurrentDate}'
                        AND
                     e.start_time > '${formattedCurrentTime}'
                        )
            )
        ORDER BY e.date, e.start_time
        LIMIT 3;
    `;

  return db.getRows(sql, friends).then((results) => {
    // Parse the images field for each record
    return results.map((result) => {
      result.images = JSON.parse(result.images);
      return result;
    });
  });
};

exports.findWallEvents = (
  userId,
  searchKeyword,
  startDate,
  endDate,
  category,
  page
) => {
  const itemsPerPage = 10;
  const offset = (page - 1) * itemsPerPage;
  let values = [];
  let sql =
    "select e.*, c.full_name, c.image from event_post e join cuser c on e.user_id = c.id where e.user_id = ?";

  values.push(userId);

  if (searchKeyword) {
    sql += " and e.title like ?";
    values.push("%" + searchKeyword + "%");
  }
  if (startDate) {
    sql += " and e.date >= ?";
    values.push(startDate);
  }
  if (endDate) {
    sql += " and e.date <= ?";
    values.push(endDate);
  }
  if (category) {
    sql += " and e.category = ?";
    values.push(category);
  }
  sql += " ORDER BY e.date DESC, e.id DESC limit ? offset ?";
  values.push(itemsPerPage);
  values.push(offset);
  return db.getRows(sql, values).then((results) => {
    // Parse the images field for each record
    return results.map((result) => {
      result.images = result.images ? JSON.parse(result.images) : [];
      return result;
    });
  });
};

exports.findBrowseEvents = (
  userId,
  searchKeyword,
  startDate,
  endDate,
  category,
  page
) => {
  const itemsPerPage = 10;
  const offset = (page - 1) * itemsPerPage;
  let values = [];

  let sql =
    "select e.*, c.full_name, c.image from event_post e " +
    "join (select user_id_1 as friend_id from friendship where user_id_2 = ?" +
    " union select user_id_2 as friend_id from friendship where user_id_1 = ?" +
    " union select ? as friend_id) as friends on e.user_id = friends.friend_id" +
    " join cuser c on e.user_id = c.id";

  values.push(userId);
  values.push(userId);
  values.push(userId);

  if (searchKeyword) {
    sql += " and e.title like ?";
    values.push("%" + searchKeyword + "%");
  }
  if (startDate) {
    sql += " and e.date >= ?";
    values.push(startDate);
  }
  if (endDate) {
    sql += " and e.date <= ?";
    values.push(endDate);
  }
  if (category) {
    sql += " and e.category = ?";
    values.push(category);
  }
  sql += " ORDER BY e.date DESC, e.id DESC limit ? offset ?";
  values.push(itemsPerPage);
  values.push(offset);

  return db.getRows(sql, values).then((results) => {
    // Parse the images field for each record
    return results.map((result) => {
      result.images = result.images ? JSON.parse(result.images) : [];
      return result;
    });
  });
};

exports.getAllEventsByFriends = (userId, page) => {
  const itemsPerPage = 10;
  const offset = (page - 1) * itemsPerPage;
  const sql =
    "select e.*, c.full_name, c.image from event_post e " +
    "join (select user_id_1 as friend_id from friendship where user_id_2 = $1" +
    " union select user_id_2 as friend_id from friendship where user_id_1 = $1" +
    " union select $1 as friend_id) as friends on e.user_id = friends.friend_id" +
    " join cuser c on e.user_id = c.id ORDER BY e.date DESC, e.id DESC limit $4 offset $5";
  return db
    .getRows(sql, [userId, userId, userId, itemsPerPage, offset])
    .then((results) => {
      // Parse the images field for each record
      return results.map((result) => {
        result.images = result.images ? JSON.parse(result.images) : [];
        return result;
      });
    });
};

exports.getFeaturedEvent = (userId) => {
  const sql =
    "select * from event_post where user_id = $1 and is_featured = true";
  return db.getRow(sql, [userId]).then((result) => {
    if (!result) return null;
    result.images = JSON.parse(result.images);
    return result;
  });
};
exports.updateFeaturedEvent = (payload, eventId, userId) => {
  const sql =
    "update event_post set is_featured = $1 where id = $2 and user_id = $3";
  return db.execute(sql, [JSON.parse(payload), eventId, userId]);
};

exports.swichFeaturedEvent = (payload, newEventId, oldEventId, userId) => {
  const updatePromises = [
    exports.updateFeaturedEvent(payload, newEventId, userId),
  ];

  if (oldEventId) {
    updatePromises.push(
      exports.updateFeaturedEvent(!payload, oldEventId, userId)
    );
  }

  return Promise.all(updatePromises).then((results) => {
    return JSON.parse(payload);
  });
};

exports.setEventNotification = (eventId, payload) => {
  const sql = "update event_post set new_notification = $1 where id = $2";
  return db.execute(sql, [JSON.parse(payload), eventId]);
};
