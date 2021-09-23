USE AdventureWorks2019

--1
SELECT COUNT(ProductID) FROM Production.Product;

--2
SELECT COUNT(ProductID) FROM Production.Product
WHERE ProductSubcategoryID IS NOT NULL
GROUP BY ProductSubcategoryID;

--3
SELECT ProductSubcategoryID, COUNT(ProductID) as [Total Number] FROM Production.Product
WHERE ProductSubcategoryID IS NOT NULL
GROUP BY ProductSubcategoryID;

--4
SELECT COUNT(ProductID) as [Total Number] FROM Production.Product
WHERE ProductSubcategoryID IS NULL;

--5
SELECT SUM(Quantity) FROM Production.ProductInventory

--6?
SELECT COUNT(ProductID) FROM Production.ProductInventory;
UPDATE Production.ProductInventory SET LocationID =40;

--7?
SELECT COUNT(ProductID) FROM Production.ProductInventory;
UPDATE Production.ProductInventory SET LocationID =40;

--8
SELECT AVG(Quantity) FROM Production.ProductInventory
WHERE LocationID = 10;

--9
SELECT AVG(Quantity) FROM Production.ProductInventory
GROUP BY Shelf;


--10
SELECT Shelf, AVG(Quantity) AS Shelf_Rank FROM Production.ProductInventory
WHERE Shelf != 'N/A'
GROUP BY Shelf
ORDER BY 2;

--11
SELECT Color, Class, ROUND(AVG(ListPrice),2) as Average_List_Price FROM Production.Product
WHERE Color IS NOT NULL AND Class IS NOT NULL
GROUP BY Color, Class
ORDER BY Average_List_Price;

--12 
SELECT pc.Name AS Country, Ps.Name AS Province 
FROM Person.CountryRegion pc INNER JOIN person.StateProvince ps ON ps.CountryRegionCode = pc.CountryRegionCode
ORDER BY pc.Name, ps.Name;

--13
SELECT pc.Name AS Country, Ps.Name AS Province 
FROM Person.CountryRegion pc INNER JOIN person.StateProvince ps ON ps.CountryRegionCode = pc.CountryRegionCode
WHERE pc.Name IN ('Germany','Canada')
ORDER BY pc.Name, ps.Name;