# SQL Manager Lite for MySQL 5.4.3.43929
# ---------------------------------------
# Host     : localhost
# Port     : 3306
# Database : versicherung_complete


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

SET FOREIGN_KEY_CHECKS=0;

CREATE DATABASE `versicherung_complete`
    CHARACTER SET 'utf8'
    COLLATE 'utf8_general_ci';

USE `versicherung_complete`;

#
# Structure for the `abteilung` table : 
#

CREATE TABLE `abteilung` (
  `ID` INTEGER(11) NOT NULL AUTO_INCREMENT,
  `Bezeichnung` VARCHAR(30) COLLATE utf8_general_ci DEFAULT NULL,
  `Ort` VARCHAR(30) COLLATE utf8_general_ci DEFAULT NULL,
  `Kuerzel` CHAR(4) COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY USING BTREE (`ID`) COMMENT ''
)ENGINE=InnoDB
AUTO_INCREMENT=14 AVG_ROW_LENGTH=1260 CHARACTER SET 'utf8' COLLATE 'utf8_general_ci'
COMMENT=''
;

#
# Structure for the `fahrzeughersteller` table : 
#

CREATE TABLE `fahrzeughersteller` (
  `ID` INTEGER(11) NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(30) COLLATE utf8_general_ci NOT NULL,
  `Land` VARCHAR(30) COLLATE utf8_general_ci DEFAULT NULL,
  PRIMARY KEY USING BTREE (`ID`) COMMENT ''
)ENGINE=InnoDB
AUTO_INCREMENT=12 AVG_ROW_LENGTH=1489 CHARACTER SET 'utf8' COLLATE 'utf8_general_ci'
COMMENT=''
;

#
# Structure for the `fahrzeugtyp` table : 
#

CREATE TABLE `fahrzeugtyp` (
  `ID` INTEGER(11) NOT NULL AUTO_INCREMENT,
  `Bezeichnung` VARCHAR(30) COLLATE utf8_general_ci NOT NULL,
  `Hersteller_ID` INTEGER(11) NOT NULL,
  PRIMARY KEY USING BTREE (`ID`) COMMENT '',
   INDEX `Fahrzeugtyp_FK` USING BTREE (`Hersteller_ID`) COMMENT '',
  CONSTRAINT `Fahrzeugtyp_FK` FOREIGN KEY (`Hersteller_ID`) REFERENCES `fahrzeughersteller` (`ID`)
)ENGINE=InnoDB
AUTO_INCREMENT=24 AVG_ROW_LENGTH=712 CHARACTER SET 'utf8' COLLATE 'utf8_general_ci'
COMMENT=''
;

#
# Structure for the `mitarbeiter` table : 
#

CREATE TABLE `mitarbeiter` (
  `ID` INTEGER(11) NOT NULL AUTO_INCREMENT,
  `Personalnummer` VARCHAR(10) COLLATE utf8_general_ci NOT NULL,
  `Name` VARCHAR(30) COLLATE utf8_general_ci NOT NULL,
  `Vorname` VARCHAR(30) COLLATE utf8_general_ci NOT NULL,
  `Geburtsdatum` DATE NOT NULL,
  `Telefon` VARCHAR(30) COLLATE utf8_general_ci DEFAULT NULL,
  `Mobil` VARCHAR(30) COLLATE utf8_general_ci DEFAULT NULL,
  `Email` VARCHAR(50) COLLATE utf8_general_ci DEFAULT NULL,
  `Raum` VARCHAR(10) COLLATE utf8_general_ci DEFAULT NULL,
  `Ist_Leiter` CHAR(1) COLLATE utf8_general_ci NOT NULL DEFAULT 'N',
  `Abteilung_ID` INTEGER(11) NOT NULL,
  `Geschlecht` CHAR(1) COLLATE utf8_general_ci NOT NULL DEFAULT 'W',
  PRIMARY KEY USING BTREE (`ID`) COMMENT '',
   INDEX `Mitarbeiter_Name` USING BTREE (`Name`, `Vorname`) COMMENT '',
   INDEX `Mitarbeiter_FK` USING BTREE (`Abteilung_ID`) COMMENT '',
  CONSTRAINT `Mitarbeiter_FK` FOREIGN KEY (`Abteilung_ID`) REFERENCES `abteilung` (`ID`)
)ENGINE=InnoDB
AUTO_INCREMENT=29 AVG_ROW_LENGTH=585 CHARACTER SET 'utf8' COLLATE 'utf8_general_ci'
COMMENT=''
;

#
# Structure for the `dienstwagen` table : 
#

CREATE TABLE `dienstwagen` (
  `ID` INTEGER(11) NOT NULL AUTO_INCREMENT,
  `Kennzeichen` VARCHAR(10) COLLATE utf8_general_ci NOT NULL,
  `Farbe` VARCHAR(30) COLLATE utf8_general_ci DEFAULT NULL,
  `Fahrzeugtyp_ID` INTEGER(11) NOT NULL,
  `Mitarbeiter_ID` INTEGER(11) DEFAULT NULL,
  PRIMARY KEY USING BTREE (`ID`) COMMENT '',
   INDEX `Dienstwagen_FZ` USING BTREE (`Fahrzeugtyp_ID`) COMMENT '',
   INDEX `Dienstwagen_MI` USING BTREE (`Mitarbeiter_ID`) COMMENT '',
  CONSTRAINT `Dienstwagen_FZ` FOREIGN KEY (`Fahrzeugtyp_ID`) REFERENCES `fahrzeugtyp` (`ID`),
  CONSTRAINT `Dienstwagen_MI` FOREIGN KEY (`Mitarbeiter_ID`) REFERENCES `mitarbeiter` (`ID`)
)ENGINE=InnoDB
AUTO_INCREMENT=23 AVG_ROW_LENGTH=862 CHARACTER SET 'utf8' COLLATE 'utf8_general_ci'
COMMENT=''
;

