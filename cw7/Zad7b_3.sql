USE AdventureWorks2019;
GO;

CREATE OR ALTER TRIGGER taxRateMonitoring ON Sales.SalesTaxRate
AFTER INSERT, UPDATE
AS
BEGIN
	IF EXISTS(
		SELECT 1
		FROM inserted i 
		JOIN deleted d
		ON (ABS(i.TaxRate - d.TaxRate) / d.TaxRate) > 0.3
	)
	BEGIN
		PRINT N'B³¹d - Modyfikacja przekracza 30%'
	END;
END;

