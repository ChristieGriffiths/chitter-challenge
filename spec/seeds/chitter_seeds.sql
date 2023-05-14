CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  username text,
  email_address text,
  password text
);

-- Then the table with the foreign key first.
CREATE TABLE posts (
  id SERIAL PRIMARY KEY,
  peep text,
  time_of_peep timestamp without time zone,
  user_id int,
  constraint fk_user foreign key(user_id)
    references users(id)
    on delete cascade
);
