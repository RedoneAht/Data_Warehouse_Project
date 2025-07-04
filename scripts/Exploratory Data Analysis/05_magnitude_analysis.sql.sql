/*
===============================================================================
Magnitude Analysis
===============================================================================
Purpose:
    - To quantify data and group results by specific dimensions.
    - For understanding data distribution across categories.
===============================================================================
*/


--find total customers by countries
select 
	country, 
	count(customer_id) as total_customers 
from gold.dim_customers
group by country
order by total_customers desc

--find total customers by gender
select 
	gender, 
	count(customer_id) as total_customers 
from gold.dim_customers
group by gender
order by total_customers desc

--find total products by category
select 
	category, 
	count(product_key) as total_products
from gold.dim_products
group by category
order by total_products desc

--what is the average costs in each category?
select 
	category, 
	avg(cost) as average_cost
from gold.dim_products
group by category
order by average_cost desc

--what is the total revenue generated for each categrory?
select 
	p.category, 
	sum(s.sales_amount) as total_revenue
from gold.fact_sales s
left join gold.dim_products p
on p.product_key = s.product_key 
group by p.category
order by total_revenue desc

--find total revenue generated by each customer
select 
	c.customer_key,
	c.firstname,
	c.lastname,
	sum(s.sales_amount) as total_revenue
from gold.fact_sales s
left join gold.dim_customers c
on c.customer_key = s.customer_key 
group by 
	c.customer_key,
	c.firstname,
	c.lastname
order by total_revenue desc

--what is the distribution of sold items across countries?
select 
	c.country,
	sum(s.quantity) as total_sold_items
from gold.fact_sales s
left join gold.dim_customers c
on c.customer_key = s.customer_key 
group by 
	c.country
order by total_sold_items desc