#
# Structure for the `fahrzeug` table : 
#

CREATE TABLE `fahrzeug` (
  `ID` INTEGER(11) NOT NULL AUTO_INCREMENT,
  `Kennzeichen` VARCHAR(10) COLLATE utf8_general_ci NOT NULL,
  `Farbe` VARCHAR(30) COLLATE utf8_general_ci DEFAULT NULL,
  `Fahrzeugtyp_ID` INTEGER(11) NOT NULL,
  PRIMARY KEY USING BTREE (`ID`) COMMENT '',
   INDEX `Fahrzeug_FK` USING BTREE (`Fahrzeugtyp_ID`) COMMENT '',
  CONSTRAINT `Fahrzeug_FK` FOREIGN KEY (`Fahrzeugtyp_ID`) REFERENCES `fahrzeugtyp` (`ID`)
)ENGINE=InnoDB
AUTO_INCREMENT=26 AVG_ROW_LENGTH=655 CHARACTER SET 'utf8' COLLATE 'utf8_general_ci'
COMMENT=''
;

#
# Structure for the `schadensfall` table : 
#

CREATE TABLE `schadensfall` (
  `ID` INTEGER(11) NOT NULL AUTO_INCREMENT,
  `Datum` DATE NOT NULL,
  `Ort` VARCHAR(200) COLLATE utf8_general_ci NOT NULL,
  `Beschreibung` VARCHAR(1000) COLLATE utf8_general_ci NOT NULL,
  `Schadenshoehe` DECIMAL(16,2) DEFAULT NULL,
  `Verletzte` CHAR(1) COLLATE utf8_general_ci NOT NULL,
  `Mitarbeiter_ID` INTEGER(11) NOT NULL,
  PRIMARY KEY USING BTREE (`ID`) COMMENT '',
   INDEX `Schadensfall_Datum` USING BTREE (`Datum`) COMMENT '',
   INDEX `Schadensfall_FK` USING BTREE (`Mitarbeiter_ID`) COMMENT '',
  CONSTRAINT `Schadensfall_FK` FOREIGN KEY (`Mitarbeiter_ID`) REFERENCES `mitarbeiter` (`ID`)
)ENGINE=InnoDB
AUTO_INCREMENT=9 AVG_ROW_LENGTH=2048 CHARACTER SET 'utf8' COLLATE 'utf8_general_ci'
COMMENT=''
;

#
# Structure for the `tempname` table : 
#

CREATE TABLE `tempname` (
  `text` VARCHAR(30) COLLATE utf8_general_ci DEFAULT NULL
)ENGINE=InnoDB
AVG_ROW_LENGTH=819 CHARACTER SET 'utf8' COLLATE 'utf8_general_ci'
COMMENT=''
;

#
# Structure for the `tempplzort` table : 
#

CREATE TABLE `tempplzort` (
  `PLZ` CHAR(5) COLLATE utf8_general_ci DEFAULT NULL,
  `Ort` VARCHAR(24) COLLATE utf8_general_ci DEFAULT NULL,
  `Kreis` VARCHAR(3) COLLATE utf8_general_ci DEFAULT NULL
)ENGINE=InnoDB
AVG_ROW_LENGTH=528 CHARACTER SET 'utf8' COLLATE 'utf8_general_ci'
COMMENT=''
;

#
# Structure for the `tempstrasse` table : 
#

CREATE TABLE `tempstrasse` (
  `Name` VARCHAR(24) COLLATE utf8_general_ci DEFAULT NULL
)ENGINE=InnoDB
AVG_ROW_LENGTH=744 CHARACTER SET 'utf8' COLLATE 'utf8_general_ci'
COMMENT=''
;

#
# Structure for the `tempvertrag` table : 
#

CREATE TABLE `tempvertrag` (
  `NR` INTEGER(11) DEFAULT NULL,
  `FZ_ID` INTEGER(11) DEFAULT NULL,
  `FZ_KENNZEICHEN` VARCHAR(10) COLLATE utf8_general_ci DEFAULT NULL,
  `FZ_KREIS` VARCHAR(3) COLLATE utf8_general_ci DEFAULT NULL,
  `VN_ID` INTEGER(11) DEFAULT NULL,
  `VN_NAME` CHAR(2) COLLATE utf8_general_ci DEFAULT NULL,
  `ABSCHLUSSDATUM` DATE DEFAULT NULL,
  `tempvertrag_field1` VARCHAR(0) COLLATE utf8_general_ci DEFAULT NULL
)ENGINE=InnoDB
CHARACTER SET 'utf8' COLLATE 'utf8_general_ci'
COMMENT=''
;

#
# Structure for the `tempvorname` table : 
#

CREATE TABLE `tempvorname` (
  `text` VARCHAR(30) COLLATE utf8_general_ci DEFAULT NULL,
  `Geschlecht` CHAR(1) COLLATE utf8_general_ci DEFAULT 'W'
)ENGINE=InnoDB
AVG_ROW_LENGTH=819 CHARACTER SET 'utf8' COLLATE 'utf8_general_ci'
COMMENT=''
;

#
# Structure for the `versicherungsgesellschaft` table : 
#

