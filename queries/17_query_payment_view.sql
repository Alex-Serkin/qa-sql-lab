-- QA SQL Lab
-- File: 17_query_payment_view.sql
-- Description: Query payment details view
-- =======================================


-- Find failed payments

SELECT *
FROM vw_payment_details
WHERE payment_status = 'failed';


-- Find completed card payments

SELECT *
FROM vw_payment_details
WHERE payment_status = 'completed'
  AND payment_method = 'card'
ORDER BY payment_created_at DESC;
