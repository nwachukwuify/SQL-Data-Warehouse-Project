/*
=================================
Create the Database and Schemas
=================================
Purpose: This script creates a new database named 'SuperMarketDW' after checking if it already exists. If it's existing, it is dropped and recreated. Also, the script
 sets up three schems within the database: bronxe, silver and gold.

NOTE! 
Running this script will entirely drop the database if it already exists, and all data will be deleted permanently, so proceed with causion and ensure you have a backup.
*/

use master
GO

--drop and recreate the 'SuperMarketDW' database
  IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'SuperMarketDW')
  BEGIN
      ALTER DATABASE SuperMarketDW SET SINGLE_USER WITH ROLLBACK IMMEDIATE
      DROP DATABASE SuperMarketDW
  END
  GO

  -- creating the database 'SuperMarketDW'
  
CREATE DATABASE SuperMarketDW
GO
  
USE SuperMarketDW
GO
  
CREATE SCHEMA bronze
GO  -- a separator that tells SQL to execute the first command before the others below
  
CREATE SCHEMA silver
GO
  
CREATE SCHEMA gold
GO
