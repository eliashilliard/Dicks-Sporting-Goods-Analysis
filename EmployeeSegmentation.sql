-- Elias Hilliard
/* Group employees into three segments based on their units_sold:
	- Great Numbers: Employee has sold 2000+ units
	- Good Numbers: Employee has sold between 1000-2000 units 
	- Needs Improvement: Employee has sold under 1000 units
*/

with employee_sales as (
select 
employee_name,
round(sum(revenue),2) as total_sales,
sum(units_sold) as total_units_sold
from employee, sales_fact
where employee.Employee_ID = sales_fact.Employee_ID
group by Employee_Name
)
select 
employee_name,
total_sales,
total_units_sold,
case when total_units_sold < 1000 then 'Needs Improvement'
when total_units_sold between 1000 and 2000 then 'Good Numbers'
else 'Great Numbers'
end employee_summary
from employee_sales
order by total_units_sold desc