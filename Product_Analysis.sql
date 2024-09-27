-- Total Sales by Product
SELECT product_id, 
       product_name, 
       SUM(order_value) AS total_sales
FROM sales_data
GROUP BY product_id, product_name
ORDER BY total_sales DESC;

-- Top 10 Best-Selling Products
SELECT product_id, 
       product_name, 
       SUM(order_value) AS total_sales
FROM sales_data
GROUP BY product_id, product_name
ORDER BY total_sales DESC
LIMIT 10;

-- Average Order Value per Product
SELECT product_id, 
       product_name, 
       AVG(order_value) AS average_order_value
FROM sales_data
GROUP BY product_id, product_name;

-- Monthly Sales Trend by Product
SELECT product_id, 
       product_name, 
       DATE_FORMAT(order_date, '%Y-%m') AS month, 
       SUM(order_value) AS total_sales
FROM sales_data
GROUP BY product_id, product_name, month
ORDER BY month;

-- Product Sales Distribution by Category
SELECT category, 
       COUNT(product_id) AS total_products, 
       SUM(order_value) AS total_sales
FROM sales_data
GROUP BY category;

-- Product Inventory Status
SELECT product_id, 
       product_name, 
       stock_quantity, 
       CASE 
           WHEN stock_quantity < 10 THEN 'Low Stock'
           WHEN stock_quantity BETWEEN 10 AND 50 THEN 'Medium Stock'
           ELSE 'In Stock'
       END AS stock_status
FROM products;

-- Average Discount Given by Product
SELECT product_id, 
       product_name, 
       AVG(discount) AS average_discount
FROM sales_data
GROUP BY product_id, product_name;

-- Product Return Rate
SELECT product_id, 
       product_name, 
       COUNT(CASE WHEN return_flag = 1 THEN 1 END) * 100.0 / COUNT(*) AS return_rate
FROM sales_data
GROUP BY product_id, product_name;

-- New Product Launch Impact Analysis
SELECT product_id, 
       product_name, 
       COUNT(CASE WHEN DATEDIFF(order_date, launch_date) <= 30 THEN 1 END) AS initial_sales
FROM products
JOIN sales_data ON products.product_id = sales_data.product_id
GROUP BY product_id, product_name;

-- Product Performance by Region
SELECT product_id, 
       product_name, 
       region, 
       SUM(order_value) AS total_sales
FROM sales_data
GROUP BY product_id, product_name, region
ORDER BY total_sales DESC;
