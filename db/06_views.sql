-- QA SQL Lab
-- File: 06_views.sql
-- Description: Views for simplified data analysis and QA checks
-- =============================================================


-- View: vw_order_details
-- Description: Orders with users and ordered products

CREATE VIEW vw_order_details AS
SELECT
    o.id AS order_id,
    o.status AS order_status,
    o.total_amount,
    o.created_at AS order_created_at,
    u.id AS user_id,
    u.first_name,
    u.last_name,
    u.email,
    p.id AS product_id,
    p.name AS product_name,
    oi.quantity,
    oi.unit_price,
    oi.quantity * oi.unit_price AS item_total
FROM orders o
JOIN users u
    ON u.id = o.user_id
JOIN order_items oi
    ON oi.order_id = o.id
JOIN products p
    ON p.id = oi.product_id;


-- View: vw_payment_details
-- Description: Payments with related orders and users

CREATE VIEW vw_payment_details AS
SELECT
    p.id AS payment_id,
    p.transaction_id,
    p.amount,
    p.status AS payment_status,
    p.payment_method,
    p.created_at AS payment_created_at,
    o.id AS order_id,
    o.status AS order_status,
    o.total_amount AS order_total,
    u.id AS user_id,
    u.first_name,
    u.last_name,
    u.email
FROM payments p
JOIN orders o
    ON o.id = p.order_id
JOIN users u
    ON u.id = o.user_id;


-- View: vw_product_sales
-- Description: Product sales summary

CREATE VIEW vw_product_sales AS
SELECT
    p.id AS product_id,
    p.name AS product_name,
    p.price,
    p.status AS product_status,
    COALESCE(SUM(oi.quantity), 0) AS units_sold,
    COALESCE(SUM(oi.quantity * oi.unit_price), 0) AS sales_amount
FROM products p
LEFT JOIN order_items oi
    ON oi.product_id = p.id
GROUP BY
    p.id,
    p.name,
    p.price,
    p.status;
