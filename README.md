# 🍫 Chocolate Sales Analytics — Power BI + ML

problem statement :
Problem Statement — Power BI:

"Build an interactive Chocolate Sales Performance Dashboard for Sales Leadership to monitor team performance, product profitability, and country-wise market penetration for Jan-Aug 2022 — with actionable insights to drive Q3/Q4 strategy"

What we're tracking in Power BI:

Page 1 — Sales Overview

Total Sales, Total Profit, Total Transactions, Avg Sale KPIs
Sales by Month — trend line
Sales by Country — map or bar chart
Premium vs Non-Premium split

Page 2 — Salesperson Performance

Actual vs Target by salesperson
Top/Bottom performers
Performance by experience level and team
Who is at risk of missing annual target?

Page 3 — Product Analysis

Sales and profit by product category
Premium vs Non-Premium deep dive
Top products by country
Margin analysis

Page 4 — Country & Market

Tier 1 vs Tier 2 market comparison
India premium insight — callout card!
Country profitability map
Best product per country


Problem Statement — ML:

"Using Jan-Aug 2022 sales data, predict September 2022 sales amount and profit for each salesperson-product-country combination, and classify whether each salesperson will hit their monthly target"


🎯 What ML is solving:
Model	Question	Type
Model 1	Predict Sep sales amount	Regression
Model 2	Predict Sep profit	Regression
Model 3	Will salesperson hit Sep target?	Classification
Features ML will use:
Monthly averages per salesperson
Product category, margin, premium flag
Country market tier
Experience level, team
Seasonal patterns (month number)
Discount %, customer type
Historical target achievement rate