CREATE TABLE `versicherungsgesellschaft` (
  `ID` INTEGER(11) NOT NULL AUTO_INCREMENT,
  `Bezeichnung` VARCHAR(30) COLLATE utf8_general_ci NOT NULL,
  `Ort` VARCHAR(30) COLLATE utf8_general_ci DEFAULT NULL,
  PRIMARY KEY USING BTREE (`ID`) COMMENT ''
)ENGINE=InnoDB
AUTO_INCREMENT=6 AVG_ROW_LENGTH=3276 CHARACTER SET 'utf8' COLLATE 'utf8_general_ci'
COMMENT=''
;

#
# Structure for the `versicherungsnehmer` table : 
#

CREATE TABLE `versicherungsnehmer` (
  `ID` INTEGER(11) NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(30) COLLATE utf8_general_ci NOT NULL,
  `Vorname` VARCHAR(30) COLLATE utf8_general_ci DEFAULT NULL,
  `Geburtsdatum` DATE DEFAULT NULL,
  `Fuehrerschein` DATE DEFAULT NULL,
  `Ort` VARCHAR(30) COLLATE utf8_general_ci NOT NULL,
  `PLZ` CHAR(5) COLLATE utf8_general_ci NOT NULL,
  `Strasse` VARCHAR(30) COLLATE utf8_general_ci NOT NULL,
  `Hausnummer` VARCHAR(10) COLLATE utf8_general_ci NOT NULL,
  `Eigener_Kunde` CHAR(1) COLLATE utf8_general_ci NOT NULL,
  `Versicherungsgesellschaft_ID` INTEGER(11) DEFAULT NULL,
  `Geschlecht` CHAR(1) COLLATE utf8_general_ci DEFAULT NULL,
  PRIMARY KEY USING BTREE (`ID`) COMMENT '',
   INDEX `Versicherungsnehmer_Name` USING BTREE (`Name`, `Vorname`) COMMENT '',
   INDEX `Versicherungsnehmer_PLZ` USING BTREE (`PLZ`, `Ort`) COMMENT ''
)ENGINE=InnoDB
AUTO_INCREMENT=135 AVG_ROW_LENGTH=682 CHARACTER SET 'utf8' COLLATE 'utf8_general_ci'
COMMENT=''
;

#
# Structure for the `versicherungsvertrag` table : 
#

CREATE TABLE `versicherungsvertrag` (
  `ID` INTEGER(11) NOT NULL AUTO_INCREMENT,
  `Vertragsnummer` VARCHAR(20) COLLATE utf8_general_ci NOT NULL,
  `Abschlussdatum` DATE NOT NULL,
  `Art` CHAR(2) COLLATE utf8_general_ci NOT NULL,
  `Mitarbeiter_ID` INTEGER(11) NOT NULL,
  `Fahrzeug_ID` INTEGER(11) NOT NULL,
  `Versicherungsnehmer_ID` INTEGER(11) NOT NULL,
  `Basispraemie` DECIMAL(10,0) NOT NULL DEFAULT 500,
  `Praemiensatz` INTEGER(11) NOT NULL DEFAULT 100,
  `Praemienaenderung` DATE DEFAULT NULL,
  PRIMARY KEY USING BTREE (`ID`) COMMENT '',
   INDEX `Versicherungsvertrag_Datum` USING BTREE (`Abschlussdatum`) COMMENT '',
   INDEX `Versicherungsvertrag_MI` USING BTREE (`Mitarbeiter_ID`) COMMENT '',
   INDEX `Versicherungsvertrag_FZ` USING BTREE (`Fahrzeug_ID`) COMMENT '',
   INDEX `Versicherungsvertrag_VN` USING BTREE (`Versicherungsnehmer_ID`) COMMENT '',
  CONSTRAINT `Versicherungsvertrag_FZ` FOREIGN KEY (`Fahrzeug_ID`) REFERENCES `fahrzeug` (`ID`),
  CONSTRAINT `Versicherungsvertrag_MI` FOREIGN KEY (`Mitarbeiter_ID`) REFERENCES `mitarbeiter` (`ID`),
  CONSTRAINT `Versicherungsvertrag_VN` FOREIGN KEY (`Versicherungsnehmer_ID`) REFERENCES `versicherungsnehmer` (`ID`)
)ENGINE=InnoDB
AUTO_INCREMENT=26 AVG_ROW_LENGTH=655 CHARACTER SET 'utf8' COLLATE 'utf8_general_ci'
COMMENT=''
;

#
# Structure for the `zuordnung_sf_fz` table : 
#

CREATE TABLE `zuordnung_sf_fz` (
  `ID` INTEGER(11) NOT NULL AUTO_INCREMENT,
  `Schadensfall_ID` INTEGER(11) NOT NULL,
  `Fahrzeug_ID` INTEGER(11) NOT NULL,
  `Schadenshoehe` DECIMAL(16,2) DEFAULT NULL,
  `Schuldanteil` INTEGER(11) DEFAULT NULL,
  PRIMARY KEY USING BTREE (`ID`) COMMENT '',
   INDEX `Zuordnung_SF_FK` USING BTREE (`Schadensfall_ID`) COMMENT '',
   INDEX `Zuordnung_FZ_FK` USING BTREE (`Fahrzeug_ID`) COMMENT '',
  CONSTRAINT `Zuordnung_FZ_FK` FOREIGN KEY (`Fahrzeug_ID`) REFERENCES `fahrzeug` (`ID`),
  CONSTRAINT `Zuordnung_SF_FK` FOREIGN KEY (`Schadensfall_ID`) REFERENCES `schadensfall` (`ID`)
)ENGINE=InnoDB
AUTO_INCREMENT=14 AVG_ROW_LENGTH=1260 CHARACTER SET 'utf8' COLLATE 'utf8_general_ci'
COMMENT=''
;

#
# Definition for the `fahrzeugart` view : 
#

