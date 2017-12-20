/* SQL Manager Lite for MySQL                              5.6.3.49012 */
/* ------------------------------------------------------------------- */
/* Host     : localhost                                                */
/* Port     : 3306                                                     */
/* Database : luna                                                     */


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES 'utf8' */;

SET FOREIGN_KEY_CHECKS=0;

CREATE DATABASE `luna`
    CHARACTER SET 'utf8'
    COLLATE 'utf8_general_ci';

USE `luna`;

/* Struktur für die Tabelle `tblabteilung`:  */

CREATE TABLE `tblabteilung` (
  `A_Nr` VARCHAR(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `A_Name` VARCHAR(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `A_Stadt` VARCHAR(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  PRIMARY KEY USING BTREE (`A_Nr`)
) ENGINE=InnoDB
ROW_FORMAT=DYNAMIC CHARACTER SET 'latin1' COLLATE 'latin1_general_ci'
;

/* Struktur für die Tabelle `tblmitarbeiter`:  */

CREATE TABLE `tblmitarbeiter` (
  `M_Nr` BIGINT(20) NOT NULL DEFAULT 0,
  `A_Nr` VARCHAR(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `M_Name` VARCHAR(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `M_Vorname` VARCHAR(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  PRIMARY KEY USING BTREE (`M_Nr`),
  KEY `IX_arbeitet` USING BTREE (`A_Nr`),
  CONSTRAINT `tblmitarbeiter_ibfk_1` FOREIGN KEY (`A_Nr`) REFERENCES `tblabteilung` (`A_Nr`)
) ENGINE=InnoDB
ROW_FORMAT=DYNAMIC CHARACTER SET 'latin1' COLLATE 'latin1_general_ci'
;

/* Struktur für die Tabelle `tblprojekt`:  */

CREATE TABLE `tblprojekt` (
  `P_Nr` VARCHAR(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `P_Name` VARCHAR(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `P_Mittel` DOUBLE NOT NULL DEFAULT 0,
  PRIMARY KEY USING BTREE (`P_Nr`)
) ENGINE=InnoDB
ROW_FORMAT=DYNAMIC CHARACTER SET 'latin1' COLLATE 'latin1_general_ci'
;

/* Struktur für die Tabelle `tbltaetigkeit`:  */

CREATE TABLE `tbltaetigkeit` (
  `T_Nr` BIGINT(20) NOT NULL DEFAULT 0,
  `M_Nr` BIGINT(20) NOT NULL DEFAULT 0,
  `P_Nr` VARCHAR(50) COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `T_Taetigkeit` VARCHAR(50) COLLATE latin1_general_ci DEFAULT NULL,
  `T_Einstellungsdatum` DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY USING BTREE (`T_Nr`),
  KEY `IX_bearbeitet` USING BTREE (`M_Nr`),
  KEY `IX_fuer` USING BTREE (`P_Nr`),
  CONSTRAINT `tbltaetigkeit_ibfk_1` FOREIGN KEY (`M_Nr`) REFERENCES `tblmitarbeiter` (`M_Nr`),
  CONSTRAINT `tbltaetigkeit_ibfk_2` FOREIGN KEY (`P_Nr`) REFERENCES `tblprojekt` (`P_Nr`)
) ENGINE=InnoDB
ROW_FORMAT=DYNAMIC CHARACTER SET 'latin1' COLLATE 'latin1_general_ci'
;

/* Data for the `tblabteilung` table  (LIMIT 0,500) */

INSERT INTO `tblabteilung` (`A_Nr`, `A_Name`, `A_Stadt`) VALUES
  ('a1','Beratung','München'),
  ('a2','Diagnose','München'),
  ('a3','Freigabe','Stuttgart');
COMMIT;

/* Data for the `tblmitarbeiter` table  (LIMIT 0,500) */

INSERT INTO `tblmitarbeiter` (`M_Nr`, `A_Nr`, `M_Name`, `M_Vorname`) VALUES
  (2581,'a2','Kaufmann','Brigitte'),
  (9031,'a2','Meier','Rainer'),
  (10102,'a3','Huber','Petra'),
  (18316,'a1','Müller','Gabriele'),
  (25384,'a3','Keller','Hans'),
  (28559,'a1','Mozer','Sibille'),
  (29346,'a2','Probst','Andreas');
COMMIT;

/* Data for the `tblprojekt` table  (LIMIT 0,500) */

INSERT INTO `tblprojekt` (`P_Nr`, `P_Name`, `P_Mittel`) VALUES
  ('p1','Apollo',120000),
  ('p2','Gemini',95000),
  ('p3','Merkur',186500);
COMMIT;

/* Data for the `tbltaetigkeit` table  (LIMIT 0,500) */

INSERT INTO `tbltaetigkeit` (`T_Nr`, `M_Nr`, `P_Nr`, `T_Taetigkeit`, `T_Einstellungsdatum`) VALUES
  (1,10102,'p1','Projektleiter','1988-10-01 00:00:00'),
  (2,10102,'p3','Gruppenleiter','1989-01-01 00:00:00'),
  (3,25384,'p2','Sachbearbeiter','1988-02-15 00:00:00'),
  (4,18316,'p2',NULL,'1989-06-01 00:00:00'),
  (5,29346,'p2',NULL,'1987-12-15 00:00:00'),
  (6,2581,'p3','Projektleiter','1989-10-15 00:00:00'),
  (7,9031,'p1','Gruppenleiter','1989-04-15 00:00:00'),
  (8,28559,'p1',NULL,'1988-08-01 00:00:00'),
  (9,28559,'p2','Sachbearbeiter','1989-02-01 00:00:00'),
  (10,9031,'p3','Sachbearbeiter','1988-11-15 00:00:00'),
  (11,29346,'p1','Sachbearbeiter','1989-04-01 00:00:00');
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;