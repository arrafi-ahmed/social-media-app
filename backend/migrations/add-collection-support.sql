-- Create event_collection table for organizing saved events into collections
CREATE TABLE event_collection
(
    id          SERIAL PRIMARY KEY,
    user_id     INTEGER REFERENCES users (id) ON DELETE CASCADE,
    name        VARCHAR(255) NOT NULL,
    description TEXT,
    color       VARCHAR(7),  -- Hex color code (e.g., #FF5733)
    icon        VARCHAR(50), -- Icon name (e.g., mdi-folder, mdi-music)
    created_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Add collection_id column to event_favorite table
-- NULL means the event is in "All Saved" (uncategorized)
-- Non-NULL means the event belongs to a specific collection
ALTER TABLE event_favorite
ADD COLUMN collection_id INTEGER REFERENCES event_collection (id) ON DELETE SET NULL;

-- Add indexes for efficient queries
CREATE INDEX idx_event_collection_user_id ON event_collection(user_id);
CREATE INDEX idx_event_favorite_collection_id ON event_favorite(collection_id);
CREATE INDEX idx_event_favorite_user_collection ON event_favorite(user_id, collection_id);

