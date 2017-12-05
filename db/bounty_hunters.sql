DROP TABLE IF EXISTS bounty;

CREATE TABLE bounty (
 id SERIAL8 PRIMARY KEY,
 name VARCHAR(255) NOT NULL,
 species VARCHAR(255),
 bounty_value INT2,
 fav_weapon VARCHAR(255)

);
