const db = require("../db");
const jwt = require("jsonwebtoken");
const { v4: uuidv4 } = require("uuid");
const CustomError = require("../model/CustomError");
const { sendMail } = require("./sendMail");
const {
  generatePassResetContent,
  generateInvitationContent,
  generateWelcomeContent,
  removeImages,
  generateNewCommentContent,
  generateTodaysEventContent,
} = require("../others/util");

exports.register = async (payload, clientUrl) => {
  const sql =
    "INSERT INTO cuser (full_name, email, password, date_of_birth, country, role, created_at) VALUES ($1, $2, $3," +
    " $4, $5, $6, $7);";

  const insertedUser = await db
    .execute(sql, [
      payload.fullName,
      payload.email,
      payload.password,
      null, // new Date(payload.dateOfBirth).toISOString().slice(0, 10),
      null, // payload.country,
      1,
      new Date(),
    ])
    .then((result) => {
      const sql2 = "SELECT * FROM cuser WHERE id = ?;";
      return db.getRow(sql2, [result.insertId]);
    });

  // insert into user settings
  exports.createUserSettings(insertedUser.id);

  // Send welcome email
  const to = payload.email;
  const subject = `Welcome to WayzAway ${payload.fullName}!`;
  const html = generateWelcomeContent(
    payload.fullName,
    insertedUser.id,
    clientUrl
  );
  sendMail(to, subject, html);

  const admins = await exports.getAdmins();

  //add new user to all admins friend list
  const records = admins.map((admin) => ({
    user_id_1: admin.id,
    user_id_2: insertedUser.id,
  }));
  bulkInsertFriendships(records);

  // Generate authentication data
  const authData = generateAuthData(insertedUser);

  // Get pending invitations for the registered user
  const pendingInvitations = await exports.getPendingInvitation(
    insertedUser.email
  );

  // if no invitation return only registered data
  if (pendingInvitations && pendingInvitations.length === 0) {
    return { authData };
  }
  // if pending invitation
  else {
    const pendingInvitationIds = pendingInvitations.map((item) => item.id);

    // Prepare friendship records for bulk insertion
    const friendshipRecords = pendingInvitations.map((item) => ({
      user_id_1: insertedUser.id,
      user_id_2: item.sender_id,
    }));

    await Promise.all([
      bulkInsertFriendships(friendshipRecords),
      bulkDeleteInvitations(pendingInvitationIds),
    ]);
    return { newFriendsCount: friendshipRecords.length, authData };
  }
};

exports.addAllUsersToAdminFriendlist = async (adminId) => {
  const users = await exports.getUsers();

  const friends = await exports.getFriends(adminId);
  const notFriends = users.filter(
    (user) =>
      !friends.some((friend) => friend.id === user.id) && user.id !== adminId
  );

  const userToAdd = notFriends.map((notFriend) => ({
    user_id_1: adminId,
    user_id_2: notFriend.id,
  }));

  bulkInsertFriendships(userToAdd);
};

exports.signin = (payload) => {
  const sql =
    "select id, full_name, image, email, password, role from cuser where email = $1 and password = $2";
  return db.getRow(sql, [payload.email, payload.password]).then((result) => {
    return generateAuthData(result);
  });
};

exports.getUserById = (userId) => {
  const sql =
    "select id, full_name, email, date_of_birth, country, image, created_at from cuser where id = $1";
  return db.getRow(sql, [userId]);
};

exports.getIdByEmail = (email) => {
  const sql = "select id from cuser where email = $1";
  return db.getRow(sql, [email]);
};

exports.getUserSettings = (userId) => {
  const sql = `select *
                 from user_settings
                 where user_id = $1`;
  return db.getRow(sql, [userId]);
};

exports.getAdmins = () => {
  const sql = "select * from cuser where role = ?";
  return db.getRows(sql, [2]);
};

exports.getUsers = () => {
  const sql = "select * from cuser";
  return db.getRows(sql, []);
};

exports.checkFriends = (id1, id2) => {
  const sql =
    "select id from friendship where (user_id_1 = $1 and user_id_2 = $2) or (user_id_1 = $2 and user_id_2 = $1)";
  return db.getRow(sql, [id1, id2, id2, id1]);
};

