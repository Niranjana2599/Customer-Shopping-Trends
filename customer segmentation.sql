-- Total Number of Customers
SELECT COUNT(DISTINCT customer_id) AS total_customers
FROM sales_data;

-- Customer Segmentation by Purchase Frequency
SELECT customer_id, COUNT(*) AS purchase_count
FROM sales_data
GROUP BY customer_id
ORDER BY purchase_count DESC;

-- High-Value Customers (Top 20% by Total Sales)
WITH CustomerSales AS (
    SELECT customer_id, SUM(order_value) AS total_sales
    FROM sales_data
    GROUP BY customer_id
),
RankedCustomers AS (
    SELECT customer_id, total_sales,
           NTILE(5) OVER (ORDER BY total_sales DESC) AS sales_rank
    FROM CustomerSales
)
SELECT customer_id, total_sales
FROM RankedCustomers
WHERE sales_rank = 1;

-- Average Order Value by Customer Segment
SELECT 
    CASE 
        WHEN total_sales < 100 THEN 'Low Value' 
        WHEN total_sales BETWEEN 100 AND 500 THEN 'Medium Value'
        ELSE 'High Value' 
    END AS customer_segment,
    AVG(order_value) AS average_order_value
FROM (
    SELECT customer_id, SUM(order_value) AS total_sales, order_value
    FROM sales_data
    GROUP BY customer_id, order_value
) AS customer_order_data
GROUP BY customer_segment;

-- Customer Retention Rate
SELECT 
    (COUNT(DISTINCT CASE WHEN DATEDIFF(NOW(), order_date) <= 30 THEN customer_id END) * 100.0 / COUNT(DISTINCT customer_id)) AS retention_rate
FROM sales_data;

-- New vs Returning Customers
SELECT 
    CASE 
        WHEN MIN(order_date) = MAX(order_date) THEN 'New Customer'
        ELSE 'Returning Customer'
    END AS customer_type,
    COUNT(DISTINCT customer_id) AS total_customers
FROM sales_data
GROUP BY customer_id;

-- Customer Segmentation by Region
SELECT region, COUNT(DISTINCT customer_id) AS total_customers
FROM sales_data
GROUP BY region;

-- Lifetime Value (LTV) of Customers
SELECT customer_id, SUM(order_value) AS lifetime_value
FROM sales_data
GROUP BY customer_id;

-- Monthly New Customers
SELECT DATE_FORMAT(order_date, '%Y-%m') AS month, COUNT(DISTINCT customer_id) AS new_customers
FROM sales_data
GROUP BY month;

-- Purchase Behavior by Customer Segment
SELECT customer_id, AVG(order_value) AS average_order_value, COUNT(*) AS purchase_count
FROM sales_data
GROUP BY customer_id;

-- Customer Segmentation by Age
SELECT 
    CASE 
        WHEN age < 18 THEN 'Under 18'
        WHEN age BETWEEN 18 AND 34 THEN '18-34'
        WHEN age BETWEEN 35 AND 54 THEN '35-54'
        ELSE '55 and above'
    END AS age_group,
    COUNT(DISTINCT customer_id) AS total_customers,
    AVG(order_value) AS average_order_value
FROM sales_data
GROUP BY age_group;

-- Customer Segmentation by Gender
SELECT gender, COUNT(DISTINCT customer_id) AS total_customers, AVG(order_value) AS average_order_value
FROM sales_data
GROUP BY gender;

-- Purchase Behavior by Age Group
SELECT 
    CASE 
        WHEN age < 18 THEN 'Under 18'
        WHEN age BETWEEN 18 AND 34 THEN '18-34'
        WHEN age BETWEEN 35 AND 54 THEN '35-54'
        ELSE '55 and above'
    END AS age_group,
    AVG(order_value) AS average_order_value, 
    COUNT(*) AS purchase_count
FROM sales_data
GROUP BY age_group;

-- Purchase Behavior by Gender
SELECT gender, AVG(order_value) AS average_order_value, COUNT(*) AS purchase_count
FROM sales_data
GROUP BY gender;
