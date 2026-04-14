CREATE TABLE `book` (
	`id` int NOT NULL AUTO_INCREMENT,
	`title` varchar(200) NOT NULL,
	`pages` int NOT NULL,
	`editorial` varchar(100) NOT NULL,
	PRIMARY KEY (`id`)
);

CREATE TABLE `book_writer_rel` (
	`book_id` int NOT NULL,
	`writer_id` int NOT NULL,
	PRIMARY KEY (`book_id`,`writer_id`)
);

CREATE TABLE `writer` (
	`id` int NOT NULL AUTO_INCREMENT,
	`name` varchar(50) NOT NULL,
	`first_surname` varchar(50) NOT NULL,
	`second_surname` varchar(50),
	PRIMARY KEY (`id`)
);

CREATE TABLE `member` (
	`id` int NOT NULL AUTO_INCREMENT,
	`name` varchar(50) NOT NULL,
	`first_surname` varchar(50) NOT NULL,
	`second_surname` varchar(50),
	`email` varchar(100) NOT NULL,
	`telephone_number` varchar(14),
	PRIMARY KEY (`id`)
);

CREATE TABLE `worker` (
	`id` int NOT NULL AUTO_INCREMENT,
	`name` varchar(50) NOT NULL,
	`first_surname` varchar(50) NOT NULL,
	`second_surname` varchar(50),
	`email` varchar(100) NOT NULL,
	`telephone_number` varchar(14),
	`start_date` DATE NOT NULL,
	PRIMARY KEY (`id`)
);

CREATE TABLE `book_loan` (
	`id` int NOT NULL AUTO_INCREMENT,
	`book_id` int NOT NULL,
	`member_id` int NOT NULL,
	`worker_id` int NOT NULL,
	`start_date` DATE NOT NULL,
	`finish_date` DATE NOT NULL,
	`days_late` int NOT NULL,
	PRIMARY KEY (`id`)
);

ALTER TABLE `book_writer_rel` ADD CONSTRAINT `book_writer_rel_fk0` FOREIGN KEY (`book_id`) REFERENCES `book`(`id`);

ALTER TABLE `book_writer_rel` ADD CONSTRAINT `book_writer_rel_fk1` FOREIGN KEY (`writer_id`) REFERENCES `writer`(`id`);

ALTER TABLE `book_loan` ADD CONSTRAINT `book_loan_fk0` FOREIGN KEY (`book_id`) REFERENCES `book`(`id`);

ALTER TABLE `book_loan` ADD CONSTRAINT `book_loan_fk1` FOREIGN KEY (`member_id`) REFERENCES `member`(`id`);

ALTER TABLE `book_loan` ADD CONSTRAINT `book_loan_fk2` FOREIGN KEY (`worker_id`) REFERENCES `worker`(`id`);


INSERT INTO book (title, pages, editorial)
VALUES ('Designing data-intensive applications', 613, "O'Reilly Media, Inc."),
("Head First Design Patterns", 619, "O'Reilly Media, Inc."),
("Effective TypeScript", 266, "O'Reilly Media, Inc."), 
("The Nature of Software Development", 180, "The Pragmatic Programmers, LLC"),
("El lazarillo de Tormes", 80, "Espasa Calpe");


INSERT INTO writer (name, first_surname, second_surname)
VALUES ("Martin", "Kleppmann", NULL),
("Eric", "Freeman", NULL),
("Elisabeth", "Robson", NULL),
("Bert", "Bates", NULL),
("Kathy", "Sierra", NULL),
("Dan", "Vanderkam", NULL), 
("Ron", "Jeffries", NULL),
("Camilo José", "Cela", "Trulock");


INSERT INTO book_writer_rel
VALUES (1,1),(2,2), (2,3), (2,4), (2,5), (3,6), (4,7);


INSERT INTO member (name, first_surname, second_surname, email, telephone_number)
VALUES ("Arturo", "Velázquez", "Madrid", "arturo.velazquez@cuatroochenta.com", "+34636125478"),
("Simone", "Szijarto", NULL, "simone.szijarto@cuatrochenta.com", "0034632256652"),
("Esteban", "Olucha", "Buendía", "esteban.olucha@cuatroochenta.com", NULL),
("Óscar", "Escribano", "Cabezuelo", "oscar.escribano@cuatroochenta.com", "695564333"),
("Raquel", "Alvear", NULL, "raquel.alvear@cuatroochenta.com", NULL),
("Álvaro", "Morales", "Guevara", "alvaro.morales@cuatroochenta.com", NULL);


