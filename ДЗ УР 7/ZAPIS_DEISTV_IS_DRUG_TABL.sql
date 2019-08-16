/*Создайте таблицу logs типа Archive. 
Пусть при каждом создании записи в таблицах users, catalogs и products в таблицу 
logs помещается время и дата создания записи, название таблицы, 
идентификатор первичного ключа и содержимое поля name. решение на строках 39 - 76 
НО ПРИ Этом когда в 77 строке нажимаю select * from logs пишет что Trigger arready exist, хотя когда выполняются все команды
то никаких ошибок нет
*/

use shop;
DROP TABLE IF EXISTS catalogs;
CREATE TABLE catalogs (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Название раздела',
  UNIQUE unique_name(name(10))
) COMMENT = 'Разделы интернет-магазина';

INSERT INTO catalogs VALUES
  (NULL, 'Процессоры'),
  (NULL, 'Материнские платы'),
  (NULL, 'Видеокарты'),
  (NULL, 'Жесткие диски'),
  (NULL, 'Оперативная память');

DROP TABLE IF EXISTS rubrics;
CREATE TABLE rubrics (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Название раздела'
) COMMENT = 'Разделы интернет-магазина';

INSERT INTO rubrics VALUES
  (NULL, 'Видеокарты'),
  (NULL, 'Память');

DROP TABLE IF EXISTS users;
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Имя покупателя',
  birthday_at DATE COMMENT 'Дата рождения',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Покупатели';
/*Создайте таблицу logs типа Archive. 
Пусть при каждом создании записи в таблицах users, catalogs и products в таблицу 
logs помещается время и дата создания записи, название таблицы, 
идентификатор первичного ключа и содержимое поля name.*/

DROP TABLE IF EXISTS logs;
CREATE TABLE logs (
id INT(10) UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
datechange DATETIME default CURRENT_TIMESTAMP, -- дата
nametable VARCHAR(40), -- имя таблицы
id_first_key VARCHAR(10), -- номер первичного ключа
name VARCHAR(100) -- содержимое поля name
) ENGINE=Archive;
/*Создание трех триггеров.*/
DELIMITER \\
DROP TRIGGER IF EXISTS `insert_users`\\
CREATE TRIGGER `insert_users` AFTER INSERT ON `users`
FOR EACH ROW BEGIN
INSERT INTO logs Set id_first_key = NEW.id, nametable = 'users', name = NEW.name;
END\\
DROP TRIGGER IF EXISTS `insert_catalogs`\\
CREATE TRIGGER `insert_catalogs` AFTER INSERT ON `catalogs`
FOR EACH ROW BEGIN
INSERT INTO logs Set id_first_key = NEW.id, nametable = 'catalogs', name =
NEW.name;
END\\

DROP TRIGGER IF EXISTS `insert_products`\\
CREATE TRIGGER `insert_products` AFTER INSERT ON `products`
FOR EACH ROW BEGIN
INSERT INTO logs Set id_first_key = NEW.id, nametable = 'products', name =
NEW.name;
END\\
/*Запросы на вставку*/
INSERT INTO users(id,name,birthday_at) VALUES(8,'Надежда','1970-11-29');
INSERT INTO catalogs(id,name) VALUES(3,'Видеокарта');
INSERT INTO products(id,name,description,price,catalog_id) VALUES(8,'NVIDIA
1080TI','Видеокарта',23000.00,3);
select * from logs;

INSERT INTO users (name, birthday_at) VALUES
  ('Геннадий', '1990-10-05'),
  ('Наталья', '1984-11-12'),
  ('Александр', '1985-05-20'),
  ('Сергей', '1988-02-14'),
  ('Иван', '1998-01-12'),
  ('Мария', '1992-08-29');


DROP TABLE IF EXISTS products;
CREATE TABLE products (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Название',
  description TEXT COMMENT 'Описание',
  price DECIMAL (11,2) COMMENT 'Цена',
  catalog_id INT UNSIGNED,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  KEY index_of_catalog_id (catalog_id)
) COMMENT = 'Товарные позиции';

INSERT INTO products
  (name, description, price, catalog_id)
VALUES
  ('Intel Core i3-8100', 'Процессор для настольных персональных компьютеров, основанных на платформе Intel.', 7890.00, 1),
  ('Intel Core i5-7400', 'Процессор для настольных персональных компьютеров, основанных на платформе Intel.', 12700.00, 1),
  ('AMD FX-8320E', 'Процессор для настольных персональных компьютеров, основанных на платформе AMD.', 4780.00, 1),
  ('AMD FX-8320', 'Процессор для настольных персональных компьютеров, основанных на платформе AMD.', 7120.00, 1),
  ('ASUS ROG MAXIMUS X HERO', 'Материнская плата ASUS ROG MAXIMUS X HERO, Z370, Socket 1151-V2, DDR4, ATX', 19310.00, 2),
  ('Gigabyte H310M S2H', 'Материнская плата Gigabyte H310M S2H, H310, Socket 1151-V2, DDR4, mATX', 4790.00, 2),
  ('MSI B250M GAMING PRO', 'Материнская плата MSI B250M GAMING PRO, B250, Socket 1151, DDR4, mATX', 5060.00, 2);

DROP TABLE IF EXISTS orders;
CREATE TABLE orders (
  id SERIAL PRIMARY KEY,
  user_id INT UNSIGNED,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  KEY index_of_user_id(user_id)
) COMMENT = 'Заказы';

DROP TABLE IF EXISTS orders_products;
CREATE TABLE orders_products (
  id SERIAL PRIMARY KEY,
  order_id INT UNSIGNED,
  product_id INT UNSIGNED,
  total INT UNSIGNED DEFAULT 1 COMMENT 'Количество заказанных товарных позиций',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Состав заказа';

DROP TABLE IF EXISTS discounts;
CREATE TABLE discounts (
  id SERIAL PRIMARY KEY,
  user_id INT UNSIGNED,
  product_id INT UNSIGNED,
  discount FLOAT UNSIGNED COMMENT 'Величина скидки от 0.0 до 1.0',
  started_at DATETIME,
  finished_at DATETIME,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  KEY index_of_user_id(user_id),
  KEY index_of_product_id(product_id)
) COMMENT = 'Скидки';

DROP TABLE IF EXISTS storehouses;
CREATE TABLE storehouses (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Название',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Склады';

DROP TABLE IF EXISTS storehouses_products;
CREATE TABLE storehouses_products (
  id SERIAL PRIMARY KEY,
  storehouse_id INT UNSIGNED,
  product_id INT UNSIGNED,
  value INT UNSIGNED COMMENT 'Запас товарной позиции на складе',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Запасы на складе';

select * from catalogs;
select * from products;
select * from users;
select * from orders;
INSERT INTO orders
  (user_id)
VALUES
  (1),
  (2);
SELECT
  id,
  user_id,
  (SELECT name FROM users WHERE id = user_id) AS 'kupil'
FROM
  orders;

SELECT
  id,
  name,
  (SELECT name FROM catalogs WHERE id = catalog_id) AS 'catalog_NAME'
FROM
  products;
  
DELIMITER //
/*
CREATE TRIGGER check_last_catalogs BEFORE INSERT ON products
FOR EACH ROW BEGIN
DECLARE name VARCHAR(255);
DECLARE description TEXT;
SELECT name, description FROM products;
IF name is null and description is null THEN
SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'INSERT canceled';
END IF;
END //
INSERT INTO products
(name, description )
VALUES
( null, null)//
select name, description from products//*/