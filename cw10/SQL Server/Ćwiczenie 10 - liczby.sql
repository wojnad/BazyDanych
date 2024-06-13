USE Optymalizacja
GO

CREATE SCHEMA Liczby
GO

CREATE TABLE Liczby.Dziesiec (
	cyfra INT NOT NULL,
	bit_ INT NOT NULL,
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