/*
=======================================
Quality Checks
=======================================
This script performs various quality checks to validate integrity, consistency and accuracy of the Gold layer. It checks for:
-Uniqueness of surrogate keys
-Integrity between fact and dimension tables
-Validation of relationships in the data model for analytical purposes

Note: Only run these checks after data loading into gold layer. Also, investigate and resolve any discrepancies found during the checks.

*/
=================================================================
--Checking for data model connectivity between fact and dimensions
SELECT *
FROM gold.fact_sales f
left join gold.dim_customers c
on c.CustomerKey = f.CustomerKey
left join gold.dim_date d
on d.DateKey = f.DateKey
left join gold.dim_locations l
on l.LocationKey = f.LocationKey
left join gold.dim_payment pm
on pm.PaymentKey = f.PaymentKey
left join gold.dim_products p
on p.ProductKey = f.ProductKey
WHERE c.CustomerKey IS NULL
OR d.DateKey IS NULL
OR l.LocationKey IS NULL
OR pm.PaymentKey IS NULL
OR p.ProductKey IS NULL

==================================================================
--check for uniqueness of CustomerKey in gold.dim_customers
SELECT CustomerKey
FROM gold.dim_customers
GROUP BY CustomerKey
HAVING COUNT(*) > 1

--check for uniqueness of ProductKey in gold.dim_products
SELECT ProductKey
FROM gold.dim_products
GROUP BY ProductKey
HAVING COUNT(*) > 1

  --check for uniqueness of LocationKey in gold.dim_locations
SELECT LocationKey
FROM gold.dim_locations
GROUP BY LocationKey
HAVING COUNT(*) > 1

  --check for uniqueness of PaymentKey in gold.dim_payment
SELECT PaymentKey
FROM gold.dim_payment
GROUP BY PaymentKey
HAVING COUNT(*) > 1

  --check for uniqueness of DateKey in gold.dim_date
SELECT DateKey
FROM gold.dim_date
GROUP BY DateKey
HAVING COUNT(*) > 1

