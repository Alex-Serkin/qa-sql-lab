"""
QA SQL Lab
File: 01_generate_data.py
Description: Generate test data for the QA SQL Lab database using Faker
"""

import os
import sys
from collections import OrderedDict
import psycopg
from faker import Faker


# Configuration

DB_HOST = os.getenv("DB_HOST", "postgres")
DB_NAME = os.getenv("DB_NAME", "qa_lab")
DB_USER = os.getenv("PGUSER", "qa_user")
DB_PORT = os.getenv("DB_PORT", "5432")

USERS_COUNT = 5000
PRODUCTS_COUNT = 1000
BATCH_SIZE = 1000


# Database connection

def get_connection():
    return psycopg.connect(
        host=DB_HOST,
        port=DB_PORT,
        dbname=DB_NAME,
        user=DB_USER,
    )


# Generate users

def generate_users(conn):
    fake = Faker()

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
                    elements=OrderedDict({
                        "active": 70,
                        "inactive": 20,
                        "blocked": 10,
                    })
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

def generate_products(conn):
    fake = Faker()

    products = [
        (
            "Ceramic Dinner Set",
            "Ceramic dinner set for four people"
        ),
        (
            "Cotton Bed Linen",
            "Cotton bed linen set for a double bed"
        ),
        (
            "Kitchen Towel Set",
            "Set of absorbent cotton kitchen towels"
        ),
        (
            "Glass Food Container",
            "Reusable glass container for food storage"
        ),
        (
            "Wooden Cutting Board",
            "Wooden cutting board for everyday kitchen use"
        ),
        (
            "Stainless Steel Kettle",
            "Stainless steel kettle for boiling water"
        ),
        (
            "Frying Pan",
            "Non-stick frying pan for everyday cooking"
        ),
        (
            "Storage Basket",
            "Woven storage basket for household items"
        ),
        (
            "Table Lamp",
            "LED table lamp for home use"
        ),
        (
            "Decorative Pillow",
            "Decorative pillow with removable cover"
        ),
        (
            "Bath Towel",
            "Soft cotton bath towel"
        ),
        (
            "Laundry Basket",
            "Large laundry basket with handles"
        ),
        (
            "Vacuum Storage Bag",
            "Reusable vacuum storage bag for clothes and textiles"
        ),
        (
            "Wall Clock",
            "Minimalist wall clock for home interiors"
        ),
        (
            "Scented Candle",
            "Decorative scented candle for home use"
        ),
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
                fake.random_int(min=100, max=50000) / 100,
                fake.random_int(min=0, max=500),
                fake.random_element(
                    elements=OrderedDict([
                        ("active", 70),
                        ("inactive", 20),
                        ("discontinued", 10),
                    ])
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


# Main

def main():
    print("Starting test data generation...")

    try:
        with get_connection() as conn:
            user_ids = generate_users(conn)
            product_ids = generate_products(conn)

            conn.commit()

            print(
                f"Users generated successfully: {len(user_ids)}"
            )
            print(
                f" Products generated successfully: {len(product_ids)}"
            )

    except Exception as e:
        print(f"Error: {e}")
        sys.exit(1)


if __name__ == "__main__":
    main()
