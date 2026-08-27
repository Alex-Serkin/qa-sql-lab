-- QA SQL Lab
-- File: 03_find_failed_payments.sql
-- Description: Find failed payments with order and user details
-- =============================================================


-- Find failed payments

SELECT
    p.id AS payment_id,
    p.transaction_id,
    p.amount,
    p.payment_method,
    p.created_at AS payment_created_at,
    o.id AS order_id,
    o.status AS order_status,
    u.id AS user_id,
    u.first_name,
    u.last_name,
    u.email
FROM payments p
JOIN orders o
    ON o.id = p.order_id
JOIN users u
    ON u.id = o.user_id
WHERE p.status = 'failed'
ORDER BY p.created_at DESC;
