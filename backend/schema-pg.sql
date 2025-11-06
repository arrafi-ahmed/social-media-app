CREATE TABLE users -- updated
(
    id            SERIAL PRIMARY KEY,
    full_name     VARCHAR(255),
    email         VARCHAR(255) UNIQUE,
    password      VARCHAR(255),
    date_of_birth DATE,
    country       VARCHAR(255),
    image         VARCHAR(255),
    slug          VARCHAR(255) UNIQUE,
    role          INTEGER NOT NULL, -- admin = 10, user = 20,
    created_at    TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE event_post
(
    id               SERIAL PRIMARY KEY,
    title            VARCHAR(255),
    date             TIMESTAMP,
    start_time       TIME,
    end_time         TIME,
    location         VARCHAR(255),
    description      TEXT,
    category         VARCHAR(255),
    images           JSONB, --updated
    is_featured      BOOLEAN,
    new_notification BOOLEAN,
    user_id          INTEGER REFERENCES users (id) ON DELETE CASCADE,
    expires_at       TIMESTAMP,  --added
    created_at       TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE event_comment
(
    id         SERIAL PRIMARY KEY,
    event_id   INTEGER NOT NULL REFERENCES event_post (id) ON DELETE CASCADE,
    user_id    INTEGER NOT NULL REFERENCES users (id) ON DELETE CASCADE,
    text       TEXT    NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE comment_mention
(
    id               SERIAL PRIMARY KEY,
    comment_id       INTEGER NOT NULL REFERENCES event_comment (id) ON DELETE CASCADE,
    mentioned_user_id INTEGER NOT NULL REFERENCES users (id) ON DELETE CASCADE,
    created_at       TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE (comment_id, mentioned_user_id)
);

CREATE TABLE friendship
(
    id         SERIAL PRIMARY KEY,
    user_id_1  INTEGER REFERENCES users (id) ON DELETE CASCADE,
    user_id_2  INTEGER REFERENCES users (id) ON DELETE CASCADE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE event_collection_item
(
    id            SERIAL PRIMARY KEY,
    user_id       INTEGER NOT NULL REFERENCES users (id) ON DELETE CASCADE,
    event_id      INTEGER NOT NULL REFERENCES event_post (id) ON DELETE CASCADE,
    collection_id INTEGER REFERENCES event_collection (id) ON DELETE CASCADE,
    created_at    TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE (user_id, event_id)
);

CREATE TABLE blog_post
(
    id          SERIAL PRIMARY KEY,
    title       VARCHAR(255),
    description TEXT,
    image       TEXT,
    user_id     INTEGER REFERENCES users (id) ON DELETE CASCADE,
    created_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE event_category
(
    id   SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);

CREATE TABLE event_wishlist
(
    id          SERIAL PRIMARY KEY,
    title       VARCHAR(255),
    location    VARCHAR(255),
    description TEXT,
    category    VARCHAR(50),
    images      JSONB, --updated
    user_id     INTEGER NOT NULL REFERENCES users (id) ON DELETE CASCADE,
    created_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE invitation
(
    id             SERIAL PRIMARY KEY,
    sender_id      INTEGER      NOT NULL REFERENCES users (id) ON DELETE CASCADE,
    receiver_email VARCHAR(255) NOT NULL,
    token          VARCHAR(255) NOT NULL,
    is_accepted    BOOLEAN,
    created_at     TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE pages
(
    id          SERIAL PRIMARY KEY,
    title       VARCHAR(255) NOT NULL,
    description JSONB, --updated
    name        VARCHAR(255) NOT NULL
);

CREATE TABLE password_reset
(
    id         SERIAL PRIMARY KEY,
    email      VARCHAR(255) NOT NULL,
    token      VARCHAR(255) NOT NULL,
    created_at TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE user_settings
(
    id                              SERIAL PRIMARY KEY,
    email_new_event_notification    BOOLEAN,
    email_update_event_notification BOOLEAN,
    email_new_comment_notification  BOOLEAN,
    sort                            VARCHAR(50),
    theme                           VARCHAR(20), -- added
    user_id                         INTEGER NOT NULL users (id) ON DELETE CASCADE
);

CREATE TABLE subscription_plan
(
    id         SERIAL PRIMARY KEY,
    title      VARCHAR(255) NOT NULL,
    tagline    VARCHAR(255),
    price      DECIMAL(10, 2),
    currency   VARCHAR(3) DEFAULT 'GBP', -- added
    lookup_key VARCHAR(255) UNIQUE       -- added
);

-- Insert subscription plans
INSERT INTO subscription_plan (id, title, tagline, price, currency, lookup_key)
VALUES (1, 'Ultimate', '* renews every year', 39.95, 'GBP', 'ultimate_yearly'),
       (2, 'Standard', '* renews every month', 4.95, 'GBP', 'standard_monthly'),
       (3, 'Basic', '* Free lifetime', 0.00, 'GBP', 'basic_free');

CREATE TABLE subscription
(
    id                     SERIAL PRIMARY KEY,
    user_id                INTEGER        NOT NULL REFERENCES users (id) ON DELETE CASCADE,
    plan_id                INTEGER        NOT NULL REFERENCES subscription_plan (id),
    stripe_subscription_id VARCHAR(255)   NOT NULL,
    subscription_amount    DECIMAL(10, 2) NOT NULL,
    activation_date        TIMESTAMP      NOT NULL,
    expire_date            TIMESTAMP      NOT NULL,
    active                 BOOLEAN        NOT NULL,
    pending_cancel         BOOLEAN,
    created_at             TIMESTAMP      NOT NULL DEFAULT CURRENT_TIMESTAMP
);

--added
CREATE TABLE event_reaction
(
    id            SERIAL PRIMARY KEY,
    user_id       INTEGER REFERENCES users (id) ON DELETE CASCADE,
    event_id      INTEGER REFERENCES event_post (id) ON DELETE CASCADE,
    reaction_type VARCHAR(20) NOT NULL, -- 'like', 'heart', 'laugh', 'wow', 'sad', 'angry'
    created_at    TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE (user_id, event_id)
);
-- added
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
-- added
CREATE TABLE event_collection_item
(
    id            SERIAL PRIMARY KEY,
    user_id       INTEGER NOT NULL REFERENCES users (id) ON DELETE CASCADE,
    event_id      INTEGER NOT NULL REFERENCES event_post (id) ON DELETE CASCADE,
    collection_id INTEGER REFERENCES event_collection (id) ON DELETE CASCADE,
    created_at    TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE (user_id, event_id)
);
--added
CREATE TABLE comment_mention
(
    id               SERIAL PRIMARY KEY,
    comment_id       INTEGER NOT NULL REFERENCES event_comment (id) ON DELETE CASCADE,
    mentioned_user_id INTEGER NOT NULL REFERENCES users (id) ON DELETE CASCADE,
    created_at       TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE (comment_id, mentioned_user_id)
);
--added
CREATE TABLE user_group (
    id          SERIAL PRIMARY KEY,
    user_id     INTEGER REFERENCES users(id) ON DELETE CASCADE,
    name        VARCHAR(255) NOT NULL,
    description TEXT,
    color       VARCHAR(7),  -- Hex color code (e.g., #FF5733)
    icon        VARCHAR(50), -- MDI icon name (e.g., 'mdi-account-group')
    created_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
--added
CREATE TABLE group_member (
    id         SERIAL PRIMARY KEY,
    group_id   INTEGER REFERENCES user_group(id) ON DELETE CASCADE,
    user_id    INTEGER REFERENCES users(id) ON DELETE CASCADE,
    role       VARCHAR(20) DEFAULT 'member', -- 'owner', 'admin', 'member'
    joined_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE (group_id, user_id)
);
--added
CREATE TABLE event_group (
    id         SERIAL PRIMARY KEY,
    event_id   INTEGER REFERENCES event_post(id) ON DELETE CASCADE,
    group_id   INTEGER REFERENCES user_group(id) ON DELETE CASCADE,
    shared_by  INTEGER REFERENCES users(id) ON DELETE CASCADE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE (event_id, group_id)
);

CREATE
DATABASE wayzaway
  WITH ENCODING 'UTF8'
       LC_COLLATE='en_US.utf8'
       LC_CTYPE='en_US.utf8'
       TEMPLATE=template0;

ALTER TABLE event_comment
ALTER
COLUMN comment_text TYPE text COLLATE "en_US.utf8";


-- Create indexes
CREATE INDEX idx_users_id ON users (id);
CREATE INDEX idx_users_full_name ON users (full_name);
CREATE INDEX idx_users_email ON users (email);
