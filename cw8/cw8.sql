USE AdventureWorks2019;
--ZAD 1--

WITH Person_Data
AS
(
	SELECT p.BusinessEntityID, p.FirstName, p.MiddleName, p.LastName, hr_e.JobTitle, hr_ph.Rate, hr_ph.PayFrequency FROM Person.Person p
	JOIN HumanResources.Employee hr_e ON
	hr_e.BusinessEntityID = p.BusinessEntityID
	JOIN HumanResources.EmployeePayHistory hr_ph ON
	hr_ph.BusinessEntityID = p.BusinessEntityID
)
SELECT * into temp_table from Person_Data

Select * from temp_table order by LastName

--ZAD 2--

USE AdventureWorksLT2019
go

WITH Total_Revenue
AS
(
	SELECT c.CompanyName, soh.totalDue FROM SalesLT.Customer c
	JOIN
	SalesLT.SalesOrderHeader soh ON
	soh.CustomerID = c.CustomerID
)
SELECT * FROM Total_Revenue order by CompanyName;

--ZAD3--

WITH Category_Sales
AS
(
	SELECT pc.Name as Category, SUM(sod.LineTotal) as SalesValue  FROM SalesLT.Product pr
	JOIN
	SalesLT.ProductCategory pc ON
	pc.ProductCategoryID = pr.ProductCategoryID
	JOIN
	SalesLT.SalesOrderDetail sod ON
	pr.ProductID = sod.ProductID
	Group by
	pc.Name
)

SELECT * FROM Category_Sales;