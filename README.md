# QA SQL Lab

[![Docker](https://img.shields.io/badge/Docker-✔-blue)](https://www.docker.com)
[![PostgreSQL](https://img.shields.io/badge/PostgreSQL-16-336791)](https://www.postgresql.org)
[![Python](https://img.shields.io/badge/Python-3.11-3776AB)](https://www.python.org)

## Описание

Практическая лаборатория для QA-инженеров по работе с SQL, PostgreSQL и тестовыми данными.

Проект создан для практики работы с базами данных в задачах QA: написание SQL-запросов, изменение и проверка данных, работа с транзакциями, тестирование целостности БД и анализ производительности запросов. В рамках проекта доступна генерация большого объёма связанных тестовых данных с помощью Python, Faker и psycopg.

## Из чего состоит

- PostgreSQL 16
- SQL / DML
- Constraints и внешние ключи
- Indexes
- Sequences
- Views
- Transactions: `COMMIT` / `ROLLBACK`
- Проверки целостности данных
- `EXPLAIN` / `EXPLAIN ANALYZE`
- Python + Faker + psycopg
- Batch INSERT
- Docker Compose
- pgAdmin
- DBeaver

## Архитектура

```markdown
Ubuntu VM (VirtualBox)
   │
   ▼
Docker Compose
   │
   ├── PostgreSQL (port 5432)
   ├── pgAdmin (port 5050)
   │
   └── Python runner (profile: tools)
          │
          ▼
       Faker
          │
          ▼
      Test data
```

## Структура проекта

```markdown
qa-sql-lab/
│
├── db/
│   ├── 01_schema.sql
│   ├── 02_constraints.sql
│   ├── 03_test_data.sql
│   ├── 04_indexes.sql
│   ├── 05_sequences.sql
│   └── 06_views.sql
│
├── queries/
│   └── SQL queries for QA scenarios (18 files)
│
├── scripts/
│   ├── Dockerfile
│   ├── requirements.txt
│   └── 01_generate_data.py
│ 
├── docker-compose.yml
├── pgpass.example
├── servers.json
├── .gitignore
└── README.md
```

**Подробное описание** структуры БД, SQL-запросов, генератора данных и принятых архитектурных решений находится в [Project Wiki](https://github.com/Alex-Serkin/qa-sql-lab/wiki).

## Быстрый запуск

### 1. Запуск проекта

```markdown
docker compose up -d
```

Запускаются:

- PostgreSQL
- pgAdmin

### 2. Проверьте контейнеры

```markdown
docker ps
```

### 3. Запустите Python-генератор

Генератор находится в отдельном Docker Compose profile и не запускается автоматически.

```markdown
docker compose --profile tools run --rm python-runner
```

Генератор создаёт большой набор связанных тестовых данных в PostgreSQL.

## Работа с базой данных

Для работы с БД можно использовать:

- **pgAdmin** — веб-интерфейс для управления и исследования PostgreSQL (доступен по адресу `http://localhost:5050`);
- **DBeaver** — SQL-клиент для удобной работы с запросами.

SQL-сценарии находятся в директории `queries/`.

## Тестовые данные

Проект использует несколько источников тестовых данных:

```markdown
Initial data          → 03_test_data.sql
Manual QA data        → queries/
Python-generated data → scripts/01_generate_data.py
```

Для разных источников данных используются отдельные диапазоны ID и PostgreSQL sequences, что позволяет безопасно разделять тестовые данные.

## Документация

Подробная документация проекта:
**[QA SQL Lab Wiki](https://github.com/Alex-Serkin/qa-sql-lab/wiki)**

В Wiki будут описаны:

- структура и схема БД;
- таблицы и связи;
- SQL-сценарии;
- sequences и диапазоны ID;
- views;
- транзакции;
- генератор тестовых данных;
- архитектура Python-контейнера;
- принципы batch INSERT;
- проверки целостности;
- анализ производительности запросов.

## Технологии

* PostgreSQL 16
* Docker
* Docker Compose
* Python 3.11
* psycopg
* Faker
* pgAdmin
* DBeaver
* SQL

## Статус проекта

Проект развивается как практическая лаборатория для развития навыков QA Engineer.

Новые SQL-сценарии, проверки и инструменты добавляются по мере развития проекта.

## Лицензия

Этот проект создан в образовательных целях.