-- QA SQL Lab
-- File: 13_transaction_rollback_on_error.sql
-- Description: Roll back transaction after an error
-- =================================================


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
    7990.00,
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
    1,
    7990.00
);


-- Create payment with an invalid order_id
-- This statement should fail because of the foreign key constraint.

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
    999999999,
    'TX-ERROR-' || currval('qa_order_id_seq'),
    7990.00,
    'completed',
    'card',
    CURRENT_TIMESTAMP
);


-- Manual steps in pgAdmin
-- =========================================================
-- The previous statement should produce a foreign key error.
-- The transaction is now in an aborted state.
-- Execute the following statements manually after the error:
-- ROLLBACK;
-- SELECT * FROM orders WHERE id = currval('qa_order_id_seq');
-- SELECT * FROM order_items WHERE order_id = currval('qa_order_id_seq');
-- SELECT * FROM payments WHERE transaction_id = 'TX-ERROR-' || currval('qa_order_id_seq');
-- Expected result:
-- The three SELECT queries should return 0 rows.
