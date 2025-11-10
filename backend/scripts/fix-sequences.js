#!/usr/bin/env node

/**
 * Fix Sequences Script
 * 
 * This script resets all SERIAL sequences to the maximum existing ID + 1.
 * This fixes issues where manual inserts bypass the sequence, causing conflicts.
 * 
 * Run with: node backend/scripts/fix-sequences.js
 */

const path = require('path');
require('dotenv').config({
  path: process.env.NODE_ENV === 'production'
    ? path.join(__dirname, '../.env.production')
    : path.join(__dirname, '../.env.development')
});

const db = require('../src/db');

// List of tables that should have SERIAL sequences (from schema)
const TABLES = [
  'users',
  'event_post',
  'event_comment',
  'comment_mention',
  'friendship',
  'event_collection',
  'event_collection_item',
  'blog_post',
  'event_category',
  'event_wishlist',
  'invitation',
  'pages',
  'password_reset',
  'user_settings',
  'subscription_plan',
  'subscription',
  'event_reaction',
  'user_group',
  'group_member',
  'event_group'
];

async function fixSequences() {
  console.log('🚀 Starting sequence reset...');
  console.log('');

  try {
    // Get all tables with SERIAL primary keys
    const tablesQuery = `
      SELECT 
        table_name,
        column_name,
        pg_get_serial_sequence(table_name::regclass::text, column_name) as sequence_name
      FROM information_schema.columns
      WHERE table_schema = 'public'
        AND column_default LIKE 'nextval%'
        AND table_name = ANY($1::text[])
      ORDER BY table_name
    `;

    const tables = await db.getRows(tablesQuery, [TABLES]);

    if (tables.length === 0) {
      console.log('⚠️  No tables with SERIAL sequences found.');
      process.exit(0);
    }

    console.log(`📊 Found ${tables.length} table(s) with SERIAL sequences\n`);

    let successCount = 0;
    let errorCount = 0;
    let skippedCount = 0;

    for (const table of tables) {
      try {
        // Skip if sequence name is null
        if (!table.sequenceName) {
          skippedCount++;
          console.log(`⚠️  Skipping ${table.tableName}.${table.columnName} - no sequence found`);
          continue;
        }

        // Get the maximum ID from the table
        // Validate identifier format to prevent SQL injection
        // Identifiers from information_schema are safe, but we validate anyway
        const identifierPattern = /^[a-z_][a-z0-9_]*$/i;
        if (!identifierPattern.test(table.tableName) || !identifierPattern.test(table.columnName)) {
          errorCount++;
          console.error(`❌ Invalid identifier format for ${table.tableName}.${table.columnName}`);
          continue;
        }
        
        // Build query with validated identifiers (double-quoted for safety)
        // Since identifiers are validated and come from information_schema, this is safe
        const maxIdQuery = `
          SELECT COALESCE(MAX("${table.columnName}"), 0) as max_id 
          FROM "${table.tableName}"
        `;
        
        // Execute the query
        const maxIdResult = await db.pool.query(maxIdQuery);
        const maxId = parseInt(maxIdResult.rows[0]?.max_id || 0);
        const nextVal = maxId + 1;

        // Reset the sequence to max_id + 1 (use parameterized query for sequence name)
        const setValQuery = `SELECT setval($1, $2, false)`;
        await db.pool.query(setValQuery, [table.sequenceName, nextVal]);

        successCount++;
        console.log(`✅ Reset ${table.sequenceName} for ${table.tableName}.${table.columnName} to ${nextVal} (max_id: ${maxId})`);
      } catch (error) {
        errorCount++;
        console.error(`❌ Error resetting sequence for ${table.tableName}.${table.columnName}: ${error.message}`);
      }
    }

    console.log('');
    console.log('📈 Summary:');
    console.log(`✅ Successfully reset: ${successCount} sequence(s)`);
    if (skippedCount > 0) {
      console.log(`⚠️  Skipped: ${skippedCount} sequence(s)`);
    }
    if (errorCount > 0) {
      console.log(`❌ Errors: ${errorCount} sequence(s)`);
    }
    console.log('');
    console.log('🎉 Sequence reset completed!');

    process.exit(0);
  } catch (error) {
    console.error('');
    console.error('💥 Sequence reset failed:', error);
    process.exit(1);
  } finally {
    // Close database connection
    await db.pool.end();
  }
}

// Run the script
fixSequences();

