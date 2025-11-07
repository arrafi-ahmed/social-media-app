const path = require('path');
require('dotenv').config({
  path: process.env.NODE_ENV === 'production'
    ? path.join(__dirname, '../.env.production')
    : path.join(__dirname, '../.env.development')
});
const db = require('../src/db');

async function backfillRoles() {
  try {
    console.log('Starting role backfill...');

    // Update role 1 to 10 (ADMIN)
    const result1 = await db.query(
      'UPDATE users SET role = 20 WHERE role = 1'
    );

    // Update role 2 to 20 (CUSTOMER)
    const result2 = await db.query(
      'UPDATE users SET role = 10 WHERE role = 2'
    );

    console.log('Role backfill completed successfully!');

  } catch (error) {
    console.error('Error during role backfill:', error);
    process.exit(1);

  }
}

backfillRoles();