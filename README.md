# qa-sql-lab
Практическая лаборатория для QA-инженеров: SQL, DML, PostgreSQL и работа с тестовыми данными.

```
Предварительная структура проекта:
qa-sql-lab/
├── README.md
├── docker-compose.yml
├── servers.json
├── pgpass.example
├── .gitignore
│
├── db/
│   ├── 01_schema.sql
│   ├── 02_constraints.sql
│   ├── 03_test_data.sql
│   ├── 04_indexes.sql
│   ├── 05_sequences.sql
│   └── 06_views.sql
│
└── queries/
│   ├── 01_find_user.sql
│   ├── 02_find_user_orders.sql
│   ├── 03_find_failed_payments.sql
│   ├── 04_find_duplicate_emails.sql
│   ├── 05_update_order_status.sql
│   ├── 06_create_test_order.sql
│   ├── 07_delete_test_data.sql
│   ├── 07_delete_python_test_data.sql
│   ├── 08_find_orphan_records.sql
│   ├── 09_check_data_integrity.sql
│   ├── 10_check_duplicate_transactions.sql
│   ├── 11_transaction_commit.sql
│   ├── 12_transaction_rollback.sql
│   ├── 13_transaction_rollback_on_error.sql
│   ├── 14_explain_query.sql
│   ├── 15_explain_analyze.sql
│   ├── 16_query_order_view.sql
│   ├── 17_query_payment_view.sql
│   └── 18_query_product_sales_view.sql
│
└── scripts/
│   ├── Dockerfile
│   ├── requirements.txt
│   └── 01_generate_data.py
```
