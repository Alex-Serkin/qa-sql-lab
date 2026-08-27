-- QA SQL Lab
-- File: 11_transaction_commit.sql
-- Description: Commit a successful order and payment transaction
-- ==============================================================


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
    4990.00,
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
    4990.00
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
    'TX-COMMIT-' || currval('qa_order_id_seq'),
    4990.00,
    'completed',
    'card',
    CURRENT_TIMESTAMP
);


-- Verify the transaction before committing

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

-- Save all changes

COMMIT;