CREATE ALGORITHM=UNDEFINED DEFINER='root'@'localhost' SQL SECURITY DEFINER VIEW `fahrzeugart`
AS
select 
    `ft`.`ID` AS `Nummer`,
    `ft`.`Bezeichnung` AS `Name`,
    `fh`.`Name` AS `Hersteller`,
    `fh`.`Land` AS `Land` 
  from 
    (`fahrzeugtyp` `ft` join `fahrzeughersteller` `fh` on((`ft`.`Hersteller_ID` = `fh`.`ID`)));

#
# Definition for the `fahrzeugart2` view : 
#

CREATE ALGORITHM=UNDEFINED DEFINER='root'@'localhost' SQL SECURITY DEFINER VIEW `fahrzeugart2`
AS
select 
    `ft`.`ID` AS `Nummer`,
    `ft`.`Bezeichnung` AS `Name`,
    `fh`.`Name` AS `Hersteller`,
    `fh`.`Land` AS `Land` 
  from 
    (`fahrzeugtyp` `ft` join `fahrzeughersteller` `fh` on((`ft`.`Hersteller_ID` = `fh`.`ID`)));

#
# Definition for the `fahrzeugart3` view : 
#

CREATE ALGORITHM=UNDEFINED DEFINER='root'@'localhost' SQL SECURITY DEFINER VIEW `fahrzeugart3`
AS
select 
    `ft`.`ID` AS `Nummer`,
    `ft`.`Bezeichnung` AS `Name`,
    `fh`.`Name` AS `Hersteller`,
    `fh`.`Land` AS `Land` 
  from 
    (`fahrzeugtyp` `ft` join `fahrzeughersteller` `fh` on((`ft`.`Hersteller_ID` = `fh`.`ID`)));

#
# Definition for the `fahrzeugart4` view : 
#

CREATE ALGORITHM=UNDEFINED DEFINER='root'@'localhost' SQL SECURITY DEFINER VIEW `fahrzeugart4`
AS
select 
    `ft`.`ID` AS `Nummer`,
    `ft`.`Bezeichnung` AS `Name`,
    `fh`.`Name` AS `Hersteller`,
    `fh`.`Land` AS `Land` 
  from 
    (`fahrzeugtyp` `ft` join `fahrzeughersteller` `fh` on((`ft`.`Hersteller_ID` = `fh`.`ID`))) 
  order by 
    `ft`.`Bezeichnung`;

#
# Definition for the `fahrzeugart5` view : 
#

CREATE ALGORITHM=UNDEFINED DEFINER='root'@'localhost' SQL SECURITY DEFINER VIEW `fahrzeugart5`
AS
select 
    `ft`.`ID` AS `Nummer`,
    `ft`.`Bezeichnung` AS `Blub`,
    `fh`.`Name` AS `AName`,
    `fh`.`Land` AS `Country` 
  from 
    (`fahrzeugtyp` `ft` join `fahrzeughersteller` `fh` on((`ft`.`Hersteller_ID` = `fh`.`ID`))) 
  order by 
    `ft`.`Bezeichnung`;

#
# Data for the `abteilung` table  (LIMIT -486,500)
#

INSERT INTO `abteilung` (`ID`, `Bezeichnung`, `Ort`, `Kuerzel`) VALUES

  (1,'Finanzbuchhaltung','Dortmund','Fibu'),
  (2,'Anlagenbuchhaltung','Dortmund','Albu'),
  (3,'Kostenrechnung','Dortmund','Kore'),
  (4,'Kostenplanung','Dortmund','Kopl'),
  (5,'Vertrieb','Essen','Vert'),
  (6,'Lagerhaltung','Bochum','Lagh'),
  (7,'Produktion','Bochum','Prod'),
  (8,'Schadensabwicklung','Essen','ScAb'),
  (9,'Personalverwaltung','Essen','Pers'),
  (10,'Sozialverwaltung','Essen','Soz'),
  (11,'Ausbildung','Herne','Ausb'),
  (12,'Forschung und Entwicklung','Bochum','Fue'),
  (13,NULL,'Bochum','bla');
COMMIT;

#
# Data for the `fahrzeughersteller` table  (LIMIT -488,500)
#

INSERT INTO `fahrzeughersteller` (`ID`, `Name`, `Land`) VALUES

  (1,'Volkswagen','Deutschland'),
  (2,'Opel','Deutschland'),
  (3,'Ford','Deutschland'),
  (4,'BMW','Deutschland'),
  (5,'Audi','Deutschland'),
  (6,'Mercedes-Benz','Deutschland'),
  (7,'Sachsenring','Deutschland'),
  (8,'Saab','Schweden'),
  (9,'Volvo',NULL),
  (10,'Renault','Frankreich'),
  (11,'Seat','');
COMMIT;

#
# Data for the `fahrzeugtyp` table  (LIMIT -476,500)
#

INSERT INTO `fahrzeugtyp` (`ID`, `Bezeichnung`, `Hersteller_ID`) VALUES

  (1,'Polo',1),
  (2,'Golf',1),
  (3,'Passat',1),
  (4,'Kadett',2),
  (5,'Corsa',2),
  (6,'Focus',3),
  (7,'Trabant',7),
  (8,'Fiesta',3),
  (9,'Sandero',4),
  (10,'Logan',4),
  (11,'Z3',4),
  (12,'A3',5),
  (13,'A4',5),
  (14,'A160',6),
  (15,'W204 (C-Klasse)',6),
  (16,'W211 (E-Klasse)',6),
  (17,'Saab 9-3',8),
  (18,'S40',9),
  (19,'C30',9),
  (20,'Clio',10),
  (21,'Twingo',10),
  (22,'Ibiza',11),
  (23,'Leon',11);
