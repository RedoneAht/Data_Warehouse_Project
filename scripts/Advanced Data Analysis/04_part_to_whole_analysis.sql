/*
===============================================================================
Part-to-Whole Analysis
===============================================================================
Purpose:
    - To compare performance or metrics across dimensions or time periods.
    - To evaluate differences between categories.
    - Useful for A/B testing or regional comparisons.
===============================================================================
*/

--which categories contribute the most to overall sales?

select 
	category,
	total_sales,
	sum(total_sales) over () overall_sales,
	concat(round((cast(total_sales as float) / sum(total_sales) over ()) * 100, 2), '%') as percentage_of_total
from(
select 
	p.category,
	sum(s.sales_amount) as total_sales
from gold.fact_sales s
left join gold.dim_products p
on s.product_key = p.product_key
group by p.category
)t