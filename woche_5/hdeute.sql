create database seminarverwaltung;
use seminarverwaltung;


-- set foreign_key_checks = 0;

create table Teilnehmer(
  ID integer primary key auto_increment 
) engine = innodb;



alter table Teilnehmer
  add column Name varchar(30);
  
  create table Zertifikat(
    id integer auto_increment primary key,
    Name varchar(20) unique key
  ) engine = innodb;
  
  create table Mitarbeiter(
    id integer primary key auto_increment,
    Name varchar(20) not null default 'unknown'
  ) engine = innodb;
  
  create table Modul(
    id integer not null primary key,
    Name varchar(20)
  ) engine = innodb;
  
  
  create table Pruefung(
    id integer primary key auto_increment,
    Pruefdatum DateTime,
    Zert_ID integer not null,
    constraint fk_Zert foreign key (Zert_ID) references Zertifikat(id)  
  ) engine = innodb;
  
  
  create table standort(
    id integer not null primary key auto_increment,
    name varchar(20)
  ) engine = innodb;
  
  alter table Pruefung
    add column M_ID integer not null,
    add foreign key (M_ID) references Mitarbeiter(id),
    add column standort_ID integer,
    add foreign key (standort_ID) references standort(id)
      on delete restrict   -- Verhindern einer Löschung/Löschweitergabe
      on update cascade    -- Weitergabe einer Änderung
      
    
    
    
    
    
    
    
    
    
    
    
    
    
    
  
  
  
  
  
  
  
 