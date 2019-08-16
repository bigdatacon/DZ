/*Практическое задание тема №10
В базе данных Redis подберите коллекцию для подсчета посещений с определенных IP-адресов.
При помощи базы данных Redis решите задачу поиска имени пользователя по электронному адресу и наоборот, 
поиск электронного адреса пользователя по его имени.
Организуйте хранение категорий и товарных позиций учебной базы данных shop в СУБД MongoDB*/

/*1. Не знаю как решить*/
/*2. При помощи базы данных Redis решите задачу поиска имени пользователя по электронному адресу и наоборот, 

HSET IVANOV emeil "ivan@ya.ru"
HSET PETROV emeil "petr@ya.ru"
HKEYS IVAnoV

/*3 Организуйте хранение категорий и товарных позиций учебной базы данных shop в СУБД MongoDB*/

db.shop.update({name: 'Процессор'}, {description: 'intel' }, {price: '500' }, {catalog_id: '5' }, {created_at: NOW()}, {updated_at: NOW()}  )
db.shop.find()

/* справочно какие категории были в таблице товаров
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
) COMMENT = 'Товарные позиции';*/