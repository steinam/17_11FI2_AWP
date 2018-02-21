select farbe, count(*) from fahrzeug
group by Farbe;


select count(*) as Anzahl from schadensfall;


select min(Schadenshoehe) from schadensfall;


select avg(Schadenshoehe) from schadensfall;



select bezeichnung, count(bezeichnung) from abteilung
group by ort;


select Raum, Abteilung_ID, Bezeichnung,  count(*)
from mitarbeiter, `abteilung`
where mitarbeiter.`Abteilung_ID` = Abteilung.`ID`
group by Abteilung_ID, Raum



select count(*) from mitarbeiter;




select Name, Kennzeichen from `mitarbeiter`, dienstwagen
where `mitarbeiter`.`ID` = `dienstwagen`.`Mitarbeiter_ID`


select Name, Kennzeichen
from dienstwagen inner join mitarbeiter
	on `mitarbeiter`.`ID` = `dienstwagen`.`Mitarbeiter_ID`


select Name, Kennzeichen
from dienstwagen left join mitarbeiter
	on `mitarbeiter`.`ID` = `dienstwagen`.`Mitarbeiter_ID`

select count(*) from dienstwagen;


select  Name, Kennzeichen
from mitarbeiter left join dienstwagen
	on `mitarbeiter`.`ID` = `dienstwagen`.`Mitarbeiter_ID`


















select avg(Schadenshoehe)  from schadensfall
group by verletzte



select fh.ID, Name, year(Datum),  sum(s.schadenshoehe)
from schadensfall s, zuordnung_SF_fz zsf, fahrzeug f, fahrzeugtyp ft,fahrzeughersteller `fh`
where s.`ID` = zsf.`Schadensfall_ID`
	 and zsf.`Fahrzeug_ID` = f.`ID`
     and f.`Fahrzeugtyp_ID` = ft.`ID`
     and ft.`Hersteller_ID` = fh.`ID`
group by name, year(datum)




select ort, count(bezeichnung) as Anzahl
from `abteilung`
group by ort
having count(Anzahl) = 1