exports.sendInvite = (body, userId) => {
  let receiver_id = null;
  let sender_id = userId;

  //check if ivnitation sent already
  const sql =
    "select * from invitation where sender_id = $1 and receiver_email = $2";
  return db
    .getRow(sql, [userId, body.email])
    .then((result) => {
      if (result && result.id) {
        throw new CustomError("Already sent invitaion!", 409, result);
      }
      //find receiver's id from email
      return exports.getIdByEmail(body.email);
    })
    .then((result) => {
      // if email exist
      if (result && result.id) {
        //cant send invitation to ownself
        if (result.id == userId) {
          throw new CustomError("Can't send invitation to ownself!");
        }
        receiver_id = result.id;
        //check if they are friends
        return exports.checkFriends(receiver_id, sender_id);
      }
    })
    .then((result) => {
      // if they are friends already
      if (result) {
        throw new CustomError("User already in friendlist!");
      }
      //if not, insert in invitation
      else {
        //generate token
        const token = uuidv4();
        const sql =
          "insert into invitation (sender_id, receiver_email, token, is_accepted, created_at) values ($1, $2, $3," +
          " $4, $5);";
        return db.execute(sql, [
          sender_id,
          body.email,
          token,
          false,
          new Date(),
        ]);
      }
    })
    .then((result) => {
      const sql2 = "SELECT * FROM invitation WHERE id = ?;";
      return db.getRow(sql2, [result.insertId]);
    })
    .then(async (result) => {
      const senderData = await exports.getUserById(sender_id);
      return { senderData, token: result.token };
    })
    .then(({ senderData, token }) => {
      const to = body.email;

      const subject = `Wayzaway invitation from ${senderData.full_name}`;
      const html = generateInvitationContent(senderData, body.message, token);
      return sendMail(to, subject, html);
    });
};

exports.acceptInvite = (token) => {
  return new Promise(async (resolve, reject) => {
    try {
      const sql = "select * from invitation where token = $1";
      const invitation = await db.getRow(sql, [token]);

      //if valid invitation
      if (invitation) {
        //destructure 'id' event its undefined
        const { id: receiverId } =
          (await exports.getIdByEmail(invitation.receiver_email)) || {};
        // if receiver id exist then no need to register
        if (receiverId) {
          //  check if friends and throw err
          const areFriends = await exports.checkFriends(
            invitation.sender_id,
            receiverId
          );

          if (areFriends) {
            throw new CustomError("User already in friendlist!");
          }

          //  insert into friendship
          const sql2 =
            "insert into friendship (user_id_1, user_id_2, created_at) values($1, $2, $3)";
          const friendship = await db.execute(sql2, [
            invitation.sender_id,
            receiverId,
            new Date(),
          ]);

          //  delete record from invitation by id
          const sql3 = "delete from invitation where id = $1";
          await db.execute(sql3, [invitation.id]);

          //  redirect to friends page
          resolve({ redirect: "friends" });
        }
        // if receiver id doesn't exist
        else {
          //  1 invitation with is_accepted=true if user doesnt exist,
          const sql = "update invitation set is_accepted = true where id = $1;";
          await db.execute(sql, [invitation.id]);
          //  redirect to register page
          resolve({ redirect: "register" });
        }
      }
      //invalid invitation
      else {
        throw new CustomError("Invalid invitation!");
      }
    } catch (err) {
      reject(err);
    }
  });
};

exports.getFriends = (userId) => {
  const sql =
    "select f.id as friendship_id, c.id, c.full_name, c.image, c.email from cuser c join (select id, user_id_1 as" +
    " friend_id, created_at from friendship where user_id_2 = $1 union select id, user_id_2 as friend_id, created_at from" +
    " friendship where user_id_1 = $1) as f on c.id = f.friend_id order by f.created_at desc";
  return db.getRows(sql, [userId, userId]);
};

exports.getFriendsWSettings = (userId) => {
  const sql =
    "select f.id as friendship_id, c.id, c.full_name, c.image, c.email, us.email_new_event_notification," +
    " us.email_update_event_notification, us.email_new_comment_notification from cuser c join (select id, user_id_1" +
    " as friend_id, created_at from friendship where user_id_2 = $1 union select id, user_id_2 as friend_id, created_at" +
    " from friendship where user_id_1 = $1) as f on c.id = f.friend_id join user_settings us on c.id = us.user_id";
  return db.getRows(sql, [userId, userId]);
};

exports.removeFriend = (userId, friendshipId) => {
  const sql =
    "delete from friendship where id = $1 and (user_id_1 = $2 or user_id_2 = $2 )";
  return db.execute(sql, [friendshipId, userId, userId]);
};

exports.searchUser = (requestedUser) => {
  const sql =
    "SELECT id, full_name, email, date_of_birth, country, image FROM cuser" +
    " WHERE (CAST(id AS CHAR) = ? OR LOWER(full_name) LIKE CONCAT('%', LOWER(?), '%') OR LOWER(email) = LOWER(?));";
  return db.getRows(sql, [requestedUser, requestedUser, requestedUser]);
};

