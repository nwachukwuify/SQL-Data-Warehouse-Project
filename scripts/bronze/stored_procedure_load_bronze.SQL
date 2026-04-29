



--creating a stored procedure to save frequently used SQL code in database
CREATE OR ALTER PROCEDURE bronze.load_bronze AS 
BEGIN
	DECLARE @start_time DATETIME, @end_time DATETIME, @batch_start_time DATETIME, @batch_end_time DATETIME  --track ETL duration to help identify bottlenecks, optimize performance, monitor trends and detect issues
	BEGIN TRY                                        --add TRY...CATCH to ensure error handling, data integrity, and issue logging for easier debugging
		SET @batch_start_time = GETDATE()            --to get the start time the batch loading started
		PRINT '============================='        --adding prints to the stored procedure to track execution, debug issues and understand its flow
		PRINT 'Loading bronze layer'
		PRINT '============================='

		SET @start_time = GETDATE()                  --to get the start time the table started loading
		PRINT '>> Truncating Table: bronze.sales_SuperMarket_Analysis'
		PRINT '>> Inserting data into: bronze.sales_SuperMarket_Analysis'
		TRUNCATE TABLE bronze.sales_SuperMarket_Analysis  --this means to delete all from the table & reset it to an empty state before loading the table with bulk insert
	
		--using bulk insert to load the csv file into the DB. 
		BULK INSERT bronze.sales_SuperMarket_Analysis
		FROM 'C:\Users\Ify I\OneDrive\Desktop\SAIT\CPSY 209 - Data Modeling\source.sales\SuperMarket_Analysis.csv'
		WITH (
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		ROWTERMINATOR = '\n',
		MAXERRORS = 100,
		TABLOCK
		)
		SET @batch_end_time = GETDATE()           --to get the start time the batch loading ended
		PRINT '========================================='
		PRINT 'Bronze layer loading completed'
		PRINT '>> Total Load Duration: ' + CAST(DATEDIFF(second, @batch_start_time, @batch_end_time) AS NVARCHAR) + ' seconds'
		PRINT '========================================='
		SET @end_time = GETDATE()                 --to get the start time the table loading ended
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds'
	END TRY
	BEGIN CATCH
		PRINT '========================================='
		PRINT 'ERROR OCCURED DURING LOADING BRONZE LAYER'
		PRINT 'Error Message' + ERROR_MESSAGE()
		PRINT '========================================='
	END CATCH
END
