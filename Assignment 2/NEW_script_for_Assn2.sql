/*******
Sample script for creating and populating tables for Assignment 2, ISYS224, 2018
*******/

/**
Drop old Tables
**/
DROP TABLE IF EXISTS T_Repayment;
DROP TABLE IF EXISTS T_Loan;
DROP TABLE IF EXISTS T_Own;
DROP TABLE IF EXISTS T_Customer;

DROP TABLE IF EXISTS T_Account;
DROP TABLE IF EXISTS T_Loan_Type;
DROP TABLE IF EXISTS T_Acc_Type;

/**
Create Tables
**/

-- Customer --
CREATE TABLE T_Customer (
  CustomerID VARCHAR(10) NOT NULL,
  CustomerName VARCHAR(45) NULL,
  CustomerAddress VARCHAR(45) NULL,
  CustomerContactNo INT NULL,
  CustomerEmail VARCHAR(45) NULL,
  CustomerJoinDate DATETIME NULL,
  PRIMARY KEY (CustomerID));

-- Acc_Type --

CREATE TABLE IF NOT EXISTS T_Acc_Type (
  AccountTypeID VARCHAR(10) NOT NULL,
  TypeName SET('SAV','CHK','LON'),
  TypeDesc VARCHAR(45) NULL,
  TypeRate DECIMAL(4,2) NULL,
  TypeFee DECIMAL(2) NULL,
  PRIMARY KEY (AccountTypeID));
  
-- Account --

CREATE TABLE IF NOT EXISTS T_Account (
  BSB VARCHAR(10) NOT NULL,
  AccountNo VARCHAR(10) NOT NULL,
  AccountBal DECIMAL(10) NULL,
  AccountType VARCHAR(10) NOT NULL,
  PRIMARY KEY (BSB, AccountNo),
    FOREIGN KEY (AccountType)
    REFERENCES T_Acc_Type(AccountTypeID));


-- Loan_Type --

CREATE TABLE IF NOT EXISTS T_Loan_Type (
  LoanTypeID VARCHAR(10) NOT NULL,
  Loan_TypeName SET('HL','IL','PL'),
  Loan_TypeDesc VARCHAR(45) NULL,
  Loan_TypeMInRate DECIMAL(4,2) NULL,
  PRIMARY KEY (LoanTypeID));
  
-- Loan --

CREATE TABLE IF NOT EXISTS T_Loan (
  LoanID VARCHAR(10) NOT NULL,
  LoanRate DECIMAL(4,2) NULL,
  LoanAmount DECIMAL(8) NULL,
  Loan_Type VARCHAR(10) NOT NULL,
  Loan_AccountBSB VARCHAR(10) NOT NULL,
  Loan_AcctNo VARCHAR(10) NOT NULL,
  PRIMARY KEY (LoanID),
	FOREIGN KEY (Loan_Type)
    REFERENCES T_Loan_Type (LoanTypeID),
    FOREIGN KEY (Loan_AccountBSB , Loan_AcctNo)
    REFERENCES T_Account (BSB, AccountNo));

-- Repayment --

CREATE TABLE IF NOT EXISTS T_Repayment (
  RepaymentNo int NOT NULL AUTO_INCREMENT,
  Repayment_LoanID VARCHAR(10) NOT NULL,
  RepaymentAmount DECIMAL(6) NULL,
  RepaymentDate DATETIME NULL,
  PRIMARY KEY (RepaymentNo),
    FOREIGN KEY (Repayment_LoanID)
    REFERENCES T_Loan (LoanID));

-- Own --

CREATE TABLE IF NOT EXISTS T_Own (
  Customer_ID VARCHAR(10) NOT NULL,
  Account_BSB VARCHAR(10) NOT NULL,
  Account_No VARCHAR(10) NOT NULL,
  PRIMARY KEY (Customer_ID, Account_BSB, Account_No),
    FOREIGN KEY (Customer_ID)
    REFERENCES T_Customer (customerID),
    FOREIGN KEY (Account_BSB, Account_No)
    REFERENCES T_Account (BSB, AccountNo));
       


/* 
Populate Tables
*/




INSERT INTO T_Customer VALUES ('C1','Adam','AdamHouse','234567891','aMail','2015-10-10');
INSERT INTO T_Customer VALUES ('C2','Badshah','BadshahPalace','234567892','bMail','2015-10-11');
INSERT INTO T_Customer VALUES ('C3','Chandni','ChandniBar','234567893','cMail','2015-10-12');

INSERT INTO T_Acc_Type VALUES ('AT1','SAV','Savings','0.1','15');
INSERT INTO T_Acc_Type VALUES ('AT2','CHK','Checking','0.2','16');
INSERT INTO T_Acc_Type VALUES ('AT3','LON','Loan','0','17');

INSERT INTO T_Account VALUES ('BSB1','Acct1','10.00','AT1');
INSERT INTO T_Account VALUES ('BSB2','Acct2','11.00','AT3');
INSERT INTO T_Account VALUES ('BSB3','Acct3','-5000','AT3');
INSERT INTO T_Account VALUES ('BSB3','Acct4','-7000','AT3');
INSERT INTO T_Account VALUES ('BSB1','Acct5','10.00','AT1');
INSERT INTO T_Account VALUES ('BSB1','Acct6','10.00','AT1');

INSERT INTO T_Loan_Type VALUES ('LT1','HL','Home Loan','0.01');
INSERT INTO T_Loan_Type VALUES ('LT2','IL','Investment Loan','0.02');
INSERT INTO T_Loan_Type VALUES ('LT3','PL','Personal Loan','0.03');

INSERT INTO T_Loan VALUES ('L1','0.05','5000.00','LT3','BSB3','Acct4');
INSERT INTO T_Loan VALUES ('L2','0.02','16200.00','LT2','BSB2','Acct2');
INSERT INTO T_Loan VALUES ('L3','0.03','670500.00','LT1','BSB3','Acct3');

INSERT INTO T_Repayment (Repayment_LoanID, RepaymentAmount, RepaymentDate)
       	VALUES ('L1','1.00','2017-10-10');
INSERT INTO T_Repayment  (Repayment_LoanID, RepaymentAmount, RepaymentDate)
        VALUES ('L2','2.00','2018-02-11');
INSERT INTO T_Repayment  (Repayment_LoanID, RepaymentAmount, RepaymentDate)
        VALUES ('L3','2.00','2018-02-11');

INSERT INTO T_Own VALUES ('C1','BSB2','Acct2');
INSERT INTO T_Own VALUES ('C2','BSB3','Acct3');
INSERT INTO T_Own VALUES ('C3','BSB3','Acct4');
INSERT INTO T_Own VALUES ('C1','BSB3','Acct4');
INSERT INTO T_Own VALUES ('C1','BSB1','Acct1');
INSERT INTO T_Own VALUES ('C2','BSB1','Acct5');
INSERT INTO T_Own VALUES ('C3','BSB1','Acct6');

/**
End Script
**/

