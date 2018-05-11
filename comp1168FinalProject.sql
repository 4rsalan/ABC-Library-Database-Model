   -- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema ProjSchema
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema ProjSchema
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `ProjSchema` DEFAULT CHARACTER SET utf8 ;
USE `ProjSchema` ;

-- -----------------------------------------------------
-- Table `ProjSchema`.`Publisher`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ProjSchema`.`Publisher` (
  `Publisher_ID_PK` INT NOT NULL,
  `Publisher_Name` VARCHAR(45) NULL,
  PRIMARY KEY (`Publisher_ID_PK`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ProjSchema`.`Author`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ProjSchema`.`Author` (
  `authorID_PK` INT NOT NULL,
  `Author_First_Name` VARCHAR(45) NOT NULL,
  `Author_Last_Name` VARCHAR(45) NOT NULL,
  `Author_Birth_Date` DATE NOT NULL,
  PRIMARY KEY (`authorID_PK`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ProjSchema`.`Memberships`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ProjSchema`.`Memberships` (
  `Membership_Type_PK` INT NOT NULL,
  `Membership_Name` VARCHAR(7) NOT NULL,
  `Membership_Item_Limit` INT NOT NULL,
  PRIMARY KEY (`Membership_Type_PK`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ProjSchema`.`Patron`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ProjSchema`.`Patron` (
  `Library_Card_ID_PK` INT NOT NULL,
  `Patron_First_Name` VARCHAR(45) NOT NULL,
  `Patron_Last_Name` VARCHAR(45) NOT NULL,
  `Phone` VARCHAR(12) NULL,
  `Membership_Type_FK` INT NOT NULL,
  PRIMARY KEY (`Library_Card_ID_PK`),
  INDEX `fk_Patron_Memberships1_idx` (`Membership_Type_FK` ASC),
  CONSTRAINT `fk_Patron_Memberships1`
    FOREIGN KEY (`Membership_Type_FK`)
    REFERENCES `ProjSchema`.`Memberships` (`Membership_Type_PK`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ProjSchema`.`Title`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ProjSchema`.`Title` (
  `Title_ID_PK` INT NOT NULL,
  `TitleName` VARCHAR(45) NOT NULL,
  `Publisher_ID_FK` INT NOT NULL,
  `Edition` INT NULL,
  PRIMARY KEY (`Title_ID_PK`),
  INDEX `fk_Title_Publisher1_idx` (`Publisher_ID_FK` ASC),
  CONSTRAINT `fk_Title_Publisher1`
    FOREIGN KEY (`Publisher_ID_FK`)
    REFERENCES `ProjSchema`.`Publisher` (`Publisher_ID_PK`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ProjSchema`.`Book`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ProjSchema`.`Book` (
  `Book_Barcode_ID_PK` INT NOT NULL,
  `Title_FK` INT NOT NULL,
  PRIMARY KEY (`Book_Barcode_ID_PK`),
  INDEX `fk_Book_Item1_idx` (`Title_FK` ASC),
  CONSTRAINT `fk_Book_Item1`
    FOREIGN KEY (`Title_FK`)
    REFERENCES `ProjSchema`.`Title` (`Title_ID_PK`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ProjSchema`.`CD`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ProjSchema`.`CD` (
  `CD_Barcode_ID_PK` INT NOT NULL,
  `Title_FK` INT NOT NULL,
  PRIMARY KEY (`CD_Barcode_ID_PK`),
  INDEX `fk_CD_Item1_idx` (`Title_FK` ASC),
  CONSTRAINT `fk_CD_Item1`
    FOREIGN KEY (`Title_FK`)
    REFERENCES `ProjSchema`.`Title` (`Title_ID_PK`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ProjSchema`.`DVD`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ProjSchema`.`DVD` (
  `DVD_Barcode_ID_PK` INT NOT NULL,
  `Title_FK` INT NOT NULL,
  PRIMARY KEY (`DVD_Barcode_ID_PK`),
  INDEX `fk_DVD_Item1_idx` (`Title_FK` ASC),
  CONSTRAINT `fk_DVD_Item1`
    FOREIGN KEY (`Title_FK`)
    REFERENCES `ProjSchema`.`Title` (`Title_ID_PK`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ProjSchema`.`Borrow_Book`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ProjSchema`.`Borrow_Book` (
  `Borrow_Book_ID_PK` INT NOT NULL,
  `Patron_ID_FK` INT NOT NULL,
  `Book_Barcode_ID_FK` INT NOT NULL,
  `Borrow_Date` DATE NOT NULL,
  `Due_Date` DATE NOT NULL,
  `Return_Date` DATE NULL,
  `Late_Fees` DECIMAL(10,2) NULL,
  INDEX `fk_Customer_has_Book_Book1_idx` (`Book_Barcode_ID_FK` ASC),
  INDEX `fk_Customer_has_Book_Customer1_idx` (`Patron_ID_FK` ASC),
  PRIMARY KEY (`Borrow_Book_ID_PK`),
  CONSTRAINT `fk_Customer_has_Book_Customer1`
    FOREIGN KEY (`Patron_ID_FK`)
    REFERENCES `ProjSchema`.`Patron` (`Library_Card_ID_PK`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Customer_has_Book_Book1`
    FOREIGN KEY (`Book_Barcode_ID_FK`)
    REFERENCES `ProjSchema`.`Book` (`Book_Barcode_ID_PK`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ProjSchema`.`Borrow_CD`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ProjSchema`.`Borrow_CD` (
  `Borrow_CD_ID_PK` INT NOT NULL,
  `Patron_ID_FK` INT NOT NULL,
  `CD_Barcode_ID_FK` INT NOT NULL,
  `Borrow_Date` DATE NOT NULL,
  `Due_Date` DATE NOT NULL,
  `Return_Date` DATE NULL,
  `Late_Fees` DECIMAL(10,2) NULL,
  PRIMARY KEY (`Borrow_CD_ID_PK`),
  INDEX `fk_Customer_has_CD_CD1_idx` (`CD_Barcode_ID_FK` ASC),
  INDEX `fk_Customer_has_CD_Customer1_idx` (`Patron_ID_FK` ASC),
  CONSTRAINT `fk_Customer_has_CD_Customer1`
    FOREIGN KEY (`Patron_ID_FK`)
    REFERENCES `ProjSchema`.`Patron` (`Library_Card_ID_PK`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Customer_has_CD_CD1`
    FOREIGN KEY (`CD_Barcode_ID_FK`)
    REFERENCES `ProjSchema`.`CD` (`CD_Barcode_ID_PK`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ProjSchema`.`Borrow_DVD`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ProjSchema`.`Borrow_DVD` (
  `Borrow_DVD_ID_PK` INT NOT NULL,
  `Patron_ID_FK` INT NOT NULL,
  `DVD_Barcode_ID_FK` INT NOT NULL,
  `Borrow_Date` DATE NOT NULL,
  `Due_Date` DATE NOT NULL,
  `Return_Date` DATE NULL,
  `Late_Fees` DECIMAL(10,2) NULL,
  INDEX `fk_Customer_has_DVD_DVD1_idx` (`DVD_Barcode_ID_FK` ASC),
  INDEX `fk_Customer_has_DVD_Customer1_idx` (`Patron_ID_FK` ASC),
  PRIMARY KEY (`Borrow_DVD_ID_PK`),
  CONSTRAINT `fk_Customer_has_DVD_Customer1`
    FOREIGN KEY (`Patron_ID_FK`)
    REFERENCES `ProjSchema`.`Patron` (`Library_Card_ID_PK`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Customer_has_DVD_DVD1`
    FOREIGN KEY (`DVD_Barcode_ID_FK`)
    REFERENCES `ProjSchema`.`DVD` (`DVD_Barcode_ID_PK`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ProjSchema`.`Author_Creates`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ProjSchema`.`Author_Creates` (
  `Author_ID_FK` INT NOT NULL,
  `Title_ID_FK` INT NOT NULL,
  PRIMARY KEY (`Author_ID_FK`, `Title_ID_FK`),
  INDEX `fk_Author_Creates_Book_Title1_idx` (`Title_ID_FK` ASC),
  CONSTRAINT `fk_Author_Creates_Book_Author1`
    FOREIGN KEY (`Author_ID_FK`)
    REFERENCES `ProjSchema`.`Author` (`authorID_PK`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Author_Creates_Book_Title1`
    FOREIGN KEY (`Title_ID_FK`)
    REFERENCES `ProjSchema`.`Title` (`Title_ID_PK`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ProjSchema`.`Subject`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ProjSchema`.`Subject` (
  `Subject_ID_FK` INT NOT NULL,
  `Subject_Name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Subject_ID_FK`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ProjSchema`.`Belongs`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ProjSchema`.`Belongs` (
  `Title_ID_FK` INT NOT NULL,
  `Subject_ID_FK` INT NOT NULL,
  PRIMARY KEY (`Title_ID_FK`, `Subject_ID_FK`),
  INDEX `fk_Item_Belongs_To_Subject_Subject1_idx` (`Subject_ID_FK` ASC),
  CONSTRAINT `fk_Item_Belongs_To_Subject_Title1`
    FOREIGN KEY (`Title_ID_FK`)
    REFERENCES `ProjSchema`.`Title` (`Title_ID_PK`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Item_Belongs_To_Subject_Subject1`
    FOREIGN KEY (`Subject_ID_FK`)
    REFERENCES `ProjSchema`.`Subject` (`Subject_ID_FK`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ProjSchema`.`Staff`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ProjSchema`.`Staff` (
  `Staff_Member_ID_PK` INT NOT NULL,
  `Staff_Member_First_Name` VARCHAR(45) NOT NULL,
  `Staff_Member_Last_Name` VARCHAR(45) NOT NULL,
  `Staff_Member_Email` VARCHAR(45) NULL,
  PRIMARY KEY (`Staff_Member_ID_PK`))
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
