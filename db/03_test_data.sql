-- QA SQL Lab
-- File: 03_test_data.sql
-- Description: Initial test data for QA scenarios
-- Prices are stored in Russian rubles (RUB)
-- ===============================================



-- Table: users
-- Description: Application users

INSERT INTO users (
    id,
    first_name,
    last_name,
    email,
    phone,
    status,
    created_at
)
VALUES
    (1, 'Ivan', 'Petrov', 'ivan.petrov@example.com', '+79001000001', 'active',   '2026-01-10 09:15:00'),
    (2, 'Anna', 'Smirnova', 'anna.smirnova@example.com', '+79001000002', 'active',   '2026-01-11 10:20:00'),
    (3, 'Petr', 'Sokolov', 'petr.sokolov@example.com', '+79001000003', 'inactive', '2026-01-12 11:30:00'),
    (4, 'Elena', 'Volkova', 'elena.volkova@example.com', '+79001000004', 'active',   '2026-01-13 12:40:00'),
    (5, 'Alexey', 'Kozlov', 'alexey.kozlov@example.com', '+79001000005', 'blocked',  '2026-01-14 13:50:00'),
    (6, 'Maria', 'Morozova', 'maria.morozova@example.com', '+79001000006', 'active',   '2026-01-15 14:10:00'),
    (7, 'Sergey', 'Novikov', 'sergey.novikov@example.com', '+79001000007', 'inactive', '2026-01-16 15:20:00'),
    (8, 'Olga', 'Fedorova', 'olga.fedorova@example.com', '+79001000008', 'active',   '2026-01-17 16:30:00'),
    (9, 'Dmitry', 'Popov', 'dmitry.popov@example.com', '+79001000009', 'active',   '2026-01-18 17:40:00'),
    (10, 'Natalia', 'Orlova', 'natalia.orlova@example.com', '+79001000010', 'blocked',  '2026-01-19 18:50:00');


-- Table: products
-- Description: Household products

INSERT INTO products (
    id,
    name,
    description,
    price,
    stock_quantity,
    status,
    created_at
)
VALUES
    (1, 'Dinner Set', 'Ceramic dinner set for four people', 4990.00, 25,  'active',       '2026-01-01 09:00:00'),
    (2, 'Bath Towel', 'Cotton bath towel',                    990.00, 100, 'active',       '2026-01-02 09:00:00'),
    (3, 'Bed Linen Set', 'Cotton bed linen set',             3490.00, 50,  'active',       '2026-01-03 09:00:00'),
    (4, 'Storage Box', 'Plastic storage box with lid',       1290.00, 75,  'active',       '2026-01-04 09:00:00'),
    (5, 'Table Lamp', 'LED table lamp',                      2990.00, 20,  'active',       '2026-01-05 09:00:00'),
    (6, 'Vacuum Cleaner', 'Compact household vacuum cleaner',12990.00, 10,  'active',       '2026-01-06 09:00:00'),
    (7, 'Kitchen Scale', 'Digital kitchen scale',             1790.00, 40,  'active',       '2026-01-07 09:00:00'),
    (8, 'Wall Clock', 'Classic wall clock',                   2490.00, 0,   'discontinued', '2026-01-08 09:00:00'),
    (9, 'Clothes Hanger Set', 'Set of ten clothes hangers',    690.00, 25,  'active',       '2026-01-09 09:00:00'),
    (10, 'Cleaning Gloves', 'Reusable household cleaning gloves', 390.00, 200, 'inactive', '2026-01-10 09:00:00');


-- Table: orders
-- Description: Customer orders

