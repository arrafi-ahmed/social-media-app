const { Pool } = require("pg");

const { DB_HOST, DB_PORT, DB_NAME, DB_USER, DB_PASS, NODE_ENV } = process.env;

const pool = new Pool({
  host: DB_HOST,
  port: DB_PORT,
  user: DB_USER,
  database: DB_NAME,
  password: DB_PASS,
  ssl: false,
  max: 20,
  idleTimeoutMillis: 30_000,
  connectionTimeoutMillis: 2000,
});

// Helper function to convert snake_case to camelCase
function toCamelCase(obj) {
  if (Array.isArray(obj)) {
    return obj.map((item) => toCamelCase(item));
  }
  if (obj !== null && typeof obj === "object") {
    // Handle Date objects specially
    if (obj instanceof Date) {
      return obj;
    }
    const newObj = {};
    for (const key in obj) {
      if (obj.hasOwnProperty(key)) {
        const camelKey = key.replace(/_([a-z])/g, (match, letter) =>
          letter.toUpperCase(),
        );
        newObj[camelKey] = toCamelCase(obj[key]);
      }
    }
    return newObj;
  }
  return obj;
}

// Wrapper function that automatically converts results
async function query(text, params) {
  const result = await pool.query(text, params);
  return {
    ...result,
    rows: toCamelCase(result.rows),
  };
}

// Wrapper functions to maintain backward compatibility with existing services
async function execute(sql, params) {
  const result = await query(sql, params);
  return result;
}

async function getRow(sql, params) {
  const result = await query(sql, params);
  return result.rows[0];
}

async function getRows(sql, params) {
  const result = await query(sql, params);
  return result.rows;
}

// Test the connection
pool.on("connect", () => {
});

pool.on("error", (err) => {
  console.error("Unexpected error on idle client", err);
  process.exit(-1);
});

module.exports = { pool, query, execute, getRow, getRows };
