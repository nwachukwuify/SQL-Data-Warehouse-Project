

--Surrogate(foreign key) integration test
SELECT *
FROM gold.fact_sales f
left join gold.dim_customers c
on c.CustomerKey = f.CustomerKey
