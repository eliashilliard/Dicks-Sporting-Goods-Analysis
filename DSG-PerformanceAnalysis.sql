-- Elias Hilliard

/*Analyze the monthly performance of products by comparing their sales and units sold to the
previous year's sales and units sold*/

with monthly_sales as (
select
months,
product_name,
round(sum(revenue),2) as current_sales,
sum(units_sold) as current_units_sold
from sales_fact, dbo.product
where sales_fact.Product_ID = dbo.product.Product_ID
group by months, Product_Name
)
select
months, 
product_name, 
current_sales,
current_units_sold,
lag(current_units_sold) over(partition by product_name order by months) as previous_month_unitsold,
current_units_sold - lag(current_units_sold) over(partition by product_name order by months) as diff_units_sold,
case when current_units_sold - lag(current_units_sold) over(partition by product_name order by months) < 0 then 'Decrease Units Sold'
when current_units_sold - lag(current_units_sold) over(partition by product_name order by months) > 0 then 'Increase Units Sold'
else 'No Change'
end as monthly_units_performance,
lag(current_sales) over(partition by product_name order by months) as previous_month_sales,
current_sales - lag(current_sales) over(partition by product_name order by months) as diff_month_sales,
case when current_sales - lag(current_sales) over(partition by product_name order by months) < 0 then 'Increase Sales'
when current_sales - lag(current_sales) over(partition by product_name order by months) > 0 then 'Decrease Sales'
else 'No Change'
end as monthly_sale_performance
from monthly_sales