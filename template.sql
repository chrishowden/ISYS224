/* Question 3-DDL Scripts */



/* Question 4-DML Scripts */
-- -----------------------------------------------------
-- Table `45183228`.`Branch`
-- -----------------------------------------------------
INSERT INTO Branch VALUES ('B001', 'Gosford', '3 Henry Parry Dr, Gosford, NSW', '0243412258');
INSERT INTO Branch VALUES ('B002', 'Hornsby', '15 Crow St, Hornsby, NSW', '0247164877');
INSERT INTO Branch VALUES ('B003', 'Epping', '2 Epping Rd, Epping, NSW', '0257894431');

-- -----------------------------------------------------
-- Table `45183228`.`Customer`
-- -----------------------------------------------------
INSERT INTO Customer VALUES ('C001', 'Spock', '15 Terrigal Rd, Terrigal, NSW', '0491570156', 'spock@gmail.com', '2017-08-02');
INSERT INTO Customer VALUES ('C002', 'Kirk', '15 Terrigal Rd, Terrigal, NSW', '0481528137', 'kirk@gmail.com', '2017-08-02');
INSERT INTO Customer VALUES ('C003', 'Bones', '70 Forest Dr, Randwick, NSW', '0212345678', 'bones@gmail.com', '2015-06-22');
INSERT INTO Customer VALUES ('C004', 'Picard', '53 Dove Ln, Chirnside, VIC', '0287654321', 'pickard@gmail.com', '2018-01-15');

-- -----------------------------------------------------
-- Table `45183228`.`Debit Card`
-- -----------------------------------------------------
INSERT INTO Debit_Card VALUES ('000001', '2020-06-01', '110', '101010');
INSERT INTO Debit_Card VALUES ('000002', '2019-05-01', '111', '191919');
INSERT INTO Debit_Card VALUES ('000003', '2022-07-01', '112', '202020');

-- -----------------------------------------------------
-- Table `45183228`.`Account_Type`
-- -----------------------------------------------------
INSERT INTO Account_Type VALUES ('STUD', 'Student', 'Student only account', '0.02', '70');
INSERT INTO Account_Type VALUES ('SAVE', 'Savings', 'High interest savings account', '0.04', '200');
INSERT INTO Account_Type VALUES ('CHEQ', 'Cheque', 'Cheque account pays no interest', '0', '160');

-- -----------------------------------------------------
-- Table `45183228`.`Account`
-- -----------------------------------------------------
INSERT INTO Account VALUES ('111222', '0001', '500', '2017-08-02', NULL, 'STUD');
INSERT INTO Account VALUES ('222333', '0002', '10000', '2015-06-22', NULL, 'SAVE');
INSERT INTO Account VALUES ('111222', '0003', '8000', '2018-01-15', NULL, 'SAVE');

-- -----------------------------------------------------
-- Table `45183228`.`ATM`
-- -----------------------------------------------------
INSERT INTO ATM VALUES ('ATM001', 'Gosford Branch', '8:00:00', '18:00:00', '15000', 'B001');
INSERT INTO ATM VALUES ('ATM002', 'Hornsby Branch', '8:00:00', '18:00:00', '15000', 'B002');
INSERT INTO ATM VALUES ('ATM003', 'Erina Fair', '9:00:00', '16:00:00', '10000', NULL);

-- -----------------------------------------------------
-- Table `45183228`.`Department` EXTRA COL NAME, SHOULDN'T BE HERE
-- -----------------------------------------------------
INSERT INTO Department VALUES ('D001', 'HR', 'Gosford', '0254321098');
INSERT INTO Department VALUES ('D002', 'Loans', 'Gosford', '0243111555');
INSERT INTO Department VALUES ('D003', 'Loans', 'Hornsby', '0287654321');
INSERT INTO Department VALUES ('D004', 'Marketing', 'Epping', '0290875643');
INSERT INTO Department VALUES ('D005', 'Loans', 'Epping', '0290555777');

-- -----------------------------------------------------
-- Table `45183228`.`Assignment`
-- -----------------------------------------------------
INSERT INTO Assignment VALUES ('D001', 'B001');
INSERT INTO Assignment VALUES ('D002', 'B001');
INSERT INTO Assignment VALUES ('D003', 'B002');
INSERT INTO Assignment VALUES ('D004', 'B003');
INSERT INTO Assignment VALUES ('D005', 'B003');

