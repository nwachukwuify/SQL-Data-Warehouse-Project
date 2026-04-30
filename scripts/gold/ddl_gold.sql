/*
=================================
Data Definition Language(DDL) Script: Create Gold Views
=================================
Purpose: This script creates views for the Gold layer in the data warehouse. It represents the final dimension and fact tables (Star Schema)
Each view performs transformation and combines data from the silver layer to prduce a clean and business-ready dataset.

These views can be queried directly for analytics and reporting.
*/
=================================================================
--Creating dimension tables as views for the gold layer
IF OBJECT_ID('gold.dim_locations', 'V') IS NOT NULL
  DROP VIEW gold.dim_locations
GO
  
CREATE VIEW gold.dim_locations AS                 -- gold.dim_locations
SELECT DISTINCT
    DENSE_RANK() OVER (ORDER BY Branch, City) AS LocationKey,
    Branch,
    City
FROM silver.sales_SuperMarket_Analysis;
GO

---------------------------------------------------------------
IF OBJECT_ID('gold.dim_products', 'V') IS NOT NULL
  DROP VIEW gold.dim_products
GO
  
CREATE VIEW gold.dim_products AS                   -- gold.dim_products
SELECT DISTINCT
    DENSE_RANK() OVER (ORDER BY ProductLine) AS ProductKey,
    ProductLine
FROM silver.sales_SuperMarket_Analysis;

GO
 --------------------------------------------------------------
IF OBJECT_ID('gold.dim_customers', 'V') IS NOT NULL
  DROP VIEW gold.dim_customers
GO
  
CREATE VIEW gold.dim_customers AS                  -- gold.dim_customers
SELECT DISTINCT
    DENSE_RANK() OVER (ORDER BY CustomerType, Gender) AS CustomerKey,
    CustomerType,
	Gender
FROM silver.sales_SuperMarket_Analysis;

GO
 --------------------------------------------------------------
IF OBJECT_ID('gold.dim_payment', 'V') IS NOT NULL
  DROP VIEW gold.dim_payment
GO
  
CREATE VIEW gold.dim_payment AS                  -- gold.dim_payment
SELECT DISTINCT
    DENSE_RANK() OVER (ORDER BY Payment) AS PaymentKey,
    Payment
FROM silver.sales_SuperMarket_Analysis;

GO
 --------------------------------------------------------------
IF OBJECT_ID('gold.dim_date', 'V') IS NOT NULL
  DROP VIEW gold.dim_date
GO
  
CREATE VIEW gold.dim_date AS                     -- gold.dim_date
SELECT DISTINCT
    DENSE_RANK() OVER (ORDER BY SalesDate) AS DateKey,
    SalesDate
FROM silver.sales_SuperMarket_Analysis;

GO
=================================================================
--Creating the fact table
IF OBJECT_ID('gold.fact_sales', 'V') IS NOT NULL
  DROP VIEW gold.fact_sales
GO
CREATE VIEW gold.fact_sales AS
SELECT 
    s.InvoiceID,
    l.LocationKey,
    p.ProductKey,
    c.CustomerKey,
    pm.PaymentKey,
    d.DateKey,
    s.UnitPrice,
    s.Quantity,
    s.Tax5Percent AS FivePercentTax,
    s.Sales,
    s.Cogs AS CostOfGoodsSold, 
    s.Rating
FROM silver.sales_SuperMarket_Analysis s
LEFT JOIN gold.dim_locations l 
    ON s.Branch = l.Branch AND s.City = l.City
LEFT JOIN gold.dim_products p 
    ON s.ProductLine = p.ProductLine
LEFT JOIN gold.dim_customers c 
    ON s.CustomerType = c.CustomerType AND s.Gender = c.Gender
LEFT JOIN gold.dim_payment pm 
    ON s.Payment = pm.Payment
LEFT JOIN gold.dim_date d 
    ON s.SalesDate = d.SalesDate;


