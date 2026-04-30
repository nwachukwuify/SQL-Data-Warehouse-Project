/*
=================================
Stored Procedure: Load Silver Layer (Bronze -> Silver)
=================================
Purpose: This script performs the ETL (Etract, Transform and Load) process to populate the silver schema table from the bronze layer. 
It truncates the silver table and inserts transformed and cleansed data from the bronze into the silver.

This stored procedure does not accept any parameters or return any values.

Usage example query to run it
EXEC silver.load_silver
=================================
*/

--creating a stored procedure to save frequently used SQL code in database
CREATE OR ALTER PROCEDURE silver.load_silver AS
BEGIN
	DECLARE @start_time DATETIME, @end_time DATETIME, @batch_start_time DATETIME, @batch_end_time DATETIME  
	BEGIN TRY                                        
		SET @batch_start_time = GETDATE()            
		PRINT '============================='       
		PRINT 'Loading silver layer'
		PRINT '============================='

		--loading silver.sales_SuperMarket_Analysis
		SET @start_time = GETDATE()                  
		PRINT '>> Truncating Table: silver.sales_SuperMarket_Analysis'
		TRUNCATE TABLE silver.sales_SuperMarket_Analysis
		PRINT '>> Inserting Data Into: silver.sales_SuperMarket_Analysis'
	--the column 'Branch' has unwanted space so to trim it, run the below query as well insert clean data into the silver layer 
		INSERT INTO silver.sales_SuperMarket_Analysis(
		Branch, 
		InvoiceID, 
		City,
		CustomerType, 
		Gender, 
		ProductLine, 
		UnitPrice, 
		Quantity,
		Tax5Percent,
		Sales, 
		SalesDate, 
		Payment,
		Cogs, 
		Rating
		)

		SELECT TRIM(Branch) AS Branch, 
		InvoiceID, 
		City,
		CustomerType, 
		Gender, 
		ProductLine, 
		UnitPrice, 
		Quantity,
		Tax5Percent,
		Sales, 
		SalesDate, 
		Payment,
		Cogs, 
		Rating
		FROM bronze.sales_SuperMarket_Analysis

		SET @end_time = GETDATE()                
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds'

		SET @batch_end_time = GETDATE()          
		PRINT '========================================='
		PRINT 'Silver layer loading completed'
		PRINT '>> Total Load Duration: ' + CAST(DATEDIFF(second, @batch_start_time, @batch_end_time) AS NVARCHAR) + ' seconds'
		PRINT '========================================='

	END TRY
	BEGIN CATCH
		PRINT '========================================='
		PRINT 'ERROR OCCURED DURING LOADING SILVER LAYER'
		PRINT 'Error Message' + ERROR_MESSAGE()
		PRINT '========================================='
	END CATCH
END
