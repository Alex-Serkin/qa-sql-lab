"""
QA SQL Lab
File: 01_generate_data.py
Description: Generate test data for the QA SQL Lab database using Faker
=======================================================================
"""

import os
import sys
import random
from collections import OrderedDict
from decimal import Decimal
import psycopg
from faker import Faker


# Configuration
# =============

USERS_COUNT = 5000
PRODUCTS_COUNT = 1000
ORDERS_COUNT = 20000
PAYMENTS_COUNT = 18000

BATCH_SIZE = 1000

USER_STATUS_DISTRIBUTION = OrderedDict([
    ("active", 70),
    ("inactive", 20),
    ("blocked", 10),
])

PRODUCT_STATUS_DISTRIBUTION = OrderedDict([
    ("active", 70),
    ("inactive", 20),
    ("discontinued", 10),
])

ORDER_STATUS_DISTRIBUTION = OrderedDict([
    ("completed", 50),
    ("paid", 20),
    ("shipped", 15),
    ("pending", 10),
    ("cancelled", 5),
])

PAYMENT_STATUS_DISTRIBUTION = OrderedDict([
    ("completed", 70),
    ("pending", 15),
    ("failed", 10),
    ("refunded", 5),
])

PAYMENT_METHOD_DISTRIBUTION = OrderedDict([
    ("card", 70),
    ("cash", 15),
    ("bank_transfer", 15),
])


# Database configuration
# ======================

DB_HOST = os.getenv("DB_HOST", "postgres")
DB_NAME = os.getenv("DB_NAME", "qa_lab")
DB_USER = os.getenv("PGUSER", "qa_user")
DB_PORT = os.getenv("DB_PORT", "5432")



# Database connection
# ===================

def get_connection():
    return psycopg.connect(
        host=DB_HOST,
        port=DB_PORT,
        dbname=DB_NAME,
        user=DB_USER,
    )


# Generate users
# ==============

def generate_users(conn, fake):

    insert_sql = """
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
    """

    user_ids = []

    for start in range(0, USERS_COUNT, BATCH_SIZE):
        batch = []

        for _ in range(min(BATCH_SIZE, USERS_COUNT - start)):
            batch.append((
                fake.first_name(),
                fake.last_name(),
                fake.unique.email(),
                fake.phone_number(),
                fake.random_element(
                    elements=USER_STATUS_DISTRIBUTION
                ),
                fake.date_time_between(
                    start_date="-1y",
                    end_date="now"
                ),
            ))

        values_sql = ", ".join(
            "(nextval('python_user_id_seq'), %s, %s, %s, %s, %s, %s)"
            for _ in batch
        )

        params = [
            value
            for row in batch
            for value in row
        ]

        with conn.cursor() as cur:
            cur.execute(
                insert_sql + values_sql + " RETURNING id",
                params
            )

            returned_ids = cur.fetchall()
            user_ids.extend(row[0] for row in returned_ids)

        print(f"Users: {len(user_ids)} / {USERS_COUNT}")

    return user_ids


# Generate products
#==================

