CREATE TABLE cuser
(
    id            INT AUTO_INCREMENT PRIMARY KEY,
    full_name     VARCHAR(255),
    email         VARCHAR(255) UNIQUE,
    password      VARCHAR(255),
    date_of_birth DATE,
    country       VARCHAR(255),
    image         VARCHAR(255),
    role          INT NOT NULL, -- user = 1, admin = 2
    created_at    TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE event_post
(
    id               INT AUTO_INCREMENT PRIMARY KEY,
    title            VARCHAR(255),
    date             DATETIME,
    start_time       TIME,
    end_time         TIME,
    location         VARCHAR(255),
    description      TEXT,
    category         VARCHAR(255),
    images           TEXT,
    is_featured      BOOLEAN,
    new_notification BOOLEAN,
    user_id          INT,
    created_at       TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES cuser (id) ON DELETE CASCADE
);

CREATE TABLE event_comment
(
    id         INT AUTO_INCREMENT PRIMARY KEY,
    event_id   INT  NOT NULL,
    user_id    INT  NOT NULL,
    text       TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (event_id) REFERENCES event_post (id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES cuser (id) ON DELETE CASCADE
);

CREATE TABLE friendship
(
    id         INT AUTO_INCREMENT PRIMARY KEY,
    user_id_1  INT,
    user_id_2  INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id_1) REFERENCES cuser (id) ON DELETE CASCADE,
    FOREIGN KEY (user_id_2) REFERENCES cuser (id) ON DELETE CASCADE
);

CREATE TABLE event_favorite
(
    id         INT AUTO_INCREMENT PRIMARY KEY,
    user_id    INT,
    event_id   INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT unique_favorite UNIQUE (user_id, event_id),
    FOREIGN KEY (user_id) REFERENCES cuser (id) ON DELETE CASCADE,
    FOREIGN KEY (event_id) REFERENCES event_post (id) ON DELETE CASCADE
);

CREATE TABLE blog_post
(
    id          INT AUTO_INCREMENT PRIMARY KEY,
    title       VARCHAR(255),
    description TEXT,
    image       VARCHAR(255),
    user_id     INT,
    created_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES cuser (id) ON DELETE CASCADE
);

CREATE TABLE event_category
(
    id   INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);

CREATE TABLE event_wishlist
(
    id          INT AUTO_INCREMENT PRIMARY KEY,
    title       VARCHAR(255),
    location    VARCHAR(255),
    description TEXT,
    category    VARCHAR(50),
    images      TEXT,
    user_id     INT NOT NULL,
    created_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES cuser (id) ON DELETE CASCADE
);

CREATE TABLE invitation
(
    id             INT AUTO_INCREMENT PRIMARY KEY,
    sender_id      INT          NOT NULL,
    receiver_email VARCHAR(255) NOT NULL,
    token          VARCHAR(255) NOT NULL,
    is_accepted    BOOLEAN,
    created_at     TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (sender_id) REFERENCES cuser (id) ON DELETE CASCADE
);

CREATE TABLE pages
(
    id          INT AUTO_INCREMENT PRIMARY KEY,
    title       VARCHAR(255) NOT NULL,
    description TEXT,
    name        VARCHAR(255) NOT NULL
);

CREATE TABLE password_reset
(
    id         INT AUTO_INCREMENT PRIMARY KEY,
    email      VARCHAR(255) NOT NULL,
    token      VARCHAR(255) NOT NULL,
    created_at TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE user_settings
(
    id                              INT AUTO_INCREMENT PRIMARY KEY,
    email_new_event_notification    BOOLEAN,
    email_update_event_notification BOOLEAN,
    email_new_comment_notification  BOOLEAN,
    sort                            varchar(50),
    user_id                         INT NOT NULL,
    FOREIGN KEY (user_id) REFERENCES cuser (id) ON DELETE CASCADE
);

--added
CREATE TABLE subscription_plan
(
    id      int AUTO_INCREMENT PRIMARY KEY,
    title   varchar(255) NOT NULL,
    tagline varchar(255),
    price   decimal(10, 2)
);

--added
CREATE TABLE subscription
(
    id                     int AUTO_INCREMENT PRIMARY KEY,
    user_id                int            NOT NULL,
    plan_id                int            NOT NULL,
    stripe_subscription_id varchar(255)   NOT NULL,
    subscription_amount    decimal(10, 2) NOT NULL,
    activation_date        TIMESTAMP      NOT NULL,
    expire_date            TIMESTAMP      NOT NULL,
    active                 BOOLEAN        NOT NULL,
    pending_cancel         BOOLEAN,
    created_at             TIMESTAMP      NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES cuser (id) ON DELETE CASCADE,
    FOREIGN KEY (plan_id) REFERENCES subscription_plan (id)
);

ALTER DATABASE wayzaway COLLATE utf8mb4_unicode_ci;
USE wayzaway;
ALTER TABLE event_comment CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;