-- Task 2
DELIMITER //
DROP PROCEDURE IF EXISTS Repay_loan //
CREATE PROCEDURE Repay_loan (IN from_BSB VARCHAR(10), IN from_accountNo VARCHAR(10), IN to_loan VARCHAR(10), IN amount DECIMAL(8,0))
	BEGIN
		-- Variables
		DECLARE next_repayNo INT(11);
        DECLARE from_acc_bal DECIMAL(10,0);
        DECLARE joint_cusNo INT(2);
        DECLARE error_found BOOLEAN DEFAULT FALSE;

		-- Customer must be assoicated with loan account and from account
        SELECT COUNT(A.Customer_ID) INTO joint_cusNo
		FROM (
			SELECT Customer_ID
			FROM T_Own AS O, T_Account AS A, T_Loan AS L
			WHERE L.LoanID = to_loan
			AND L.Loan_AcctNo = A.AccountNo
			AND L.Loan_AccountBSB = A.BSB
			AND O.Account_No = A.AccountNo
			AND O.Account_BSB = A.BSB
        ) AS A
        , (
			SELECT Customer_ID
			FROM T_Own AS O, T_Account AS A
			WHERE A.AccountNo = from_accountNo
			AND A.BSB = from_BSB
			AND O.Account_No = A.AccountNo
			AND O.Account_BSB = A.BSB
        ) AS B
        WHERE A.Customer_ID = B.Customer_ID;
        -- LIMIT 1;

        -- IF no rows, then error
        IF joint_cusNo = 0 THEN
			SET error_found = TRUE;
			SELECT "ERROR: Customer is not associated with loan and/or selected account" AS 'OUTPUT';
		END IF;

        -- Get account balance from_account and put into variable from_acc_bal
        IF error_found = FALSE THEN
			SELECT AccountBal INTO from_acc_bal
			FROM T_Account
			WHERE AccountNo = from_accountNo
			AND BSB = from_BSB;

			-- From Account Bal >= amount
			IF amount > from_acc_bal THEN
				SET error_found = TRUE;
				SELECT "ERROR: Not enough funds in the account" AS 'OUTPUT';
			END IF;
        END IF;

		IF error_found = FALSE THEN
			-- Insert Repayment
			INSERT INTO T_Repayment (Repayment_LoanID, RepaymentAmount, RepaymentDate)
			VALUES (to_loan, amount, NOW());

			-- Update account associated with the loan
			UPDATE T_Account
			SET AccountBal = AccountBal - amount
			WHERE AccountNo = (SELECT Loan_AcctNo
							   FROM T_Loan
							   WHERE Loan_AccountBSB = from_BSB
							   AND LoanID = to_loan)
			AND BSB = from_BSB;

			-- Update the from_account provided
			UPDATE T_Account
			SET AccountBal = AccountBal - amount
			WHERE AccountNo = from_accountNo
			AND BSB = from_BSB;

			-- Show repayment
			SELECT *
			FROM T_Repayment
			WHERE RepaymentNo = (SELECT MAX(RepaymentNo)
								 FROM T_Repayment);
		END IF;

		IF error_found = TRUE THEN
			ROLLBACK;
		END IF;

	END
//
DELIMITER ;

CALL Repay_Loan('BSB1', 'Acct1', 'L3', 1);


-- Task 3
DELIMITER //
CREATE TRIGGER cust_loan_insert
	BEFORE INSERT ON T_Own
    FOR EACH ROW
BEGIN
	DECLARE cus_loan_count INT(2);
	DECLARE loan_type INT(10);
	-- Customer cannot have individually more than 5 loans
		SELECT COUNT(LoanID) INTO cus_loan_count
		FROM T_Own AS O, T_Account AS A, T_Loan AS L
		WHERE L.Loan_AcctNo = A.AccountNo
		AND L.Loan_AccountBSB = A.BSB
		AND O.Account_No = A.AccountNo
		AND O.Account_BSB = A.BSB
    AND O.Customer_ID = NEW.Customer_ID
    GROUP BY Customer_ID;

    -- Max loans is 8 for customer IS THIS THE SAME THING?
		SELECT COUNT(LoanID) INTO cus_loan_count
		FROM T_Own AS O, T_Account AS A, T_Loan AS L
		WHERE L.Loan_AcctNo = A.AccountNo
		AND L.Loan_AccountBSB = A.BSB
		AND O.Account_No = A.AccountNo
		AND O.Account_BSB = A.BSB
    AND O.Customer_ID = NEW.Customer_ID
    GROUP BY Customer_ID;

    -- Max personal loans is 1 for customer
		SELECT COUNT(Loan_Type) INTO personal_loan_count
		FROM T_Own AS O, T_Account AS A, T_Loan AS L
		WHERE L.Loan_AcctNo = A.AccountNo
		AND L.Loan_AccountBSB = A.BSB
		AND O.Account_No = A.AccountNo
		AND O.Account_BSB = A.BSB
		AND O.Customer_ID = NEW.Customer_ID
		AND L.Loan_Type = 'LT3'
		GROUP BY Customer_ID;

    -- Max total original loan amount for customer must not exceed 10 MIL!
		SELECT SUM(LoanAmount) From T_Loan WHERE (SELECT T_Loan.LoanAmount AS loantotal
																						FROM T_Own
																						WHERE T_Loan.Loan_AcctNo = T_Own.AccountNo
																						AND CustomerID = NEW.CustomerID)) >99999999);
    -- My way of finidning answer
		SELECT SUM(L.LoanAmount) INTO loan_total
		FROM T_Own AS O, T_Loan AS L
		WHERE L.Loan_AcctNo = O.Account_No
    AND L.Loan_AccountBSB = O.Account_BSB
		AND Customer_ID = 'C1';

    -- Customer cannot have more than 3 home loans
		SELECT COUNT(Loan_Type) From T_Loan WHERE (SELECT T_Loan.Loan_Type AS loan
																							FROM T_Own
																							WHERE T_Loan.Loan_AcctNo = T_Own.AccountNo
																							AND CustomerID = NEW.CustomerID)) LIKE 'LT1');
    --My way of finidning answer
		SELECT COUNT(L.Loan_Type)
		FROM T_Own AS O, T_Loan AS L
		WHERE L.Loan_AcctNo = O.Account_No
		AND L.Loan_AccountBSB = O.Account_BSB
		AND CustomerID = 'C1'
		AND LIKE 'LT1';


END
//
DELIMITER ;
