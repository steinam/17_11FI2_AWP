/* SQL Manager Lite for MySQL                              5.6.3.49012 */
/* ------------------------------------------------------------------- */
/* Host     : localhost                                                */
/* Port     : 3306                                                     */
/* Database : sommer_2015                                              */


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES 'utf8' */;

SET FOREIGN_KEY_CHECKS=0;

CREATE DATABASE `sommer_2015`
    CHARACTER SET 'utf8'
    COLLATE 'utf8_general_ci';

USE `sommer_2015`;

/* Struktur für die Tabelle `kunde`:  */

CREATE TABLE `kunde` (
  `kd_id` INTEGER(11) NOT NULL,
  `kd_firma` VARCHAR(200) COLLATE utf8_general_ci DEFAULT NULL,
  `kd_strasse` VARCHAR(200) COLLATE utf8_general_ci DEFAULT NULL,
  `kd_plz` VARCHAR(5) COLLATE utf8_general_ci DEFAULT NULL,
  `kd_ort` VARCHAR(30) COLLATE utf8_general_ci DEFAULT NULL,
  PRIMARY KEY USING BTREE (`kd_id`)
) ENGINE=InnoDB
CHARACTER SET 'utf8' COLLATE 'utf8_general_ci'
;

/* Struktur für die Tabelle `auftrag`:  */

CREATE TABLE `auftrag` (
  `au_id` INTEGER(11) NOT NULL,
  `au_kd_id` INTEGER(11) DEFAULT NULL,
  `au_auftrag` VARCHAR(20) COLLATE utf8_general_ci DEFAULT NULL,
  PRIMARY KEY USING BTREE (`au_id`),
  KEY `au_kd_id` USING BTREE (`au_kd_id`),
  CONSTRAINT `auftrag_ibfk_1` FOREIGN KEY (`au_kd_id`) REFERENCES `kunde` (`kd_id`)
) ENGINE=InnoDB
CHARACTER SET 'utf8' COLLATE 'utf8_general_ci'
;

/* Struktur für die Tabelle `fahrer`:  */

CREATE TABLE `fahrer` (
  `fa_id` INTEGER(11) NOT NULL,
  `fa_name` VARCHAR(20) COLLATE utf8_general_ci DEFAULT NULL,
  `fa_strasse` VARCHAR(20) COLLATE utf8_general_ci DEFAULT NULL,
  `fa_plz` VARCHAR(5) COLLATE utf8_general_ci DEFAULT NULL,
  `fa_ort` VARCHAR(20) COLLATE utf8_general_ci DEFAULT NULL,
  PRIMARY KEY USING BTREE (`fa_id`)
) ENGINE=InnoDB
CHARACTER SET 'utf8' COLLATE 'utf8_general_ci'
;

/* Struktur für die Tabelle `fahrten`:  */

CREATE TABLE `fahrten` (
  `f_id` INTEGER(11) NOT NULL,
  `f_fa_id` INTEGER(11) DEFAULT NULL,
  `f_au_id` INTEGER(11) DEFAULT NULL,
  PRIMARY KEY USING BTREE (`f_id`),
  KEY `f_fa_id` USING BTREE (`f_fa_id`),
  KEY `f_au_id` USING BTREE (`f_au_id`),
  CONSTRAINT `fahrten_ibfk_1` FOREIGN KEY (`f_fa_id`) REFERENCES `fahrer` (`fa_id`),
  CONSTRAINT `fahrten_ibfk_2` FOREIGN KEY (`f_au_id`) REFERENCES `auftrag` (`au_id`)
) ENGINE=InnoDB
CHARACTER SET 'utf8' COLLATE 'utf8_general_ci'
;

/* Struktur für die Tabelle `teilstrecke`:  */

CREATE TABLE `teilstrecke` (
  `ts_id` INTEGER(11) NOT NULL,
  `ts_f_id` INTEGER(11) DEFAULT NULL,
  `ts_strecke` INTEGER(11) DEFAULT NULL,
  PRIMARY KEY USING BTREE (`ts_id`),
  KEY `ts_f_id` USING BTREE (`ts_f_id`),
  CONSTRAINT `teilstrecke_ibfk_1` FOREIGN KEY (`ts_f_id`) REFERENCES `fahrten` (`f_id`)
) ENGINE=InnoDB
CHARACTER SET 'utf8' COLLATE 'utf8_general_ci'
;

/* Data for the `kunde` table  (LIMIT 0,500) */

INSERT INTO `kunde` (`kd_id`, `kd_firma`, `kd_strasse`, `kd_plz`, `kd_ort`) VALUES
  (1,'Trapo',NULL,NULL,NULL),
  (2,'Öhlandi',NULL,NULL,NULL),
  (3,'Müller',NULL,NULL,NULL);
COMMIT;

/* Data for the `auftrag` table  (LIMIT 0,500) */

INSERT INTO `auftrag` (`au_id`, `au_kd_id`, `au_auftrag`) VALUES
  (1,1,'AU_00012'),
  (2,1,'Au_00133'),
  (3,3,'Au_01101');
COMMIT;

/* Data for the `fahrer` table  (LIMIT 0,500) */

INSERT INTO `fahrer` (`fa_id`, `fa_name`, `fa_strasse`, `fa_plz`, `fa_ort`) VALUES
  (1,'Petermann',NULL,NULL,NULL),
  (2,'Hansen',NULL,NULL,NULL),
  (3,'Mutzner',NULL,NULL,NULL);
COMMIT;

/* Data for the `fahrten` table  (LIMIT 0,500) */

INSERT INTO `fahrten` (`f_id`, `f_fa_id`, `f_au_id`) VALUES
  (1,1,1),
  (2,1,1),
  (3,1,1),
  (4,2,1),
  (5,3,1),
  (6,3,2),
  (7,3,2);
COMMIT;

/* Data for the `teilstrecke` table  (LIMIT 0,500) */

INSERT INTO `teilstrecke` (`ts_id`, `ts_f_id`, `ts_strecke`) VALUES
  (1,1,400),
  (2,1,122),
  (3,1,4),
  (4,1,55),
  (5,1,89),
  (6,1,233),
  (7,2,121),
  (8,2,44),
  (9,2,66),
  (10,2,322),
  (11,3,850),
  (12,4,333),
  (13,4,560);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;