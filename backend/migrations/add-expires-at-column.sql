ALTER TABLE event_post 
ADD COLUMN expires_at TIMESTAMP NULL;

-- Add index for efficient deletion queries
CREATE INDEX idx_event_post_expires_at ON event_post(expires_at) WHERE expires_at IS NOT NULL;