INSERT INTO orders (
    id,
    user_id,
    status,
    total_amount,
    created_at,
    updated_at
)
VALUES
    (1,  1, 'completed',  5980.00, '2026-02-01 10:00:00', '2026-02-02 10:00:00'),
    (2,  2, 'paid',       3490.00, '2026-02-02 11:00:00', '2026-02-02 11:30:00'),
    (3,  4, 'shipped',    4280.00, '2026-02-03 12:00:00', '2026-02-04 09:00:00'),
    (4,  6, 'pending',   12990.00, '2026-02-04 13:00:00', '2026-02-04 13:00:00'),
    (5,  8, 'cancelled',  1290.00, '2026-02-05 14:00:00', '2026-02-05 15:00:00'),
    (6,  9, 'completed',  1790.00, '2026-02-06 15:00:00', '2026-02-07 10:00:00'),
    (7,  1, 'paid',        690.00, '2026-02-07 16:00:00', '2026-02-07 16:30:00'),
    (8,  3, 'completed',  2780.00, '2026-02-08 17:00:00', '2026-02-09 09:00:00'),
    (9,  5, 'cancelled',  2990.00, '2026-02-09 18:00:00', '2026-02-09 18:30:00'),
    (10, 6, 'completed',  4480.00, '2026-02-10 10:00:00', '2026-02-11 11:00:00'),
    (11, 7, 'pending',     990.00, '2026-02-11 11:00:00', '2026-02-11 11:00:00'),
    (12, 9, 'completed',   690.00, '2026-02-12 12:00:00', '2026-02-13 09:00:00');


-- Table: order_items
-- Description: Products included in orders

INSERT INTO order_items (
    id,
    order_id,
    product_id,
    quantity,
    unit_price
)
VALUES
    (1,  1, 1, 1, 4990.00),
    (2,  1, 2, 1,  990.00),
    (3,  2, 3, 1, 3490.00),
    (4,  3, 4, 1, 1290.00),
    (5,  3, 5, 1, 2990.00),
    (6,  4, 6, 1, 12990.00),
    (7,  5, 4, 1, 1290.00),
    (8,  6, 7, 1, 1790.00),
    (9,  7, 9, 1,  690.00),
    (10, 8, 2, 1,  990.00),
    (11, 8, 7, 1, 1790.00),
    (12, 9, 5, 1, 2990.00),
    (13, 10, 2, 1,  990.00),
    (14, 10, 3, 1, 3490.00),
    (15, 11, 2, 1,  990.00),
    (16, 12, 9, 1,  690.00);


-- Table: payments
-- Description: Payments associated with orders

INSERT INTO payments (
    id,
    order_id,
    transaction_id,
    amount,
    status,
    payment_method,
    created_at
)
VALUES
    (1,  1,  'TXN-20260201-001',  5980.00, 'completed', 'card',          '2026-02-01 10:05:00'),
    (2,  2,  'TXN-20260202-002',  3490.00, 'completed', 'card',          '2026-02-02 11:05:00'),
    (3,  3,  'TXN-20260203-003',  4280.00, 'completed', 'bank_transfer', '2026-02-03 12:05:00'),
    (4,  4,  'TXN-20260204-004', 12990.00, 'pending',   'card',          '2026-02-04 13:05:00'),
    (5,  5,  'TXN-20260205-005',  1290.00, 'refunded',  'card',          '2026-02-05 14:05:00'),
    (6,  6,  'TXN-20260206-006',  1790.00, 'completed', 'card',          '2026-02-06 15:05:00'),
    (7,  7,  'TXN-20260207-007',   690.00, 'completed', 'cash',          '2026-02-07 16:05:00'),
    (8,  8,  'TXN-20260208-008',  2780.00, 'completed', 'card',          '2026-02-08 17:05:00'),
    (9,  9,  'TXN-20260209-009',  2990.00, 'failed',    'card',          '2026-02-09 18:05:00'),
    (10, 10, 'TXN-20260210-010',  4480.00, 'completed', 'bank_transfer', '2026-02-10 10:05:00'),
    (11, 11, 'TXN-20260211-011',   990.00, 'pending',   'card',          '2026-02-11 11:05:00'),
    (12, 12, 'TXN-20260212-012',   690.00, 'completed', 'card',          '2026-02-12 12:05:00');
