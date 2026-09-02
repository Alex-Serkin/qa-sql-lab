-- QA SQL Lab
-- File: 14_explain_query.sql
-- Description: Show the query execution plan
-- ==========================================


EXPLAIN
SELECT
    o.id,
    o.status,
    o.total_amount,
    o.created_at
FROM orders o
WHERE o.user_id = 1;
