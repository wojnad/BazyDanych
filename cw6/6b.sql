USE firma;

-- a)

UPDATE ksiegowosc.pracownicy
SET Telefon_kierunkowy = '(+48) ' + telefon;

-- b)

UPDATE ksiegowosc.pracownicy
SET telefon = SUBSTRING(telefon, 1, 3) + '-' + SUBSTRING(telefon, 4, 3) + '-' + SUBSTRING(telefon, 7, 3)

-- c)

SELECT p.id_pracownika, UPPER(p.imie) as IMIE, UPPER(p.nazwisko) as NAZWISKO, UPPER(p.adres) as ADRES, p.telefon FROM
ksiegowosc.pracownicy p
WHERE LEN(p.nazwisko) = (SELECT MAX(LEN(p.nazwisko)) 
						FROM ksiegowosc.pracownicy p);

-- d)

SELECT HASHBYTES('md5', CONCAT(pr.id_pracownika,'_',pr.imie,'_', pr.nazwisko,'_', pr.adres,'_', pr.telefon,'_',pn.kwota))

FROM ksiegowosc.pracownicy pr
JOIN
ksiegowosc.wynagrodzenie w on w.id_pracownika = pr.id_pracownika
JOIN
ksiegowosc.pensja pn on w.id_pensji = pn.id_pensji;

-- e)

SELECT pr.imie as Imiê, pr.nazwisko as Nazwisko, pn.kwota as Pensja, pm.kwota as Premia FROM
ksiegowosc.pracownicy pr
LEFT JOIN
ksiegowosc.wynagrodzenie w on w.id_pracownika = pr.id_pracownika
LEFT JOIN
ksiegowosc.pensja pn on pn.id_pensji = w.id_pensji
LEFT JOIN
ksiegowosc.premia pm on pm.id_premii = w.id_premii

-- f)

SELECT CONCAT('Pracownik ', pr.imie, ' ', pr.nazwisko, ' w dniu ', g.data_, ' otrzyma³ pensjê ca³kowit¹ na kwotê ',
				(pm.kwota+pn.kwota+(g.liczba_nadgodzin * 50)), ' z³, gdzie wynagrodzenie zasadnicze wynios³o: ',
				pn.kwota, ' z³, premia: ', pm.kwota, ' z³, nadgodziny: ', (g.liczba_nadgodzin * 50), 'z³') 
				FROM
ksiegowosc.pracownicy pr
LEFT JOIN
ksiegowosc.wynagrodzenie w on w.id_pracownika = pr.id_pracownika
LEFT JOIN
ksiegowosc.pensja pn on pn.id_pensji = w.id_pensji
LEFT JOIN
ksiegowosc.premia pm on pm.id_premii = w.id_premii
LEFT JOIN
ksiegowosc.godziny g on g.id_pracownika = pr.id_pracownika;