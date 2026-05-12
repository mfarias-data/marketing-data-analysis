/*
Author: Mauricio
Description: Ranks the top product categories
by total revenue and sales volume.
*/

SELECT
    p.product_category_name AS category,
    COUNT(oi.order_id) AS sales_volume,
    SUM(oi.price) AS total_revenue,
    AVG(oi.price) AS average_ticket
FROM olist_order_items_clean oi
JOIN olist_products_dataset p
    ON oi.product_id = p.product_id
GROUP BY p.product_category_name
ORDER BY total_revenue DESC;