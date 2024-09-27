-- Total Sales
SELECT SUM(order_value) AS total_sales
FROM sales_data;

-- Average Order Value
SELECT AVG(order_value) AS average_order_value
FROM sales_data;

-- Sales by Product
SELECT product_id, SUM(order_value) AS total_sales
FROM sales_data
GROUP BY product_id
ORDER BY total_sales DESC;

-- Sales by Customer
SELECT customer_id, SUM(order_value) AS total_sales
FROM sales_data
GROUP BY customer_id
ORDER BY total_sales DESC;

-- Monthly Sales Trend
SELECT DATE_FORMAT(order_date, '%Y-%m') AS sales_month, SUM(order_value) AS total_sales
FROM sales_data
GROUP BY sales_month
ORDER BY sales_month;

-- Sales by Region
SELECT region, SUM(order_value) AS total_sales
FROM sales_data
GROUP BY region
ORDER BY total_sales DESC;

-- Top 10 Customers by Sales
SELECT customer_id, SUM(order_value) AS total_sales
FROM sales_data
GROUP BY customer_id
ORDER BY total_sales DESC
LIMIT 10;

-- Sales Count by Product
SELECT product_id, COUNT(*) AS sales_count
FROM sales_data
GROUP BY product_id
ORDER BY sales_count DESC;

-- Average Sales per Customer
SELECT AVG(total_sales) AS average_sales_per_customer
FROM (
    SELECT customer_id, SUM(order_value) AS total_sales
    FROM sales_data
    GROUP BY customer_id
) AS customer_sales;

-- Year-over-Year Sales Comparison
SELECT YEAR(order_date) AS sales_year, SUM(order_value) AS total_sales
FROM sales_data
GROUP BY sales_year
ORDER BY sales_year;
