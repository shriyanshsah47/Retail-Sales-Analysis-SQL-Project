-- Count total records
SELECT COUNT(*) FROM retail_sales;

-- Count unique customers
SELECT COUNT(DISTINCT customer_id) FROM retail_sales;

-- Find unique categories
SELECT DISTINCT category FROM retail_sales;

-- Check null values
SELECT *
FROM retail_sales
WHERE 
    sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL OR 
    gender IS NULL OR age IS NULL OR category IS NULL OR 
    quantity IS NULL OR price_per_unit IS NULL OR cogs IS NULL;

-- Delete null value records
DELETE FROM retail_sales
WHERE 
    sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL OR 
    gender IS NULL OR age IS NULL OR category IS NULL OR 
    quantity IS NULL OR price_per_unit IS NULL OR cogs IS NULL;
