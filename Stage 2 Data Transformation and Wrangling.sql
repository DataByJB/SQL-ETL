----------------------------------------------------------------
-- Stage 2: Data Transformation and Wrangling CUSTOMERS --
-- Automating this procress using a Stored Procedure
----------------------------------------------------------------
CREATE OR REPLACE PROCEDURE sp_CustomerETL()
LANGUAGE plpgsql
AS $$
DECLARE 
BEGIN
    -- Create a New Customer Table (Copy Data from Import) --
    DROP TABLE IF EXISTS tCustomer_ETL;

    CREATE TABLE tCustomer_ETL AS
    SELECT * FROM tCustomer_Import;

    RAISE NOTICE '1: Data successfully imported into ETL table.';
    
    --  Add and Update Columns --
    ALTER TABLE tCustomer_ETL ADD FirstName varchar(30) NULL;
    ALTER TABLE tCustomer_ETL ADD Surname varchar(30) NULL;
    ALTER TABLE tCustomer_ETL ALTER COLUMN gender TYPE varchar(6);
    ALTER TABLE tCustomer_ETL ADD Address varchar(100) NULL;
    ALTER TABLE tCustomer_ETL ADD PostCode varchar(12) NULL;
    ALTER TABLE tCustomer_ETL ADD Age int NULL;
    
    -- Clean and Transform Data --
    UPDATE tCustomer_ETL SET fulladdress = TRIM(fulladdress);
    UPDATE tCustomer_ETL SET telephone = CONCAT('0', telephone) WHERE LENGTH(telephone) <= 10;
    UPDATE tCustomer_ETL SET firstname = TRIM(SUBSTRING(fullname FROM 1 FOR POSITION(',' IN fullname) - 1));
    UPDATE tCustomer_ETL SET surname = TRIM(SUBSTRING(fullname FROM POSITION(',' IN fullname) + 1));
    UPDATE tCustomer_ETL SET address = TRIM(SUBSTRING(fulladdress FROM 1 FOR POSITION(',' IN fulladdress) - 1));
    UPDATE tCustomer_ETL SET postcode = TRIM(SUBSTRING(fulladdress FROM POSITION(',' IN fulladdress) + 1));
    UPDATE tCustomer_ETL SET age = EXTRACT(YEAR FROM AGE(dob::DATE));
    UPDATE tCustomer_ETL SET gender = 'Male' WHERE gender = 'M';
    UPDATE tCustomer_ETL SET gender = 'Female' WHERE gender = 'F';

    RAISE NOTICE '2: Data cleaning and transformation completed.';
    
    -- Remove Unnecessary Columns --
    ALTER TABLE tCustomer_ETL DROP COLUMN fullname;
    ALTER TABLE tCustomer_ETL DROP COLUMN fulladdress;

----------------------------------------------------------------
-- Additional database management: Rearranging colums for Customer Table 
----------------------------------------------------------------
    
	-- Rearrange Columns for New Customer Table --
    DROP TABLE IF EXISTS tCustomer_ETL_Rearranged;
    
    CREATE TABLE tCustomer_ETL_Rearranged (
        CustomerID SERIAL PRIMARY KEY, 
        FirstName varchar(30) NULL,
        Surname varchar(30) NULL,
        Gender varchar(6) NULL,
        City varchar(30) NULL,
        Address varchar(100) NULL,
        PostCode varchar(12) NULL,
        Telephone varchar(11) NULL,
        DOB DATE NULL,
        Age int NULL
    );

    RAISE NOTICE '3: Rearranged table created.';
    
    -- Insert Data into Rearranged Table --
    INSERT INTO tCustomer_ETL_Rearranged (
        CustomerID, FirstName, Surname, Gender, City, Address, PostCode, Telephone, DOB, Age
    )
    SELECT 
        CustomerID, FirstName, Surname, Gender, City, Address, PostCode, Telephone, DOB, Age
    FROM tCustomer_ETL;
    
    -- Drop Old Table --
    DROP TABLE tCustomer_ETL;
    
    -- Rename Rearranged Table --
    ALTER TABLE tCustomer_ETL_Rearranged RENAME TO tCustomer_ETL;

    RAISE NOTICE ' Stage 2 of Pipeline completed: tCustomer_ETL successfully created and populated.';

END;
$$;

CALL sp_CustomerETL();