CREATE SCHEMA `media` ;
use media;

DROP TABLE IF EXISTS users;
create table users (
	id SERIAL PRIMARY KEY,
    name VARCHAR(255) COMMENT 'Имя пользователя',
    users_id INT UNSIGNED NOT NULL COMMENT 'Айди юсера который будет использоваться в таблице products',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    foreign key (users_id) 
); 
insert into users (id, name) VALUES (1, 'hello');
select * from users;
DROP TABLE IF EXISTS media;
CREATE TABLE media (
  id SERIAL PRIMARY KEY,
  path_file TEXT COMMENT 'Путь до файла',
  media_id INT UNSIGNED COMMENT 'Для каждого типа контента фото/видео/аудио присваивается свой id номер, который потом в др таблицах использ',
  media_type CHAR ( 10 ) DEFAULT 'empty' COMMENT 'Описание это фото/видое/аудио',
  foreign key (id) references products(id)
);
DROP TABLE IF EXISTS products;
CREATE TABLE products (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Название медиафайла',
  desription TEXT COMMENT 'ключевые слова',
  media_id INT UNSIGNED COMMENT 'Для каждого типа контента фото/видео/аудио присваивается свой id номер, который потом в др таблицах использ',
  media_type CHAR ( 10 ) DEFAULT 'empty' COMMENT 'Описание это фото/видое/аудио',
  users_id INT UNSIGNED NOT NULL COMMENT 'Айди юсера который взят из таблицы users',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  KEY index_of_media_id (desription),
  foreign key (users_id) references users(users_id),
  foreign key (id) references media(id)
);