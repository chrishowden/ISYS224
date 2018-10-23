-- Task 2
DELIMITER //
DROP PROCEDURE IF EXISTS Repay_loan //
CREATE PROCEDURE Repay_loan (IN from_BSB VARCHAR(10), IN from_accountNo VARCHAR(10), IN to_loan VARCHAR(10), IN amount DECIMAL(8,0))
BEGIN
	DECLARE found TEXT DEFAULT 'FALSE';
	SELECT DISTINCT accountNo into found FROM orderdetails WHERE orderNumber = oNumber;



	 DECLARE found TEXT DEFAULT 'FALSE';
     SELECT DISTINCT orderNumber into found FROM orderdetails WHERE orderNumber = oNumber;
     IF found != 'FALSE' THEN
		SELECT sum(quantityOrdered*priceEach) into amount
		FROM orderdetails
        WHERE orderNumber = oNumber
		GROUP BY ordernumber;
	 ELSE
	 	SELECT "Order not found." AS 'OUTPUT';
	 END IF;
END
//
DELIMITER ;


-- Task 2
DELIMITER //
DROP PROCEDURE IF EXISTS Repay_loan //
CREATE PROCEDURE Repay_loan (IN from_BSB VARCHAR(10), IN from_accountNo VARCHAR(10), IN to_loan VARCHAR(10), IN amount DECIMAL(8,0))
BEGIN
	DECLARE Cus TEXT DEFAULT NULL;
	SELECT DISTINCT Customer_ID into found FROM T_Own WHERE Account_BSB = from_BSB AND Account_No = from_accountNo;

END



	 DECLARE found TEXT DEFAULT 'FALSE';
     SELECT DISTINCT orderNumber into found FROM orderdetails WHERE orderNumber = oNumber;
     IF found != 'FALSE' THEN
		SELECT sum(quantityOrdered*priceEach) into amount
		FROM orderdetails
        WHERE orderNumber = oNumber
		GROUP BY ordernumber;
	 ELSE
	 	SELECT "Order not found." AS 'OUTPUT';
	 END IF;
END
//
DELIMITER ;
