-- QA SQL Lab
-- File: 10_check_duplicate_transactions.sql
-- Description: Find duplicate payment transactions
-- ================================================


-- Find duplicate transaction by ID

SELECT
    transaction_id,
    COUNT(*) AS duplicate_count
FROM payments
GROUP BY transaction_id
HAVING COUNT(*) > 1
ORDER BY duplicate_count DESC;
