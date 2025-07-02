-- Elias Hilliard
-- Change-Overtime-Trends

select
months,
concat(('$'),round(sum(revenue),2)) as Total_sales,
sum(Units_Sold) as total_units_sold,
count(distinct Customer_ID) as total_customers,
count(distinct employee_id) as total_employees,
count(distinct Product_ID) as total_products
from sales_fact
where months is not null
group by months
	