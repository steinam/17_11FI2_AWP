
-- KOmbination aller Datensätze de rlinken Tabell emit allen DS der rechtne Tabelle
-- kartesiches Kreuzprodukt
select *
from spieler, strafen
where spieler.spielernr = strafen.spielernr



select datum, betrag, `sp`.`SPIELERNR`, st.`SPIELERNR`
from spieler sp, strafen st
where sp.spielernr = st.spielernr

-- zeige mir alle spieler und wenn sie strafen haben auch noch den Betrag und das Datum

select datum, betrag, `sp`.`SPIELERNR`, st.`SPIELERNR`
from spieler sp  left join strafen st
	on sp.`SPIELERNR` = st.`SPIELERNR`





select * from strafen


select 112 / 8