exports.deleteUser = (userId, rmImage) => {
  const sql = "select images from event_post where user_id = $0;";
  const sql1 = "delete from event_favorite WHERE user_id = $1;";
  const sql2 = "delete from event_comment WHERE user_id = $1;";
  const sql3 = "delete from event_wishlist WHERE user_id = $1;";
  const sql4 = "delete from event_post WHERE user_id = $1;";
  const sql5 = "delete from friendship WHERE user_id_1 = $1 OR user_id_2 = $1;";
  const sql6 = "delete from cuser where id = $1";

  return Promise.all([
    db.getRows(sql, [userId]),
    db.execute(sql1, [userId]),
    db.execute(sql2, [userId]),
    db.execute(sql3, [userId]),
    db.execute(sql4, [userId]),
    db.execute(sql5, [userId, userId]),
    db.execute(sql6, [userId]),
  ]).then(async (results) => {
    // remove all events images
    const rows = results[0];
    if (rows.length > 0) {
      let rmImages = [];
      rows.forEach((row) => {
        let images;
        try {
          images = JSON.parse(row.images);
        } catch (e) {
          console.error("deleteUser() - Invalid JSON:", row);
          return; // Skip this row
        }
        // const images = JSON.parse(row);
        if (images.length > 0) {
          // Ignore empty arrays
          rmImages = rmImages.concat(images);
        }
      });

      if (rmImage) await removeImages([rmImage]); //remove user img
      if (rmImages.length > 0) await removeImages(rmImages); //remove all event images by user
    }
    return results;
  });
};

exports.updateProfile = (body, files, userId) => {
  let sql = "UPDATE cuser SET";
  const values = [];
  const columns = [];
  if (body.full_name !== undefined) {
    columns.push("full_name");
    values.push(body.full_name);
  }
  if (body.email !== undefined) {
    columns.push("email");
    values.push(body.email);
  }
  if (body.password !== undefined) {
    columns.push("password");
    values.push(body.password);
  }
  if (files) {
    columns.push("image");
    values.push(files[0].filename);
  }
  sql += " " + columns.map((col, index) => `${col} = $${index + 1}`).join(", ");
  values.push(userId);
  sql += ` WHERE id = $${values.length};`;

  return db.execute(sql, values).then((result) => {
    if (!result) throw new Error();
    const sql = "select full_name, email, image from cuser where id = $1;";

    if (body.rmImage) {
      return Promise.all([
        db.getRow(sql, [userId]),
        removeImages([body.rmImage]),
      ]).then((results) => results[0]);
    }
    return db.getRow(sql, [userId]);
  });
};

exports.requestResetPass = (resetEmail, clientUrl) => {
  return exports
    .getIdByEmail(resetEmail)
    .then((result) => {
      if (!result) {
        throw new CustomError("User doesn't exist!");
      }
      const sql =
        "insert into password_reset (email, token, created_at) values (?, ?, ?)";
      const token = uuidv4();
      const values = [resetEmail, token, new Date()];

      return db.execute(sql, values);
    })
    .then((result) => {
      const sql = "select * from password_reset where id = ?";
      return db.getRow(sql, [result.insertId]);
    })
    .then((result) => {
      const to = resetEmail;
      const subject = "Wayzaway password reset link";
      const html = generatePassResetContent(result.token, clientUrl);
      return sendMail(to, subject, html);
    });
};

exports.submitResetPass = ({ token, newPass }) => {
  const sql = "select * from password_reset where token = ?";
  return db
    .getRow(sql, [token])
    .then((result) => {
      if (!result) {
        throw new CustomError("Invalid request!");
      }
      const createdAtMillis = result.created_at.getTime();

      // Calculate the expiration time (expiration time 1 hour)
      const expirationMillis = createdAtMillis + 1 * 60 * 60 * 1000;
      const now = new Date();

      if (expirationMillis < now) {
        throw new CustomError("Password reset link expired!");
      }

      const sql = "update cuser set password = $1 where email = $2";
      return db.execute(sql, [newPass, result.email]);
    })
    .then((result) => {
      const sql = "delete from password_reset where token = $1";
      return db.execute(sql, [token]);
    });
};

exports.getUsersWNewCommentsInDays = (day) => {
  const sql =
    "SELECT c.id, c.full_name, c.email, us.email_new_comment_notification, COUNT(event_comment.id) as comment_count FROM" +
    " event_comment JOIN event_post ON event_comment.event_id = event_post.id JOIN cuser c ON event_post.user_id =" +
    " c.id join user_settings us on us.user_id = c.id WHERE event_comment.created_at > DATE_SUB(NOW(), INTERVAL ?" +
    " DAY) AND event_comment.user_id != event_post.user_id GROUP BY c.id, us.email_new_comment_notification;";

  return db.getRows(sql, [day]);
};

exports.getUsersPostedEventsToday = () => {
  const currentDate = new Date().toISOString().split("T")[0];
  const sql = `SELECT DISTINCT c.id, c.email
                 FROM cuser as c
                          JOIN event_post as e ON c.id = e.user_id
                 where DATE(e.date) = '${currentDate}'`;

  return db.getRows(sql);
};

