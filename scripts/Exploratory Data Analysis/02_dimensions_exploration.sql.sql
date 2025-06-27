/*
===============================================================================
Dimensions Exploration
===============================================================================
Purpose:
    - To explore the structure of dimension tables.
===============================================================================
*/

--explore all countries of the customers
select DISTINCT country from gold.dim_customers 

--explore all the categories of the products
select distinct category,subcategory,product_name from gold.dim_products
order by 1,2,3