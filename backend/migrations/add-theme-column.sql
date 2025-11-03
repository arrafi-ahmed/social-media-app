-- Migration: Add theme column to user_settings table
-- Run with: psql -U your_user -d wayzaway -f backend/migrations/add-theme-column.sql

ALTER TABLE user_settings 
ADD COLUMN IF NOT EXISTS theme VARCHAR(10) DEFAULT 'light';

