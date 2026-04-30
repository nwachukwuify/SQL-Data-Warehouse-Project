## Gold Layer: Star Schema Overview
The Gold layer consists of five Dimension Views and one central Fact View. All relationships are managed via Surrogate Keys generated using DENSE_RANK().

### Fact Table (Central Metrics)
gold.fact_sales

Column	Data Type	Description
InvoiceID	INT	Natural key for the transaction.
LocationKey	INT	Foreign Key linking to gold.dim_locations.
ProductKey	INT	Foreign Key linking to gold.dim_products.
CustomerKey	INT	Foreign Key linking to gold.dim_customers.
PaymentKey	INT	Foreign Key linking to gold.dim_payment.
DateKey	INT	Foreign Key linking to gold.dim_date.
UnitPrice	DECIMAL	Price per single unit of product.
Quantity	INT	Number of items purchased.
Tax5Percent	DECIMAL	Calculated 5% tax on the sale.
Sales	DECIMAL	Total revenue for the transaction (Gross).
CostOfGoodsSold	DECIMAL	Total cost to the company for the items (Original: Cogs).
Rating	DECIMAL	Customer satisfaction score (1.0 to 10.0).


### Dimension Tables (Descriptive Data)
#### gold.dim_locations

Column	Data Type	Description
LocationKey	INT	Primary Key (Surrogate).
Branch	NVARCHAR(25)	Branch identifier.
City	NVARCHAR(25)	City where the branch is located.


#### gold.dim_products

Column	Data Type	Description
ProductKey	INT	Primary Key (Surrogate).
ProductLine	NVARCHAR(50)	Category of product (e.g., Electronic, Accessories).


#### gold.dim_customers

Column	Data Type	Description
CustomerKey	INT	Primary Key (Surrogate).
CustomerType	NVARCHAR(25)	Membership status (e.g., Member, Normal).
Gender	NVARCHAR(10)	Gender of the customer.



#### gold.dim_payment

Column	Data Type	Description
PaymentKey	INT	Primary Key (Surrogate).
Payment	NVARCHAR(50)	Method used (e.g., Cash, Credit card, Ewallet).


#### gold.dim_date

Column	Data Type	Description
DateKey	INT	Primary Key (Surrogate).
SalesDate	DATE	Cleaned transaction date (Format: YYYY-MM-DD).

====================================================================

### Data Pipeline Traceability
•	Source: CSV File.
•	Bronze Layer: Raw NVARCHAR storage to prevent import failure (handles dashes).
•	Silver Layer: Data cleaning, trimming, and conversion (CONVERT(DATE, ..., 105)).
•	Gold Layer: Business logic transformation into Star Schema Views.