-- -----------------------------------------------------
-- Table `45183228`.`Employee`
-- -----------------------------------------------------
-- Gosford Loans
INSERT INTO Employee VALUES ('E001', 'Worf', '1 Enterprise Dr, Randwick', '0409000111', 'Loans Clerk', '30000', 'D002', 'B001');
INSERT INTO Employee VALUES ('E002', 'Data', '2 Enterprise Dr, Randwick', '0409000222', 'Loans Clerk', '50000', 'D002', 'B001');
INSERT INTO Employee VALUES ('E003', 'Q', '3 Enterprise Dr, Randwick', '0409000333', 'Manager', '70000', 'D002', 'B001');
-- Gosford HR
INSERT INTO Employee VALUES ('E004', 'Guinan', '4 Enterprise Dr, Randwick', '0409000444', 'Manager', '60000', 'D001', 'B001');
-- Hornsby Loans
INSERT INTO Employee VALUES ('E005', 'Gowron', '5 Enterprise Dr, Randwick', '0409000555', 'Manager', '80000', 'D003', 'B002');
-- Epping Loans
INSERT INTO Employee VALUES ('E006', 'Lore', '6 Enterprise Dr, Randwick', '0409000666', 'Manager', '60000', 'D005', 'B003');
-- Epping Marketing
INSERT INTO Employee VALUES ('E007', 'Scotty', '7 Enterprise Dr, Randwick', '0409000777', 'Manager', '120000', 'D004', 'B003');
-- -----------------------------------------------------
-- Table `45183228`.`Loan_Type`
-- -----------------------------------------------------
INSERT INTO Loan_Type VALUES ('PR01', 'Personal', 'Personal loan for 1 year', '1');
INSERT INTO Loan_Type VALUES ('PR03', 'Personal', 'Personal loan for 3 years', '3');
INSERT INTO Loan_Type VALUES ('HM30', 'Home', 'Home loan for 30 years', '30');
INSERT INTO Loan_Type VALUES ('BU05', 'Business', 'Business loan for 5 years', '5');

-- -----------------------------------------------------
-- Table `45183228`.`Loan`
-- -----------------------------------------------------
INSERT INTO Loan VALUES ('L001', '0.2', '400', '400', 'PR01', '111222', '0001');
INSERT INTO Loan VALUES ('L002', '0.15', '5000', '3000', 'PR03', '222333', '0002');
INSERT INTO Loan VALUES ('L003', '0.04', '1000000', '500000', 'HM30', '111222', '0001');
INSERT INTO Loan VALUES ('L004', '0.08', '20000', '8000', 'BU05', '111222', '0003');

-- -----------------------------------------------------
-- Table `45183228`.`Cash_Withdrawal`
-- -----------------------------------------------------
INSERT INTO Cash_Withdrawal VALUES ('W001', 'Gosford', '2018-07-05', '12:55:00', '100', 'ATM001', '000001');
INSERT INTO Cash_Withdrawal VALUES ('W002', 'Hornsby', '2018-07-16', '16:00:00', '350', 'ATM002', '000002');
INSERT INTO Cash_Withdrawal VALUES ('W003', 'Erina Fair', '2018-07-22', '15:30:00', '50', 'ATM003', '000001');

-- -----------------------------------------------------
-- Table `45183228`.`Loan_Repayment`FIX EXTRA KEYS
-- -----------------------------------------------------
INSERT INTO Loan_Repayment VALUES ('R001', 'Personal loan repayment', '500', '2018-04-03', '14:01:00', 'L002', 'E001');
INSERT INTO Loan_Repayment VALUES ('R002', 'Mortgage repayment', '10000', '2018-04-08', '10:34:00', 'L003', 'E001');
INSERT INTO Loan_Repayment VALUES ('R003', 'Business loan repayment', '3000', '2018-04-15', '11:55:00', 'L004', 'E002');

-- -----------------------------------------------------
-- Table `45183228`.`Customer_Account`
-- -----------------------------------------------------
INSERT INTO Customer_Account VALUES ('C001', '222333', '0002', '000003');
INSERT INTO Customer_Account VALUES ('C002', '222333', '0002', '000003');
INSERT INTO Customer_Account VALUES ('C003', '111222', '0001', '000001');
INSERT INTO Customer_Account VALUES ('C004', '111222', '0003', '000002');

-- -----------------------------------------------------
-- Table `45183228`.`Manage`
-- -----------------------------------------------------
INSERT INTO Manage VALUES ('E003', 'B001', 'D002', '2015-02-07', NULL);
INSERT INTO Manage VALUES ('E004', 'B001', 'D001', '2015-02-27', NULL);
INSERT INTO Manage VALUES ('E005', 'B002', 'D003', '2016-06-09', NULL);
INSERT INTO Manage VALUES ('E006', 'B002', 'D005', '2016-06-13', NULL);
INSERT INTO Manage VALUES ('E007', 'B003', 'D004', '2017-08-07', NULL);

/* Question 5-DQL Scripts */
SELECT COUNT(*) AS Number_of_Joint_Accounts
FROM Customer_Account
GROUP BY accountNumber, BSB
HAVING COUNT(accountNumber) > 1
AND COUNT(BSB) > 1;

SELECT *
-- Account_BSB, Account_accountNumber
FROM Loan L, Loan_Type LT
WHERE L.loanType = LT.loanType
AND LT.name = 'Personal';

SELECT M.branchID, D.name AS DepartmentName, E.name AS ManagerName
FROM Manage M, Department D, Employee E
WHERE M.employeeID = E.employeeID
AND M.departmentID = D.departmentID
GROUP BY M.departmentID;

SELECT E.name AS ManagerName, E.position, E.salary
FROM Manage M, Employee E
WHERE M.employeeID = E.employeeID
AND E.salary > (SELECT AVG(salary)
				FROM Manage M, Employee E
                WHERE M.employeeID = E.employeeID);
