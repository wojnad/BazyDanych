-- UTWORZENIE BAZY DANYCH -- 

CREATE DATABASE Optymalizacja
GO
USE Optymalizacja
GO
CREATE SCHEMA Geo
GO


CREATE TABLE Geo.Eon (
	id_eon INT NOT NULL IDENTITY(1,1) Primary Key,
	nazwa_eon VARCHAR(100) NOT NULL
);

CREATE TABLE Geo.Era (
	id_era INT NOT NULL IDENTITY(1,1) Primary Key,
	nazwa_era VARCHAR(100) NOT NULL,
	id_eon INT,
	FOREIGN KEY(id_eon) REFERENCES Geo.Eon(id_eon)
	ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Geo.Okres (
	id_okres INT NOT NULL IDENTITY(1,1) Primary Key,
	nazwa_okres VARCHAR(100) NOT NULL,
	id_era INT,
	FOREIGN KEY(id_era) REFERENCES Geo.Era(id_era)
	ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Geo.Epoka (
	id_epoka INT NOT NULL IDENTITY(1,1) Primary Key,
	nazwa_epoka VARCHAR(100) NOT NULL,
	id_okres INT,
	FOREIGN KEY(id_okres) REFERENCES Geo.Okres(id_okres)
	ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Geo.Pietro (
	id_pietro INT NOT NULL IDENTITY(1,1) Primary Key,
	nazwa_pietro VARCHAR(100) NOT NULL,
	id_epoka INT,
	FOREIGN KEY(id_epoka) REFERENCES Geo.Epoka(id_epoka)
	ON DELETE CASCADE ON UPDATE CASCADE
);

--UTWORZENIE TABELI ZDENORMALIZOWANEJ--
SELECT p.id_pietro, p.nazwa_pietro, ep.id_epoka, ep.nazwa_epoka, ok.id_okres, ok.nazwa_okres, er.id_era, er.nazwa_era, eo.id_eon, eo.nazwa_eon
INTO Geo.Tabela
FROM Geo.Pietro p
INNER JOIN Geo.Epoka ep ON p.id_epoka = ep.id_epoka
INNER JOIN Geo.Okres ok ON ok.id_okres = ep.id_okres 
INNER JOIN Geo.Era er ON er.id_era = ok.id_era 
INNER JOIN Geo.Eon eo ON eo.id_eon = er.id_eon
--

