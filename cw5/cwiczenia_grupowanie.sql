use firma;


-- k)

SELECT pn.stanowisko,
	   COUNT (*) AS liczba_pracownikow
FROM ksiegowosc.pracownicy p
JOIN
ksiegowosc.wynagrodzenie w ON p.id_pracownika = w.id_pracownika
JOIN
ksiegowosc.pensja pn ON pn.id_pensji = w.id_pensji
GROUP BY
pn.stanowisko

-- l)

SELECT MIN(p.kwota) as minimum, AVG(p.kwota) as srednia, MAX(p.kwota) as maksimum
FROM ksiegowosc.pensja p WHERE p.stanowisko LIKE 'Ksiêgowy';

-- m)

SELECT SUM(pn.kwota) as suma_wynagrodzen
FROM ksiegowosc.pracownicy pr
JOIN
ksiegowosc.wynagrodzenie w on pr.id_pracownika = w.id_pracownika
JOIN
ksiegowosc.pensja pn on w.id_pensji = pn.id_pensji

-- n)

SELECT pn.stanowisko, SUM(pn.kwota) as suma_wynagrodzen
FROM ksiegowosc.pracownicy pr
JOIN
ksiegowosc.wynagrodzenie w on pr.id_pracownika = w.id_pracownika
JOIN
ksiegowosc.pensja pn on w.id_pensji = pn.id_pensji
GROUP BY
pn.stanowisko

-- o)

SELECT pn.stanowisko,
COUNT(pr.id_premii) AS liczba_premii
FROM ksiegowosc.pracownicy pc
JOIN
ksiegowosc.wynagrodzenie w on pc.id_pracownika = w.id_pracownika
JOIN
ksiegowosc.premia pr on w.id_premii = pr.id_premii
JOIN
ksiegowosc.pensja pn on w.id_pensji = pn.id_pensji
GROUP BY
pn.stanowisko;

-- p)

DELETE FROM ksiegowosc.pracownicy
WHERE id_pracownika in
		(SELECT pr.id_pracownika
		FROM ksiegowosc.pracownicy pr
		JOIN
		ksiegowosc.wynagrodzenie wn on wn.id_pracownika = pr.id_pracownika
		JOIN
		ksiegowosc.pensja pn on wn.id_pensji = pn.id_pensji
		WHERE pn.kwota < 1200);


