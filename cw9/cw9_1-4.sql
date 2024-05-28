USE AdventureWorks2019;
--ZAD 1--

BEGIN TRANSACTION
UPDATE Production.Product
SET StandardCost = 1.1 * StandardCost
WHERE ProductID = 680
COMMIT TRANSACTION

--ZAD 2--
BEGIN TRANSACTION


SELECT * FROM Production.Product Where ProductID = 707

--USUWANIE KLUCZY OBCYCH--
DELETE  FROM Production.ProductCostHistory Where ProductID = 707
DELETE  FROM Production.ProductDocument Where ProductID = 707
DELETE  FROM Production.ProductInventory Where ProductID = 707
DELETE  FROM Production.ProductListPriceHistory Where ProductID = 707
DELETE  FROM Production.ProductProductPhoto Where ProductID = 707
DELETE  FROM Production.ProductReview Where ProductID = 707
DELETE  FROM Purchasing.ProductVendor Where ProductID = 707
DELETE  FROM Purchasing.PurchaseOrderDetail Where ProductID = 707
DELETE  FROM Sales.SalesOrderDetail Where SalesOrderDetailID IN (SELECT SalesOrderDetailID FROM Sales.SpecialOfferProduct Where ProductID = 707)
DELETE  FROM Sales.SpecialOfferProduct Where ProductID = 707
DELETE  FROM Production.TransactionHistory Where ProductID = 707

DELETE  FROM Production.Product Where ProductID = 707


SELECT * FROM Production.Product Where ProductID = 707

ROLLBACK Transaction


--ZAD 3--
BEGIN TRANSACTION

SET IDENTITY_INSERT Production.Product ON

SELECT * FROM Production.Product where ProductID = 2137

INSERT INTO Production.Product (ProductID, Name, ProductNumber, SafetyStockLevel, ReorderPoint, StandardCost, ListPrice, DaysToManufacture, SellStartDate) 
VALUES (2137, 'TESTOWY PRODUKT', 'TP-2137', 1, 750, 12.12, 20.20, 2, '2014-02-08 10:01:36.827')

SELECT * FROM Production.Product where ProductID = 2137

SET IDENTITY_INSERT Production.Product OFF

COMMIT TRANSACTION

--ZAD 4--

BEGIN TRANSACTION

UPDATE Production.Product
SET StandardCost = 1.1 * StandardCost

DECLARE @suma money

SET @suma = (SELECT SUM(StandardCost) FROM Production.Product)

IF @suma < 50000
	BEGIN
	PRINT 'Transakcja siê powiod³a: ' + CAST(@suma as varchar(15))
	COMMIT TRANSACTION
	END;
ELSE
	BEGIN
	PRINT 'Transakcja siê nie powiod³a ' + CAST(@suma as varchar(15))
	ROLLBACK TRANSACTION
	END;

IF @@ERROR != 0
	BEGIN
	ROLLBACK TRANSACTION
	END;