def generate_products(conn, fake):

    products = [
        ("Ceramic Dinner Set", "Ceramic dinner set for four people"),
        ("Cotton Bed Linen", "Cotton bed linen set for a double bed"),
        ("Kitchen Towel Set", "Set of absorbent cotton kitchen towels"),
        ("Glass Food Container", "Reusable glass container for food storage"),
        ("Wooden Cutting Board", "Wooden cutting board for everyday kitchen use"),
        ("Stainless Steel Kettle", "Stainless steel kettle for boiling water"),
        ("Frying Pan", "Non-stick frying pan for everyday cooking"),
        ("Storage Basket", "Woven storage basket for household items"),
        ("Table Lamp", "LED table lamp for home use"),
        ("Decorative Pillow", "Decorative pillow with removable cover"),
        ("Bath Towel", "Soft cotton bath towel"),
        ("Laundry Basket", "Large laundry basket with handles"),
        ("Vacuum Storage Bag", "Reusable vacuum storage bag for clothes and textiles"),
        ("Wall Clock", "Minimalist wall clock for home interiors"),
        ("Scented Candle", "Decorative scented candle for home use"),
    ]

    insert_sql = """
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
    """

    product_ids = []

    for start in range(0, PRODUCTS_COUNT, BATCH_SIZE):
        batch = []

        for _ in range(min(BATCH_SIZE, PRODUCTS_COUNT - start)):
            name, description = fake.random_element(products)

            batch.append((
                name,
                description,
                Decimal(
                    fake.random_int(
                        min=100,
                        max=50000
                    )
                ) / Decimal("100"),
                fake.random_int(
                    min=0,
                    max=500
                ),
                fake.random_element(
                    elements=PRODUCT_STATUS_DISTRIBUTION
                ),
                fake.date_time_between(
                    start_date="-1y",
                    end_date="now"
                ),
            ))

        values_sql = ", ".join(
            "(nextval('python_product_id_seq'), %s, %s, %s, %s, %s, %s)"
            for _ in batch
        )

        params = [
            value
            for row in batch
            for value in row
        ]

        with conn.cursor() as cur:
            cur.execute(
                insert_sql + values_sql + " RETURNING id",
                params
            )

            returned_ids = cur.fetchall()
            product_ids.extend(row[0] for row in returned_ids)

        print(
            f"Products: {len(product_ids)} / {PRODUCTS_COUNT}"
        )

    return product_ids


# Orders
#=======

def generate_orders(conn, fake, user_ids):
    insert_sql = """
        INSERT INTO orders (
            id,
            user_id,
            status,
            total_amount,
            created_at,
            updated_at
        )
        VALUES
    """

    order_ids = []

    for start in range(0, ORDERS_COUNT, BATCH_SIZE):
        batch = []

        for _ in range(min(BATCH_SIZE, ORDERS_COUNT - start)):
            status = fake.random_element(
                elements=ORDER_STATUS_DISTRIBUTION
            )
            created_at = fake.date_time_between(start_date="-1y", end_date="now")
            updated_at = fake.date_time_between(start_date=created_at, end_date="now")

            batch.append((
                fake.random_element(user_ids),
                status,
                Decimal("0.00"),
                created_at,
                updated_at,
            ))

        values_sql = ", ".join(
            "(nextval('python_order_id_seq'), %s, %s, %s, %s, %s)"
            for _ in batch
        )

        params = [
            value
            for row in batch
            for value in row
        ]

        with conn.cursor() as cur:
            cur.execute(
                insert_sql + values_sql + " RETURNING id",
                params
            )

            returned_ids = cur.fetchall()
            order_ids.extend(row[0] for row in returned_ids)

        print(f"Orders: {len(order_ids)} / {ORDERS_COUNT}")

    return order_ids


# Order items
# ===========

def generate_order_items(conn, fake, order_ids, product_ids):
    insert_sql = """
        INSERT INTO order_items (
            id,
            order_id,
            product_id,
            quantity,
            unit_price
        )
        VALUES
    """

    order_totals = {
        order_id: Decimal("0.00")
        for order_id in order_ids
    }

    total_generated = 0
    batch = []

    for order_id in order_ids:
        num_items = random.randint(1, 4)



        for _ in range(num_items):
            product_id = fake.random_element(product_ids)
            quantity = fake.random_int(min=1, max=4)
            unit_price = (
                Decimal(fake.random_int(min=100, max=50000)) / Decimal("100")
            )
            line_total = Decimal(quantity) * unit_price

            order_totals[order_id] += line_total

            batch.append((
                order_id,
                product_id,
                quantity,
                unit_price,
            ))

            total_generated += 1

            if len(batch) >= BATCH_SIZE:
                values_sql = ", ".join(
                    "(nextval('python_order_item_id_seq'), %s, %s, %s, %s)"
                    for _ in batch
                )
                params = [value for row in batch for value in row]

                with conn.cursor() as cur:
                    cur.execute(insert_sql + values_sql, params)

                print(f" Order items: {total_generated} / ?")
                batch = []

    if batch:
        values_sql = ", ".join(
            "(nextval('python_order_item_id_seq'), %s, %s, %s, %s)"
            for _ in batch
        )
        params = [value for row in batch for value in row]

        with conn.cursor() as cur:
            cur.execute(insert_sql + values_sql, params)

    print(f" Order items generated: {total_generated}")

    return order_totals, total_generated


