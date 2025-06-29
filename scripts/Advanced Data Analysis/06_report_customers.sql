/*
===============================================================================
Customer Report
===============================================================================
Purpose:
    - This report consolidates key customer metrics and behaviors

Highlights:
    1. Gathers essential fields such as names, ages, and transaction details.
	2. Segments customers into categories (VIP, Regular, New) and age groups.
    3. Aggregates customer-level metrics:
	   - total orders
	   - total sales
	   - total quantity purchased
	   - total products
	   - lifespan (in months)
    4. Calculates valuable KPIs:
	    - recency (months since last order)
		- average order value
		- average monthly spend
===============================================================================
*/
create view gold.report_customers as 
with base_query as (
select 
	s.order_number,
	s.product_key,
	s.order_date,
	s.sales_amount,
	s.quantity,
	c.customer_key,
	c.customer_number,
	concat(c.firstname, ' ', c.lastname) as customer_name,
	c.birthdate,
	DATEDIFF(year,c.birthdate,getdate()) as customer_age
from gold.fact_sales s
left join gold.dim_customers c
on c.customer_key = s.customer_key
where order_date is not null
)

, customer_agregation as (
select
	customer_key,
	customer_number,
	customer_name,
	customer_age,
	count(distinct order_number) as total_orders,
	sum(sales_amount) as total_sales,
	sum(quantity) as total_quantity,
	count(distinct product_key) as total_products,
	max(order_date) as last_order,
	min(order_date) as first_order,
	datediff(month, min(order_date), max(order_date)) as lifespan
from base_query
group by customer_key,customer_number,customer_name,customer_age
)

select 
	customer_key,
	customer_number,
	customer_name,
	customer_age,
	CASE WHEN customer_age < 20 THEN 'Under 20'
		 WHEN customer_age between 20 and 29 THEN '20-29'
		 WHEN customer_age between 30 and 39 THEN '30-39'
		 WHEN customer_age between 40 and 49 THEN '40-49'
		 ELSE '50 and above'
	END AS age_group,
	case when lifespan >= 12 and total_sales > 5000 then 'vip'
			 when lifespan >= 12 and total_sales <= 5000 then 'regular'
			 else'new'
		end as customer_segment,
	total_orders,
	total_sales,
	total_quantity,
	total_products,
	first_order,
	last_order,
	DATEDIFF(month, last_order, GETDATE()) AS recency,
	lifespan,
	-- Compuate average order value (AVO)
	CASE WHEN total_sales = 0 THEN 0
		 ELSE total_sales / total_orders
	END AS avg_order_value,
	-- Compuate average monthly spend
	CASE WHEN lifespan = 0 THEN total_sales
		 ELSE total_sales / lifespan
	END AS avg_monthly_spend
from customer_agregation