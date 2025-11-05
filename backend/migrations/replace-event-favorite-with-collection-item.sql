-- Replace event_favorite table with event_collection_item table
-- This migration:
-- 1. Creates the new event_collection_item table
-- 2. Migrates data from event_favorite
-- 3. Drops the old event_favorite table
-- 4. Updates indexes

-- Step 1: Create new event_collection_item table
-- Note: An event can only be saved once per user (can be in one collection or uncategorized)
CREATE TABLE event_collection_item
(
    id            SERIAL PRIMARY KEY,
    user_id       INTEGER NOT NULL REFERENCES users (id) ON DELETE CASCADE,
    event_id      INTEGER NOT NULL REFERENCES event_post (id) ON DELETE CASCADE,
    collection_id INTEGER REFERENCES event_collection (id) ON DELETE CASCADE,
    created_at    TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE (user_id, event_id)
);

-- Step 2: Migrate data from event_favorite to event_collection_item
-- Handle potential duplicates by taking the most recent entry per user_id + event_id
INSERT INTO event_collection_item (user_id, event_id, collection_id, created_at)
SELECT DISTINCT ON (user_id, event_id) 
    user_id, 
    event_id, 
    collection_id, 
    created_at
FROM event_favorite
ORDER BY user_id, event_id, created_at DESC;

-- Step 3: Drop old event_favorite table (this will also drop its indexes)
DROP TABLE event_favorite CASCADE;

-- Step 4: Create indexes for the new table
CREATE INDEX idx_event_collection_item_user_id ON event_collection_item(user_id);
CREATE INDEX idx_event_collection_item_event_id ON event_collection_item(event_id);
CREATE INDEX idx_event_collection_item_collection_id ON event_collection_item(collection_id);
CREATE INDEX idx_event_collection_item_user_collection ON event_collection_item(user_id, collection_id);
CREATE INDEX idx_event_collection_item_user_event ON event_collection_item(user_id, event_id);

