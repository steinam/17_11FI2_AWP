SELECT te.`SPIELERNR`, (Betrag) AS Maximum FROM Strafen St, Teams Te
WHERE St.SpielerNr = Te.SpielerNr AND YEAR(Datum) = 1996
AND MONTH(Datum) > 6
group by te.`SPIELERNR`;



SELECT Betrag, count(spielernr) AS Summe
FROM Strafen
GROUP BY Betrag



-- ermittle die Anzahl der Spieler pro ort

select Ort, COUNT(name)
from spieler
group by Ort
having count(name) >= 2




-- Wie alt sind durchschnittlich die Vereinsmitglieder?
-- Unterscheiden Sie nach Geschlecht.


select avg(year(now()) - year(geboren)) from spieler
group by Geschlecht;


-- Welcher Betrag an Strafen wurde von Spielern der Bundesliga gezahlt,
-- welcher von Spielern der Regionalliga?

select sum(betrag) from `strafen`, wettkaempfe, teams
where strafen.`SPIELERNR` = `wettkaempfe`.`SPIELERNR`
		and `wettkaempfe`.`TEAMNR` = `teams`.`TEAMNR`
        and teams.`LIGA` = 'Bundesliga'

-- Wie heißen die Spieler, die mindestens zwei Strafen erhalten haben?
-- Berücksichtigen Sie nur Strafen von mindestens 50,- DM

select name
from spieler, strafen
where spieler.`SPIELERNR` = strafen.`SPIELERNR`
and strafen.`BETRAG` >= 50
group by `spieler`.`SPIELERNR`
having count(strafen.`BETRAG`) >= 2 