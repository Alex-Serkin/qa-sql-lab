-- QA SQL Lab
-- File: 04_find_duplicate_emails.sql
-- Description: Find duplicate user emails
-- =======================================


-- Find duplicate emails

SELECT
    email,
    COUNT(*) AS duplicate_count
FROM users
GROUP BY email
HAVING COUNT(*) > 1
ORDER BY duplicate_count DESC;
