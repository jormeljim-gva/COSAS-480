-- Soluciones:
-- 1
SELECT DISTINCT c.name, c.first_surname
FROM client c INNER JOIN order_head h
ON c.id = h.client_id
INNER JOIN order_detail d
ON h.id = d.order_id
WHERE c.birthdate >= '1985-01-01'
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
-- Opción 1 (mi opción)
SELECT c.*
FROM client c LEFT JOIN address a
ON c.id = a.client_id
WHERE a.id NOT IN
(SELECT address_id
 FROM order_head
);

-- Opción 2 (Corrección)
SELECT DISTINCT c.*
FROM client c
INNER JOIN address a ON c.id = a.client_id
LEFT JOIN order_head oh ON a.id = oh.address_id
WHERE oh.address_id IS NULL;