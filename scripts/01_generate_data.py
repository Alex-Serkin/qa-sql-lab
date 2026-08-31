"""
QA SQL Lab
File: 01_generate_data.py
Description: Generate test data for the QA SQL Lab database using Faker
"""

import os
import sys
import psycopg
from faker import Faker

DB_HOST = os.getenv("DB_HOST", "postgres")
DB_NAME = os.getenv("DB_NAME", "qa_lab")
DB_USER = os.getenv("PGUSER", "qa_user")
DB_PORT = os.getenv("DB_PORT", "5432")

try:
    conn = psycopg.connect(
        host=DB_HOST,
        port=DB_PORT,
        dbname=DB_NAME,
        user=DB_USER,
    )

    with conn.cursor() as cur:
        cur.execute("SELECT 1")
        result = cur.fetchone()
        print(f"✅ Подключение успешно! Результат: {result}")

    conn.close()
    print("✅ Скрипт выполнен успешно")
    sys.exit(0)

except Exception as e:
    print(f"❌ Ошибка: {e}")
    sys.exit(1)
