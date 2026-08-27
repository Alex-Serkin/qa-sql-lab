-- QA SQL Lab
-- File: 01_schema.sql
-- Description: Database schema for QA test data
-- =============================================


-- Table: users
-- Description: Application users

CREATE TABLE users (
    id              BIGINT,
    first_name      VARCHAR(100),
    last_name       VARCHAR(100),
    email           VARCHAR(100),
    phone           VARCHAR(20),
    status          VARCHAR(20),
    created_at      TIMESTAMP
);


-- Table: products
-- Description: Products available in the application

CREATE TABLE products (
    id              BIGINT,
    name            VARCHAR(100),
    description     TEXT,
    price           NUMERIC(12, 2),
    stock_quantity  INTEGER,
    status          VARCHAR(20),
    created_at      TIMESTAMP
);


-- Table: orders
-- Description: Customer orders

CREATE TABLE orders (
    id              BIGINT,
    user_id         BIGINT,
    status          VARCHAR(20),
    total_amount    NUMERIC(12, 2),
    created_at      TIMESTAMP,
    updated_at      TIMESTAMP
);


-- Table: order_items
-- Description: Products included in orders

CREATE TABLE order_items (
    id              BIGINT,
    order_id        BIGINT,
    product_id      BIGINT,
    quantity        INTEGER,
    unit_price      NUMERIC(12, 2)
);


-- Table: payments
-- Description: Payments associated with orders

CREATE TABLE payments (
    id              BIGINT,
    order_id        BIGINT,
    transaction_id  VARCHAR(100),
    amount          NUMERIC(12, 2),
    status          VARCHAR(20),
    payment_method  VARCHAR(30),
    created_at      TIMESTAMP
);
