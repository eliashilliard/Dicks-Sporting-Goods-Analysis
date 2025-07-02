--Elias Hilliard
-- What percentage amount of each dsg product category contributes to the revenue

with product_category as (
select
category,
round(sum(revenue),2) as category_sales
from dbo.product, sales_fact
where dbo.product.Product_ID = dbo.sales_fact.Product_ID
group by category
)
select 
category,
category_sales,
sum(category_sales) over() as total_sales,
concat(round((category_sales / sum(category_sales) over() * 100),2), '%') as total_sales_percentage
from product_category
order by total_sales_percentage desc

