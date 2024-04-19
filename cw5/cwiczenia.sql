USE firma;

-- Pracownicy
INSERT INTO ksiegowosc.pracownicy (id_pracownika, imie, nazwisko, adres, telefon) VALUES
(1, 'Jan', 'Kowalski', 'ul. Kwiatowa 1, Warszawa', '123-456-789'),
(2, 'Anna', 'Nowak', 'ul. Leœna 2, Kraków', '987-654-321'),
(3, 'Marek', 'Wiœniewski', 'ul. S³oneczna 3, Gdañsk', '111-222-333'),
(4, 'Katarzyna', 'D¹browska', 'ul. Polna 4, Wroc³aw', '444-555-666'),
(5, 'Piotr', 'Lis', 'ul. Jesienna 5, Poznañ', '777-888-999'),
(6, 'Alicja', 'Kwiatkowska', 'ul. G³ówna 6, Szczecin', '222-333-444'),
(7, 'Grzegorz', 'Zieliñski', 'ul. Morska 7, £ódŸ', '555-666-777'),
(8, 'Micha³', 'WoŸnicki', 'pl. Zmartwychwstania 1, Baranowo', '999-888-777'),
(9, 'Tomasz', 'Kaczmarek', 'ul. Wiejska 9, Katowice', '111-333-555'),
(10, 'Barbara', 'Zaj¹c', 'ul. Ogrodowa 10, Gdynia', '333-222-111');

-- Godziny
INSERT INTO ksiegowosc.godziny (id_godziny, data_, liczba_godzin, id_pracownika) VALUES
(1, '2024-04-01', 8, 1),
(2, '2024-04-01', 7, 2),
(3, '2024-04-02', 9, 1),
(4, '2024-04-02', 6, 3),
(5, '2024-04-03', 8, 4),
(6, '2024-04-03', 7, 5),
(7, '2024-04-04', 9, 6),
(8, '2024-04-04', 6, 7),
(9, '2024-04-05', 8, 8),
(10, '2024-04-05', 7, 9);

-- Pensja
INSERT INTO ksiegowosc.pensja (id_pensji, stanowisko, kwota) VALUES
(1, 'Ksiêgowy', 4000.00),
(2, 'Administrator', 4500.00),
(3, 'Programista', 5000.00),
(4, 'Analityk', 4200.00),
(5, 'Specjalista ds. HR', 3800.00),
(6, 'In¿ynier', 4600.00),
(7, 'Technik', 3500.00),
(8, 'Doradca Klienta', 3200.00),
(9, 'Pracownik Produkcji', 3000.00),
(10, 'Recepcjonista', 3300.00);

-- Premia
INSERT INTO ksiegowosc.premia (id_premii, rodzaj, kwota) VALUES
(1, 'Za dobre wyniki', 200.00),
(2, 'Za sta¿ pracy', 300.00),
(3, 'Za wysi³ek', 250.00),
(4, 'Za innowacyjnoœæ', 400.00),
(5, 'Za zaanga¿owanie', 150.00),
(6, 'Za osi¹gniêcia', 350.00),
(7, 'Za wyj¹tkow¹ pracê', 280.00),
(8, 'Za lojalnoœæ', 180.00),
(9, 'Za kreatywnoœæ', 320.00),
(10, 'Za przed³u¿enie umowy', 270.00);

-- Wynagrodzenie
INSERT INTO ksiegowosc.wynagrodzenie (id_wynagrodzenia, data_, id_pracownika, id_godziny, id_pensji, id_premii) VALUES
(1, '2024-04-01', 1, 1, 1, 1),
(2, '2024-04-01', 2, 2, 2, 1),
(3, '2024-04-02', 1, 3, 1, 1),
(4, '2024-04-02', 3, 4, 3, 2),
(5, '2024-04-03', 4, 5, 4, 3),
(6, '2024-04-03', 5, 6, 5, 4),
(7, '2024-04-04', 6, 7, 6, 5),
(8, '2024-04-04', 7, 8, 7, 6),
(9, '2024-04-05', 8, 9, 8, 7),
(10, '2024-04-05', 9, 10, 9, 8);

SELECT id_pracownika, nazwisko FROM ksiegowosc.pracownicy;

SELECT id_pracownika FROM ksiegowosc.pracownicy 
JOIN ksiegowosc.pensja ON id_pracownika = id_pensji
WHERE kwota > 1000;

SELECT prac.id_pracownika, imie FROM ksiegowosc.pracownicy prac
JOIN ksiegowosc.wynagrodzenie wyn ON prac.id_pracownika = wyn.id_pracownika
JOIN ksiegowosc.premia prem ON wyn.id_premii = prem.id_premii
JOIN ksiegowosc.pensja pen ON wyn.id_pensji = pen.id_pensji
WHERE prem.kwota = 0 AND pen.kwota > 2000;

SELECT * FROM ksiegowosc.pracownicy
WHERE imie LIKE 'J%';

SELECT * FROM ksiegowosc.pracownicy
WHERE imie LIKE '%n%' AND nazwisko LIKE '%a';

ALTER TABLE ksiegowosc.godziny
ADD liczba_nadgodzin INT;
UPDATE ksiegowosc.godziny
SET liczba_nadgodzin = CASE
	WHEN (liczba_godzin * 20) > 160 THEN (liczba_godzin * 20) - 160
	ELSE 0
	END;

SELECT 
    p.imie,
    p.nazwisko,
    CASE WHEN (g.liczba_godzin*20) > 160 THEN (g.liczba_godzin*20) - 160 ELSE 0 END AS nadgodziny
FROM 
    ksiegowosc.pracownicy p
LEFT JOIN 
    ksiegowosc.godziny g ON p.id_pracownika = g.id_pracownika;


SELECT imie, nazwisko, kwota FROM ksiegowosc.pracownicy
JOIN ksiegowosc.pensja ON id_pensji = id_pracownika
WHERE kwota >= 1500 AND kwota <= 3000;

SELECT p.imie, p.nazwisko
FROM ksiegowosc.pracownicy p
INNER JOIN ksiegowosc.godziny g ON p.id_pracownika = g.id_pracownika
LEFT JOIN ksiegowosc.premia pr ON p.id_pracownika = pr.id_premii
WHERE g.liczba_godzin > 160 AND pr.id_premii IS NULL;

SELECT p.imie, p.nazwisko, pen.kwota as pensja FROM
ksiegowosc.pracownicy p
INNER JOIN ksiegowosc.pensja pen ON p.id_pracownika = pen.id_pensji
ORDER BY pensja;

SELECT imie, nazwisko, pen.kwota AS pensja, prem.kwota AS premia FROM ksiegowosc.pracownicy -- j)
JOIN ksiegowosc.pensja pen ON id_pracownika = id_pensji
JOIN ksiegowosc.premia prem ON id_pracownika = id_premii
GROUP BY imie, nazwisko, pen.kwota, prem.kwota
ORDER BY pen.kwota DESC, prem.kwota DESC;
