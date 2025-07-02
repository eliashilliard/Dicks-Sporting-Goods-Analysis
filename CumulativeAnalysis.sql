-- Elias Hilliard
-- Cumulative Analysis 


select
months as order_date,
total_sales,
sum(total_sales) over(order by months) as runnings_monthly_sales,
avg(average_units_sold) over(order by months) as moving_averages
from
(
select
months,
round(sum(revenue),2) as total_sales,
avg(units_sold) as average_units_sold
from sales_fact
where months is not null
group by months
) t