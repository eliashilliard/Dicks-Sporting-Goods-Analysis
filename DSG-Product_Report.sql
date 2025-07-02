/* 
PRODUCT REPORT

Purpose:
	- This report consolidates key product metrics and behaviors

Highlights:
	1. Gathers essential fields such as product names, category, and transaction details.
	2. Segments customers into categories (High Demand, Average, Low Demand).
	3. Aggregate customer-level metrics:
		- Total Products
		- Total Sales
		- Total Units Sold
		- Total Units on Hand
*/

with base_query as (
select
i.product_id,
p.product_name,
p.category,
unit_price,
units_on_hand,
units_sold,
revenue
from inventory i, sales_fact s, product p
where i.Product_ID = s.Product_ID
and i.Product_ID = p.Product_ID 
)
, product_aggregation as (
select 
product_name,
category,
product_id,
unit_price,
units_sold,
units_on_hand,
count(distinct product_id) as total_products,
concat('$',round(sum(revenue),2)) as total_sales,
sum(units_sold) as total_units_sold
from base_query
group by 
product_name,
category,
product_id,
unit_price,
units_on_hand,
units_sold)
select 
product_name,
category,
product_id,
concat('$', round(unit_price,2)) as unit_price,
units_on_hand,
case when units_sold < 50 then 'Low Demand'
when units_sold between 50 and 100 then 'Average Demand'
else 'High Demand'
end product_demand,
total_products,
total_sales,
total_units_sold
from product_aggregation
