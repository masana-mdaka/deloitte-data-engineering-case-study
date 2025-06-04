-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;


-- -----------------------------------------------------
-- Table `mydb`.`Listings`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Listings` (
  `listing_id` INT NOT NULL,
  `name` VARCHAR(200) NULL,
  `neighbourhood` VARCHAR(100) NULL,
  `latitude` DECIMAL(65) NULL,
  `longitude` DECIMAL(65) NULL,
  `room_type` VARCHAR(100) NULL,
  `price` DECIMAL(65) NULL,
  PRIMARY KEY (`listing_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Weather`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Weather` (
  `weather_id` INT NOT NULL,
  `listing_id` INT NULL,
  `reviewer_id` INT NULL,
  `precipitation` DECIMAL(50) NULL,
  `temperature_max` DECIMAL(50) NULL,
  `temperature_min` DECIMAL(50) NULL,
  PRIMARY KEY (`weather_id`),
  CONSTRAINT `listing_id`
    FOREIGN KEY (`listing_id`)
    REFERENCES `mydb`.`Listings` (`listing_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `reviewer_id`
    FOREIGN KEY (`reviewer_id`)
    REFERENCES `mydb`.`Reviews` (`reviewer_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Reviews`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Reviews` (
  `reviewer_id` INT NOT NULL,
  `listing_id` INT NULL,
  `weather_id` INT NULL,
  `date` DATETIME NULL,
  `comments` VARCHAR(200) NULL,
  `translated_comments` VARCHAR(200) NULL,
  `sentiment` VARCHAR(45) NULL,
  PRIMARY KEY (`reviewer_id`),
  INDEX `listing_id_idx` (`listing_id` ASC) VISIBLE,
  INDEX `weather_id_idx` (`weather_id` ASC) VISIBLE,
  CONSTRAINT `listing_id`
    FOREIGN KEY (`listing_id`)
    REFERENCES `mydb`.`Listings` (`listing_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `weather_id`
    FOREIGN KEY (`weather_id`)
    REFERENCES `mydb`.`Weather` (`weather_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
