-- QA SQL Lab
-- File: 12_transaction_rollback.sql
-- Description: Roll back a successful order and payment transaction
-- =================================================================


BEGIN;

-- Create order

INSERT INTO orders (
    id,
    user_id,
    status,
    total_amount,
    created_at,
    updated_at
)
VALUES (
    nextval('qa_order_id_seq'),
    1,
    'pending',
    9990.00,
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP
);


-- Add product to the order

INSERT INTO order_items (
    id,
    order_id,
    product_id,
    quantity,
    unit_price
)
VALUES (
    nextval('qa_order_item_id_seq'),
    currval('qa_order_id_seq'),
    1,
    2,
    4995.00
);


-- Create payment for the order

INSERT INTO payments (
    id,
    order_id,
    transaction_id,
    amount,
    status,
    payment_method,
    created_at
)
VALUES (
    nextval('qa_payment_id_seq'),
    currval('qa_order_id_seq'),
    'TX-ROLLBACK-' || currval('qa_order_id_seq'),
    9990.00,
    'completed',
    'card',
    CURRENT_TIMESTAMP
);


-- Verify the changes before rollback

SELECT
    o.id AS order_id,
    o.status AS order_status,
    o.total_amount,
    p.id AS payment_id,
    p.transaction_id,
    p.amount AS payment_amount,
    p.status AS payment_status
FROM orders o
JOIN payments p
    ON p.order_id = o.id
WHERE o.id = currval('qa_order_id_seq');


-- Roll back all changes

ROLLBACK;

-- Verify that the order was not saved

SELECT
    id,
    status,
    total_amount
FROM orders
WHERE id = currval('qa_order_id_seq');


-- Verify that the order item was not saved

SELECT
    id,
    order_id,
    product_id,
    quantity,
    unit_price
FROM order_items
WHERE order_id = currval('qa_order_id_seq');


-- Verify that the payment was not saved

SELECT
    id,
    order_id,
    transaction_id,
    amount,
    status,
    payment_method
FROM payments
WHERE order_id = currval('qa_order_id_seq');
