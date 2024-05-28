USE AdventureWorks2019
GO
--ZAD 5--
SET IDENTITY_INSERT Production.Product ON

BEGIN TRANSACTION

DECLARE @counter INT
SET @counter = (SELECT COUNT(*) FROM Production.Product Where ProductNumber = 'TP-2137');

IF @counter = 0
	BEGIN
	INSERT INTO Production.Product (ProductID, Name, ProductNumber, SafetyStockLevel, ReorderPoint, StandardCost, ListPrice, DaysToManufacture, SellStartDate) 
	VALUES (2138, 'TESTOWY PRODUKT', 'TP-2137', 1, 750, 12.12, 20.20, 2, '2014-02-08 10:01:36.827')
	PRINT 'PRODUKT O TAKIM NUMERZE JESZCZE NIE ISTNIEJE - ZATWIERDZENIE TRANSAKCJI'
	COMMIT TRANSACTION
	END;
ELSE
	BEGIN
	PRINT 'PRODUKT O TAKIM NUMERZE JU¯ ISTNIEJE - WYCOFANIE TRANSAKCJI'
	ROLLBACK TRANSACTION
	END;

IF @@ERROR != 0
	BEGIN
	ROLLBACK TRANSACTION
	END;

SET IDENTITY_INSERT Production.Product OFF

--ZAD 6--

BEGIN TRANSACTION

IF (SELECT COUNT(*) FROM Sales.SalesOrderDetail Where OrderQty = 0) > 0
	BEGIN
	PRINT 'ZNALEZIONO WARTOŒÆ 0 w OrderQty - wycofanie transakcji';
	ROLLBACK TRANSACTION
	END;
ELSE
	BEGIN
	UPDATE Sales.SalesOrderDetail
	SET OrderQty = 1 + OrderQty;
	PRINT 'NIE ZNALEZIONO WARTOŒCI 0 w OrderQty - wycofanie transakcji';
	COMMIT TRANSACTION
	END;


--ZAD 7--
BEGIN TRANSACTION

DECLARE @counter7 INT
DECLARE @average money

SET @average = (SELECT AVG(StandardCost) FROM Production.Product)
SET @counter7 = (SELECT COUNT(*) FROM Production.Product Where StandardCost > @average)

IF @counter7 > 10
	BEGIN
	PRINT 'Liczba produktów do usuniêcia wiêksza od 10 - wycofanie transakcji'
	ROLLBACK TRANSACTION
	END;
ELSE
	BEGIN
	DELETE Production.Product WHERE StandardCost > @average
	PRINT 'Liczba produktów do usuniêcia mniejsza od 10 - zatwierdzenie transakcji'
	COMMIT TRANSACTION
	END;







