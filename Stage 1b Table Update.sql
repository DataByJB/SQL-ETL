-- THIS STORED PROCEDURE WILL DELETE ALL ROWS FROM TABLE AND INSERT NEW ONES --

-- Stage 1b: Table Update Stored Procedure BANKCARD CHARGES--

CREATE OR REPLACE PROCEDURE sp_tBankCardCharge_Data_Update()
LANGUAGE plpgsql
AS $$
BEGIN 
	
	DELETE FROM tBankCardCharge;

INSERT INTO tBankCardCharge(CreditCardName,BankCharge) VALUES
	('Visa', 0.015),
	('Mastercard', 0.018),
	('Other', 0.005),
	('Cash', 0);

END; 
$$;

-- Stage 1b: Table Update Stored Procedure PAYMENT METHODS--

CREATE OR REPLACE PROCEDURE sp_tPaymentMethod_Data_Update()
LANGUAGE plpgsql
AS $$
BEGIN
	DELETE FROM tPaymentMethod;

	INSERT INTO tPaymentMethod(Paymentmethod) VALUES 
		('Cash'),
		('Debit Card'),
		('Credit Card');
END;
$$;

-- Stage 1b: Table Update Stored Procedure TILL TYPE--

CREATE PROCEDURE sp_tTillType_Data_Update()
LANGUAGE plpgsql
AS $$
BEGIN 
	
	DELETE FROM tTillType;

	INSERT INTO tTillType(TillDescription) VALUES
	('Self Checkout'),
	('Staff Checkout'),
	('Scanner');

END; 
$$;

