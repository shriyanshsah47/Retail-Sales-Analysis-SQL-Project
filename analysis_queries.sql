-- 1. Sales made on '2022-11-05'
SELECT * FROM retail_sales
WHERE sale_date = '2022-11-05';

-- 2. Clothing sales (Nov-2022) with qty >= 4
SELECT * 
FROM retail_sales
WHERE category = 'Clothing'
  AND TO_CHAR(sale_date, 'YYYY-MM') = '2022-11'
  AND quantity >= 4;

-- 3. Total sales per category
SELECT category,
       SUM(total_sale) AS net_sale,
       COUNT(*) AS total_orders
FROM retail_sales
GROUP BY category;

-- 4. Avg age of customers who bought Beauty products
SELECT ROUND(AVG(age), 2) AS avg_age
FROM retail_sales
WHERE category = 'Beauty';

-- 5. Transactions with sales > 1000
SELECT * FROM retail_sales
WHERE total_sale > 1000;

-- 6. Number of transactions by gender & category
SELECT category, gender,
       COUNT(*) AS total_trans
FROM retail_sales
GROUP BY category, gender
ORDER BY category;

-- 7. Best-selling month in each year
SELECT year, month, avg_sale
FROM (
    SELECT EXTRACT(YEAR FROM sale_date) AS year,
           EXTRACT(MONTH FROM sale_date) AS month,
           AVG(total_sale) AS avg_sale,
           RANK() OVER (PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY AVG(total_sale) DESC) AS rank
    FROM retail_sales
    GROUP BY 1,2
) t
WHERE rank = 1;

-- 8. Top 5 customers by total sales
SELECT customer_id,
       SUM(total_sale) AS total_sales
FROM retail_sales
GROUP BY customer_id
ORDER BY total_sales DESC
LIMIT 5;

-- 9. Unique customers per category
SELECT category,
       COUNT(DISTINCT customer_id) AS cnt_unique_cs
FROM retail_sales
GROUP BY category;

-- 10. Orders per shift
WITH hourly_sale AS (
    SELECT *,
           CASE
               WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
               WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
               ELSE 'Evening'
           END AS shift
    FROM retail_sales
)
SELECT shift,
       COUNT(*) AS total_orders
FROM hourly_sale
GROUP BY shift;
