/*
===============================================================================
Measures Exploration (Key Metrics)
===============================================================================
Purpose:
    - To calculate aggregated metrics (e.g., totals, averages) for quick insights.
    - To identify overall trends or spot anomalies.
===============================================================================
*/


--find the total sales
select SUM(sales_amount) as total_sales from gold.fact_sales

--find how many items are sold
select sum(quantity) as number_sold_items from gold.fact_sales

--find the average selling price
select AVG(price) as average_selling_price from gold.fact_sales

--find the total number of orders
select count(distinct order_number) as total_number_orders from gold.fact_sales

--find the total number of products
select count(product_key) as total_number_products from gold.dim_products

--find the total number of customers
select count(customer_key) as total_number_customers from gold.dim_customers

--find the total number of customers that has placed an order
select count(distinct customer_key) as total_number_customers_that_ordered from gold.fact_sales


--generate a report that shows all key metrics of the business

select 'Total sales' as measure_name, SUM(sales_amount) as measure_value from gold.fact_sales
union all
select 'Total quantity', sum(quantity) from gold.fact_sales
union all
select 'Average selling price', AVG(price) from gold.fact_sales
union all
select 'Total number orders', count(distinct order_number) from gold.fact_sales
union all
select 'Total number products', count(product_key) from gold.dim_products
union all
select 'Total number customers', count(customer_key) from gold.dim_customers
union all
select 'Total number customers that ordered', count(distinct customer_key) from gold.fact_sales

