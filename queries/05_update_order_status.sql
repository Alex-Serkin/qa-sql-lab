-- QA SQL Lab
-- File: 05_update_order_status.sql
-- Description: Update order status
-- ================================


-- Update order status

UPDATE orders
SET
    status = 'shipped',
    updated_at = CURRENT_TIMESTAMP
WHERE id = 1;


-- Verify the updated order

SELECT
    id,
    user_id,
    status,
    total_amount,
    created_at,
    updated_at
FROM orders
WHERE id = 11245;
