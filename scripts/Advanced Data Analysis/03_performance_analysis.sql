/*
===============================================================================
Performance Analysis (Year-over-Year, Month-over-Month)
===============================================================================
Purpose:
    - To measure the performance of products, customers, or regions over time.
    - For benchmarking and identifying high-performing entities.
    - To track yearly trends and growth.
===============================================================================
*/

--Analyze the yearly performance of products by comparing their sales to both 
--the average sales performance of the products and the previous year's sales
select 
	order_date,
	product_name,
	total_sales,
	avg(total_sales) over (partition by product_name) as average_sales,
	total_sales - avg(total_sales) over (partition by product_name) as diff_avg,
	case when total_sales - avg(total_sales) over (partition by product_name) > 0 then 'above_average'
		 when total_sales - avg(total_sales) over (partition by product_name) < 0 then 'below_average'
		 else 'average'
	end as average_change,
	lag(total_sales) over (partition by product_name order by order_date) as previous_year_sales, --LAG(): Accesses data from previous rows.
	total_sales - lag(total_sales) over (partition by product_name order by order_date),  
	case when total_sales - lag(total_sales) over (partition by product_name order by order_date) > 0 then 'encrease'
		 when total_sales - lag(total_sales) over (partition by product_name order by order_date) < 0 then 'decrease'
		 else 'no change'
	end as previous_year_change
from (
	select 
		year(s.order_date) as order_date,
		p.product_name as product_name,
		sum(s.sales_amount) as total_sales
	from gold.fact_sales s
	left join gold.dim_products p
	on p.product_key = s.product_key
	where s.order_date is not null
	group by year(s.order_date),p.product_name
)t
order by product_name, order_date
