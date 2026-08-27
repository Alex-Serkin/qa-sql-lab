-- QA SQL Lab
-- File: 07_delete_python_test_data.sql
-- Description: Delete Python-generated test data
-- ==============================================


BEGIN;

-- Delete Python-generated order items

DELETE FROM order_items
WHERE order_id >= 10000;


-- Delete Python-generated payments

DELETE FROM payments
WHERE order_id >= 10000;


-- Delete Python-generated orders

DELETE FROM orders
WHERE id >= 10000;


-- Delete Python-generated products

DELETE FROM products
WHERE id >= 10000;


-- Delete Python-generated users

DELETE FROM users
WHERE id >= 10000;


-- Verify the result before finishing the transaction

SELECT
    (SELECT COUNT(*)
     FROM users
     WHERE id >= 10000) AS remaining_users,

    (SELECT COUNT(*)
     FROM products
     WHERE id >= 10000) AS remaining_products,

    (SELECT COUNT(*)
     FROM orders
     WHERE id >= 10000) AS remaining_orders,

    (SELECT COUNT(*)
     FROM order_items oi
     JOIN orders o
         ON o.id = oi.order_id
     WHERE o.id >= 10000) AS remaining_order_items,

    (SELECT COUNT(*)
     FROM payments p
     JOIN orders o
         ON o.id = p.order_id
     WHERE o.id >= 10000) AS remaining_payments;


-- Transaction control

ROLLBACK;       -- Test deletion without saving changes
-- COMMIT;     -- Permanently delete changes