INSERT INTO worker (name, first_surname, second_surname, email, telephone_number, start_date)
VALUES ("Sergio", "Aguado", "González", "sergio.aguado@cuatroochenta.com", NULL, "2011-01-01"),
("Jano", "Soler", "Díaz", "jano.soler@xarxatecactiva.com", "695654587", "2021-05-24");


INSERT INTO book_loan (book_id, member_id, worker_id, start_date, finish_date, days_late)
VALUES (2,4,1,"2019-02-01", "2019-02-16", 5),
(2,1,2,"2019-02-14", "2019-03-01", 10),
(3,1,2,"2020-04-05", "2020-04-20", 0),
(4,5,1,"2020-12-01", "2020-12-16", 0),
(1,3,1,"2021-01-13", "2021-01-28", 17);


---------------------------------Soluciones ejemplos-----------------------------------

SELECT title, pages 
FROM book 
WHERE pages>300;

SELECT id, name, first_surname, email 
FROM member 
WHERE email LIKE '%cuatroochenta.com' AND second_surname IS NOT NULL;

SELECT id, name, first_surname, telephone_number 
FROM member 
WHERE telephone_number LIKE '+34%' 
OR telephone_number IS NULL;

----------------------------Ejercicios de la presentación------------------------------

-- Ejercicios consultas sobre varias tablas
-- 1
SELECT b.title, w.name, w.first_surname 
FROM book b INNER JOIN book_writer_rel bwr 
ON b.id = bwr.book_id
INNER JOIN writer w 
ON bwr.writer_id = w.id

-- 2
SELECT b.title, m.name, m.first_surname, m.second_surname, w.name, w.first_surname, l.start_date
FROM book_loan l 
INNER JOIN book b
ON l.book_id = b.id
INNER JOIN member m
ON l.member_id = m.id
INNER JOIN worker w
ON l.worker_id = w.id;

-- 3
SELECT name, first_surname, email
FROM member
WHERE email LIKE '%@cuatroochenta.com'
UNION
SELECT name, first_surname, email
FROM worker
WHERE email LIKE '%@cuatroochenta.com';




-- Ejercicios JOIN mix
-- 1
SELECT b.title, l.start_date 
FROM book b RIGHT JOIN book_loan l
ON b.id = l.book_id;

-- 2
SELECT m.*, l.*
FROM member m LEFT JOIN book_loan l
ON m.id = l.book_id;

-- 3
SELECT DISTINCT b.title
FROM book b LEFT JOIN book_loan l
ON b.id != l.book_id
WHERE l.book_id IS NOT NULL;




-- Ejercicios consultas con agrupaciones
-- 1

-- 3
SELECT b.title, b.pages, count(bw.writer_id) AS num_autors
FROM book b INNER JOIN book_writer_rel bw
ON b.id = bw.book_id
GROUP BY b.id
HAVING num_autors > 1
ORDER BY b.pages DESC;




-- subconsultas
-- 1
SELECT title
FROM book
WHERE pages = (SELECT MIN(pages) 
               FROM book);

-- 2
SELECT m.name, m.first_surname, SUM(bl.days_late) AS total_dates_late
FROM member m INNER JOIN book_loan bl
ON m.id = bl.member_id
WHERE m.id IN (SELECT DISTINCT m.id
               FROM member m INNER JOIN book_loan bl ON m.id = bl.member_id
               WHERE YEAR(finish_date) >= 2020)
GROUP BY m.id
ORDER BY total_dates_late ASC;

-- 3
SELECT b.title
FROM book b LEFT JOIN book_writer_rel bw
ON b.id = bw.book_id
GROUP BY b.title
HAVING COUNT(writer_id) > (
	SELECT AVG(num_writer)
	FROM (
		SELECT book_id, COUNT(writer_id) AS num_writer
		FROM book_writer_rel
		GROUP BY book_id
		)
	AS cantidad_escritores
	);


 