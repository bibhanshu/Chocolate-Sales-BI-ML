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

-- Sales and product join view :
select * from [dbo].[sales_fact] SF
left join [dbo].[dim_product] PD on SF.product = PD.product_name
-- so the above is basically a basement to verify nulls in product table how many products tables null i have i can add a extra where statement coloumn name is null 
-- the reverse can happnen or right join to see how many products are not in sales table zero sales further can be clasified on date and month ganuality

-- I will continue with Inner join though 
--premium product sales
select SF.product,sum(SF.amount) as Primium_product_amount,sum(SF.profit) as Primium_product_profit from [dbo].[sales_fact] SF
inner join [dbo].[dim_product] PD on SF.product = PD.product_name
where PD.is_premium = 1
group by SF.product


--Non premium product sales
select SF.product,sum(SF.amount) as Primium_product_amount,sum(SF.profit) as Primium_product_profit from [dbo].[sales_fact] SF
inner join [dbo].[dim_product] PD on SF.product = PD.product_name
where PD.is_premium = 0
group by SF.product

-- premium vs non premium product details 
-- Premium vs Non Premium comparison
SELECT 
    PD.is_premium,
    COUNT(DISTINCT SF.product) AS product_count,
    SUM(SF.amount) AS total_sales,
    SUM(SF.profit) AS total_profit,
    ROUND(SUM(SF.profit) * 100.0 / SUM(SF.amount), 2) AS profit_margin_pct
FROM sales_fact SF
INNER JOIN dim_product PD ON SF.product = PD.product_name
GROUP BY PD.is_premium

--Premium vs non premium
select SF.product,sum(SF.amount) as Primium_product_amount,sum(SF.profit) as Primium_product_profit,PD.is_premium from [dbo].[sales_fact] SF
inner join [dbo].[dim_product] PD on SF.product = PD.product_name
where PD.is_premium = 1
group by SF.product,PD.is_premium
union
select SF.product,sum(SF.amount) as Primium_product_amount,sum(SF.profit) as Primium_product_profit,PD.is_premium from [dbo].[sales_fact] SF
inner join [dbo].[dim_product] PD on SF.product = PD.product_name
where PD.is_premium = 0
group by SF.product,PD.is_premium

--++ country + Prod + Sales fact
select * from [dbo].[sales_fact] SF
inner join [dbo].[dim_product] PD on SF.product = PD.product_name
inner join [dbo].[dim_country] CT on CT.country_name = SF.country

--country product,premium,category,tier wise details 
select SF.product,sum(SF.amount) as Primium_product_amount,sum(SF.profit) as Primium_product_profit,PD.is_premium,CT.country_name,CT.market_tier from [dbo].[sales_fact] SF
inner join [dbo].[dim_product] PD on SF.product = PD.product_name
inner join [dbo].[dim_country] CT on CT.country_name = SF.country
group by SF.product,PD.is_premium,CT.country_name,CT.market_tier


--Which country buys most premium products?
with CTE as (
select SF.product,sum(SF.amount) as Primium_product_amount,sum(SF.profit) as Primium_product_profit,PD.is_premium,CT.country_name,CT.market_tier from [dbo].[sales_fact] SF
inner join [dbo].[dim_product] PD on SF.product = PD.product_name
inner join [dbo].[dim_country] CT on CT.country_name = SF.country
group by SF.product,PD.is_premium,CT.country_name,CT.market_tier
)
--select country_name,count(is_premium) as count_premium_products from CTE
--where is_premium = 1
--group by country_name
select country_name, sum(Primium_product_amount) as premium_sales
from CTE
where is_premium = 1
group by country_name
order by premium_sales desc

--Which product-country combo has highest profit?


--Tier 1 vs Tier 2 market performance?
