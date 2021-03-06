/* Question 3-DDL Scripts */

-- MySQL ScAssignmentript generated by MySQL Workbench
-- Thu Sep 13 12:14:22 2018
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema 45183228
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema 45183228
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `45183228` DEFAULT CHARACTER SET utf8 ;
USE `45183228` ;

-- -----------------------------------------------------
-- Table `45183228`.`Branch`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `45183228`.`Branch` ;

CREATE TABLE IF NOT EXISTS `45183228`.`Branch` (
  `branchID` CHAR(4) NOT NULL,
  `name` VARCHAR(30) NULL,
  `address` VARCHAR(30) NULL,
  `phNo` CHAR(10) NULL,
  PRIMARY KEY (`branchID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `45183228`.`Customer`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `45183228`.`Customer` ;

CREATE TABLE IF NOT EXISTS `45183228`.`Customer` (
  `customerID` CHAR(4) NOT NULL,
  `name` VARCHAR(30) NULL,
  `address` VARCHAR(30) NULL,
  `contactNo` CHAR(10) NULL,
  `emailAdress` VARCHAR(45) NULL,
  `joinDate` DATE NULL,
  PRIMARY KEY (`customerID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `45183228`.`Debit_Card`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `45183228`.`Debit_Card` ;

CREATE TABLE IF NOT EXISTS `45183228`.`Debit_Card` (
  `debitCardNum` INT(6) NOT NULL,
  `expiryDate` DATE NULL,
  `CVV` INT(3) NULL,
  `PIN` INT(6) NULL,
  PRIMARY KEY (`debitCardNum`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `45183228`.`Account_Type`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `45183228`.`Account_Type` ;

CREATE TABLE IF NOT EXISTS `45183228`.`Account_Type` (
  `accountType` CHAR(4) NOT NULL,
  `name` VARCHAR(15) NULL,
  `description` VARCHAR(45) NULL,
  `interestRate` DECIMAL(3,2) NULL,
  `serviceFee` INT NULL,
  PRIMARY KEY (`accountType`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `45183228`.`Account`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `45183228`.`Account` ;

CREATE TABLE IF NOT EXISTS `45183228`.`Account` (
  `BSB` INT(6) NOT NULL,
  `accountNumber` INT(4) NOT NULL,
  `curBal` DECIMAL(7,2) NULL,
  `dateOpened` DATE NULL,
  `dateClosed` DATE NULL,
  `accountType` CHAR(4) NOT NULL,
  PRIMARY KEY (`BSB`, `accountNumber`, `accountType`),
  INDEX `fk_Account_Account_idx` (`accountType` ASC),
  CONSTRAINT `fk_Account_Account Type1`
    FOREIGN KEY (`accountType`)
    REFERENCES `45183228`.`Account_Type` (`accountType`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `45183228`.`ATM`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `45183228`.`ATM` ;

CREATE TABLE IF NOT EXISTS `45183228`.`ATM` (
  `atmNo` CHAR(6) NOT NULL,
  `location` VARCHAR(25) NULL,
  `openHour` TIME(0) NULL,
  `closeHour` TIME(0) NULL,
  `cashCap` INT NULL,
  `branchID` CHAR(4) NULL,
  PRIMARY KEY (`atmNo`),
  INDEX `fk_ATM_Branch1_idx` (`branchID` ASC),
  CONSTRAINT `fk_ATM_Branch1`
    FOREIGN KEY (`branchID`)
    REFERENCES `45183228`.`Branch` (`branchID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `45183228`.`Department`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `45183228`.`Department` ;

CREATE TABLE IF NOT EXISTS `45183228`.`Department` (
  `departmentID` CHAR(4) NOT NULL,
  `name` VARCHAR(30) NULL,
  `location` VARCHAR(25) NULL,
  `contactNo` CHAR(10) NULL,
  PRIMARY KEY (`departmentID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `45183228`.`Assignment`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `45183228`.`Assignment` ;

CREATE TABLE IF NOT EXISTS `45183228`.`Assignment` (
  `departmentID` CHAR(4) NOT NULL,
  `branchID` CHAR(4) NOT NULL,
  PRIMARY KEY (`departmentID`, `branchID`),
  INDEX `fk_Assignment_Branch1_idx` (`branchID` ASC),
  CONSTRAINT `fk_Assignment_Department`
    FOREIGN KEY (`departmentID`)
    REFERENCES `45183228`.`Department` (`departmentID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Assignment_Branch`
    FOREIGN KEY (`branchID`)
    REFERENCES `45183228`.`Branch` (`branchID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `45183228`.`Employee`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `45183228`.`Employee` ;

CREATE TABLE IF NOT EXISTS `45183228`.`Employee` (
  `employeeID` CHAR(4) NOT NULL,
  `name` VARCHAR(30) NULL,
  `address` VARCHAR(30) NULL,
  `phNo` CHAR(10) NULL,
  `position` VARCHAR(20) NULL,
  `salary` INT NULL,
  `departmentID` CHAR(4) NOT NULL,
  `branchID` CHAR(4) NOT NULL,
  PRIMARY KEY (`employeeID`, `departmentID`, `branchID`),
  INDEX `fk_Employee_Assignment1_idx` (`departmentID` ASC, `branchID` ASC),
  CONSTRAINT `fk_Employee_Assignment1`
    FOREIGN KEY (`departmentID` , `branchID`)
    REFERENCES `45183228`.`Assignment` (`departmentID` , `branchID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `45183228`.`Loan_Type`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `45183228`.`Loan_Type` ;

CREATE TABLE IF NOT EXISTS `45183228`.`Loan_Type` (
  `loanType` CHAR(4) NOT NULL,
  `name` VARCHAR(15) NULL,
  `description` VARCHAR(45) NULL,
  `term` INT NULL,
  PRIMARY KEY (`loanType`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `45183228`.`Loan`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `45183228`.`Loan` ;

CREATE TABLE IF NOT EXISTS `45183228`.`Loan` (
  `loanNo` CHAR(4) NOT NULL,
  `interestRate` DECIMAL(3,2) NULL,
  `loanTotal` INT NULL,
  `outstandingBal` INT NULL,
  `loanType` CHAR(4) NOT NULL,
  `BSB` INT(6) NOT NULL,
  `accountNumber` INT(4) NOT NULL,
  PRIMARY KEY (`loanNo`, `loanType`),
  INDEX `fk_Loan_Account1_idx` (`BSB` ASC, `accountNumber` ASC),
  INDEX `fk_Loan_Loan Type1_idx` (`loanType` ASC),
  CONSTRAINT `fk_Loan_Account1`
    FOREIGN KEY (`BSB` , `accountNumber`)
    REFERENCES `45183228`.`Account` (`BSB` , `accountNumber`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Loan_Loan Type1`
    FOREIGN KEY (`loanType`)
    REFERENCES `45183228`.`Loan_Type` (`loanType`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `45183228`.`Cash_Withdrawal`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `45183228`.`Cash_Withdrawal` ;

CREATE TABLE IF NOT EXISTS `45183228`.`Cash_Withdrawal` (
  `withdrawNumber` CHAR(4) NOT NULL,
  `location` VARCHAR(25) NULL,
  `date` DATE NULL,
  `time` TIME(0) NULL,
  `amount` INT NULL,
  `atmNo` CHAR(6) NOT NULL,
  `debitCardNum` INT(6) NOT NULL,
  PRIMARY KEY (`withdrawNumber`, `atmNo`, `debitCardNum`),
  INDEX `fk_Cash Withdrawal_ATM_idx` (`atmNo` ASC),
  INDEX `fk_Cash Withdrawal_Debit Card1_idx` (`debitCardNum` ASC),
  CONSTRAINT `fk_Cash Withdrawal_ATM`
    FOREIGN KEY (`atmNo`)
    REFERENCES `45183228`.`ATM` (`atmNo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Cash Withdrawal_Debit Card`
    FOREIGN KEY (`debitCardNum`)
    REFERENCES `45183228`.`Debit_Card` (`debitCardNum`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `45183228`.`Loan_Repayment`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `45183228`.`Loan_Repayment` ;

CREATE TABLE IF NOT EXISTS `45183228`.`Loan_Repayment` (
  `repayNumber` CHAR(4) NOT NULL,
  `desc` VARCHAR(45) NULL,
  `amount` INT NULL,
  `date` DATE NULL,
  `time` TIME(0) NULL,
  `loanNo` CHAR(4) NOT NULL,
  `employeeID` CHAR(4) NOT NULL,
  PRIMARY KEY (`repayNumber`, `loanNo`, `employeeID`),
  INDEX `fk_Loan Repayment_Loan1_idx` (`loanNo` ASC),
  INDEX `fk_Loan Repayment_Employee1_idx` (`employeeID` ASC),
  CONSTRAINT `fk_Loan Repayment_Loan1`
    FOREIGN KEY (`loanNo`)
    REFERENCES `45183228`.`Loan` (`loanNo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Loan Repayment_Employee1`
    FOREIGN KEY (`employeeID`)
    REFERENCES `45183228`.`Employee` (`employeeID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `45183228`.`Customer_Account`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `45183228`.`Customer_Account` ;

CREATE TABLE IF NOT EXISTS `45183228`.`Customer_Account` (
  `customerID` CHAR(4) NOT NULL,
  `BSB` INT(6) NOT NULL,
  `accountNumber` INT(4) NOT NULL,
  `debitCardNum` INT(6) NOT NULL,
  PRIMARY KEY (`customerID`, `BSB`, `accountNumber`),
  INDEX `fk_Customer Account_Customer1_idx` (`customerID` ASC),
  INDEX `fk_Customer Account_Account1_idx` (`BSB` ASC, `accountNumber` ASC),
  INDEX `fk_Customer Account_Debit Card1_idx` (`debitCardNum` ASC),
  CONSTRAINT `fk_Customer Account_Customer1`
    FOREIGN KEY (`customerID`)
    REFERENCES `45183228`.`Customer` (`customerID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Customer Account_Account1`
    FOREIGN KEY (`BSB` , `accountNumber`)
    REFERENCES `45183228`.`Account` (`BSB` , `accountNumber`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Customer Account_Debit Card1`
    FOREIGN KEY (`debitCardNum`)
    REFERENCES `45183228`.`Debit_Card` (`debitCardNum`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `45183228`.`Manage`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `45183228`.`Manage` ;

CREATE TABLE IF NOT EXISTS `45183228`.`Manage` (
  `employeeID` CHAR(4) NOT NULL,
  `branchID` CHAR(4) NOT NULL,
  `departmentID` CHAR(4) NOT NULL,
  `startDate` DATE NULL,
  `endDate` DATE NULL,
  PRIMARY KEY (`employeeID`, `branchID`, `departmentID`),
  INDEX `fk_Manage_Branch1_idx` (`branchID` ASC),
  INDEX `fk_Manage_Department1_idx` (`departmentID` ASC),
  CONSTRAINT `fk_Manage_Employee1`
    FOREIGN KEY (`employeeID`)
    REFERENCES `45183228`.`Employee` (`employeeID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Manage_Branch1`
    FOREIGN KEY (`branchID`)
    REFERENCES `45183228`.`Branch` (`branchID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Manage_Department1`
    FOREIGN KEY (`departmentID`)
    REFERENCES `45183228`.`Department` (`departmentID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;


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
-- Table `45183228`.`Department`
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
-- Table `45183228`.`Loan_Repayment`
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

-- Query 1
-- Total joint accounts
SELECT COUNT(*) AS Number_of_Joint_Accounts
FROM (SELECT accountNumber, BSB, COUNT(*)
      FROM Customer_Account
      GROUP BY accountNumber, BSB
      HAVING COUNT(*) > 1
    ) AS a;

-- Query 2
-- Accounts with personal loan's linked to them
SELECT L.accountNumber, L.BSB
FROM Loan L, Loan_Type LT
WHERE L.loanType = LT.loanType
AND LT.name = 'Personal';

-- Query 3
-- Branch departments (including department manager)
SELECT M.branchID, D.name AS DepartmentName, E.name AS ManagerName
FROM Manage M, Department D, Employee E
WHERE M.employeeID = E.employeeID
AND M.departmentID = D.departmentID
ORDER BY M.branchID, D.name;

-- Query 4
-- Managers who make more than the average manager salary
SELECT E.name AS ManagerName
FROM Manage M, Employee E
WHERE M.employeeID = E.employeeID
AND E.salary > (SELECT AVG(salary)
				FROM Manage M, Employee E
                WHERE M.employeeID = E.employeeID)
ORDER BY E.name;
