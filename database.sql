CREATE TABLE users
(
    id         SERIAL PRIMARY KEY,
    first_name VARCHAR(50),
    last_name  VARCHAR(50),
    username   VARCHAR(50),
    email      VARCHAR(50),
    password   VARCHAR(50),
    create_at  DATE DEFAULT now(),
    update_at  DATE DEFAULT now()
);

CREATE TABLE file
(
    id        SERIAL PRIMARY KEY,
    file_name VARCHAR(200),
    mime_type VARCHAR(20),
    url       VARCHAR(200),
    key       VARCHAR(50),
    create_at DATE DEFAULT now(),
    update_at DATE DEFAULT now()
);

CREATE TABLE movie
(
    id           SERIAL PRIMARY KEY,
    title        VARCHAR(255),
    description  TEXT,
    budget       DECIMAL,
    release_date DATE,
    duration     interval,
    director     INT,
    country      INT,
    create_at    DATE DEFAULT now(),
    update_at    DATE DEFAULT now(),
    FOREIGN KEY (director) REFERENCES person (id),
    FOREIGN KEY (country) REFERENCES country (id)
);

CREATE TYPE roles AS ENUM ('leading','supporting', 'background');

CREATE TABLE character
(
    id          SERIAL PRIMARY KEY,
    name        VARCHAR(50),
    description TEXT,
    role        roles,
    create_at   DATE DEFAULT now(),
    update_at   DATE DEFAULT now()
);

CREATE type genders AS ENUM ('male', 'female', 'another');

CREATE TABLE person
(
    id         SERIAL PRIMARY KEY,
    first_name VARCHAR(50),
    last_name  VARCHAR(50),
    biography  TEXT,
    birthday   DATE,
    gender     genders,
    country    INT,
    create_at  DATE DEFAULT now(),
    update_at  DATE DEFAULT now(),
    FOREIGN KEY (country) REFERENCES country (id)
);

CREATE TABLE favorite_movie
(
    user_id  INT,
    movie_id INT,
    PRIMARY KEY (user_id, movie_id),
    FOREIGN KEY (user_id) REFERENCES users (id),
    FOREIGN KEY (movie_id) REFERENCES movie (id)
);

CREATE TABLE avatars
(
    user_id   INT,
    avatar_id INT,
    PRIMARY KEY (user_id, avatar_id),
    FOREIGN KEY (user_id) REFERENCES users (id),
    FOREIGN KEY (avatar_id) REFERENCES file (id)
);

CREATE TABLE posters
(
    movie_id  INT,
    poster_id INT,
    PRIMARY KEY (movie_id, poster_id),
    FOREIGN KEY (movie_id) REFERENCES movie (id),
    FOREIGN KEY (poster_id) REFERENCES file (id)
);

CREATE TABLE photos
(
    person_id INT,
    photo_id  INT,
    "primary" boolean,
    PRIMARY KEY (person_id, photo_id),
    FOREIGN KEY (person_id) REFERENCES person (id),
    FOREIGN KEY (photo_id) REFERENCES file (id)
);

SELECT *
FROM photos;

CREATE TABLE genre
(
    id   SERIAL PRIMARY KEY,
    name VARCHAR(50)
);

CREATE TABLE movie_genre
(
    movie_id INT,
    genre_id INT,
    PRIMARY KEY (movie_id, genre_id),
    FOREIGN KEY (movie_id) REFERENCES movie (id),
    FOREIGN KEY (genre_id) REFERENCES genre (id)
);

CREATE TABLE movie_character
(
    movie_id     INT,
    character_id INT,
    PRIMARY KEY (movie_id, character_id),
    FOREIGN KEY (movie_id) REFERENCES movie (id),
    FOREIGN KEY (character_id) REFERENCES character (id)
);

CREATE TABLE movie_actor
(
    movie_id  INT,
    person_id INT,
    PRIMARY KEY (movie_id, person_id),
    FOREIGN KEY (movie_id) REFERENCES movie (id),
    FOREIGN KEY (person_id) REFERENCES person (id)
);

CREATE TABLE country
(
    id   SERIAL PRIMARY KEY,
    name VARCHAR(255)
);