COMMIT;

#
# Data for the `mitarbeiter` table  (LIMIT -471,500)
#

INSERT INTO `mitarbeiter` (`ID`, `Personalnummer`, `Name`, `Vorname`, `Geburtsdatum`, `Telefon`, `Mobil`, `Email`, `Raum`, `Ist_Leiter`, `Abteilung_ID`, `Geschlecht`) VALUES

  (1,'10001','Müller','Kurt','1977-01-05','0231/5554987','','kurt.mueller@unserefirma.de','112','J',1,'M'),
  (2,'10002','Schneider','Daniela','1980-02-16','0231/5554988',NULL,'daniela.schneider@unserefirma.de','113','N',1,'W'),
  (3,'20001','Meyer','Walter','1963-07-02','0231/5553967','','walter.meyer@unserefirma.de','212','J',2,'M'),
  (4,'20002','Schmitz','Michael','1959-08-25','0231/5556187',NULL,'michael.schmitz@unserefirma.de','212','N',2,'M'),
  (5,'30001','Wagner','Gaby','1970-01-18','0231/5554787','','gaby.wagner@unserefirma.de','312','J',3,'W'),
  (6,'30002','Feyerabend','Werner','1982-04-01','0231/5554997',NULL,'werner.feyerabend@unserefirma.de','316','N',3,'M'),
  (7,'40001','Langmann','Matthias','1976-03-28','0231/5551927','','matthias.langmann@unserefirma.de','412','J',4,'M'),
  (8,'40002','Peters','Michael','1973-11-15','0231/5554237',NULL,'michael.peters@unserefirma.de','412','N',4,'M'),
  (9,'50001','Pohl','Helmut','1980-10-27','0201/4014186','(0171) 4123456','helmut.pohl@unserefirma.de','152','J',5,'M'),
  (10,'50002','Braun','Christian','1966-09-05','0201/4014726','(0170) 8351647','christian.braun@unserefirma.de','153','N',5,'M'),
  (11,'50003','Polovic','Frantisek','1961-11-26','0201/4014727','(0161) 5124793','frantisek.polovic@unserefirma.de','154','N',5,'M'),
  (12,'50004','Kalman','Aydin','1976-12-17','0201/4014728','(0161) 4486319','aydin.kalman@unserefirma.de','155','N',5,'M'),
  (13,'60001','Aagenau','Karolin','1950-01-02','0234/66006001','','Karolin.Aagenau@unserefirma.de','48','J',6,'W'),
  (14,'60002','Pinkart','Petra','1953-03-04','0234/66006002',NULL,'Petra.Pinkart@unserefirma.de','43','N',6,'W'),
  (15,'70001','Olschewski','Pjotr','1956-05-06','0234/66007001','','Pjotr.Olschewski@unserefirma.de','28','J',7,'M'),
  (16,'70002','Nordmann','Jörg','1959-07-08','0234/66007002',NULL,'Joerg.Nordmann@unserefirma.de','27','N',7,'M'),
  (17,'80001','Schindler','Christina','1962-09-10','0201/4012151','(0173) 7513901','Christina.Schindler@unserefirma.de','101','J',8,'W'),
  (18,'80002','Aliman','Zafer','1965-11-12','0201/4012161','(0171) 9416755','Zafer.Aliman@unserefirma.de','102','N',8,'M'),
  (19,'80003','Langer','Norbert','1968-01-13','0201/4012171','(0162) 1357902','Norbert.Langer@unserefirma.de','103','N',8,'M'),
  (20,'80004','Kolic','Ivana','1971-02-14','0201/4012181','(0172) 4680135','Ivana.Kolic@unserefirma.de','104','N',8,'W'),
  (21,'90001','Janssen','Bernhard','1974-03-15','0201/4013111','','Bernhard.Janssen@unserefirma.de','201','J',9,'M'),
  (22,'90002','Hinkel','Martina','1977-04-16','0201/4013110',NULL,'Martina.Hinkel@unserefirma.de','203','N',9,'W'),
  (23,'100001','Grosser','Horst','1980-05-17','0201/4013344','','Horst.Grosser@unserefirma.de','271','J',10,'M'),
  (24,'100002','Friedrichsen','Angelina','1983-06-20','0201/4013345',NULL,'Angelina.Friedrichsen@unserefirma.de','273','N',10,'W'),
  (25,'110001','Eggert','Louis','1986-07-23','02323/381456','fghgfhfgh','Louis.Eggert@unserefirma.de','14','J',11,'M'),
  (26,'110002','Deiters','Gisela','1989-08-26','02323/381457',NULL,'Gisela.Deiters@unserefirma.de','18','N',11,'W'),
  (27,'120001','Carlsen','Zacharias','1965-09-29','0234/66012001','','Zacharias.Carlsen@unserefirma.de','61','J',12,'M'),
  (28,'120002','Baber','Yvonne','1957-10-02','0234/66012002',NULL,'Yvonne.Baber@unserefirma.de','62','N',12,'W');
COMMIT;

#
# Data for the `dienstwagen` table  (LIMIT -480,500)
#

