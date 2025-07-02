-- Elias Hilliard

/* 
CUSTOMER REPORT

Purpose:
	- This report consolidates key customer metrics and behaviors

Highlights:
	1. Gathers essential fields such as names, ages, and transaction details.
	2. Segments customers into categories (VIP, Regular, New) and age groups.
	3. Aggregate customer-level metrics:
		- Total Orders
		- Total Sales
		- Total Quantity Purchased
		- Total Products
*/

-- 1. Base Query: Retrieves core coloumns from tables
create view customer_report as 
with base_query as (
select
c.Customer_ID,
Customer_name, 
age, 
gender,
membership_status,
product_id,
revenue, 
units_sold
from sales_fact s, dbo.customer c
where s.Customer_ID = c.Customer_ID) 

, customer_aggregation as (
select
customer_id,
customer_name, 
age,
gender,
membership_status,
count(distinct product_id) as total_products,
concat('$',round(sum(revenue),2)) as total_sales,
sum(units_sold) as total_units_sold
from base_query
group by 
Customer_ID,
customer_name,
age,
gender,
membership_status)
select
customer_id,
customer_name, 
age,
gender,
membership_status,
case when age < 20 then 'Under 20'
when age between 20 and 29 then '20-29'
when age between 30 and 39 then '30-39'
when age between 40 and 49 then '40-49'
else 'Over 50'
end Age_group,
total_products,
total_sales,
total_units_sold
from customer_aggregation

