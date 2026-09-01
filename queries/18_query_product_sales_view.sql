-- QA SQL Lab
-- File: 18_query_product_sales_view.sql
-- Description: Query product sales view
-- =====================================


-- Show products by sales amount

SELECT *
FROM vw_product_sales
ORDER BY sales_amount DESC;


-- Find top-selling products

SELECT
    product_id,
    product_name,
    units_sold,
    sales_amount
FROM vw_product_sales
ORDER BY sales_amount DESC
LIMIT 10;