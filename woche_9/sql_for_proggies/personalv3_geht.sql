# SQL Manager 2005 Lite for MySQL 3.7.7.1
# ---------------------------------------
# Host     : win-srv06
# Port     : 3306
# Database : personal


SET FOREIGN_KEY_CHECKS=0;

CREATE DATABASE `personal`
    CHARACTER SET 'latin1'
    COLLATE 'latin1_general_ci';

USE `personal`;

#
# Structure for the `abteilung` table : 
#

CREATE TABLE `abteilung` (
  `AbtNr` int(11) NOT NULL,
  `AbtName` varchar(50) collate latin1_general_ci default NULL,
  PRIMARY KEY  (`AbtNr`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

#
# Structure for the `stundensatz` table : 
#

CREATE TABLE `stundensatz` (
  `StundensatzNr` tinyint(4) NOT NULL,
  `Stundensatz` double default NULL,
  PRIMARY KEY  (`StundensatzNr`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

#
# Structure for the `mitarbeiter` table : 
#

CREATE TABLE `mitarbeiter` (
  `MNr` int(11) NOT NULL,
  `MName` varchar(30) collate latin1_general_ci default NULL,
  `MVorname` varchar(20) collate latin1_general_ci default NULL,
  `MGeburtsdatum` datetime default NULL,
  `MGeschlecht` varchar(1) collate latin1_general_ci default NULL,
  `AbtNr` int(11) default NULL,
  `StundensatzNr` tinyint(4) default NULL,
  PRIMARY KEY  (`MNr`),
  KEY `fi0` (`AbtNr`),
  KEY `fi1` (`StundensatzNr`),
  CONSTRAINT `mitarbeiter_ibfk_1` FOREIGN KEY (`AbtNr`) REFERENCES `abteilung` (`AbtNr`),
  CONSTRAINT `mitarbeiter_ibfk_2` FOREIGN KEY (`StundensatzNr`) REFERENCES `stundensatz` (`StundensatzNr`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

#
# Structure for the `gehalt` table : 
#

CREATE TABLE `gehalt` (
  `MNr` int(11) NOT NULL,
  `Monatsgehalt` double default NULL,
  PRIMARY KEY  (`MNr`),
  CONSTRAINT `gehalt_ibfk_1` FOREIGN KEY (`MNr`) REFERENCES `mitarbeiter` (`MNr`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

#
# Structure for the `kunden` table : 
#

CREATE TABLE `kunden` (
  `KundenNr` int(11) NOT NULL,
  `Firma` varchar(30) collate latin1_general_ci default NULL,
  `Ansprechpartner` varchar(30) collate latin1_general_ci default NULL,
  `Strasse` varchar(30) collate latin1_general_ci default NULL,
  `Postleitzahl` varchar(20) collate latin1_general_ci default NULL,
  `Ort` varchar(30) collate latin1_general_ci default NULL,
  `Telefonnummer` varchar(20) collate latin1_general_ci default NULL,
  `Telefax` varchar(20) collate latin1_general_ci default NULL,
  `Email` varchar(30) collate latin1_general_ci default NULL,
  PRIMARY KEY  (`KundenNr`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

#
# Structure for the `projekte` table : 
#

CREATE TABLE `projekte` (
  `ProjektNr` varchar(3) collate latin1_general_ci NOT NULL,
  `Projektname` varchar(20) collate latin1_general_ci default NULL,
  `KundenCode` int(11) default NULL,
  `Auftragsdatum` datetime default NULL,
  `Projektbeginn` datetime default NULL,
  `Projektende` datetime default NULL,
  `Rechnung` tinyint(4) default NULL,
  PRIMARY KEY  (`ProjektNr`),
  KEY `fi0` (`KundenCode`),
  CONSTRAINT `projekte_ibfk_1` FOREIGN KEY (`KundenCode`) REFERENCES `kunden` (`KundenNr`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

#
# Structure for the `projektbearbeitung` table : 
#

CREATE TABLE `projektbearbeitung` (
  `MNr` int(11) NOT NULL,
  `ProjNr` varchar(3) collate latin1_general_ci NOT NULL,
  `Stunden` double default NULL,
  PRIMARY KEY  (`MNr`,`ProjNr`),
  KEY `fi0` (`MNr`),
  KEY `fi1` (`ProjNr`),
  CONSTRAINT `projektbearbeitung_ibfk_1` FOREIGN KEY (`MNr`) REFERENCES `mitarbeiter` (`MNr`),
  CONSTRAINT `projektbearbeitung_ibfk_2` FOREIGN KEY (`ProjNr`) REFERENCES `projekte` (`ProjektNr`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

#
# Data for the `abteilung` table  (LIMIT 0,500)
#

INSERT INTO `abteilung` (`AbtNr`, `AbtName`) VALUES 
  (1,'Geschäftsleitung'),
  (2,'Marketing'),
  (3,'Verwaltung'),
  (4,'Projektierung Produktionsplanung und -steuerung'),
  (5,'Projektierung Kosten- und Leistungsrechnung');

COMMIT;

#
# Data for the `stundensatz` table  (LIMIT 0,500)
#

INSERT INTO `stundensatz` (`StundensatzNr`, `Stundensatz`) VALUES 
  (1,150),
  (2,180),
  (3,200);

COMMIT;

#
# Data for the `mitarbeiter` table  (LIMIT 0,500)
#

INSERT INTO `mitarbeiter` (`MNr`, `MName`, `MVorname`, `MGeburtsdatum`, `MGeschlecht`, `AbtNr`, `StundensatzNr`) VALUES 
  (1,'Kölbel','Konrad','1950-01-29','m',4,3),
  (2,'Bayerlein','Heinz','1950-08-10','m',1,3),
  (3,'Lorbeer','Werner','1945-04-05','m',2,3),
  (4,'Wiedemann','Albert','1954-05-10','m',2,3),
  (5,'Weishaupt','Paul','1948-04-08','m',3,3),
  (6,'Amann','Klaus','1965-12-10','m',4,1),
  (7,'Matzke','Wolfgang','1953-01-08','m',4,3),
  (8,'Gutfrau','Ursulua','1970-09-09','w',3,2),
  (9,'Müller','Sabine','1975-10-01','w',2,1),
  (10,'Meier','Monika','1975-04-02','w',2,1),
  (11,'Fromm','Erich','1960-09-03','m',2,2),
  (12,'Meier','Andrea','1975-04-02','w',1,2),
  (13,'Kaiser','Hans','1974-12-10','m',4,1),
  (14,'Bund','Karin','1975-11-11','w',3,3),
  (15,'Stubenrauch','Martin','1970-01-09','m',2,1),
  (16,'Zimmermann','Ludwig','1966-12-12','m',2,2),
  (17,'Umbrecher','Jochen','1974-05-04','m',2,1),
  (18,'Grüner','Bernd','1972-09-09','m',3,2),
  (19,'Sieber','Daniela','1978-04-02','w',3,1),
  (20,'Wunsch','Werner','1959-03-09','m',5,1),
  (21,'Riem','Gerhard','1968-01-02','m',5,2),
  (22,'Senso','Chen',NULL,NULL,NULL,2);

COMMIT;

#
# Data for the `gehalt` table  (LIMIT 0,500)
#

INSERT INTO `gehalt` (`MNr`, `Monatsgehalt`) VALUES 
  (1,15000),
  (2,10000),
  (3,12000),
  (4,10000),
  (5,NULL),
  (6,5000),
  (7,10000),
  (8,9000),
  (9,9800),
  (10,4000),
  (13,8000),
  (15,3800),
  (18,4200),
  (19,3400),
  (20,9800),
  (21,8000);

COMMIT;

#
# Data for the `kunden` table  (LIMIT 0,500)
#

INSERT INTO `kunden` (`KundenNr`, `Firma`, `Ansprechpartner`, `Strasse`, `Postleitzahl`, `Ort`, `Telefonnummer`, `Telefax`, `Email`) VALUES 
  (1,'FOSBOS','Lehmer','Kärnerstr. 6','95448','Bayreuth','0921/792080','0921/34567','fosbos@.bayreuth.baynet.de'),
  (2,'Orgasys','Müller','Frankenstr. 45','89745','Lauf','0831/56342','0831/56349','orgasys@.lauf.de'),
  (3,'Multidata','Konrad','Hofer Str. 23','92345','Noringen','0763/93261','0763/93269','multidata@.noringen.de'),
  (4,'FOSPROD GmbH','Schuler','Kerschensteinerstr. 4','95448','Bayreuth','0921/758320','0921/758290','fosprod@.bayreuth.de');

COMMIT;

#
# Data for the `projekte` table  (LIMIT 0,500)
#

INSERT INTO `projekte` (`ProjektNr`, `Projektname`, `KundenCode`, `Auftragsdatum`, `Projektbeginn`, `Projektende`, `Rechnung`) VALUES 
  ('A1','PKR',2,'1998-08-16','1998-08-17','1998-09-13',1),
  ('A10','Unternehmensmodell_B',3,'1998-02-18','1998-02-24','1998-07-30',1),
  ('A11','PKR',1,'1998-02-17','1998-02-18','1998-05-30',1),
  ('A2','DBR mehrstufig',3,'1998-02-20','1998-02-25','1998-04-28',0),
  ('A3','PPS_MX',NULL,NULL,NULL,NULL,0),
  ('A4','PPS_XL',NULL,NULL,NULL,NULL,0),
  ('A5','BAB',NULL,NULL,NULL,NULL,0),
  ('A6','KTRZ',NULL,NULL,NULL,NULL,0),
  ('A7','BDE',NULL,NULL,NULL,NULL,0),
  ('A8','PPS_BAT',NULL,NULL,NULL,NULL,0),
  ('A9','PPS_FOS',4,'1998-02-28','1998-03-02',NULL,0);

COMMIT;

#
# Data for the `projektbearbeitung` table  (LIMIT 0,500)
#

INSERT INTO `projektbearbeitung` (`MNr`, `ProjNr`, `Stunden`) VALUES 
  (1,'A1',3),
  (1,'A2',3),
  (2,'A10',2),
  (2,'A11',5),
  (2,'A2',3),
  (6,'A10',5),
  (6,'A2',6),
  (7,'A11',30),
  (11,'A10',15),
  (11,'A11',3),
  (14,'A1',10),
  (15,'A1',10),
  (15,'A2',20),
  (18,'A2',2),
  (22,'A10',3);

COMMIT;

