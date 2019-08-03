/* Задание: Переместите запись id = 1 из таблицы shop.users в таблицу sample.users. Используйте транзакции.
Создал новую базу данных, по тем скприптам которые есть в интеренет из одной базы данных в другую перенести не удалось (решение 
на строках 38-42, но удалось перенести данные из 1 таблицы в другую, решение на строках 28-32*/


use shop_dubl;
DROP TABLE IF EXISTS users;
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Имя покупателя',
  birthday_at DATE COMMENT 'Дата рождения',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Покупатели';

DROP TABLE IF EXISTS users2;
CREATE TABLE users2 (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Имя покупателя',
  birthday_at DATE COMMENT 'Дата рождения',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Покупатели';
INSERT INTO users (name, birthday_at) VALUES
  ('Наталья', '1984-11-12'),
  ('Александр', '1985-05-20');

select * from users;
START TRANSACTION; 
INSERT INTO users2 SELECT * FROM users WHERE id = 1;
COMMIT;
select * from users2;
/*
INSERT INTO users (name, birthday_at) VALUES
  ('Наталья', '1984-11-12'),
  ('Александр', '1985-05-20');
  
select * from users;
select * into [shop_dubl].[dbo].[users] from [shop].[dbo].[users];
select * from users;
select * into shop_dubl.users from shop.users;*/

