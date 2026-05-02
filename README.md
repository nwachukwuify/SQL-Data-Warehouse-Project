## Project Overview
This project delivers an end-to-end data warehousing and business intelligence solution for a supermarket retail business. Raw transactional data from CSV files is ingested, transformed, and loaded into a structured SQL Server data warehouse following a dimensional modelling approach. The warehouse serves as the single source of truth for BI dashboards and analytical reports that support data-driven decisions across sales, product, customer, and operational domains.

The project is split into two core parts:
Data Engineering — designing and building the warehouse, ETL pipeline, and dimensional model
BI & Analytics — defining KPIs, building reports, and answering key business questions

## Data Source
The source data is a flat CSV file containing supermarket point-of-sale (POS) transaction records with the following columns:
InvoiceID, Branch, City, CustomerType, Gender, ProductLine, UnitPrice, Quantity, Tax(5%),Sales, Date, Payment, Cogs(Cost of goods sold), Rating(1–10)

## Project Requirements
Business Requirements - The business requires a centralised, reliable data platform that enables:

- Consolidated reporting across all branches, cities, product lines, and customer segments from a single source of truth.
- Trend analysis to monitor sales and profitability performance over time (daily, weekly, monthly, quarterly).
- Customer segmentation to understand spend behaviour by customer type and demographic.
- Product performance tracking to identify top-performing and underperforming product lines by revenue, margin, and customer satisfaction.
- Operational insights to understand peak trading periods, payment preferences, and branch-level efficiency.
- Self-service BI so that business stakeholders can access dashboards without requiring direct SQL access.

## Data Engineering: Building the Data Warehouse
### Objectives
The data engineering phase aims to:

- Build a data warehouse using the medallion architecture: Bronze → Silver (Cleansed) → Gold (Integration & Aggregation)
- Design a dimensional model (star schema) optimised for analytical querying in SQL Server
- Enforce data quality rules including deduplication, null handling, type casting, and referential integrity
- Provide a clear documentation of the data model to support both business and analytics teams
  !Data Warehouse Archtiecture(docs/Data_Architecture DW.png)

## BI & Analytics: Reporting and Insights
### Objectives
The BI and analytics phase aims to:

- Connect Power BI to the SQL Server presentation layer and build interactive dashboards
- Surface key business KPIs in a clear, executive-friendly format
- Enable self-service exploration of sales, product, customer, and operational data
- Answer the critical business questions that drive commercial decisions

## Technical Specifications
Database - Microsoft SQL Server
ETL Method - T-SQL scripts
Data Modelling - Star Schema — Kimball dimensional modelling methodology
Source Format - CSV (flat file)
Version Control - Git / GitHub
Query Language - T-SQL
BI Tool Micorosft Power BI (connected via Import mode)

### License
This project is licensed under the MIT License. You are free to use, modify and share this project with proper attribution.