INSERT INTO `dienstwagen` (`ID`, `Kennzeichen`, `Farbe`, `Fahrzeugtyp_ID`, `Mitarbeiter_ID`) VALUES

  (1,'DO-WB 421','elfenbein',14,1),
  (2,'DO-WB 422','elfenbein',14,3),
  (3,'DO-WB 423','elfenbein',14,5),
  (4,'DO-WB 424','elfenbein',14,7),
  (5,'DO-WB 425','elfenbein',14,9),
  (6,'DO-WB 426','elfenbein',14,13),
  (7,'DO-WB 427','elfenbein',14,15),
  (8,'DO-WB 428','elfenbein',14,17),
  (9,'DO-WB 429','elfenbein',14,21),
  (10,'DO-WB 4210','elfenbein',14,23),
  (11,'DO-WB 4211','elfenbein',14,NULL),
  (12,'DO-WB 4212','elfenbein',14,27),
  (16,'DO-WB 111','elfenbein',16,NULL),
  (17,'DO-WB 352','gelb',2,10),
  (18,'DO-WB 353','gelb',3,11),
  (19,'DO-WB 354','gelb',4,12),
  (20,'DO-WB 382','gelb',2,18),
  (21,'DO-WB 383','gelb',3,19),
  (22,'DO-WB 384','gelb',4,20);
COMMIT;

#
# Data for the `fahrzeug` table  (LIMIT -474,500)
#

INSERT INTO `fahrzeug` (`ID`, `Kennzeichen`, `Farbe`, `Fahrzeugtyp_ID`) VALUES

  (1,'RE-LM 901','ocker',5),
  (2,'RE-LM 902','ocker',5),
  (3,'RE-LM 903','ocker',5),
  (4,'GE-AB 123','schwarz',22),
  (5,'RE-CD 456','ocker',21),
  (6,'HER-EF 789','gelb',20),
  (7,'BO-GH 102','rot',19),
  (8,'E-IJ 345','bordeaux',18),
  (9,'BO-KL 678','blau',17),
  (10,'RE-MN 901','elfenbein',16),
  (11,'RE-OP 234','ocker',15),
  (12,'RE-QR 567','gelb',14),
  (13,'RE-ST 890','rot',13),
  (14,'RE-UV 135','bordeaux',12),
  (15,'RE-WX 791','ocker',11),
  (16,'RE-YZ 369','rot',10),
  (17,'GE-AC 246','elfenbein',9),
  (18,'GE-EG 892','blau',8),
  (19,'OB-FH 470','elfenbein',7),
  (20,'BOT-KI 357','rot',6),
  (21,'BOR-NO 234','gelb',4),
  (22,'BOR-PQ 567','elfenbein',3),
  (23,'BOR-RS 890','gelb',2),
  (24,'K-XR 147',NULL,6),
  (25,'HH-MM 783','schwarz',7);
COMMIT;

#
# Data for the `schadensfall` table  (LIMIT -491,500)
#

INSERT INTO `schadensfall` (`ID`, `Datum`, `Ort`, `Beschreibung`, `Schadenshoehe`, `Verletzte`, `Mitarbeiter_ID`) VALUES

  (1,'2007-02-03','Recklinghausen, Bergknappenstr. 144','Gartenzaun gestreift',1234.50,'N',14),
  (2,'2007-07-11','Haltern, Hauptstr. 46','beim Ausparken hat BO-GH 102 die Vorfahrt von RE-CD 456 missachtet',2066.00,'N',15),
  (3,'2007-12-19','Marl, Rathausstr./Halterner Allee','beim Abbiegen nach links hat ein fremder Wagen die Vorfahrt missachtet',3715.60,'N',14),
  (4,'2008-05-27','Recklinghausen, Südgrabenstr. 23','Fremdes parkendes Auto gestreift',1438.75,'N',16),
  (5,'2008-10-05','Dorsten, Oberhausener Str. 18','beim Ausparken hat ein fremder Wagen die Vorfahrt missachtet',1983.00,'N',14),
  (6,'2009-03-13','Marl, Rathausstr./Halterner Allee','beim Abbiegen nach links hat ein fremder Wagen die Vorfahrt missachtet',4092.15,'J',15),
  (7,'2009-08-21','Recklinghausen, Bergknappenstr. 144','Laternenpfahl umgefahren',865.00,'N',14),
  (8,'2009-08-01','L318 Hamm-Flaesheim','Wildunfall mit Reh; 10% Wertverlust',2471.50,'N',16);
COMMIT;

#
# Data for the `tempname` table  (LIMIT -479,500)
#

INSERT INTO `tempname` (`text`) VALUES

  ('Babel'),
  ('Broszat'),
  ('Heenemann'),
  ('Frese'),
  ('Dittmann'),
  ('Kaynak'),
  ('Ludewig'),
  ('Remmele'),
  ('Schmidt'),
  ('Meier'),
  ('Ullrich'),
  ('Wichert'),
  ('Antonius'),
  ('Zachert'),
  ('Christensen'),
  ('Virck'),
  ('Eisenmann'),
  ('Trakan'),
  ('Grossert'),
  ('Paulsen');
COMMIT;

#
# Data for the `tempplzort` table  (LIMIT -468,500)
#

INSERT INTO `tempplzort` (`PLZ`, `Ort`, `Kreis`) VALUES

  ('44135','Dortmund','DO'),
  ('44289','Dortmund','DO'),
  ('44575','Castrop-Rauxel','RE'),
  ('44625','Herne','HER'),
  ('44649','Herne','HER'),
  ('44801','Bochum','BO'),
  ('44892','Bochum','BO'),
  ('45127','Essen','E'),
  ('45276','Essen','E'),
  ('45277','Essen','E'),
  ('45525','Hattingen','BO'),
  ('45657','Recklinghausen','RE'),
  ('45699','Herten','RE'),
  ('45721','Haltern am See','RE'),
  ('45768','Marl','RE'),
  ('45879','Gelsenkirchen','GE'),
  ('45889','Gelsenkirchen','GE'),
  ('45964','Gladbeck','RE'),
  ('46045','Oberhausen','OB'),
  ('46117','Oberhausen','OB'),
  ('46236','Bottrop','BOT'),
  ('46244','Bottrop','BOT'),
  ('46325','Borken','BOR'),
  ('46342','Velen','BOR'),
  ('46395','Bocholt','BOR'),
  ('47119','Duisburg','DU'),
  ('47137','Duisburg','DU'),
  ('58313','Herdecke','EN'),
  ('58332','Schwelm','EN'),
  ('59069','Hamm','HAM'),
  ('59071','Hamm','HAM');
