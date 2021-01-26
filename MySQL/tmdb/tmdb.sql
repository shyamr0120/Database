-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`cast member`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`cast member` (
  `cast_id` INT NOT NULL,
  `cast_name` VARCHAR(20) NULL,
  `cast_character` VARCHAR(20) NOT NULL,
  `actor_gender` INT NULL,
  `movie_id` INT NOT NULL,
  PRIMARY KEY (`cast_id`, `movie_id`, `cast_character`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`crew member`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`crew member` (
  `crew_id` INT NOT NULL,
  `crew_name` CHAR(20) NULL,
  `crew_job` CHAR(20) NOT NULL,
  `movie_id` INT NOT NULL,
  `department` VARCHAR(20) NULL,
  PRIMARY KEY (`crew_id`, `movie_id`, `crew_job`),
  UNIQUE INDEX `crew_id_UNIQUE` (`crew_id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`movie`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`movie` (
  `movie_id` INT NOT NULL,
  `movie_title` CHAR(50) NULL,
  `movie_language` CHAR(50) NULL,
  `movie_release_date` DATE NULL,
  `movie_popularity` FLOAT NULL,
  `movie_revenue` INT NULL,
  `movie_budget` INT NULL,
  `movie_status` CHAR(10) NULL,
  `movie_vote_average` FLOAT NULL,
  `movie_vote_count` INT NULL,
  `movie_runtime` INT NULL,
  `movie_tagline` VARCHAR(50) NULL,
  PRIMARY KEY (`movie_id`),
  UNIQUE INDEX `movie_id_UNIQUE` (`movie_id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`production country`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`production country` (
  `country_code` CHAR(10) NOT NULL,
  `country_name` CHAR(20) NULL,
  `movie_id` INT NOT NULL,
  PRIMARY KEY (`country_code`, `movie_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`genre`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`genre` (
  `geners_id` INT NOT NULL,
  `generes_title` VARCHAR(20) NULL,
  `movie_id` INT NOT NULL,
  PRIMARY KEY (`geners_id`, `movie_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`keyword`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`keyword` (
  `key_id` INT NOT NULL,
  `movie_id` INT NOT NULL,
  `key_description` VARCHAR(20) NULL,
  PRIMARY KEY (`key_id`, `movie_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`production company`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`production company` (
  `company_id` INT NOT NULL,
  `company_name` VARCHAR(20) NULL,
  `movie_id` INT NOT NULL,
  PRIMARY KEY (`company_id`, `movie_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`dubbed language`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`dubbed language` (
  `language_id` INT NOT NULL,
  `movie_id` VARCHAR(45) NOT NULL,
  `language_name` VARCHAR(45) NULL,
  PRIMARY KEY (`language_id`, `movie_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Produced By`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Produced By` (
  `movie_movie_id` INT NOT NULL,
  `production company_company_id` INT NOT NULL,
  `production company_movie_id` INT NOT NULL,
  PRIMARY KEY (`movie_movie_id`, `production company_company_id`, `production company_movie_id`),
  INDEX `fk_movie_has_production company_production company1_idx` (`production company_company_id` ASC, `production company_movie_id` ASC) VISIBLE,
  INDEX `fk_movie_has_production company_movie1_idx` (`movie_movie_id` ASC) VISIBLE,
  CONSTRAINT `fk_movie_has_production company_movie1`
    FOREIGN KEY (`movie_movie_id`)
    REFERENCES `mydb`.`movie` (`movie_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_movie_has_production company_production company1`
    FOREIGN KEY (`production company_company_id` , `production company_movie_id`)
    REFERENCES `mydb`.`production company` (`company_id` , `movie_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Produced In`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Produced In` (
  `movie_movie_id` INT NOT NULL,
  `production country_country_code` CHAR(10) NOT NULL,
  `production country_movie_id` INT NOT NULL,
  PRIMARY KEY (`movie_movie_id`, `production country_country_code`, `production country_movie_id`),
  INDEX `fk_movie_has_production country_production country1_idx` (`production country_country_code` ASC, `production country_movie_id` ASC) VISIBLE,
  INDEX `fk_movie_has_production country_movie1_idx` (`movie_movie_id` ASC) VISIBLE,
  CONSTRAINT `fk_movie_has_production country_movie1`
    FOREIGN KEY (`movie_movie_id`)
    REFERENCES `mydb`.`movie` (`movie_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_movie_has_production country_production country1`
    FOREIGN KEY (`production country_country_code` , `production country_movie_id`)
    REFERENCES `mydb`.`production country` (`country_code` , `movie_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Dubbed In`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Dubbed In` (
  `movie_movie_id` INT NOT NULL,
  `dubbed language_language_id` INT NOT NULL,
  `dubbed language_movie_id` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`movie_movie_id`, `dubbed language_language_id`, `dubbed language_movie_id`),
  INDEX `fk_movie_has_dubbed language_dubbed language1_idx` (`dubbed language_language_id` ASC, `dubbed language_movie_id` ASC) VISIBLE,
  INDEX `fk_movie_has_dubbed language_movie1_idx` (`movie_movie_id` ASC) VISIBLE,
  CONSTRAINT `fk_movie_has_dubbed language_movie1`
    FOREIGN KEY (`movie_movie_id`)
    REFERENCES `mydb`.`movie` (`movie_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_movie_has_dubbed language_dubbed language1`
    FOREIGN KEY (`dubbed language_language_id` , `dubbed language_movie_id`)
    REFERENCES `mydb`.`dubbed language` (`language_id` , `movie_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Is A`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Is A` (
  `movie_movie_id` INT NOT NULL,
  `genre_geners_id` INT NOT NULL,
  `genre_movie_id` INT NOT NULL,
  PRIMARY KEY (`movie_movie_id`, `genre_geners_id`, `genre_movie_id`),
  INDEX `fk_movie_has_genre_genre1_idx` (`genre_geners_id` ASC, `genre_movie_id` ASC) VISIBLE,
  INDEX `fk_movie_has_genre_movie1_idx` (`movie_movie_id` ASC) VISIBLE,
  CONSTRAINT `fk_movie_has_genre_movie1`
    FOREIGN KEY (`movie_movie_id`)
    REFERENCES `mydb`.`movie` (`movie_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_movie_has_genre_genre1`
    FOREIGN KEY (`genre_geners_id` , `genre_movie_id`)
    REFERENCES `mydb`.`genre` (`geners_id` , `movie_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Defined By`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Defined By` (
  `movie_movie_id` INT NOT NULL,
  `keyword_key_id` INT NOT NULL,
  `keyword_movie_id` INT NOT NULL,
  PRIMARY KEY (`movie_movie_id`, `keyword_key_id`, `keyword_movie_id`),
  INDEX `fk_movie_has_keyword_keyword1_idx` (`keyword_key_id` ASC, `keyword_movie_id` ASC) VISIBLE,
  INDEX `fk_movie_has_keyword_movie1_idx` (`movie_movie_id` ASC) VISIBLE,
  CONSTRAINT `fk_movie_has_keyword_movie1`
    FOREIGN KEY (`movie_movie_id`)
    REFERENCES `mydb`.`movie` (`movie_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_movie_has_keyword_keyword1`
    FOREIGN KEY (`keyword_key_id` , `keyword_movie_id`)
    REFERENCES `mydb`.`keyword` (`key_id` , `movie_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Worked On By`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Worked On By` (
  `movie_movie_id` INT NOT NULL,
  `crew member_crew_id` INT NOT NULL,
  `crew member_movie_id` INT NOT NULL,
  `crew member_crew_job` CHAR(20) NOT NULL,
  PRIMARY KEY (`movie_movie_id`, `crew member_crew_id`, `crew member_movie_id`, `crew member_crew_job`),
  INDEX `fk_movie_has_crew member_crew member1_idx` (`crew member_crew_id` ASC, `crew member_movie_id` ASC, `crew member_crew_job` ASC) VISIBLE,
  INDEX `fk_movie_has_crew member_movie1_idx` (`movie_movie_id` ASC) VISIBLE,
  CONSTRAINT `fk_movie_has_crew member_movie1`
    FOREIGN KEY (`movie_movie_id`)
    REFERENCES `mydb`.`movie` (`movie_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_movie_has_crew member_crew member1`
    FOREIGN KEY (`crew member_crew_id` , `crew member_movie_id` , `crew member_crew_job`)
    REFERENCES `mydb`.`crew member` (`crew_id` , `movie_id` , `crew_job`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Acted By`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Acted By` (
  `movie_movie_id` INT NOT NULL,
  `cast member_cast_id` INT NOT NULL,
  `cast member_movie_id` INT NOT NULL,
  `cast member_cast_character` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`movie_movie_id`, `cast member_cast_id`, `cast member_movie_id`, `cast member_cast_character`),
  INDEX `fk_movie_has_cast member_cast member1_idx` (`cast member_cast_id` ASC, `cast member_movie_id` ASC, `cast member_cast_character` ASC) VISIBLE,
  INDEX `fk_movie_has_cast member_movie1_idx` (`movie_movie_id` ASC) VISIBLE,
  CONSTRAINT `fk_movie_has_cast member_movie1`
    FOREIGN KEY (`movie_movie_id`)
    REFERENCES `mydb`.`movie` (`movie_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_movie_has_cast member_cast member1`
    FOREIGN KEY (`cast member_cast_id` , `cast member_movie_id` , `cast member_cast_character`)
    REFERENCES `mydb`.`cast member` (`cast_id` , `movie_id` , `cast_character`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
