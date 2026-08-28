-- QA SQL Lab
-- File: 07_delete_test_data.sql
-- Description: Delete manual QA test data
-- =======================================


BEGIN;

-- Delete manual QA order items

DELETE FROM order_items
WHERE order_id >= 1000
  AND order_id < 10000;


-- Delete manual QA payments

DELETE FROM payments
WHERE order_id >= 1000
  AND order_id < 10000;


-- Delete manual QA orders

DELETE FROM orders
WHERE id >= 1000
  AND id < 10000;


-- Delete manual QA products

DELETE FROM products
WHERE id >= 1000
  AND id < 10000;


-- Delete manual QA users

DELETE FROM users
WHERE id >= 1000
  AND id < 10000;


-- Verify the result before finishing the transaction

SELECT
    (SELECT COUNT(*)
     FROM users
     WHERE id >= 1000 AND id < 10000) AS remaining_users,

    (SELECT COUNT(*)
     FROM products
     WHERE id >= 1000 AND id < 10000) AS remaining_products,

    (SELECT COUNT(*)
     FROM orders
     WHERE id >= 1000 AND id < 10000) AS remaining_orders,

    (SELECT COUNT(*)
     FROM order_items oi
     JOIN orders o
         ON o.id = oi.order_id
     WHERE o.id >= 1000 AND o.id < 10000) AS remaining_order_items,

    (SELECT COUNT(*)
     FROM payments p
     JOIN orders o
         ON o.id = p.order_id
     WHERE o.id >= 1000 AND o.id < 10000) AS remaining_payments;



-- Transaction control

ROLLBACK;       -- Test deletion without saving changes
-- COMMIT;     -- Permanently delete changes

-- Verify that deleted QA data was restored after ROLLBACK

SELECT id FROM users WHERE id >= 1000 AND id < 10000;
SELECT id FROM products WHERE id >= 1000 AND id < 10000;
SELECT id FROM orders WHERE id >= 1000 AND id < 10000;
SELECT order_id FROM order_items WHERE order_id >= 1000 AND order_id < 10000;
SELECT order_id FROM payments WHERE order_id >= 1000 AND order_id < 10000;
