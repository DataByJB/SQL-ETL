----------------------------------------------------------------
-- Stage 1a: Table Creation CUSTOMERS --
----------------------------------------------------------------
DROP TABLE IF EXISTS tCustomer_Import;

CREATE TABLE tCustomer_Import(
	CustomerID SERIAL PRIMARY KEY,
	FullName varchar(50) NULL,	
	FullAddress	varchar(100) NULL,
	City varchar(30) NULL,
	Telephone varchar(11) NULL,
	DOB date null,
	Gender varchar(1)
);

INSERT INTO tCustomer_Import(FullName,FullAddress,City,Telephone,DOB,Gender) VALUES 
('Alexandra, Saki','17 Gorey Close, SO19 2EW','HAMPSHIRE','7503662116','1979-12-13','F'),
('Dakir, Tetouan',	' 1 Orchard Road, SO30 2FJ','HAMPSHIRE','7511622117','1968-06-01','M'),
('Abiil, Biba',' 5 Genthorn Close, BN1 7HT','EAST SUSSEX','7328002119','1982-11-29','F'),
('Angela, Ilesa','79 Waterhead Drive, RH4 2DE','SURREY','7233802122','1971-11-08','F'),
('Briny, Tarlac',' 2 St Georges Parade, NG11 8JG','NOTTINGHAMSHIRE','7394802123','1979-03-07','F'),
('Diana, Olomouc','137 Common Road, SO16 8DX','HAMPSHIRE','7089942129','1986-11-03','F'),
('Jessica, Lianzhou',' 49 Snape Road, SO19 6BX','HAMPSHIRE','7495442131','1989-07-06','F'),
('Alan, Christchurch','9 Penn Moor, SS0 8HS','ESSEX','7484762134','1979-06-11','M'),
('Almeta, NuevoLaredo',' 28 Elizabeth Roadnue, GU21 3QU','SURREY','7040112135','1975-10-01','F'),
('Amanda, Hail','66 Highfields Road, HU6 7EA','NORTH HUMBERSIDE','7496112127','1994-03-29','F'),
('Camila, Garoowe','2 Yew Tree Lane, SP6 1QR','HAMPSHIRE','7532962128','1984-05-08','F');

SELECT * FROM tCustomer_Import;

-- Stage 1a: Table Creation PRODUCTS --

DROP TABLE IF EXISTS tProduct_Import;

CREATE TABLE tProduct_Import(
	ProductID SERIAL PRIMARY KEY,
	Title varchar(100) NULL,
	Price float NULL,
	In_Stock int NULL
);

INSERT INTO tProduct_Import (Title, Price, In_Stock) VALUES 
('Animals Colouring Pad (486H)',0.69,1),
('Indoor Work bench (TY6236)',33.89,1),
('Snuggles Deluxe Pram (TY6102)',29.09,1),
('John Adams Street Magic (10784)',18.49,4),
('Hti Babyboo Tri Pushchair (1423751)',20.79,5),	
('Edco Cool Box Blue (14610)',13.59,0),
('Duplo Town Water Park (10989)',26.89,0),
('Minecraft The Axoloti House (21247)',14.39,4),
('Gabbys Dollhouse Gabbys Garden Playset (6061583)',26.05,2),
('Friends Stargazing Camping Vehicle (42603)',16.75,5),
('City Gaming Tournament Truck (60388)',28.25,0),
('Marvel Spider-man vs Sandman Final Battle (76280)',21.89,1),
('My Farm Colouring Book (492H)',0.69,1),
('City Car Wash (60362)',12.09,4);

SELECT * FROM tProduct_Import;

-- Stage 1a: Table Creation PURCHASES --

DROP TABLE IF EXISTS tPurchase_Import;

CREATE TABLE tPurchase_Import (
	PurchaseID SERIAL PRIMARY KEY,
	CustomerID int NULL,
	ProductID int NULL,
	TillTypeID int NULL,
	PaymentMethodID int NULL,
	BankCardChargeID int NULL,
	ProductQty int NULL,
	PurchaseDate date NULL
);

INSERT INTO tPurchase_Import(CustomerID,ProductID,TillTypeID,PaymentMethodID,BankCardChargeID,ProductQty,PurchaseDate) VALUES 
	(1 ,1 ,2,1,4,4,'2024-01-20'),
	(8 ,2 ,3,1,4,5,'2024-01-20'),
	(10,3 ,1,2,3,1,'2024-01-20'),
	(1 ,4 ,2,1,4,3,'2024-01-20'),
	(2 ,5 ,1,3,1,2,'2024-01-20'),
	(3 ,6 ,2,1,4,4,'2024-01-20'),
	(4 ,12,3,3,1,3,'2024-01-20'),
	(5 ,10,3,1,4,2,'2024-01-21'),
	(6 ,11,1,3,2,4,'2024-01-21'),
	(7 ,9 ,2,2,3,5,'2024-01-21'),
	(2 ,8 ,2,2,3,4,'2024-01-21'),
	(4 ,11,2,2,3,3,'2024-01-21');

SELECT * FROM tPurchase_Import;

-- Stage 1a: Table Creation BANKCARD CHARGES --

DROP TABLE IF EXISTS tBankCardCharge;

CREATE TABLE tBankCardCharge(
	BankCardChargeID SERIAL PRIMARY KEY,
	CreditCardName varchar(15),
	BankCharge float
);

INSERT INTO tBankCardCharge(CreditCardName,BankCharge) VALUES
	('Visa', 0.015),
	('Mastercard', 0.018),
	('Other', 0.005),
	('Cash', 0);

SELECT * FROM tBankCardCharge

-- Stage 1a: Table Creation PAYMENT METHODS --

DROP TABLE IF EXISTS tPaymentMethod;

CREATE TABLE tPaymentMethod (
	PaymentMethodID SERIAL PRIMARY KEY,
	Paymentmethod varchar(15) 
);

INSERT INTO tPaymentMethod(Paymentmethod) VALUES 
	('Cash'),
	('Debit Card'),
	('Credit Card');

SELECT * FROM tPaymentMethod;

-- Stage 1a: Table Creation TILL TYPES --

DROP TABLE IF EXISTS tTillType;

CREATE TABLE tTillType(
	TillTypeID SERIAL PRIMARY KEY,
	TillDescription varchar(15)
);

INSERT INTO tTillType(TillDescription) VALUES
	('Self Checkout'),
	('Staff Checkout'),
	('Scanner');

SELECT * FROM tTillType;
