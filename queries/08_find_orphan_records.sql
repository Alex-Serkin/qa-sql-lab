-- QA SQL Lab
-- File: 08_find_orphan_records.sql
-- Description: Find orphan records caused by missing references
-- =============================================================


-- Find orders without a user

SELECT
    o.id AS order_id,
    o.user_id
FROM orders o
LEFT JOIN users u
    ON u.id = o.user_id
WHERE u.id IS NULL;


-- Find order items without an order

SELECT
    oi.id AS order_item_id,
    oi.order_id
FROM order_items oi
LEFT JOIN orders o
    ON o.id = oi.order_id
WHERE o.id IS NULL;


-- Find order items without a product

SELECT
    oi.id AS order_item_id,
    oi.product_id
FROM order_items oi
LEFT JOIN products p
    ON p.id = oi.product_id
WHERE p.id IS NULL;


-- Find payments without an order

SELECT
    p.id AS payment_id,
    p.order_id
FROM payments p
LEFT JOIN orders o
    ON o.id = p.order_id
WHERE o.id IS NULL;
