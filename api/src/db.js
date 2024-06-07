const mysql = require("mysql2/promise");
const {
  DB_TYPE,
  DB_HOST,
  DB_PORT,
  DB_DATABASE,
  DB_USER,
  DB_PASSWORD,
  DB_ENDPOINT_ID,
} = process.env;

let pool = mysql.createPool({
  host: DB_HOST,
  port: DB_PORT,
  user: DB_USER,
  database: DB_DATABASE,
  password: DB_PASSWORD,
  ssl: false,
  // waitForConnections: true,
  // connectionLimit: 10,
  // queueLimit: 0,
  // ssl: {
  //   rejectUnauthorized: false, // For "ssl-mode=REQUIRED," set the "rejectUnauthorized" option to true
  // },
});

exports.pool = pool;

const pgToMysql = (sql, params) => {
  // Replace $1, $2, ... with ? for placeholders
  let query = sql.replace(/\$\d+/g, "?");

  // Ensure that the number of placeholders matches the number of parameters
  if (params && params.length !== (query.match(/\?/g) || []).length) {
    throw new Error("Mismatch between placeholders and parameters.");
  }
  return query;
};

exports.execute = async (sql, params) => {
  try {
    const query = pgToMysql(sql, params);
    const [results] = await pool.query(query, params);
    return results;
  } catch (err) {
    throw err;
  }
};

exports.getRow = async (sql, params) => {
  try {
    const query = pgToMysql(sql, params);
    const [rows] = await pool.query(query, params);
    return rows[0];
  } catch (err) {
    throw err;
  }
};

exports.getRows = async (sql, params) => {
  try {
    const query = pgToMysql(sql, params);
    const [rows] = await pool.query(query, params);
    return rows;
  } catch (err) {
    throw err;
  }
};

exports.query = async (sql, params) => {
  try {
    const query = pgToMysql(sql, params);
    const [results] = await pool.query(sql, params);
    return results;
  } catch (err) {
    throw err;
  }
};
