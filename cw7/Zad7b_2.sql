USE AdventureWorks2019;

GO

CREATE OR ALTER TRIGGER majusculeSurname ON Person.Person
AFTER INSERT
AS
BEGIN
	UPDATE Person.Person
	SET LastName = UPPER(LastName) FROM Person.Person;
END;

INSERT INTO Person.Person (FirstName, LastName, BusinessEntityID, PersonType)
VALUES ('Jacob', 'Zigarlovsky', 306, 'EM')

SELECT p.FirstName, p.LastName, p.BusinessEntityID FROM Person.Person p
ORDER BY p.LastName;