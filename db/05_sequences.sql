-- QA SQL Lab
-- File: 05_sequences.sql
-- Description: Sequences for generating test data IDs
-- ID ranges:
-- 1 - 999:     Initial test data
-- 1000 - 9999: Manual QA test data
-- 10000+:      Python-generated test data
-- ===================================================


-- Manual QA test data

CREATE SEQUENCE qa_user_id_seq
    START WITH 1000
    INCREMENT BY 1
    MINVALUE 1000
    MAXVALUE 9999
    NO CYCLE;


CREATE SEQUENCE qa_product_id_seq
    START WITH 1000
    INCREMENT BY 1
    MINVALUE 1000
    MAXVALUE 9999
    NO CYCLE;


CREATE SEQUENCE qa_order_id_seq
    START WITH 1000
    INCREMENT BY 1
    MINVALUE 1000
    MAXVALUE 9999
    NO CYCLE;


CREATE SEQUENCE qa_order_item_id_seq
    START WITH 1000
    INCREMENT BY 1
    MINVALUE 1000
    MAXVALUE 9999
    NO CYCLE;


CREATE SEQUENCE qa_payment_id_seq
    START WITH 1000
    INCREMENT BY 1
    MINVALUE 1000
    MAXVALUE 9999
    NO CYCLE;


-- Python-generated test data

CREATE SEQUENCE python_user_id_seq
    START WITH 10000
    INCREMENT BY 1
    MINVALUE 10000
    NO MAXVALUE
    NO CYCLE;


CREATE SEQUENCE python_product_id_seq
    START WITH 10000
    INCREMENT BY 1
    MINVALUE 10000
    NO MAXVALUE
    NO CYCLE;


CREATE SEQUENCE python_order_id_seq
    START WITH 10000
    INCREMENT BY 1
    MINVALUE 10000
    NO MAXVALUE
    NO CYCLE;


CREATE SEQUENCE python_order_item_id_seq
    START WITH 10000
    INCREMENT BY 1
    MINVALUE 10000
    NO MAXVALUE
    NO CYCLE;


CREATE SEQUENCE python_payment_id_seq
    START WITH 10000
    INCREMENT BY 1
    MINVALUE 10000
    NO MAXVALUE
    NO CYCLE;
