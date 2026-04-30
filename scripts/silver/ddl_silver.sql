/*
=================================
Data Definition Language(DDL) Script: Create Silver Table
=================================
Purpose: This script creates a table/tables in the silver schema, dropping tables if they previously exists. 
Run this script to re-define the DDL structure of 'silver' table
*/

/*
if table already exits and there are updates to be made, this query tell the db to delete and recreate the table.
The 'U' means - user defined table.
*/

IF OBJECT_ID('silver.sales_SuperMarket_Analysis', 'U') IS NOT NULL
	DROP TABLE silver.sales_SuperMarket_Analysis

CREATE TABLE silver.sales_SuperMarket_Analysis (
InvoiceID INT,
Branch NVARCHAR(25),
City NVARCHAR(25),
CustomerType NVARCHAR(25),
Gender NVARCHAR(10),
ProductLine NVARCHAR(50),
UnitPrice DECIMAL(10, 2),
Quantity INT,
Tax5Percent DECIMAL(10, 2),
Sales DECIMAL(10, 2),
SalesDate DATE,
Payment NVARCHAR(50),
Cogs DECIMAL(10, 2),
Rating DECIMAL(3, 1),
dwh_create_date DATETIME2 DEFAULT GETDATE() -- this is a metadata column added by a DE to a table that do not originate from the source data to provide more info on the each records . It's like a label
)