COMMIT;

#
# Data for the `tempstrasse` table  (LIMIT -477,500)
#

INSERT INTO `tempstrasse` (`Name`) VALUES

  ('Goethestr.'),
  ('Schillerstr.'),
  ('Lessingstr.'),
  ('Badstr.'),
  ('Turmstr.'),
  ('Chausseestr.'),
  ('Elisenstr.'),
  ('Poststr.'),
  ('Hafenstr.'),
  ('Seestr.'),
  ('Neue Str.'),
  ('Münchener Str.'),
  ('Wiener Str.'),
  ('Berliner Str.'),
  ('Museumsstr.'),
  ('Theaterstr.'),
  ('Opernplatz'),
  ('Rathausplatz'),
  ('Bahnhofstr.'),
  ('Hauptstr.'),
  ('Parkstr.'),
  ('Schlossallee');
COMMIT;

#
# Data for the `tempvorname` table  (LIMIT -479,500)
#

INSERT INTO `tempvorname` (`text`, `Geschlecht`) VALUES

  ('Maria','W'),
  ('Teresa','W'),
  ('Christine','W'),
  ('Emily','W'),
  ('Gudrun','W'),
  ('Shirin','W'),
  ('Petra','W'),
  ('Yasemin','W'),
  ('Susanna','W'),
  ('Alexandra','W'),
  ('Justus','M'),
  ('Biral','M'),
  ('Detlef','M'),
  ('Frantisek','M'),
  ('Siegmund','M'),
  ('Zacharias','M'),
  ('Wolfgang','M'),
  ('Marcus','M'),
  ('Recep','M'),
  ('Konstantin','M');
COMMIT;

#
# Data for the `versicherungsgesellschaft` table  (LIMIT -494,500)
#

INSERT INTO `versicherungsgesellschaft` (`ID`, `Bezeichnung`, `Ort`) VALUES

  (1,'Deutsches Kontor','Frankfurt a.M.'),
  (2,'Rheinischer Vers.-Verein','Oberhausen'),
  (3,'Knappschaftshilfe','Essen'),
  (4,'Hannoversche Gesellschaft','Lehrte'),
  (5,'Westfalen-Bruderhilfe','Recklinghausen');
COMMIT;

#
# Data for the `versicherungsnehmer` table  (LIMIT -475,500)
#

INSERT INTO `versicherungsnehmer` (`ID`, `Name`, `Vorname`, `Geburtsdatum`, `Fuehrerschein`, `Ort`, `PLZ`, `Strasse`, `Hausnummer`, `Eigener_Kunde`, `Versicherungsgesellschaft_ID`, `Geschlecht`) VALUES

  (1,'Heckel Obsthandel GmbH','',NULL,NULL,'Dorsten','46282','Gahlener Str.','40','J',NULL,NULL),
  (2,'Antonius','Bernhard','1950-02-01','1972-04-03','Gelsenkirchen','45892','Coesfelder Str.','23','J',NULL,'M'),
  (3,'Cornelsen','Dorothea','1951-06-05','1974-08-07','Castrop-Rauxel','44577','Kiefernweg','9','J',NULL,NULL),
  (4,'Elberfeld','Fritz','1952-10-09','1976-12-11','Herne','44625','Haberstr.','13','J',NULL,'M'),
  (5,'Geissler','Helga','1953-01-13','1978-02-14','Bochum','44809','Steinbankstr.','15','J',NULL,NULL),
  (6,'Westermann','Yvonne','1961-08-07','1994-10-09','Oer-Erkenschwick','45739','Ackerstr.','34','J',NULL,'M'),
  (7,'Karlovich','Liane','1955-05-19','1982-06-20','Hattingen','45525','Raabestr.','21','J',NULL,NULL),
  (8,'Meier','Norbert','1956-07-22','1984-08-23','Recklinghausen','45665','Idastr.','24','J',NULL,'M'),
  (9,'Ottensen','Petra','1957-09-25','1986-10-26','Herten','45699','Gablonzer Weg','27','J',NULL,NULL),
  (10,'Quantz','Reinhard','1958-11-28','1988-01-29','Datteln','45711','Halterner Allee','30','J',NULL,'M'),
  (11,'Schiller','Theresia','1959-03-31','1990-02-01','Haltern','45721','Am Freibad','32','J',NULL,NULL),
  (12,'Untermann','Volker','1960-04-02','1992-06-05','Waltrop','45731','Goethestr.','33','J',NULL,'M'),
  (13,'Westermann','Yvonne','1961-08-07','1994-10-09','Oer-Erkenschwick','45739','Ackerstr.','34','J',NULL,NULL),
  (14,'Xanh','Wu Dao','1962-12-11','1996-01-13','Marl','45772','Bachackerweg','35','J',NULL,'M'),
  (15,'Zenep','Altun','1963-02-14','1998-03-15','Gelsenkirchen','45888','Cheruskerstr.','36','J',NULL,'M'),
  (16,'Bronkovic','Cecilia','1964-04-16','2000-05-17','Gladbeck','45966','Dechenstr.','37','J',NULL,NULL),
  (17,'Deutschmann','Evelyn','1965-06-18','2002-07-19','Oberhausen','46147','Ebereschenweg','38','J',NULL,NULL),
  (18,'Friedrichsen','Gustav','1966-08-20','2004-09-21','Bottrop','46244','Falkenweg','39','J',1,'M'),
  (19,'Jaspers','Karol','1968-12-24','2008-01-25','Borken','46325','Heimser Weg','1','J',2,'M'),
  (20,'Liebermann','Maria','1970-02-26','1988-03-27','Velen','46342','Inselstr.','4','J',4,NULL),
  (21,'Netep','Osman','1971-05-28','1990-06-29','Raesfeld','46348','Juister Str.','7','J',4,'M'),
  (22,'Chwielorz','Kathrin','1981-08-18','2002-12-15','Köln','50173','Gartenfelder Str.','23','N',3,NULL),
  (23,'Schwichting','Eberhard','1985-06-27','2003-08-08','Hamburg','20444','Harvestehuder Weg','23 a','N',2,NULL),
  (134,'Steinam','Kurt','1899-12-28',NULL,'TBB','97941','Gdggdf','1','J',NULL,NULL);