exports.sendNewCommentEmail = async (clientUrl) => {
  // find friends & send notification email to friends
  const users = await exports.getUsersWNewCommentsInDays(1);
  // Generate email and send emails in parallel
  const sendEmailPromises = users
    .filter((user) => user.email_new_comment_notification)
    .map(async (user) => {
      const to = user.email;
      const subject = `You have new ${user.comment_count} comment(s) on WayzAway!`;
      const html = generateNewCommentContent(user, clientUrl);
      return sendMail(to, subject, html);
    });
  // Wait for all emails to be sent
  return Promise.all(sendEmailPromises);
};

exports.sendTodaysEventEmail = async (clientUrl) => {
  // find friends & send notification email to friends
  const users = await exports.getUsersPostedEventsToday();
  // Generate email and send emails in parallel
  const sendEmailPromises = users.map(async (user) => {
    const to = user.email;
    const subject = `You have an event scheduled for today!`;
    const html = generateTodaysEventContent(user, clientUrl);

    return sendMail(to, subject, html);
  });
  // Wait for all emails to be sent
  return Promise.all(sendEmailPromises);
};

exports.getProfileWSettings = (userId) => {
  const sql = `select c.id,
                        c.full_name,
                        c.email,
                        c.date_of_birth,
                        c.country,
                        c.image,
                        c.created_at,
                        us.email_new_event_notification,
                        us.email_update_event_notification,
                        us.email_new_comment_notification
                 from cuser as c
                          join user_settings as us on c.id = us.user_id
                 where c.id = ?`;
  return db.getRow(sql, [userId]);
};

exports.updateEmailNewEventNotification = (payload, userId) => {
  const sql =
    "update user_settings set email_new_event_notification = ? where user_id = ?";
  return db.execute(sql, [payload, userId]);
};

exports.updateEmailUpdateEventNotification = (payload, userId) => {
  const sql =
    "update user_settings set email_update_event_notification = ? where user_id = ?";
  return db.execute(sql, [payload, userId]);
};

exports.updateEmailNewCommentNotification = (payload, userId) => {
  const sql =
    "update user_settings set email_new_comment_notification = ? where user_id = ?";
  return db.execute(sql, [payload, userId]);
};

const generateAuthData = (result) => {
  let token = "";
  let currentUser = {};
  if (result) {
    currentUser = {
      id: result.id,
      role: result.role === 1 ? "user" : "admin",
      name: result.full_name,
      image: result.image,
    };
    token = jwt.sign({ currentUser }, process.env.TOKEN_SECRET);
  }
  return { token, currentUser };
};

exports.getPendingInvitation = (email) => {
  const sql =
    "select * from invitation where receiver_email = $1 and is_accepted = true";
  return db.getRowsgit(sql, [email]);
};

exports.createUserSettings = (userId) => {
  const sql =
    "insert into user_settings (email_new_event_notification," +
    " email_update_event_notification, email_new_comment_notification, sort, user_id)" +
    " values (?, ?, ?, ?);";
  return db.execute(sql, [true, true, true, "DESC", userId]);
};

exports.updateSettings = (payload, userId) => {
  let sql = "UPDATE user_settings SET";
  const values = [];

  if (payload.email_new_event_notification !== undefined) {
    sql += " email_new_event_notification = ?,";
    values.push(payload.email_new_event_notification);
  }
  if (payload.email_update_event_notification !== undefined) {
    sql += " email_update_event_notification = ?,";
    values.push(payload.email_update_event_notification);
  }
  if (payload.email_new_comment_notification !== undefined) {
    sql += " email_new_comment_notification = ?,";
    values.push(payload.email_new_comment_notification);
  }
  if (payload.sort !== undefined) {
    sql += " sort = ?,";
    values.push(payload.sort);
  }

  // Remove the trailing comma and add the WHERE clause
  sql = sql.slice(0, -1) + " WHERE user_id = ?";
  values.push(userId);

  return db.execute(sql, values);
};

const bulkInsertFriendships = async (records) => {
  let values = records
    .map(
      (record) =>
        `(${record.user_id_1}, ${record.user_id_2}, '${new Date()
          .toISOString()
          .slice(0, 19)
          .replace("T", " ")}')`
    )
    .join(", ");

  let query = `INSERT INTO friendship (user_id_1, user_id_2, created_at)
    VALUES
    ${values}`;
  return db.execute(query);
};

const bulkDeleteInvitations = async (invitationIds) => {
  const connection = await db.pool.getConnection();

  try {
    await connection.beginTransaction();
    const inPlaceholders = invitationIds.map(() => "?").join(", ");
    const queryText = `DELETE
                           FROM invitation
                           WHERE id IN (${inPlaceholders})`;
    await connection.execute(queryText, invitationIds);

    await connection.commit();
  } catch (error) {
    await connection.rollback();
    throw error;
  } finally {
    connection.release();
  }
};
