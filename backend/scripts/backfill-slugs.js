#!/usr/bin/env node

/**
 * Backfill Slugs Migration Script
 * 
 * This script generates and backfills slugs for all existing users who don't have one.
 * Run with: node backend/scripts/backfill-slugs.js
 */

const path = require('path');
const { v4: uuidv4 } = require('uuid');
require('dotenv').config({
  path: process.env.NODE_ENV === 'production'
    ? path.join(__dirname, '../.env.production')
    : path.join(__dirname, '../.env.development')
});

const { generateSlug } = require('../src/others/util');
const db = require('../src/db');

// Helper to generate random string for slug uniqueness
function generateRandomString(length = 6) {
  return uuidv4().replace(/-/g, '').slice(0, length);
}

async function backfillSlugs() {
  console.log('🚀 Starting slug backfill migration...');
  
  try {
    // Get all users without slugs
    const usersWithoutSlugs = await db.getRows(`
      SELECT id, full_name, email 
      FROM users 
      WHERE slug IS NULL OR slug = ''
    `);
    
    console.log(`📊 Found ${usersWithoutSlugs.length} users without slugs`);
    
    let successCount = 0;
    let errorCount = 0;
    
    for (const user of usersWithoutSlugs) {
      try {
        // Generate base slug from full_name
        let baseSlug = generateSlug(user.fullName);
        let slug = baseSlug;
        let counter = 1;
        let isSlugUnique = false;
        
        // If slug is empty or only numbers, use email or fallback
        if (!slug || /^\d+$/.test(slug)) {
          baseSlug = generateSlug(user.email.split('@')[0]) || 'user';
          slug = baseSlug;
        }
        
        // Check if slug already exists and make it unique
        while (!isSlugUnique) {
          const existingUser = await db.getRow(
            'SELECT id FROM users WHERE slug = $1',
            [slug]
          );
          
          if (!existingUser) {
            isSlugUnique = true;
          } else {
            // Combine base slug with random characters for uniqueness
            if (counter === 1 && baseSlug) {
              slug = `${baseSlug}${generateRandomString(6)}`;
            } else {
              slug = `${baseSlug || 'user'}${generateRandomString(6)}`;
            }
            counter++;
            
            // Fallback if slug still conflicts after many attempts
            if (counter > 100) {
              slug = `user${Date.now()}${user.id}`;
              isSlugUnique = true;
            }
          }
        }
        
        // Update user with generated slug
        await db.execute(
          'UPDATE users SET slug = $1 WHERE id = $2',
          [slug, user.id]
        );
        
        successCount++;
        console.log(`✅ ${user.fullName} (${user.email}) → ${slug}`);
      } catch (error) {
        errorCount++;
        console.error(`❌ Error processing user ${user.id}: ${error.message}`);
      }
    }
    
    console.log('\n📈 Migration Summary:');
    console.log(`✅ Successfully backfilled: ${successCount} users`);
    console.log(`❌ Errors: ${errorCount} users`);
    console.log('\n🎉 Slug backfill migration completed!');
    
    process.exit(0);
  } catch (error) {
    console.error('\n💥 Migration failed:', error);
    process.exit(1);
  }
}

// Run the migration
backfillSlugs();

