-- Remove Duplicates
DELETE FROM sales_data
WHERE id NOT IN (
    SELECT MIN(id)
    FROM sales_data
    GROUP BY customer_id, order_date, product_id
);

-- Handle Null Values
UPDATE sales_data
SET order_value = 0
WHERE order_value IS NULL;

UPDATE sales_data
SET product_id = 'Unknown'
WHERE product_id IS NULL;

-- Standardize Data Formats
UPDATE sales_data
SET order_date = DATE_FORMAT(order_date, '%Y-%m-%d')
WHERE order_date IS NOT NULL;

-- Identify and Handle Outliers
DELETE FROM sales_data
WHERE order_value < 0;

-- Consistent Formatting
UPDATE sales_data
SET customer_name = UPPER(customer_name)
WHERE customer_name IS NOT NULL;

-- Date Validation
DELETE FROM sales_data
WHERE order_date > CURDATE();

-- Trim Whitespace
UPDATE sales_data
SET customer_name = TRIM(customer_name);
