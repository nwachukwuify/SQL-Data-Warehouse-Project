## Gold Layer: Star Schema Overview
The Gold layer consists of five Dimension Views and one central Fact View. All relationships are managed via Surrogate Keys generated using DENSE_RANK().

### Fact Table (Central Metrics)
Fact Table (Central Metrics)
gold.fact_sales
Column	Data Type	Description
InvoiceID	NVARCHAR(50)	Natural key for the transaction (contains dashes).
LocationKey	BIGINT	Foreign Key linking to gold.dim_locations.
ProductKey	BIGINT	Foreign Key linking to gold.dim_products.
CustomerKey	BIGINT	Foreign Key linking to gold.dim_customers.
PaymentKey	BIGINT	Foreign Key linking to gold.dim_payment.
DateKey	BIGINT	Foreign Key linking to gold.dim_date.
UnitPrice	DECIMAL(10,2)	Price per single unit of product.
Quantity	INT	Number of items purchased.
Tax5Percent	DECIMAL(10,2)	Calculated 5% tax on the sale.
Sales	DECIMAL(10,2)	Total revenue for the transaction (Gross).
CostOfGoodsSold	DECIMAL(10,2)	Total cost to the company for the items (Original: Cogs).
Rating	DECIMAL(3,1)	Customer satisfaction score (1.0 to 10.0).
GrossProfit	DECIMAL(10,2)	Calculated as: Sales - CostOfGoodsSold.
===================================================================

### Dimension Tables (Descriptive Data)
#### gold.dim_locations
Column	Data Type	Description
LocationKey	BIGINT	Primary Key (Surrogate).
Branch	NVARCHAR(25)	Branch identifier (e.g., A, B, C).
City	NVARCHAR(25)	City where the branch is located.

#### gold.dim_products
Column	Data Type	Description
ProductKey	BIGINT	Primary Key (Surrogate).
ProductLine	NVARCHAR(50)	Category of product (e.g., Electronic accessories).


#### gold.dim_customers
Column	Data Type	Description
CustomerKey	BIGINT	Primary Key (Surrogate).
CustomerType	NVARCHAR(25)	Membership status (e.g., Member, Normal).
Gender	NVARCHAR(10)	Gender of the customer.

#### gold.dim_payment
Column	Data Type	Description
PaymentKey	BIGINT	Primary Key (Surrogate).
Payment	NVARCHAR(50)	Method used (e.g., Cash, Credit card, Ewallet).

#### gold.dim_date
Column	Data Type	Description
DateKey	BIGINT	Primary Key (Surrogate).
SalesDate	DATE	Cleaned transaction date (Format: YYYY-MM-DD).
====================================================================

### Data Pipeline Traceability
•	Source: CSV File.
•	Bronze Layer: Raw NVARCHAR storage to prevent import failure (handles dashes).
•	Silver Layer: Data cleaning, trimming, and conversion (CONVERT(DATE, ..., 105)).
•	Gold Layer: Business logic transformation into Star Schema Views.
