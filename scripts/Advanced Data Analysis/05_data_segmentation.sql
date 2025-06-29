/*
===============================================================================
Data Segmentation Analysis
===============================================================================
Purpose:
    - To group data into meaningful categories for targeted insights.
    - For customer segmentation, product categorization, or regional analysis.
===============================================================================
*/

--segment products into cost ranges and count how many products fall into each segment

select 
	cost_range,
	count(product_key) as total_products
from (
select 
	product_key,
	product_name,
	cost,
	case when cost < 100 then 'bellow 100'
		 when cost > 100 and cost < 500 then '100-500'
		 when cost > 500 and cost < 1000 then '500-1000'
		 else 'above 1000'
	end as cost_range
from gold.dim_products
)t
group by cost_range
order by total_products desc

/*Group customers into three segments based on their spending behavior:
	- VIP: Customers with at least 12 months of history and spending more than €5,000.
	- Regular: Customers with at least 12 months of history but spending €5,000 or less.
	- New: Customers with a lifespan less than 12 months.
And find the total number of customers by each group
*/

select
	customer_segment,
	count(customer_key) as total_customers
from(
	select 
		customer_key,
		firstname,
		lastname,
		case when liftespan >= 12 and total_spending > 5000 then 'vip'
			 when liftespan >= 12 and total_spending <= 5000 then 'regular'
			 else'new'
		end as customer_segment
	from(
		select 
			c.customer_key,
			firstname,
			lastname,
			min(order_date) as first_order,
			max(order_date) as last_order,
			datediff(month, min(order_date),max(order_date)) as liftespan,
			sum(s.sales_amount) as total_spending
		from gold.fact_sales s
		left join gold.dim_customers c
		on c.customer_key = s.customer_key
		group by c.customer_key,firstname,lastname
	)t
)t
group by customer_segment