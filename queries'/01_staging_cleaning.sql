/*
Author: Mauricio
Description: Standardizing data types for price and freight
to ensure mathematical accuracy.
*/

SELECT
    order_id,
    product_id,
    CAST(price AS FLOAT) AS price,
    CAST(freight_value AS FLOAT) AS freight_value
INTO olist_order_items_clean
FROM olist_order_items_dataset;
