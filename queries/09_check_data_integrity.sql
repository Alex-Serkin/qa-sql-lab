-- QA SQL Lab
-- File: 09_check_data_integrity.sql
-- Description: Check data integrity rules
-- =======================================


-- Check users with invalid status

SELECT
    id,
    status
FROM users
WHERE status NOT IN ('active', 'inactive', 'blocked');


-- Check products with invalid status

SELECT
    id,
    status
FROM products
WHERE status NOT IN ('active', 'inactive', 'discontinued');


-- Check orders with invalid status

SELECT
    id,
    status
FROM orders
WHERE status NOT IN (
    'pending',
    'paid',
    'shipped',
    'completed',
    'cancelled'
);


-- Check payments with invalid status

SELECT
    id,
    status
FROM payments
WHERE status NOT IN (
    'pending',
    'completed',
    'failed',
    'refunded'
);


-- Check payments with invalid payment method

SELECT
    id,
    payment_method
FROM payments
WHERE payment_method NOT IN (
    'card',
    'cash',
    'bank_transfer'
);


-- Check products with invalid price

SELECT
    id,
    name,
    price
FROM products
WHERE price < 0;


-- Check products with invalid stock quantity

SELECT
    id,
    name,
    stock_quantity
FROM products
WHERE stock_quantity < 0;


-- Check order items with invalid quantity

SELECT
    id,
    order_id,
    product_id,
    quantity
FROM order_items
WHERE quantity <= 0;


-- Check order items with invalid unit price

SELECT
    id,
    order_id,
    product_id,
    unit_price
FROM order_items
WHERE unit_price < 0;


-- Check payments with invalid amount

SELECT
    id,
    order_id,
    amount
FROM payments
WHERE amount < 0;


-- Check orders with invalid total amount

SELECT
    id,
    user_id,
    total_amount
FROM orders
WHERE total_amount < 0;

-- Check order total against order items

SELECT
    o.id AS order_id,
    o.total_amount,
    SUM(oi.quantity * oi.unit_price) AS calculated_total
FROM orders o
JOIN order_items oi
    ON oi.order_id = o.id
GROUP BY
    o.id,
    o.total_amount
HAVING o.total_amount <> SUM(oi.quantity * oi.unit_price);
