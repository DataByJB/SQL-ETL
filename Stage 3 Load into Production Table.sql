----------------------------------------------------------------
-- Stage 3: Load tables to Production CUSTOMERS --
-- Automating this process using a Stored Procedure
----------------------------------------------------------------
CREATE OR REPLACE PROCEDURE sp_Customer()
LANGUAGE plpgsql
AS $$
DECLARE 
BEGIN
    -- Create a New Customer Table (Copy ETL to Production Table) --
    DROP TABLE IF EXISTS tCustomer;

    CREATE TABLE tCustomer AS
    SELECT * FROM tCustomer_ETL;

    RAISE NOTICE 'Data successfully imported into Production table.';

END;
$$;

CALL sp_Customer();

----------------------------------------------------------------
-- Stage 3: Load tables to Production PRODUCTS --
----------------------------------------------------------------
CREATE OR REPLACE PROCEDURE sp_Product()
LANGUAGE plpgsql
AS $$
DECLARE 
BEGIN
    -- Create a New Products Table (Copy Import to Production Table) --
    DROP TABLE IF EXISTS tProduct;

    CREATE TABLE tProduct AS
    SELECT * FROM tProduct_Import;

    RAISE NOTICE 'Data successfully imported into Production table.';

END;
$$;

CALL sp_Product();

----------------------------------------------------------------
-- Stage 3: Load tables to Production PURCHASES --
----------------------------------------------------------------
CREATE OR REPLACE PROCEDURE sp_Purchase()
LANGUAGE plpgsql
AS $$
DECLARE 
BEGIN
    -- Create a New Purchases Table (Copy Import to Production Table) --
    DROP TABLE IF EXISTS tPurchase;

    CREATE TABLE tPurchase AS
    SELECT * FROM tPurchase_Import;

    RAISE NOTICE 'Data successfully imported into Production table.';

END;
$$;

CALL sp_Purchase();