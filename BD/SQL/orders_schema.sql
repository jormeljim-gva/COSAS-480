CREATE TABLE `client` (
	`id` int NOT NULL AUTO_INCREMENT,
	`name` varchar(30) NOT NULL,
	`first_surname` varchar(30) NOT NULL,
	`second_surname` varchar(30),
	`birthdate` DATE NOT NULL,
	PRIMARY KEY (`id`)
);

CREATE TABLE `order_head` (
	`id` int NOT NULL AUTO_INCREMENT,
	`client_id` int NOT NULL,
	`address_id` int NOT NULL,
	`order_date` DATE NOT NULL,
	PRIMARY KEY (`id`)
);

CREATE TABLE `address` (
	`id` int NOT NULL AUTO_INCREMENT,
	`street` varchar(50) NOT NULL,
	`number` int NOT NULL,
	`postal_code` varchar(5) NOT NULL,
	`client_id` int NOT NULL,
	PRIMARY KEY (`id`)
);

CREATE TABLE `order_detail` (
	`id` int NOT NULL AUTO_INCREMENT,
	`order_id` int NOT NULL,
	`article_id` int NOT NULL,
	`qty_ordered` int NOT NULL,
	`discount` FLOAT,
	PRIMARY KEY (`id`)
);

CREATE TABLE `article` (
	`id` int NOT NULL AUTO_INCREMENT,
	`description` varchar(100) NOT NULL,
	`stock_qty` int NOT NULL,
	`price` FLOAT NOT NULL,
	`unit_price` FLOAT NOT NULL,
	PRIMARY KEY (`id`)
);

ALTER TABLE `order_head` ADD CONSTRAINT `order_head_fk0` FOREIGN KEY (`client_id`) REFERENCES `client`(`id`);

ALTER TABLE `order_head` ADD CONSTRAINT `order_head_fk1` FOREIGN KEY (`address_id`) REFERENCES `address`(`id`);

ALTER TABLE `address` ADD CONSTRAINT `address_fk0` FOREIGN KEY (`client_id`) REFERENCES `client`(`id`);

ALTER TABLE `order_detail` ADD CONSTRAINT `order_detail_fk0` FOREIGN KEY (`order_id`) REFERENCES `order_head`(`id`);

ALTER TABLE `order_detail` ADD CONSTRAINT `order_detail_fk1` FOREIGN KEY (`article_id`) REFERENCES `article`(`id`);



INSERT INTO client (name, first_surname, second_surname, birthdate) VALUES ('Alejandro','Soler', 'Martínez', '2019-03-18'),('Vanessa','Martínez', 'Martínez', '1985-09-25'), ('Jano','Soler', 'Díaz', '1980-03-04');

INSERT INTO address (street, number, postal_code, client_id) VALUES ('Orfebres Santalínea', 3, '12005', 2), ('Orfebres Santalínea', 3, '12005', 3), ('Císcar', 13, '12003', 3);

INSERT INTO article (description, stock_qty, price, unit_price) VALUES ('Carro de paseo', 3, 1075, 1075), ('Bañera', 2, 119.35, 119.35), ('Minicuna', 1, 348.60, 348.60), ('Set de toallas', 5, 50, 10);

INSERT INTO order_head (client_id, address_id, order_date) VALUES (2,1,'2018-12-15'), (3,2,'2019-02-05'), (2,1,'2020-01-17'), (3,3,'2021-06-20');

INSERT INTO order_detail (order_id, article_id, qty_ordered, discount) VALUE (1,1,1,NULL), (2,2,1,10), (2,3,1,10), (3,1,1,5), (3,2,2,5), (3,3,2,10), (4,4,15,NULL);


-- Soluciones:
-- 1
SELECT DISTINCT c.name, c.first_surname
FROM client c INNER JOIN order_head h
ON c.id = h.client_id
INNER JOIN order_detail d
ON h.id = d.order_id
WHERE c.birthdate >= 1985-01-01
AND d.qty_ordered > 1;

-- 2
SELECT a.*
FROM article a LEFT JOIN order_detail d
ON a.id = d.article_id
WHERE d.article_id IS NULL
OR d.qty_ordered > 4;

-- 3
SELECT *, (price/unit_price) as Unidades
FROM article
WHERE price > unit_price;

-- 4
SELECT c.*
FROM client c LEFT JOIN address a
ON c.id = a.client_id
WHERE a.id NOT IN
(SELECT address_id
 FROM order_head
);