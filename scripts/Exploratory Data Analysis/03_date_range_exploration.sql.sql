/*
===============================================================================
Date Range Exploration 
===============================================================================
Purpose:
    - To determine the temporal boundaries of key data points.
    - To understand the range of historical data.
===============================================================================
*/


--find the date of the first and last order
select 
	MIN(order_date) as first_order_date, 
	MAX(order_date) as last_order_date, 
	DATEDIFF(month, MIN(order_date),MAX(order_date)) as order_range_months  
from gold.fact_sales

--find the youngest and oldest customer
select 
	datediff(year,min(birthdate),getdate()) as oldest_customer,
	datediff(year,max(birthdate),getdate()) as youngest_customer
from gold.dim_customers
