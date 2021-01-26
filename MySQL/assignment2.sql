
SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema assignment2
-- -----------------------------------------------------
-- Assignment 2

-- -----------------------------------------------------
-- Schema assignment2
--
-- Assignment 2
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `assignment2` DEFAULT CHARACTER SET utf8 COLLATE utf8_bin ;
USE `assignment2` ;

-- -----------------------------------------------------
-- Table `assignment2`.`Landmass`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `assignment2`.`Landmass` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(20) NOT NULL,
  `area` FLOAT NULL,
  PRIMARY KEY (`id`, `name`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `assignment2`.`Body of Water`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `assignment2`.`Body of Water` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(20) NOT NULL,
  `area` FLOAT ZEROFILL NULL,
  UNIQUE INDEX `name_UNIQUE` (`name` ASC) VISIBLE,
  PRIMARY KEY (`id`, `name`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `assignment2`.`Strait`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `assignment2`.`Strait` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_straits_body_of_water1_idx` (`name` ASC) VISIBLE,
  UNIQUE INDEX `name_UNIQUE` (`name` ASC) VISIBLE,
  CONSTRAINT `fk_straits_body_of_water1`
    FOREIGN KEY (`name`)
    REFERENCES `assignment2`.`Body of Water` (`name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `assignment2`.`Continent`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `assignment2`.`Continent` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(20) NOT NULL,
  `sepearted by` VARCHAR(20) NULL,
  `connected to` VARCHAR(20) NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Continent_Landmass1_idx` (`name` ASC) VISIBLE,
  INDEX `fk_continent_straits1_idx` (`sepearted by` ASC) VISIBLE,
  INDEX `fk_continent_continent1_idx` (`connected to` ASC) VISIBLE,
  UNIQUE INDEX `name_UNIQUE` (`name` ASC) VISIBLE,
  CONSTRAINT `fk_Continent_Landmass1`
    FOREIGN KEY (`name`)
    REFERENCES `assignment2`.`Landmass` (`name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_continent_straits1`
    FOREIGN KEY (`sepearted by`)
    REFERENCES `assignment2`.`Strait` (`name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_continent_continent1`
    FOREIGN KEY (`connected to`)
    REFERENCES `assignment2`.`Continent` (`name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `assignment2`.`Ocean`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `assignment2`.`Ocean` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_ocean_body_of_water1_idx` (`name` ASC) VISIBLE,
  UNIQUE INDEX `name_UNIQUE` (`name` ASC) VISIBLE,
  CONSTRAINT `fk_ocean_body_of_water1`
    FOREIGN KEY (`name`)
    REFERENCES `assignment2`.`Body of Water` (`name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `assignment2`.`Island`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `assignment2`.`Island` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(20) NOT NULL,
  `separated by` VARCHAR(20) NULL,
  `located in` VARCHAR(20) NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_island_landmass1_idx` (`name` ASC) VISIBLE,
  INDEX `fk_island_straits1_idx` (`separated by` ASC) VISIBLE,
  UNIQUE INDEX `name_UNIQUE` (`name` ASC) VISIBLE,
  INDEX `fk_Island_Ocean1_idx` (`located in` ASC) VISIBLE,
  CONSTRAINT `fk_island_landmass1`
    FOREIGN KEY (`name`)
    REFERENCES `assignment2`.`Landmass` (`name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_island_straits1`
    FOREIGN KEY (`separated by`)
    REFERENCES `assignment2`.`Strait` (`name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Island_Ocean1`
    FOREIGN KEY (`located in`)
    REFERENCES `assignment2`.`Ocean` (`name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
