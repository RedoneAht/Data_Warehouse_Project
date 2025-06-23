/*
===============================================================================
Stored Procedure: Load Bronze Layer (Source -> Bronze)
===============================================================================
Script Purpose:
    This stored procedure loads data into the 'bronze' schema from external CSV files. 
    It performs the following actions:
    - Truncates the bronze tables before loading data.
    - Uses the `BULK INSERT` command to load data from csv Files to bronze tables.

Usage Example:
    EXEC bronze.load_bronze;
===============================================================================
*/

CREAtE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
	BEGIN TRY 
	PRINT '============================================';
	PRINT 'Loading bronze layer';
	PRINT '============================================';
	
	PRINT'------------------------------------';
	PRINT 'Loading crm tables';
	PRINT'------------------------------------';

	PRINT '>> Truncating table: bronze.crm_cust_info';
	TRUNCATE TABLE bronze.crm_cust_info;			--Empty the table first
	
	PRINT '>> Inserting table: bronze.crm_cust_info';
	BULK INSERT bronze.crm_cust_info
	FROM 'C:\Users\ahnta\Desktop\Project_DataWarehouse\source_crm\cust_info.csv'
	WITH (
		FIRSTROW = 2,  --skip the header(first row)
		FIELDTERMINATOR = ',',
		TABLOCK			--Lock the table while loading it
	);

	PRINT '>> Truncating table: bronze.crm_prd_info';
	TRUNCATE TABLE bronze.crm_prd_info;			--Empty the table first

	PRINT '>> Inserting table: bronze.crm_prd_info';
	BULK INSERT bronze.crm_prd_info
	FROM 'C:\Users\ahnta\Desktop\Project_DataWarehouse\source_crm\prd_info.csv'
	WITH (
		FIRSTROW = 2,  --skip the header(first row)
		FIELDTERMINATOR = ',',
		TABLOCK			--Lock the table while loading it
	);

	PRINT '>> Truncating table: bronze.crm_sales_details';
	TRUNCATE TABLE bronze.crm_sales_details;			--Empty the table first

	PRINT '>> Inserting table: bronze.crm_sales_details';
	BULK INSERT bronze.crm_sales_details
	FROM 'C:\Users\ahnta\Desktop\Project_DataWarehouse\source_crm\sales_details.csv'
	WITH (
		FIRSTROW = 2,  --skip the header(first row)
		FIELDTERMINATOR = ',',
		TABLOCK			--Lock the table while loading it
	);
	
	PRINT'------------------------------------';
	PRINT 'Loading erp tables';
	PRINT'------------------------------------';

	PRINT '>> Truncating table: bronze.erp_cust_az12';
	TRUNCATE TABLE bronze.erp_cust_az12;			--Empty the table first

	PRINT '>> Inserting table: bronze.erp_cust_az12';
	BULK INSERT bronze.erp_cust_az12
	FROM 'C:\Users\ahnta\Desktop\Project_DataWarehouse\source_erp\cust_az12.csv'
	WITH (
		FIRSTROW = 2,  --skip the header(first row)
		FIELDTERMINATOR = ',',
		TABLOCK			--Lock the table while loading it
	);

	PRINT '>> Truncating table: bronze.erp_loc_a101';
	TRUNCATE TABLE bronze.erp_loc_a101;			--Empty the table first

	PRINT '>> Inserting table: bronze.erp_loc_a101';
	BULK INSERT bronze.erp_loc_a101
	FROM 'C:\Users\ahnta\Desktop\Project_DataWarehouse\source_erp\loc_a101.csv'
	WITH (
		FIRSTROW = 2,  --skip the header(first row)
		FIELDTERMINATOR = ',',
		TABLOCK			--Lock the table while loading it
	);

	PRINT '>> Truncating table: bronze.erp_px_cat_g1v2';
	TRUNCATE TABLE bronze.erp_px_cat_g1v2;			--Empty the table first

	PRINT '>> Inserting table: bronze.erp_px_cat_g1v2';
	BULK INSERT bronze.erp_px_cat_g1v2
	FROM 'C:\Users\ahnta\Desktop\Project_DataWarehouse\source_erp\px_cat_g1v2.csv'
	WITH (
		FIRSTROW = 2,  --skip the header(first row)
		FIELDTERMINATOR = ',',
		TABLOCK			--Lock the table while loading it
	);

	END TRY
	BEGIN CATCH 
		PRINT '=========================================='
		PRINT 'ERROR OCCURED DURING LOADING BRONZE LAYER'
		PRINT 'Error Message' + ERROR_MESSAGE();
		PRINT 'Error Message' + CAST (ERROR_NUMBER() AS NVARCHAR);
		PRINT 'Error Message' + CAST (ERROR_STATE() AS NVARCHAR);
		PRINT '=========================================='
	END CATCH
END;
