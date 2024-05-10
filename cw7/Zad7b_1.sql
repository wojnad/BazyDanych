USE AdventureWorks2019;
GO

CREATE OR ALTER FUNCTION Fibonacci(@n INT)
RETURNS BIGINT
AS
BEGIN
	DECLARE @T BIGINT = 0; -- tymczasowa zmienna do zamiany
	DECLARE @n0 BIGINT = 0; -- pocz¹tkowa wartoœæ - zerowy element
	DECLARE @n1 BIGINT = 1; -- pierwszy element 
	DECLARE @i INT = 0; -- iterator

	WHILE @i < @n
	BEGIN
		SET @T = @n0 + @n1;
		SET @n0 = @n1;
		SET @n1 = @T;
		SET @i = @i+1;
	END;

	RETURN @n0;
END;

GO

CREATE OR ALTER PROCEDURE Fibonacci_Printer
@n INT
AS
BEGIN
	PRINT 'Ci¹g Fibonacciego dla '+CAST(@n AS varchar(5))+' elementów: ';
	DECLARE @i INT = 0;
	WHILE @i < @n
	BEGIN
		PRINT CAST(dbo.Fibonacci(@i) as varchar(20)) + ' ';
		SET @i = @i + 1;
	END;

END;

GO

EXEC Fibonacci_Printer 90;