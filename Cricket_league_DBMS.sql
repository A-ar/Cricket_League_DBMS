

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema REVIEW
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema REVIEW
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `REVIEW` DEFAULT CHARACTER SET latin1 ;
USE `REVIEW` ;

-- -----------------------------------------------------
-- Table `REVIEW`.`coaches`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `REVIEW`.`coaches` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `experience` TINYINT(4) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 5
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `REVIEW`.`owners`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `REVIEW`.`owners` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `profession` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 5
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `REVIEW`.`players`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `REVIEW`.`players` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `matches_played` SMALLINT(5) UNSIGNED NULL DEFAULT '0',
  `total_runs` SMALLINT(5) UNSIGNED NULL DEFAULT '0',
  `total_wickets` SMALLINT(5) UNSIGNED NULL DEFAULT '0',
  `team_id` INT(10) UNSIGNED NOT NULL,
  `ducks` SMALLINT(5) UNSIGNED NULL DEFAULT '0',
  `role` VARCHAR(45) NOT NULL,
  `player_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 5
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `REVIEW`.`teams`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `REVIEW`.`teams` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(30) NOT NULL,
  `home_ground` VARCHAR(50) NULL DEFAULT NULL,
  `owner_id` INT(10) UNSIGNED NOT NULL,
  `coach_id` INT(10) UNSIGNED NOT NULL,
  `captain_id` INT(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `owner_id` (`owner_id` ASC),
  INDEX `coach_id` (`coach_id` ASC),
  INDEX `captain_id` (`captain_id` ASC),
  CONSTRAINT `teams_ibfk_1`
    FOREIGN KEY (`owner_id`)
    REFERENCES `REVIEW`.`owners` (`id`),
  CONSTRAINT `teams_ibfk_2`
    FOREIGN KEY (`coach_id`)
    REFERENCES `REVIEW`.`coaches` (`id`),
  CONSTRAINT `teams_ibfk_3`
    FOREIGN KEY (`captain_id`)
    REFERENCES `REVIEW`.`players` (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 5
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `REVIEW`.`venues`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `REVIEW`.`venues` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  `location` VARCHAR(255) NOT NULL,
  `capacity` MEDIUMINT(8) UNSIGNED NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 5
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `REVIEW`.`umpires`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `REVIEW`.`umpires` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `experience` TINYINT(4) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 5
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `REVIEW`.`fixtures`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `REVIEW`.`fixtures` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `date_time` INT(11) NOT NULL,
  `team1_id` INT(10) UNSIGNED NOT NULL,
  `team2_id` INT(10) UNSIGNED NOT NULL,
  `venue_id` INT(10) UNSIGNED NOT NULL,
  `umpire_id` INT(10) UNSIGNED NOT NULL,
  `completed` TINYINT(1) NOT NULL DEFAULT '0',
  `date` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `team1_id` (`team1_id` ASC),
  INDEX `team2_id` (`team2_id` ASC),
  INDEX `venue_id` (`venue_id` ASC),
  INDEX `umpire_id` (`umpire_id` ASC),
  CONSTRAINT `fixtures_ibfk_1`
    FOREIGN KEY (`team1_id`)
    REFERENCES `REVIEW`.`teams` (`id`),
  CONSTRAINT `fixtures_ibfk_2`
    FOREIGN KEY (`team2_id`)
    REFERENCES `REVIEW`.`teams` (`id`),
  CONSTRAINT `fixtures_ibfk_3`
    FOREIGN KEY (`venue_id`)
    REFERENCES `REVIEW`.`venues` (`id`),
  CONSTRAINT `fixtures_ibfk_4`
    FOREIGN KEY (`umpire_id`)
    REFERENCES `REVIEW`.`umpires` (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 5
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `REVIEW`.`matches`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `REVIEW`.`matches` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `fixture_id` INT(10) UNSIGNED NOT NULL,
  `winning_team_id` INT(10) UNSIGNED NULL DEFAULT NULL,
  `man_of_match_id` INT(10) UNSIGNED NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `fixture_id` (`fixture_id` ASC),
  INDEX `winning_team_id` (`winning_team_id` ASC),
  INDEX `man_of_match_id` (`man_of_match_id` ASC),
  CONSTRAINT `matches_ibfk_1`
    FOREIGN KEY (`fixture_id`)
    REFERENCES `REVIEW`.`fixtures` (`id`),
  CONSTRAINT `matches_ibfk_2`
    FOREIGN KEY (`winning_team_id`)
    REFERENCES `REVIEW`.`teams` (`id`),
  CONSTRAINT `matches_ibfk_3`
    FOREIGN KEY (`man_of_match_id`)
    REFERENCES `REVIEW`.`players` (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 5
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `REVIEW`.`player_100s`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `REVIEW`.`player_100s` (
  `player_id` INT(10) UNSIGNED NOT NULL,
  `match_id` INT(10) UNSIGNED NOT NULL,
  `balls` TINYINT(3) UNSIGNED NOT NULL,
  PRIMARY KEY (`player_id`, `match_id`),
  INDEX `match_id` (`match_id` ASC),
  CONSTRAINT `player_100s_ibfk_1`
    FOREIGN KEY (`player_id`)
    REFERENCES `REVIEW`.`players` (`id`),
  CONSTRAINT `player_100s_ibfk_2`
    FOREIGN KEY (`match_id`)
    REFERENCES `REVIEW`.`matches` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `REVIEW`.`player_50s`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `REVIEW`.`player_50s` (
  `player_id` INT(10) UNSIGNED NOT NULL,
  `match_id` INT(10) UNSIGNED NOT NULL,
  `balls` TINYINT(3) UNSIGNED NOT NULL,
  PRIMARY KEY (`player_id`, `match_id`),
  INDEX `match_id` (`match_id` ASC),
  CONSTRAINT `player_50s_ibfk_1`
    FOREIGN KEY (`player_id`)
    REFERENCES `REVIEW`.`players` (`id`),
  CONSTRAINT `player_50s_ibfk_2`
    FOREIGN KEY (`match_id`)
    REFERENCES `REVIEW`.`matches` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `REVIEW`.`player_batting_stats`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `REVIEW`.`player_batting_stats` (
  `player_id` INT(10) UNSIGNED NOT NULL,
  `match_id` INT(10) UNSIGNED NOT NULL,
  `runs` TINYINT(3) UNSIGNED NULL DEFAULT '0',
  `balls_played` TINYINT(3) UNSIGNED NULL DEFAULT '0',
  `strike_rate` FLOAT NULL DEFAULT NULL,
  PRIMARY KEY (`player_id`, `match_id`),
  INDEX `match_id` (`match_id` ASC),
  CONSTRAINT `player_batting_stats_ibfk_1`
    FOREIGN KEY (`player_id`)
    REFERENCES `REVIEW`.`players` (`id`),
  CONSTRAINT `player_batting_stats_ibfk_2`
    FOREIGN KEY (`match_id`)
    REFERENCES `REVIEW`.`matches` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `REVIEW`.`player_bowling_stats`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `REVIEW`.`player_bowling_stats` (
  `player_id` INT(10) UNSIGNED NOT NULL,
  `match_id` INT(10) UNSIGNED NOT NULL,
  `balls_delivered` TINYINT(3) UNSIGNED NULL DEFAULT '0',
  `wickets` TINYINT(3) UNSIGNED NULL DEFAULT '0',
  PRIMARY KEY (`player_id`, `match_id`),
  INDEX `match_id` (`match_id` ASC),
  CONSTRAINT `player_bowling_stats_ibfk_1`
    FOREIGN KEY (`player_id`)
    REFERENCES `REVIEW`.`players` (`id`),
  CONSTRAINT `player_bowling_stats_ibfk_2`
    FOREIGN KEY (`match_id`)
    REFERENCES `REVIEW`.`matches` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `REVIEW`.`player_fielding_stats`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `REVIEW`.`player_fielding_stats` (
  `player_id` INT(10) UNSIGNED NOT NULL,
  `match_id` INT(10) UNSIGNED NOT NULL,
  `catches` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0',
  PRIMARY KEY (`player_id`, `match_id`),
  INDEX `match_id` (`match_id` ASC),
  CONSTRAINT `player_fielding_stats_ibfk_1`
    FOREIGN KEY (`player_id`)
    REFERENCES `REVIEW`.`players` (`id`),
  CONSTRAINT `player_fielding_stats_ibfk_2`
    FOREIGN KEY (`match_id`)
    REFERENCES `REVIEW`.`matches` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `REVIEW`.`sixes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `REVIEW`.`sixes` (
  `player_id` INT(10) UNSIGNED NOT NULL,
  `match_id` INT(10) UNSIGNED NOT NULL,
  `distance_in_mtr` TINYINT(3) UNSIGNED NOT NULL,
  INDEX `player_id` (`player_id` ASC),
  INDEX `match_id` (`match_id` ASC),
  CONSTRAINT `sixes_ibfk_1`
    FOREIGN KEY (`player_id`)
    REFERENCES `REVIEW`.`players` (`id`),
  CONSTRAINT `sixes_ibfk_2`
    FOREIGN KEY (`match_id`)
    REFERENCES `REVIEW`.`matches` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `REVIEW`.`sponsors`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `REVIEW`.`sponsors` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 5
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `REVIEW`.`team_stats`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `REVIEW`.`team_stats` (
  `team_id` INT(10) UNSIGNED NOT NULL,
  `total_matches` MEDIUMINT(8) UNSIGNED NULL DEFAULT '0',
  `matches_won` MEDIUMINT(8) UNSIGNED NULL DEFAULT '0',
  `matches_lost` MEDIUMINT(8) UNSIGNED NULL DEFAULT '0',
  `points` SMALLINT(5) UNSIGNED NULL DEFAULT '0',
  `net_run_rate` FLOAT NULL DEFAULT '0',
  INDEX `team_id` (`team_id` ASC),
  CONSTRAINT `team_stats_ibfk_1`
    FOREIGN KEY (`team_id`)
    REFERENCES `REVIEW`.`teams` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
