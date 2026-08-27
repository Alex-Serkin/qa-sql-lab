-- QA SQL Lab
-- File: 05_sequences.sql
-- Description: Sequences for generating unique test data IDs
-- ==========================================================


-- Sequence: test_user_id_seq
-- Description: Generates IDs for new test users

CREATE SEQUENCE test_user_id_seq
    START WITH 1001
    INCREMENT BY 1
    MINVALUE 1
    NO MAXVALUE
    CACHE 1;


-- Sequence: test_product_id_seq
-- Description: Generates IDs for new test products

CREATE SEQUENCE test_product_id_seq
    START WITH 1001
    INCREMENT BY 1
    MINVALUE 1
    NO MAXVALUE
    CACHE 1;


-- Sequence: test_order_id_seq
-- Description: Generates IDs for new test orders

CREATE SEQUENCE test_order_id_seq
    START WITH 1001
    INCREMENT BY 1
    MINVALUE 1
    NO MAXVALUE
    CACHE 1;


-- Sequence: test_order_item_id_seq
-- Description: Generates IDs for new test order items

CREATE SEQUENCE test_order_item_id_seq
    START WITH 1001
    INCREMENT BY 1
    MINVALUE 1
    NO MAXVALUE
    CACHE 1;


-- Sequence: test_payment_id_seq
-- Description: Generates IDs for new test payments

CREATE SEQUENCE test_payment_id_seq
    START WITH 1001
    INCREMENT BY 1
    MINVALUE 1
    NO MAXVALUE
    CACHE 1;
