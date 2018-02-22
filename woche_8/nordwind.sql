select k.kundencode, firma
from kunden k, bestellungen b, bestelldetails bd, artikel a
	where k.`KundenCode` = b.`KundenCode`
    and b.`BestellNr` = bd.`BestellNr`
    and bd.`ArtikelNr` = a.`ArtikelNr`




select k.kundencode, k.firma
from kunden k inner join bestellungen b
	on k.`KundenCode` = b.`KundenCode`
    inner join bestelldetails bd
    on b.`BestellNr` = bd.`BestellNr`
    inner join artikel a
	on bd.`ArtikelNr` = a.`ArtikelNr`
    where a.`Artikelname` like '%chai%';



select k.kundencode, k.firma
from kunden k inner join bestellungen b
	on k.`KundenCode` = b.`KundenCode`
    inner join bestelldetails bd
    on b.`BestellNr` = bd.`BestellNr`
	where bd.`ArtikelNr` = 1




select k.KundenCode, sum(Einzelpreis * Anzahl) as Umsatz
from kunden k inner join bestellungen b
					on k.`KundenCode` = b.`KundenCode`
               inner join bestelldetails bd
    				on b.`BestellNr` = bd.`BestellNr`
group by k.kundencode
order by Umsatz desc
limit 3









select * from artikel;

    select count(*) from bestelldetails;