COMMIT;

#
# Data for the `versicherungsvertrag` table  (LIMIT -474,500)
#

INSERT INTO `versicherungsvertrag` (`ID`, `Vertragsnummer`, `Abschlussdatum`, `Art`, `Mitarbeiter_ID`, `Fahrzeug_ID`, `Versicherungsnehmer_ID`, `Basispraemie`, `Praemiensatz`, `Praemienaenderung`) VALUES

  (1,'DG-01','1974-05-03','TK',9,1,1,550,100,NULL),
  (2,'DG-02','1974-05-03','TK',9,2,1,550,100,NULL),
  (3,'DG-03','1974-05-03','TK',9,3,1,550,100,NULL),
  (4,'DH-02','1990-02-01','HP',10,12,10,500,100,NULL),
  (5,'DO-03','1994-10-09','HP',9,14,12,500,100,NULL),
  (6,'DB-04','2008-01-25','HP',9,21,19,500,100,NULL),
  (7,'RH-01','1976-12-11','VK',10,5,3,800,100,NULL),
  (8,'RD-02','1988-01-29','HP',9,11,9,500,100,NULL),
  (9,'RM-03','1996-01-13','HP',9,15,13,500,100,NULL),
  (10,'RD-04','2006-11-23','HP',9,20,18,500,100,NULL),
  (11,'RR-05','1990-06-29','TK',9,23,21,550,100,NULL),
  (12,'KB-01','1978-02-14','TK',10,6,4,550,100,NULL),
  (13,'KH-02','1986-10-26','HP',9,10,8,500,100,NULL),
  (14,'KG-03','1998-03-15','HP',9,16,14,500,100,NULL),
  (15,'KV-04','1988-03-27','HP',10,22,20,500,100,NULL),
  (16,'HE-01','1980-04-17','HP',10,7,5,500,100,NULL),
  (17,'HR-02','1984-08-23','HP',9,9,7,500,100,NULL),
  (18,'HG-03','2000-05-17','HP',9,17,15,500,100,NULL),
  (19,'HB-04','2004-09-21','HP',9,19,17,500,100,NULL),
  (20,'XC-01','1974-08-07','HP',10,4,2,500,100,NULL),
  (21,'XH-02','1982-06-20','VK',9,8,6,800,100,NULL),
  (22,'XW-03','1992-06-05','VK',10,13,11,800,100,NULL),
  (23,'XO-04','2002-07-19','VK',9,18,16,800,100,NULL),
  (24,'KNH-234','2007-03-16','TK',9,24,22,550,100,NULL),
  (25,'RVV-845','2003-08-08','HP',10,25,23,500,100,NULL);
COMMIT;

#
# Data for the `zuordnung_sf_fz` table  (LIMIT -486,500)
#

INSERT INTO `zuordnung_sf_fz` (`ID`, `Schadensfall_ID`, `Fahrzeug_ID`, `Schadenshoehe`, `Schuldanteil`) VALUES

  (1,1,2,1234.50,100),
  (2,2,7,852.00,0),
  (3,2,5,1214.00,100),
  (4,3,4,1438.75,20),
  (5,3,24,2276.85,0),
  (6,4,1,1234.50,0),
  (7,4,5,1983.00,100),
  (8,5,2,1251.50,80),
  (9,5,25,731.50,100),
  (10,6,3,2653.40,0),
  (11,6,7,1438.75,100),
  (12,7,6,865.00,100),
  (13,8,7,NULL,80);
COMMIT;



DELIMITER $$

CREATE DEFINER = 'root'@'localhost' TRIGGER `Mitarbeiter_BD2` BEFORE UPDATE ON `mitarbeiter`
  FOR EACH ROW
BEGIN
 update Dienstwagen
 set Mitarbeiter_ID = null
 where Mitarbeiter_ID = old.ID; 
 END$$

CREATE DEFINER = 'root'@'localhost' TRIGGER `Mitarbeiter_On_Delete2` AFTER DELETE ON `mitarbeiter`
  FOR EACH ROW
BEGIN
 DECLARE ltr_id INTEGER;


 select ID
 from Mitarbeiter
 where Abteilung_id = old.Abteilung_ID
 and Ist_Leiter = 'J'
 into ltr_id;

 update Schadensfall
 set Mitarbeiter_ID = ltr_id
 where Mitarbeiter_ID = old.ID;

 update Versicherungsvertrag
 set Mitarbeiter_ID = ltr_id
 where Mitarbeiter_ID = old.ID;
 END$$

DELIMITER ;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;