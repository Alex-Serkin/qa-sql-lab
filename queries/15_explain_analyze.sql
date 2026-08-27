-- QA SQL Lab
-- File: 15_explain_analyze.sql
-- Description: Analyze actual query execution
-- ===========================================


EXPLAIN ANALYZE
SELECT
    o.id,
    o.status,
    o.total_amount,
    o.created_at
FROM orders o
WHERE o.user_id = 1;