# Update order totals
# ====================

def update_order_totals(conn, order_totals):
    if not order_totals:
        return

    values_sql = ", ".join(
        "(%s, %s)"
        for _ in order_totals
    )

    params = []

    for order_id, total in order_totals.items():
        params.extend([
            order_id,
            total,
        ])

    update_sql = f"""
        UPDATE orders AS o
        SET total_amount = v.total_amount
        FROM (
            VALUES {values_sql}
        ) AS v(order_id, total_amount)
        WHERE o.id = v.order_id
    """

    with conn.cursor() as cur:
        cur.execute(update_sql, params)

    print(
        f"Order totals updated: {len(order_totals)}"
    )


# Payments
# =========

def generate_payments(conn, fake, order_ids):
    insert_sql = """
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
    """

    payment_ids = []

    for start in range(0, PAYMENTS_COUNT, BATCH_SIZE):
        batch = []

        for _ in range(
            min(
                BATCH_SIZE,
                PAYMENTS_COUNT - start
            )
        ):
            order_id = fake.random_element(order_ids)

            amount = (
                Decimal(
                    fake.random_int(
                        min=100,
                        max=50000
                    )
                )
                / Decimal("100")
            )

            payment_status = fake.random_element(
                elements=PAYMENT_STATUS_DISTRIBUTION
            )

            payment_method = fake.random_element(
                elements=PAYMENT_METHOD_DISTRIBUTION
            )

            batch.append((
                order_id,
                f"TX-{fake.uuid4()}",
                amount,
                payment_status,
                payment_method,
                fake.date_time_between(
                    start_date="-1y",
                    end_date="now"
                ),
            ))

        values_sql = ", ".join(
            "(nextval('python_payment_id_seq'), %s, %s, %s, %s, %s, %s)"
            for _ in batch
        )

        params = [
            value
            for row in batch
            for value in row
        ]

        with conn.cursor() as cur:
            cur.execute(
                insert_sql + values_sql + " RETURNING id",
                params
            )

            returned_ids = cur.fetchall()
            payment_ids.extend(row[0] for row in returned_ids)

        print(
            f"Payments: "
            f"{len(payment_ids)} / {PAYMENTS_COUNT}"
        )

    return payment_ids


# Main
#=====

def main():

    fake = Faker()

    print("Starting test data generation...")

    print("Configuration:")
    print(f"   Users:        {USERS_COUNT}")
    print(f"   Products:     {PRODUCTS_COUNT}")
    print(f"   Orders:       {ORDERS_COUNT}")
    print(f"   Payments:     {PAYMENTS_COUNT}")
    print(f"   Batch size:   {BATCH_SIZE}")

    try:
        with get_connection() as conn:
            user_ids = generate_users(conn, fake)
            product_ids = generate_products(conn, fake)
            order_ids = generate_orders(conn, fake, user_ids)
            order_totals, total_order_items = generate_order_items(conn, fake, order_ids, product_ids)
            update_order_totals(conn, order_totals)
            payment_ids = generate_payments(conn, fake, order_ids)

            conn.commit()

            print()
            print("Data generation completed successfully")
            print("========================================")
            print(f"Users:       {len(user_ids)}")
            print(f"Products:    {len(product_ids)}")
            print(f"Orders:      {len(order_ids)}")
            print(f"Order items: {total_order_items}")
            print(f"Payments:    {len(payment_ids)}")

    except Exception as e:
        print(f"\n Error: {e}")
        import traceback
        traceback.print_exc()
        sys.exit(1)

if __name__ == "__main__":
    main()
