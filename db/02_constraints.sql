-- QA SQL Lab
-- File: 02_constraints.sql
-- Description: Database constraints for data integrity
-- ====================================================


-- Table: users

ALTER TABLE users
    ADD CONSTRAINT pk_users
    PRIMARY KEY (id);

ALTER TABLE users
    ALTER COLUMN first_name SET NOT NULL,
    ALTER COLUMN last_name SET NOT NULL,
    ALTER COLUMN email SET NOT NULL,
    ALTER COLUMN status SET NOT NULL;

ALTER TABLE users
    ADD CONSTRAINT uq_users_email
    UNIQUE (email);

ALTER TABLE users
    ADD CONSTRAINT chk_users_status
    CHECK (status IN ('active', 'inactive', 'blocked'));


-- Table: products

ALTER TABLE products
    ADD CONSTRAINT pk_products
    PRIMARY KEY (id);

ALTER TABLE products
    ALTER COLUMN name SET NOT NULL,
    ALTER COLUMN price SET NOT NULL,
    ALTER COLUMN stock_quantity SET NOT NULL,
    ALTER COLUMN status SET NOT NULL;

ALTER TABLE products
    ADD CONSTRAINT chk_products_price
    CHECK (price >= 0);

ALTER TABLE products
    ADD CONSTRAINT chk_products_stock
    CHECK (stock_quantity >= 0);

ALTER TABLE products
    ADD CONSTRAINT chk_products_status
    CHECK (status IN ('active', 'inactive', 'discontinued'));


-- Table: orders

ALTER TABLE orders
    ADD CONSTRAINT pk_orders
    PRIMARY KEY (id);

ALTER TABLE orders
    ALTER COLUMN user_id SET NOT NULL,
    ALTER COLUMN status SET NOT NULL,
    ALTER COLUMN total_amount SET NOT NULL,
    ALTER COLUMN created_at SET NOT NULL;

ALTER TABLE orders
    ADD CONSTRAINT fk_orders_user
    FOREIGN KEY (user_id)
    REFERENCES users (id);

ALTER TABLE orders
    ADD CONSTRAINT chk_orders_status
    CHECK (status IN (
        'pending',
        'paid',
        'shipped',
        'completed',
        'cancelled'
    ));

ALTER TABLE orders
    ADD CONSTRAINT chk_orders_total_amount
    CHECK (total_amount >= 0);


-- Table: order_items

ALTER TABLE order_items
    ADD CONSTRAINT pk_order_items
    PRIMARY KEY (id);

ALTER TABLE order_items
    ALTER COLUMN order_id SET NOT NULL,
    ALTER COLUMN product_id SET NOT NULL,
    ALTER COLUMN quantity SET NOT NULL,
    ALTER COLUMN unit_price SET NOT NULL;

ALTER TABLE order_items
    ADD CONSTRAINT fk_order_items_order
    FOREIGN KEY (order_id)
    REFERENCES orders (id);

ALTER TABLE order_items
    ADD CONSTRAINT fk_order_items_product
    FOREIGN KEY (product_id)
    REFERENCES products (id);

ALTER TABLE order_items
    ADD CONSTRAINT chk_order_items_quantity
    CHECK (quantity > 0);

ALTER TABLE order_items
    ADD CONSTRAINT chk_order_items_unit_price
    CHECK (unit_price >= 0);


-- Table: payments

ALTER TABLE payments
    ADD CONSTRAINT pk_payments
    PRIMARY KEY (id);

ALTER TABLE payments
    ALTER COLUMN order_id SET NOT NULL,
    ALTER COLUMN transaction_id SET NOT NULL,
    ALTER COLUMN amount SET NOT NULL,
    ALTER COLUMN status SET NOT NULL,
    ALTER COLUMN payment_method SET NOT NULL,
    ALTER COLUMN created_at SET NOT NULL;

ALTER TABLE payments
    ADD CONSTRAINT fk_payments_order
    FOREIGN KEY (order_id)
    REFERENCES orders (id);

ALTER TABLE payments
    ADD CONSTRAINT uq_payments_transaction_id
    UNIQUE (transaction_id);

ALTER TABLE payments
    ADD CONSTRAINT chk_payments_amount
    CHECK (amount >= 0);

ALTER TABLE payments
    ADD CONSTRAINT chk_payments_status
    CHECK (status IN (
        'pending',
        'completed',
        'failed',
        'refunded'
    ));

ALTER TABLE payments
    ADD CONSTRAINT chk_payments_method
    CHECK (payment_method IN (
        'card',
        'cash',
        'bank_transfer'
    ));
