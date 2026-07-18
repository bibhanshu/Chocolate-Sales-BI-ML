--view
SELECT COUNT(*) FROM sales_fact;
SELECT COUNT(*) FROM dim_salesperson;
SELECT COUNT(*) FROM dim_product;
SELECT COUNT(*) FROM dim_country;
SELECT COUNT(*) FROM monthly_targets;


-- Top 5 rows of each table
SELECT TOP 5 * FROM sales_fact;
SELECT TOP 5 * FROM dim_salesperson;
SELECT TOP 5 * FROM dim_product;
SELECT TOP 5 * FROM dim_country;
SELECT TOP 5 * FROM monthly_targets;


--Common stats
select salesperson_name,sum(amount) as Total_amount,sum(profit) as Total_profit  FROM sales_fact
group by salesperson_name

--Person with top sales  --- Ches Bonnell 320901 --- top preformer with sales
select Top 1 salesperson_name,Total_amount from (select salesperson_name,sum(amount) as Total_amount,sum(profit) as Total_profit  FROM sales_fact
group by salesperson_name) as sales_data
order by Total_amount desc

--Person with top profit  --- Ches Bonnell 126663 --- top preformer with profit
select Top 1 salesperson_name,Total_profit from (select salesperson_name,sum(amount) as Total_amount,sum(profit) as Total_profit  FROM sales_fact
group by salesperson_name) as sales_data
order by Total_amount desc

--low performer --Wilone O'Kielt--138523
select Top 1 salesperson_name,Total_amount from (select salesperson_name,sum(amount) as Total_amount,sum(profit) as Total_profit  FROM sales_fact
group by salesperson_name) as sales_data
order by Total_amount

--Which country makes most sales? --Australia with 1137367
select top 1 country,sum(amount) as Total_amount from sales_fact
group by country
order by Total_amount desc


--Which product is most profitable? -- White choc - 138415
select top 1  product,sum(profit) as Total_profit from sales_fact
group by product
order by Total_profit desc

--Which month has highest sales?
-- this might be wrong as the granuality will be 
--wrong if i do group by month it will group by let say jan of 2025 with 2026 
--the more insight full question could be top selling month of 2025 or 2026 or top selling month of each year 
--and we can see diff 
-- Top selling month per year
SELECT 
    year,
    month,
    SUM(amount) AS monthly_sales,
    RANK() OVER (PARTITION BY year ORDER BY SUM(amount) DESC) AS rank_in_year
FROM sales_fact
GROUP BY year, month
ORDER BY year, rank_in_year

-- Top selling month in 2022 --month 1 with sales 89610 profit 348820 transection 154
SELECT 
    month,
    SUM(amount) AS monthly_sales,
    SUM(profit) AS total_profit,
    COUNT(*) AS transactions
FROM sales_fact
GROUP BY month
ORDER BY monthly_sales DESC

-- Check date range exactly -- we have data from Jan 2022 to aug 20222
SELECT 
    MIN(date) AS earliest_date,
    MAX(date) AS latest_date
FROM sales_fact

--transiction per month 
SELECT 
    month,
    COUNT(*) AS transactions,
    SUM(amount) AS monthly_sales,
    ROUND(SUM(amount) * 1.0 / COUNT(*), 0) AS avg_sale_per_transaction
FROM sales_fact
GROUP BY month
ORDER BY month