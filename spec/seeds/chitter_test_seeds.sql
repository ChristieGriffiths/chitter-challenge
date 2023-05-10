DROP TABLE IF EXISTS users, posts; 

CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  username text,
  email_address text
);

-- Then the table with the foreign key first.
CREATE TABLE posts (
  id SERIAL PRIMARY KEY,
  peep text,
  time_of_peep timestamp without time zone default current_timestamp,
  user_id int,
  constraint fk_user foreign key(user_id)
    references users(id)
    on delete cascade
);

TRUNCATE TABLE users, posts RESTART IDENTITY;

INSERT INTO users ("username", "email_address") VALUES
('Pixie', 'dust@gmail.com'),
('voyagenow', 'abba@gmail.com'),
('Taylor', 'taylor@hotmail.com');

-- TRUNCATE posts RESTART IDENTITY; 

INSERT INTO posts ("peep", "time_of_peep", "user_id") VALUES
('Just saw the queen', '2022-01-01 09:00:35', '3'),
('Flew to Valencia', '2021-12-12 09:10:15', '3'),
('Bought a rabit', '2022-01-15 09:30:00', '1');