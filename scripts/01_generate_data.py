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


# Main

def main():
    print("Starting test data generation...")

    try:
        with get_connection() as conn:
            user_ids = generate_users(conn)

            conn.commit()

            print(
                f" Users generated successfully: {len(user_ids)}"
            )

    except Exception as e:
        print(f" Error: {e}")
        sys.exit(1)


if __name__ == "__main__":
    main()
