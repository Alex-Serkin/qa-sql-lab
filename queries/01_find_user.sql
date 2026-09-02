-- QA SQL Lab
-- File: 01_find_user.sql
-- Description: Find a user by ID
-- ==============================


-- Find user by ID

SELECT
    id,
    first_name,
    last_name,
    email,
    phone,
    status,
    created_at
FROM users
WHERE id = 14521;
