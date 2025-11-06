-- Create user_group table
CREATE TABLE user_group (
    id          SERIAL PRIMARY KEY,
    user_id     INTEGER REFERENCES users(id) ON DELETE CASCADE,
    name        VARCHAR(255) NOT NULL,
    description TEXT,
    color       VARCHAR(7),  -- Hex color code (e.g., #FF5733)
    icon        VARCHAR(50), -- MDI icon name (e.g., 'mdi-account-group')
    created_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create group_member table
CREATE TABLE group_member (
    id         SERIAL PRIMARY KEY,
    group_id   INTEGER REFERENCES user_group(id) ON DELETE CASCADE,
    user_id    INTEGER REFERENCES users(id) ON DELETE CASCADE,
    role       VARCHAR(20) DEFAULT 'member', -- 'owner', 'admin', 'member'
    joined_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE (group_id, user_id)
);

-- Create event_group table for sharing events with groups
CREATE TABLE event_group (
    id         SERIAL PRIMARY KEY,
    event_id   INTEGER REFERENCES event_post(id) ON DELETE CASCADE,
    group_id   INTEGER REFERENCES user_group(id) ON DELETE CASCADE,
    shared_by  INTEGER REFERENCES users(id) ON DELETE CASCADE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE (event_id, group_id)
);

-- Add indexes for performance
CREATE INDEX idx_user_group_user_id ON user_group(user_id);
CREATE INDEX idx_group_member_user_id ON group_member(user_id);
CREATE INDEX idx_group_member_group_id ON group_member(group_id);
CREATE INDEX idx_event_group_event_id ON event_group(event_id);
CREATE INDEX idx_event_group_group_id ON event_group(group_id);
CREATE INDEX idx_event_group_shared_by ON event_group(shared_by);

