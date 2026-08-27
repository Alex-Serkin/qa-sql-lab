-- QA SQL Lab
-- File: 04_indexes.sql
-- Description: Indexes for query performance
-- ==========================================


-- Table: users

-- Search users by status
CREATE INDEX idx_users_status
    ON users (status);


-- Table: products

-- Search products by status
CREATE INDEX idx_products_status
    ON products (status);


-- Search products by stock quantity
CREATE INDEX idx_products_stock_quantity
    ON products (stock_quantity);


-- Table: orders

-- Find orders belonging to a specific user
CREATE INDEX idx_orders_user_id
    ON orders (user_id);


-- Search orders by status
CREATE INDEX idx_orders_status
    ON orders (status);


-- Search and sort orders by creation date
CREATE INDEX idx_orders_created_at
    ON orders (created_at);


-- Find orders of a specific user within a date range
CREATE INDEX idx_orders_user_id_created_at
    ON orders (user_id, created_at);


-- Find orders by status within a date range
CREATE INDEX idx_orders_status_created_at
    ON orders (status, created_at);


-- Table: order_items

-- Find order items belonging to a specific order
CREATE INDEX idx_order_items_order_id
    ON order_items (order_id);


-- Find orders containing a specific product
CREATE INDEX idx_order_items_product_id
    ON order_items (product_id);


-- Table: payments

-- Find payments belonging to a specific order
CREATE INDEX idx_payments_order_id
    ON payments (order_id);


-- Search payments by status
CREATE INDEX idx_payments_status
    ON payments (status);


-- Find payments by status within a date range
CREATE INDEX idx_payments_status_created_at
    ON payments (status, created_at);
