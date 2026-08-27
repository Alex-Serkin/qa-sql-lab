-- QA SQL Lab
-- File: 02_find_user_orders.sql
-- Description: Find all user orders
-- =================================


-- Find orders by user ID

SELECT
    o.id AS order_id,
    o.status,
    o.total_amount,
    o.created_at,
    o.updated_at
FROM orders o
JOIN users u
    ON u.id = o.user_id
WHERE u.id = 1
ORDER BY o.created_at DESC;
