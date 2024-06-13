USE Optymalizacja
GO

--PROCEDURA ZADANIA

CREATE OR ALTER PROCEDURE Geo.Iteracje_10
AS

BEGIN

DECLARE @i INT = 1;
SET NOCOUNT ON
WHILE @i <= 20
BEGIN

-- 1 ZL --
PRINT 'CZAS DLA 1. ZAPYTANIA - ' + CAST(@i as VARCHAR(5)) + ' ITERACJA: '

set statistics time on
SELECT COUNT(*) 
FROM Liczby.Milion m
INNER JOIN Geo.Tabela t 
ON (m.liczba % 77)+1 = t.id_pietro 
set statistics time off

-- 2 ZL --
PRINT 'CZAS DLA 2. ZAPYTANIA - ' + CAST(@i as VARCHAR(5)) + ' ITERACJA: '

set statistics time on
SELECT COUNT(*) FROM Liczby.Milion m INNER JOIN Geo.Pietro p
ON (m.liczba % 77)+1 = p.id_pietro
INNER JOIN Geo.Epoka ep ON p.id_epoka = ep.id_epoka
INNER JOIN Geo.Okres ok ON ok.id_okres = ep.id_okres 
INNER JOIN Geo.Era er ON er.id_era = ok.id_era 
INNER JOIN Geo.Eon eo ON eo.id_eon = er.id_eon
set statistics time off

-- 3 ZL --
PRINT 'CZAS DLA 3. ZAPYTANIA - ' + CAST(@i as VARCHAR(5)) + ' ITERACJA: '

set statistics time on
SELECT COUNT(*) FROM Liczby.Milion m
WHERE ((m.liczba % 77)+1) = 
(SELECT id_pietro FROM Geo.Tabela t WHERE (m.liczba % 77)+1 = t.id_pietro)
set statistics time off

-- 4 ZL --
PRINT 'CZAS DLA 4. ZAPYTANIA - ' + CAST(@i as VARCHAR(5)) + ' ITERACJA: '

set statistics time on
SELECT COUNT(*) FROM Liczby.Milion m
WHERE ((m.liczba % 77)+1) = 
(SELECT id_pietro FROM Geo.Pietro p
INNER JOIN Geo.Epoka ep ON p.id_epoka = ep.id_epoka
INNER JOIN Geo.Okres ok ON ok.id_okres = ep.id_okres 
INNER JOIN Geo.Era er ON er.id_era = ok.id_era 
INNER JOIN Geo.Eon eo ON eo.id_eon = er.id_eon
WHERE (m.liczba % 77)+1 = p.id_pietro)
set statistics time off

SET @i = @i + 1;
END;
SET NOCOUNT OFF

END;
GO

EXEC Geo.Iteracje_10



--Z Indeksami

BEGIN TRANSACTION

CREATE INDEX idx_GeoEon ON Geo.Eon(id_eon);
CREATE INDEX idx_GeoEpoka ON Geo.Epoka(id_epoka);
CREATE INDEX idx_GeoEra ON Geo.Era(id_era);
CREATE INDEX idx_GeoOkres ON Geo.Okres(id_okres);
CREATE INDEX idx_GeoPietro ON Geo.Pietro(id_pietro);

EXEC Geo.Iteracje_10;

ROLLBACK TRANSACTION;