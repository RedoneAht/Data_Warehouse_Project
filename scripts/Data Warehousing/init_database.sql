/*
Create database and schemas

This script creates a new databse named 'DataWarehouse' after checking if it already exists.
if it does, it is dropped and recreated. Then the script sets up three schemas: bronze,silver and gold

*/


use master;
go

--Drop and recreate the 'DataWarehouse' database
if exists (select 1 from sys.databases where name ='DataWarehouse')
begin 
	alter database DataWarehouse set single_user with rollback immediate;
	drop database DataWarehouse;
end;
go 

-- Create DataBase 'DataWarehouse'
create database DataWarehouse;
go

use DataWarehouse;
go 

create schema bronze;
go
create schema silver;
go      -- Go separate batches when working with multiple SQL statements
create schema gold;
go
