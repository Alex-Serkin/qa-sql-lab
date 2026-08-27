-- QA SQL Lab
-- File: 16_query_order_view.sql
-- Description: Query order details view
-- =====================================


-- Find user orders

SELECT *
FROM vw_order_details
WHERE user_id = 1;


-- Find completed orders

SELECT *
FROM vw_order_details
WHERE order_status = 'completed'
ORDER BY order_created_at DESC;
