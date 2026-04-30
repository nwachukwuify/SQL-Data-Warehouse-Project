/*
=======================================
Quality Checks
=======================================
This script performs various quality checks for data consistency, accuracy, and standardization accross the silver schema. It checks for:
-Nulls or dulpicate primary keys
-Data consistency & standardization
-Unwanted spaces in string fields

Note: Only run these checks after data loading into silver layer. Also, investigate and resolve any discrepancies found during the checks.

*/

SELECT *
FROM silver.sales_SuperMarket_Analysis

--to check for duplicates or null values in the primary key 'InvoiceID' 
--Expectation: No results
SELECT InvoiceID, count(*)
FROM silver.sales_SuperMarket_Analysis
GROUP BY InvoiceID
HAVING count(*) > 1 OR InvoiceID IS NULL

--to check for data consistency & standardization
SELECT DISTINCT Payment
FROM silver.sales_SuperMarket_Analysis

--to check for unwanted spaces 
--Expectation: No results
SELECT Branch
FROM silver.sales_SuperMarket_Analysis
WHERE Branch != TRIM(Branch)

--to confirm the change of datatype for SalesDate column from String to Date
EXEC sp_help 'silver.sales_SuperMarket_Analysis';
