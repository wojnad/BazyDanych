-- Wypełnienie tabeli

USE Optymalizacja

INSERT INTO Geo.Eon (nazwa_eon) VALUES
('Fanerozoik');

INSERT INTO Geo.Era (nazwa_era, id_eon) VALUES
('Paleozoik', 1),
('Mezozoik', 1),
('Kenozoik', 1);

INSERT INTO Geo.Okres (nazwa_okres, id_era) VALUES
('Dewon', 1),
('Karbon', 1),
('Perm', 1),
('Trias', 2),
('Jura', 2),
('Kreda', 2),
('Paleogen', 3),
('Neogen', 3),
('Czwartorząd', 3);

INSERT INTO Geo.Epoka (nazwa_epoka, id_okres) VALUES
('Dolny', 1),
('Środkowy', 1),
('Górny', 1),
--
('Dolny', 2),
('Górny', 2),
--
('Dolny', 3),
('Środkowy', 3),
('Górny', 3),
--
('Dolny',4),
('Środkowy', 4),
('Górny', 4),
--
('Dolny',5),
('Środkowy', 5),
('Górny', 5),
--
('Dolny', 6),
('Górny', 6),
--
('Paleocen',7),
('Eocen', 7),
('Oligocen', 7),
--
('Miocen',8),
('Pliocen', 8),
--
('Plejstocen', 9),
('Halocen', 9);


INSERT INTO Geo.Pietro (id_epoka, nazwa_pietro) Values
(1, 'Lochkow'),
(1, 'Prag'),
(1, 'Ems'),
(2, 'Eifel'),
(2, '¯ywet'),
(3, 'Fran'),
(3, 'Famen'),
(4, 'Turnej'),
(4, 'Wizen'),
(4, 'Serpuchow'),
(5, 'Baszkir'),
(5, 'Moskow'),
(5, 'Kasimow'),
(5, 'G¿el'),
(6, 'Assel'),
(6, 'Sakmar'),
(6, 'Artinsk'),
(6, 'Kungur'),
(7, 'Road'),
(7, 'Word'),
(7, 'Kapitan'),
(8, 'Wucziaping'),
(8, 'Czangsing'),
(9, 'Ind'),
(9, 'Olenek'),
(10, 'Anizyk'),
(10, 'Ladyn'),
(11, 'Karnik'),
(11, 'Noryk'),
(11, 'Retyk'),
(12, 'Hettang'),
(12, 'Synemur'),
(12, 'Pliensbach'),
(12, 'Toark'),
(13, 'Aalen'),
(13, 'Bajos'),
(13, 'Baton'),
(13, 'Kelowej'),
(14, 'Oksford'),
(14, 'Kimeryd'),
(14, 'Tyton'),
(15, 'Berrias'),
(15, 'Walan¿yn'),
(15, 'Hoteryw'),
(15, 'Barrem'),
(15, 'Apt'),
(15, 'Alb'),
(16, 'Cenoman'),
(16, 'Turon'),
(16, 'Koniak'),
(16, 'Santon'),
(16, 'Kampan'),
(16, 'Mastrycht'),
(17, 'Dan'),
(17, 'Zeland'),
(17, 'Tanet'),
(18, 'Iprez'),
(18, 'Lutet'),
(18, 'Barton'),
(18, 'Priabon'),
(19, 'Rupel'),
(19, 'Szat'),
(20, 'Akwitan'),
(20, 'Burdyga³'),
(20, 'Lang'),
(20, 'Serrwal'),
(20, 'Torton'),
(20, 'Messyn'),
(21, 'Zankl'),
(21, 'Piacent'),
(22, 'Gelas'),
(22, 'Kalabr'),
(22, 'Chiban'),
(22, 'PóŸny Chiban'),
(23, 'Grenland'),
(23, 'Northgrip'),
(23, 'Megalaj');
