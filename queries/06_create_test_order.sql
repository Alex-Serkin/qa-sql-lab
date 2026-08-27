-- QA SQL Lab
-- File: 06_create_test_order.sql
-- Description: Create a test order with product price
-- ===================================================


-- Create test order

INSERT INTO orders (
    id,
    user_id,
    status,
    total_amount,
    created_at,
    updated_at
)
SELECT
    nextval('qa_order_id_seq'),
    1,
    'pending',
    p.price,
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP
FROM products p
WHERE p.id = 1;


-- Add product to the test order

INSERT INTO order_items (
    id,
    order_id,
    product_id,
    quantity,
    unit_price
)
SELECT
    nextval('qa_order_item_id_seq'),
    currval('qa_order_id_seq'),
    p.id,
    1,
    p.price
FROM products p
WHERE p.id = 1;


-- Verify the created order

SELECT
    o.id AS order_id,
    o.user_id,
    o.status,
    o.total_amount,
    oi.product_id,
    p.name AS product_name,
    oi.quantity,
    oi.unit_price,
    oi.quantity * oi.unit_price AS item_total
FROM orders o
JOIN order_items oi
    ON oi.order_id = o.id
JOIN products p
    ON p.id = oi.product_id
WHERE o.id = currval('qa_order_id_seq');
