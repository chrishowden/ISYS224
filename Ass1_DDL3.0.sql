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
