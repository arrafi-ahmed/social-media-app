-- Create comment_mention table for storing user mentions in comments
CREATE TABLE comment_mention
(
    id               SERIAL PRIMARY KEY,
    comment_id       INTEGER NOT NULL REFERENCES event_comment (id) ON DELETE CASCADE,
    mentioned_user_id INTEGER NOT NULL REFERENCES users (id) ON DELETE CASCADE,
    created_at       TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE (comment_id, mentioned_user_id)
);

-- Add indexes for efficient queries
CREATE INDEX idx_comment_mention_comment_id ON comment_mention(comment_id);
CREATE INDEX idx_comment_mention_mentioned_user_id ON comment_mention(mentioned_user_id);

