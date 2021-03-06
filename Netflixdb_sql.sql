

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema onab4340
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema onab4340
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `onab4340` DEFAULT CHARACTER SET utf8 ;
USE `onab4340` ;

-- -----------------------------------------------------
-- Table `onab4340`.`Main_Genre`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `onab4340`.`Main_Genre` (
  `GenreId` INT NOT NULL AUTO_INCREMENT,
  `GenreName` VARCHAR(25) NOT NULL,
  PRIMARY KEY (`GenreId`),
  UNIQUE INDEX `GenreName_UNIQUE` (`GenreName` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `onab4340`.`Media`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `onab4340`.`Media` (
  `MediaId` INT NOT NULL AUTO_INCREMENT,
  `Title` VARCHAR(30) NOT NULL,
  `ImdbRating` DECIMAL(2,1) NULL DEFAULT 0.0,
  `Summary` LONGTEXT NULL,
  `GenreId` INT NOT NULL,
  PRIMARY KEY (`MediaId`),
  INDEX `fk_Media_Genre1_idx` (`GenreId` ASC) VISIBLE,
  INDEX `Index_Title` (`Title` ASC) VISIBLE,
  CONSTRAINT `fk_Media_Genre`
    FOREIGN KEY (`GenreId`)
    REFERENCES `onab4340`.`Main_Genre` (`GenreId`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `onab4340`.`Main_Director`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `onab4340`.`Main_Director` (
  `DirectorId` CHAR(8) NOT NULL,
  `first_name` VARCHAR(15) NOT NULL,
  `last_name` VARCHAR(15) NOT NULL,
  PRIMARY KEY (`DirectorId`),
  INDEX `Index_name` (`first_name` ASC, `last_name` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `onab4340`.`Movie`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `onab4340`.`Movie` (
  `MediaId` INT NOT NULL,
  `MovieLength(Minutes)` INT NOT NULL,
  `ReleaseDate` DATE NOT NULL,
  `DirectorId` CHAR(8) NOT NULL,
  PRIMARY KEY (`MediaId`),
  INDEX `fk_Movie_Media1_idx` (`MediaId` ASC) VISIBLE,
  INDEX `fk_Movie_Main_Director1_idx` (`DirectorId` ASC) VISIBLE,
  CONSTRAINT `fk_Movie_Media1`
    FOREIGN KEY (`MediaId`)
    REFERENCES `onab4340`.`Media` (`MediaId`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Movie_Main_Director1`
    FOREIGN KEY (`DirectorId`)
    REFERENCES `onab4340`.`Main_Director` (`DirectorId`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `onab4340`.`Show`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `onab4340`.`Show` (
  `MediaId` INT NOT NULL,
  `no_of_Seasons` INT NOT NULL,
  `no_of_Episodes` INT NOT NULL,
  `Start_Date` DATE NOT NULL,
  `End_Date` DATE NULL DEFAULT NULL,
  `LastUpdated` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`MediaId`),
  INDEX `fk_Show_Media1_idx` (`MediaId` ASC) VISIBLE,
  CONSTRAINT `fk_Show_Media1`
    FOREIGN KEY (`MediaId`)
    REFERENCES `onab4340`.`Media` (`MediaId`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `onab4340`.`Actor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `onab4340`.`Actor` (
  `ActorId` CHAR(8) NOT NULL COMMENT 'last 4 character of lastname + random set of 4 numbers\n',
  `first_name` VARCHAR(15) NOT NULL,
  `last_name` VARCHAR(15) NOT NULL,
  `Sex` CHAR(1) NULL DEFAULT NULL,
  PRIMARY KEY (`ActorId`),
  INDEX `Index_name` (`first_name` ASC, `last_name` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `onab4340`.`Media_Actor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `onab4340`.`Media_Actor` (
  `MediaId` INT NOT NULL,
  `ActorId` CHAR(8) NOT NULL,
  PRIMARY KEY (`MediaId`, `ActorId`),
  INDEX `fk_Media_has_Actor_Actor1_idx` (`ActorId` ASC) VISIBLE,
  INDEX `fk_Media_has_Actor_Media1_idx` (`MediaId` ASC) VISIBLE,
  CONSTRAINT `fk_Media_has_Actor_Media1`
    FOREIGN KEY (`MediaId`)
    REFERENCES `onab4340`.`Media` (`MediaId`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Media_has_Actor_Actor1`
    FOREIGN KEY (`ActorId`)
    REFERENCES `onab4340`.`Actor` (`ActorId`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `onab4340`.`Sub_Genre`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `onab4340`.`Sub_Genre` (
  `SGenreId` INT NOT NULL,
  `GenreId` INT NOT NULL AUTO_INCREMENT,
  `Sub_Genre_Name` VARCHAR(25) NOT NULL,
  PRIMARY KEY (`SGenreId`),
  INDEX `fk_Sub_Genre_Main_Genre1_idx` (`GenreId` ASC) VISIBLE,
  INDEX `Index_name` (`Sub_Genre_Name` ASC) VISIBLE,
  CONSTRAINT `fk_Sub_Genre_Main_Genre1`
    FOREIGN KEY (`GenreId`)
    REFERENCES `onab4340`.`Main_Genre` (`GenreId`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `onab4340`.`Media_Sub_Genre`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `onab4340`.`Media_Sub_Genre` (
  `MediaId` INT NOT NULL,
  `SGenreId` INT NOT NULL,
  PRIMARY KEY (`MediaId`, `SGenreId`),
  INDEX `fk_Media_has_Sub_Genre_Sub_Genre1_idx` (`SGenreId` ASC) VISIBLE,
  INDEX `fk_Media_has_Sub_Genre_Media1_idx` (`MediaId` ASC) VISIBLE,
  CONSTRAINT `fk_Media_has_Sub_Genre_Media1`
    FOREIGN KEY (`MediaId`)
    REFERENCES `onab4340`.`Media` (`MediaId`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Media_has_Sub_Genre_Sub_Genre1`
    FOREIGN KEY (`SGenreId`)
    REFERENCES `onab4340`.`Sub_Genre` (`SGenreId`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

USE `onab4340` ;

-- -----------------------------------------------------
-- Placeholder table for view `onab4340`.`v_Main_Genre_Sub_Genre`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `onab4340`.`v_Main_Genre_Sub_Genre` (`GenreId` INT, `GenreName` INT, `SGenreId` INT, `Sub_Genre_Name` INT);

-- -----------------------------------------------------
-- Placeholder table for view `onab4340`.`v_Movie_Media_Director`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `onab4340`.`v_Movie_Media_Director` (`MediaId` INT, `Title` INT, `ImdbRating` INT, `Summary` INT, `GenreId` INT, `ReleaseDate` INT, `DirectorId` INT, `first_name` INT, `last_name` INT);

-- -----------------------------------------------------
-- View `onab4340`.`v_Main_Genre_Sub_Genre`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `onab4340`.`v_Main_Genre_Sub_Genre`;
USE `onab4340`;
CREATE  OR REPLACE VIEW `v_Main_Genre_Sub_Genre` AS
SELECT m.GenreId, m.GenreName, s.SGenreId, s.Sub_Genre_Name
FROM Main_Genre as m
LEFT JOIN Sub_Genre as s
ON m.GenreId = s.GenreId
ORDER BY m.GenreName, s.Sub_Genre_Name;

-- -----------------------------------------------------
-- View `onab4340`.`v_Movie_Media_Director`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `onab4340`.`v_Movie_Media_Director`;
USE `onab4340`;
CREATE  OR REPLACE VIEW `v_Movie_Media_Director` AS
SELECT me.MediaId, me.Title, me.ImdbRating, me.Summary, me.GenreId,  mo.ReleaseDate, mo.DirectorId, md.first_name, md.last_name
FROM Media as me
INNER JOIN Movie as mo
ON mo.MediaId = me.MediaId
LEFT JOIN  Main_Director as md
ON mo.DirectorId = md.DirectorId
ORDER BY me.Title;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
