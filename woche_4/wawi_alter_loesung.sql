/*
create table  kunden(
Kunden_Code varchar(5)not null,
Firma varchar(40) not null,
Strasse varchar(60) not null,
Ort varchar(15) not null,
PLZ varchar(10) not null,
Land varchar(15) not null,
Telefon varchar(24) not null
) type = innodb


create table bestellungen(
Bestell_Nr bigint not null,
Kunden_Code varchar(5) not null,
Bestelldatum Datetime not null,
Lieferdatum datetime not null,
Versanddatum datetime not null,
Frachtkosten double(8,2)
) type = innodb


create table bestelldetails(
Besetll_Nr bigint not null,
Artikel_Nr bigint not null,
Einzelpreis double(8,2) not null,
Anzahl int not null,
Rabatt double(8,2)
) type = innodb

create table artikel(
Artikel_Nr bigint not null,
Artikelname varchar(40) not null,
Einzelpreis double(8,2),
Lagerbestand int not null,
Mindestbestand int not null,
Auslaufartikel tinyint not null
)
type = innodb



alter table kunden add primary key (Kunden_Code)

alter table bestellungen  add primary key (Bestell_Nr)

alter table artikel add primary key (Artikel_Nr)


alter table bestelldetails add primary key (Besetll_Nr, Artikel_Nr)

alter table bestelldetails add index(Besetll_Nr, Artikel_Nr)


alter table artikel add unique index(Artikelname)


alter table kunden modify Ort varchar(60)


alter table bestellungen add foreign key(Kunden_Code) references kunden(Kunden_Code)

alter table bestelldetails add index(Besetll_Nr)
alter table bestelldetails add foreign key(Besetll_Nr) references bestellungen(Bestell_Nr)


alter table bestelldetails add foreign key(Artikel_Nr) references artikel(Artikel_Nr)

alter table kunden drop Land

alter table artikel change Artikelname A_Name varchar(40) not null

alter table kunden add column Land varchar(15) not null


insert into kunden(Kunden_Code, Firma, Strasse, Ort, PLZ, Land, Telefon)
            values ('STEI1', 'Steinman OHG', 'Bauchweg 3', 'Würzburg', '97071', 'Grmany', '0931/111')

insert into kunden(Kunden_Code, Firma, Strasse, Ort, PLZ, Land, Telefon)
            values ('SIER2', 'Sierl KG', 'Herbstweg 7', 'TBB', '95434', 'Austria', '09341/552')

insert into bestellungen(Bestell_Nr, Kunden_Code, Bestelldatum, Lieferdatum, Versanddatum, Frachtkosten)
            values ( 1, 'SIER2', '2005-11-20', '2005-11-23', '2005-11-22', 2345.87)

update kunden set Land = 'Germany'
              where Kunden_Code = 'STEI1'
              
delete from kunden where Kunden_Code = 'SIER2'

*/