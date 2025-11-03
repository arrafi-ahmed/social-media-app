#!/usr/bin/env node

/**
 * Password Migration Script
 * 
 * This script hashes all existing plaintext passwords in the database.
 * Run with: NODE_ENV=development node backend/scripts/migrate-passwords.js
 * 
 * WARNING: This script should only be run once. After running, all existing
 * passwords will be hashed. Users will need to use their current passwords
 * to sign in, and they will be automatically re-hashed if they're still plaintext.
 */

const path = require('path');
const bcrypt = require('bcrypt');
require('dotenv').config({
  path: process.env.NODE_ENV === 'production'
    ? path.join(__dirname, '../.env.production')
    : path.join(__dirname, '../.env.development')
});

const db = require('../src/db');

// Helper function to detect if a password is already hashed (bcrypt hash format)
function isAlreadyHashed(password) {
  // Bcrypt hashes start with $2a$, $2b$, or $2y$ and are 60 characters long
  return /^\$2[ayb]\$.{56}$/.test(password);
}

async function migratePasswords() {
  console.log('🚀 Starting password migration to bcrypt...');
  
  try {
    // Get all users with their passwords
    const users = await db.getRows(`
      SELECT id, email, password 
      FROM users
    `);
    
    console.log(`📊 Found ${users.length} users to check`);
    
    let successCount = 0;
    let alreadyHashedCount = 0;
    let errorCount = 0;
    
    for (const user of users) {
      try {
        // Check if password is already hashed
        if (isAlreadyHashed(user.password)) {
          alreadyHashedCount++;
          console.log(`⏭️  ${user.email}: Password already hashed`);
          continue;
        }
        
        // Hash the plaintext password
        const hashedPassword = await bcrypt.hash(user.password, 10);
        
        // Update user with hashed password
        await db.execute(
          'UPDATE users SET password = $1 WHERE id = $2',
          [hashedPassword, user.id]
        );
        
        successCount++;
        console.log(`✅ ${user.email}: Password hashed successfully`);
      } catch (error) {
        errorCount++;
        console.error(`❌ Error processing user ${user.email}: ${error.message}`);
      }
    }
    
    console.log('\n📈 Migration Summary:');
    console.log(`✅ Successfully hashed: ${successCount} passwords`);
    console.log(`⏭️  Already hashed: ${alreadyHashedCount} passwords`);
    console.log(`❌ Errors: ${errorCount} passwords`);
    console.log('\n🎉 Password migration completed!');
    console.log('\n⚠️  Note: Users can now sign in with their existing passwords.');
    
    process.exit(0);
  } catch (error) {
    console.error('\n💥 Migration failed:', error);
    process.exit(1);
  }
}

// Run the migration
migratePasswords();

