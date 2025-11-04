CREATE TABLE event_reaction
(
    id            SERIAL PRIMARY KEY,
    user_id       INTEGER REFERENCES users (id) ON DELETE CASCADE,
    event_id      INTEGER REFERENCES event_post (id) ON DELETE CASCADE,
    reaction_type VARCHAR(20) NOT NULL, -- 'like', 'heart', 'laugh', 'wow', 'sad', 'angry'
    created_at    TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE (user_id, event_id)
);

-- Add indexes for efficient queries
CREATE INDEX idx_event_reaction_event_id ON event_reaction(event_id);
CREATE INDEX idx_event_reaction_user_event ON event_reaction(user_id, event_id);

