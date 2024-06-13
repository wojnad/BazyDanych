create database Optymalizacja_INX;

create schema Geo;

create table Geo.Eon (
	id_eon SERIAL primary key,
	nazwa_eon VARCHAR(100)
);

CREATE INDEX idx_GeoEon ON Geo.Eon(id_eon);

create table Geo.Era (
	id_era SERIAL primary key,
	nazwa_era VARCHAR(100),
	id_eon INT references Geo.Eon(id_eon)
	
);

CREATE INDEX idx_GeoEra ON Geo.Era(id_era);

create table Geo.Okres (
	id_okres SERIAL primary key,
	nazwa_okres VARCHAR(100),
	id_era INT references Geo.Era(id_era)
);

CREATE INDEX idx_GeoOkres ON Geo.Okres(id_okres);

create table Geo.Epoka (
	id_epoka SERIAL primary key,
	nazwa_epoka VARCHAR(100),
	id_okres INT references Geo.Okres(id_okres)
);
CREATE INDEX idx_GeoEpoka ON Geo.Epoka(id_epoka);

create table Geo.Pietro (
	id_pietro SERIAL primary key,
	nazwa_pietro VARCHAR(100),
	id_epoka INT references Geo.Epoka(id_epoka)
);
CREATE INDEX idx_GeoPietro ON Geo.Pietro(id_pietro);

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


--UTWORZENIE TABELI ZDENORMALIZOWANEJ--
SELECT p.id_pietro, p.nazwa_pietro, ep.id_epoka, ep.nazwa_epoka, ok.id_okres, ok.nazwa_okres, er.id_era, er.nazwa_era, eo.id_eon, eo.nazwa_eon
INTO Geo.Tabela
FROM Geo.Pietro p
INNER JOIN Geo.Epoka ep ON p.id_epoka = ep.id_epoka
INNER JOIN Geo.Okres ok ON ok.id_okres = ep.id_okres 
INNER JOIN Geo.Era er ON er.id_era = ok.id_era 
INNER JOIN Geo.Eon eo ON eo.id_eon = er.id_eon

--TABELE LICZBOWE--
CREATE SCHEMA Liczby

CREATE TABLE Liczby.Dziesiec (
	cyfra INT NOT NULL,
	bit_ INT NOT NULL
);

CREATE TABLE Liczby.Milion (
	cyfra INT NOT NULL,
	liczba INT NOT NULL,
	bit_ INT NOT NULL
);

INSERT INTO Liczby.Dziesiec (cyfra, bit_) VALUES
(0, 0),
(1, 1),
(2, 10),
(3, 11),
(4, 100),
(5, 101),
(6, 110),
(7, 111),
(8, 1000),
(9, 1001);

INSERT INTO Liczby.Milion 
SELECT a1.cyfra as cyfra, 
a1.cyfra + a2.cyfra * 10 + a3.cyfra * 100 + a4.cyfra * 1000 + a5.cyfra * 10000 + a6.cyfra * 100000 as liczba,
a1.bit_ as bit_ FROM 
Liczby.Dziesiec a1, 
Liczby.Dziesiec a2, 
Liczby.Dziesiec a3, 
Liczby.Dziesiec a4, 
Liczby.Dziesiec a5, 
Liczby.Dziesiec a6;

-- Iteracje

DO $$
DECLARE
    i INT := 1;
    start_time TIMESTAMP;
    end_time TIMESTAMP;
    duration INTERVAL;
BEGIN
    WHILE i <= 20 LOOP
        -- 1 ZL --
        RAISE NOTICE 'CZAS DLA 1. ZAPYTANIA - % ITERACJA:', i;

        start_time := clock_timestamp();
        PERFORM COUNT(*) 
        FROM Liczby.Milion m
        INNER JOIN Geo.Tabela t 
        ON (m.liczba % 77)+1 = t.id_pietro;
        end_time := clock_timestamp();
        duration := end_time - start_time;
        RAISE NOTICE 'Duration: %', duration;

        -- 2 ZL --
        RAISE NOTICE 'CZAS DLA 2. ZAPYTANIA - % ITERACJA:', i;

        start_time := clock_timestamp();
        PERFORM COUNT(*) 
        FROM Liczby.Milion m 
        INNER JOIN Geo.Pietro p ON (m.liczba % 77)+1 = p.id_pietro
        INNER JOIN Geo.Epoka ep ON p.id_epoka = ep.id_epoka
        INNER JOIN Geo.Okres ok ON ok.id_okres = ep.id_okres 
        INNER JOIN Geo.Era er ON er.id_era = ok.id_era 
        INNER JOIN Geo.Eon eo ON eo.id_eon = er.id_eon;
        end_time := clock_timestamp();
        duration := end_time - start_time;
        RAISE NOTICE 'Duration: %', duration;

        -- 3 ZL --
        RAISE NOTICE 'CZAS DLA 3. ZAPYTANIA - % ITERACJA:', i;

        start_time := clock_timestamp();
        PERFORM COUNT(*) 
        FROM Liczby.Milion m
        WHERE ((m.liczba % 77)+1) = 
        (SELECT id_pietro FROM Geo.Tabela t WHERE (m.liczba % 77)+1 = t.id_pietro);
        end_time := clock_timestamp();
        duration := end_time - start_time;
        RAISE NOTICE 'Duration: %', duration;

        -- 4 ZL --
        RAISE NOTICE 'CZAS DLA 4. ZAPYTANIA - % ITERACJA:', i;

        start_time := clock_timestamp();
        PERFORM COUNT(*) 
        FROM Liczby.Milion m
        WHERE ((m.liczba % 77)+1) = 
        (SELECT id_pietro FROM Geo.Pietro p
        INNER JOIN Geo.Epoka ep ON p.id_epoka = ep.id_epoka
        INNER JOIN Geo.Okres ok ON ok.id_okres = ep.id_okres 
        INNER JOIN Geo.Era er ON er.id_era = ok.id_era 
        INNER JOIN Geo.Eon eo ON eo.id_eon = er.id_eon
        WHERE (m.liczba % 77)+1 = p.id_pietro);
        end_time := clock_timestamp();
        duration := end_time - start_time;
        RAISE NOTICE 'Duration: %', duration;

        i := i + 1;
    END LOOP;
END $$;

