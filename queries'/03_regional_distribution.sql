/*
Author: Mauricio
Description: Analyzes sales distribution across
different Brazilian states (UF).
*/

SELECT
    c.customer_state AS state,
    COUNT(o.order_id) AS total_orders,
    SUM(oi.price) AS state_revenue
FROM olist_orders_dataset o
JOIN olist_customers_dataset c
    ON o.customer_id = c.customer_id
JOIN olist_order_items_clean oi
    ON o.order_id = oi.order_id
GROUP BY c.customer_state
ORDER BY state_revenue DESC;