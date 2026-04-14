-- Soluciones práctica 3 SQL:
-- 1
SELECT c.name, c.first_surname, a.street, a.number, a.postal_code
FROM client c LEFT JOIN address a
ON c.id = a.client_id
WHERE a.id IS NOT NULL;

-- 2
SELECT DISTINCT c.name 
FROM client c LEFT JOIN order_head o
ON c.id = o.client_id
WHERE o.client_id IS NOT NULL
ORDER BY c.name ASC;

-- 3
SELECT COUNT(*)
FROM client
WHERE second_surname LIKE 'M%';

-- 4
SELECT c.name, c.first_surname, a.street, a.number, a.postal_code, o.order_date
FROM client c LEFT JOIN address a
ON c.id = a.client_id
LEFT JOIN order_head o
ON c.id = o.client_id
WHERE YEAR(birthdate) > 1980
AND YEAR(order_date) > 2019;

-- 5
SELECT c.* 
FROM client c LEFT JOIN address a
ON c.id = a.client_id
WHERE a.id IS NULL;

-- 6
SELECT order_id, count(*)
FROM order_detail
GROUP BY order_id;

-- 7
SELECT a.description, sum(o.qty_ordered) AS unidades_vendidas, sum(a.unit_price * o.qty_ordered)
FROM article a LEFT JOIN order_detail o
ON a.id = o.article_id
GROUP BY a.id, a.description
ORDER BY description ASC;

-- 8
SELECT description
FROM article
WHERE unit_price = (SELECT MAX(unit_price)
FROM article);

-- 9
SELECT a.description
FROM article a LEFT JOIN order_detail o
ON a.id = o.article_id
GROUP BY a.description
HAVING SUM(o.qty_ordered) >= 2;

-- 10
SELECT id, order_date
FROM order_head
WHERE id NOT IN (SELECT order_id
                 FROM order_detail
                 WHERE article_id = (SELECT id
                                     FROM article
                                     WHERE unit_price = (SELECT MIN(unit_price) FROM article)
                                    )
                );