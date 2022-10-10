-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema MusaicDB
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema MusaicDB
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `MusaicDB` DEFAULT CHARACTER SET utf8 ;
USE `MusaicDB` ;

-- -----------------------------------------------------
-- Table `MusaicDB`.`users`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `MusaicDB`.`users` ;

CREATE TABLE IF NOT EXISTS `MusaicDB`.`users` (
  `email` VARCHAR(100) NOT NULL,
  `username` VARCHAR(100) NOT NULL,
  `password` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`email`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `MusaicDB`.`playlist`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `MusaicDB`.`playlist` ;

CREATE TABLE IF NOT EXISTS `MusaicDB`.`playlist` (
  `playlistId` INT NOT NULL AUTO_INCREMENT,
  `songId` VARCHAR(200) NOT NULL,
  `users_email` VARCHAR(100) NOT NULL,
  INDEX `fk_playlist_users_idx` (`users_email` ASC) ,
  PRIMARY KEY (`playlistId`),
  CONSTRAINT `fk_playlist_users`
    FOREIGN KEY (`users_email`)
    REFERENCES `MusaicDB`.`users` (`email`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
