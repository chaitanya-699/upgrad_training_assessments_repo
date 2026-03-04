-- Problem 1: Basic Customer Order Report

SELECT 
    c.first_name,
    c.last_name,
    o.order_id,
    o.order_date,
    o.order_status
FROM customers c
INNER JOIN orders o
ON c.customer_id = o.customer_id
WHERE o.order_status = 1
   OR o.order_status = 4
ORDER BY o.order_date DESC;