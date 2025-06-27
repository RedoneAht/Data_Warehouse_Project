/*
===============================================================================
Ranking Analysis
===============================================================================
Purpose:
    - To rank items (e.g., products, customers) based on performance or other metrics.
    - To identify top performers or laggards.
===============================================================================
*/

--which 5 products generate the highest revenue?
select TOP 5
	p.product_name, 
	sum(s.sales_amount) as total_revenue
from gold.fact_sales s
left join gold.dim_products p
on p.product_key = s.product_key 
group by p.product_name
order by total_revenue desc 

select * from (
	select
		p.product_name, 
		sum(s.sales_amount) as total_revenue,
		row_number() over (order by sum(s.sales_amount) desc) as rank_products
	from gold.fact_sales s
	left join gold.dim_products p
	on p.product_key = s.product_key 
	group by p.product_name
)t
where rank_products <= 5

--what are the 5 worst-performing products in terms of sales?
select TOP 5
	p.product_name, 
	sum(s.sales_amount) as total_revenue
from gold.fact_sales s
left join gold.dim_products p
on p.product_key = s.product_key 
group by p.product_name
order by total_revenue 

