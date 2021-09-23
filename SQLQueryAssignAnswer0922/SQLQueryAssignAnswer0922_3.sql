USE Northwind

--14
SELECT p.ProductName, COUNT(o.OrderID) AS [Sold Amount]
	FROM Products p INNER JOIN [Order Details] od ON od.ProductID = p.ProductID
					INNER JOIN Orders o ON o.OrderID = od.OrderID
WHERE (YEAR(o.OrderDate) >= (SELECT YEAR(GETDATE())-25)) AND (YEAR(o.OrderDate) <= (SELECT YEAR(GETDATE())))
GROUP BY ProductName
ORDER BY [Sold Amount]

--15 
SELECT TOP 5 o.ShipPostalCode, COUNT(o.OrderID) AS [Sold Amount]
	FROM Products p INNER JOIN [Order Details] od ON od.ProductID = p.ProductID
					INNER JOIN Orders o ON o.OrderID = od.OrderID
WHERE o.ShipPostalCode IS NOT NULL
GROUP BY o.ShipPostalCode
ORDER BY [Sold Amount] DESC

--16
SELECT TOP 5 o.ShipPostalCode, COUNT(o.OrderID) AS [Sold Amount]
	FROM Products p INNER JOIN [Order Details] od ON od.ProductID = p.ProductID
					INNER JOIN Orders o ON o.OrderID = od.OrderID
WHERE o.ShipPostalCode IS NOT NULL AND (YEAR(o.OrderDate) >= (SELECT YEAR(GETDATE())-25)) AND (YEAR(o.OrderDate) <= (SELECT YEAR(GETDATE())))
GROUP BY o.ShipPostalCode
ORDER BY [Sold Amount] DESC;

--17
SELECT City, COUNT(CustomerID) AS [Customer Number] FROM Customers
GROUP BY City 
ORDER BY [Customer Number];

--18
SELECT City, COUNT(CustomerID) AS [Customer Number] FROM Customers
GROUP BY City 
HAVING  COUNT(CustomerID) >=2
ORDER BY [Customer Number];


--19? how to describe date and filter out time
SELECT c.ContactName, Year(o.OrderDate)+'-'+Month(o.OrderDate)+'-'+DAY(o.OrderDate) AS Date
	FROM Customers c INNER JOIN Orders o ON c.CustomerID = o.CustomerID
WHERE o.OrderDate >= '1998-01-01';

--20
SELECT c.ContactName, o.OrderDate
	FROM Customers c INNER JOIN Orders o ON c.CustomerID = o.CustomerID
WHERE o.OrderDate = (SELECT MAX(OrderDate) FROM Orders)

--21
SELECT c.ContactName, COUNT(o.CustomerID)
	FROM Customers c INNER JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.ContactName
ORDER BY COUNT(o.CustomerID)

--22
SELECT c.CustomerID, COUNT(o.OrderID)
	FROM Customers c INNER JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerID
HAVING COUNT(o.OrderID) >= 100;


--23?
SELECT DISTINCT spp.CompanyName AS [Supplier Company Name], s.CompanyName AS [Shipping Company Name]
	FROM Suppliers spp INNER JOIN Products p ON spp.SupplierID = p.SupplierID
					   INNER JOIN [Order Details] od ON p.ProductID = od.ProductID
					   INNER JOIN Orders o ON o.OrderID = od.OrderID
					   INNER JOIN Shippers s ON o.ShipVia = s.ShipperID
ORDER BY 1;

--24
SELECT o.OrderDate, p.ProductName
	FROM Products p INNER JOIN [Order Details] od ON p.ProductID = od.ProductID
					INNER JOIN Orders o ON od.OrderID = o.OrderID

--25? How to filter out B&A but keep the A&B pair? 
SELECT DISTINCT fe.EmployeeID, se.EmployeeID
	FROM Employees fe LEFT OUTER JOIN Employees se ON fe.Title = se.Title
WHERE fe.EmployeeID != se.EmployeeID

--26~
SELECT e.ReportsTo AS Manager
	FROM Employees e RIGHT OUTER JOIN Employees m ON e.EmployeeID = m.ReportsTo
GROUP BY e.ReportsTo
HAVING COUNT(e.ReportsTo) >= 2;

--27
SELECT City, CompanyName AS Name, ContactName AS [Contact Name], 'Customer' AS Type FROM Customers
UNION
SELECT City, CompanyName AS Name, ContactName AS [Contact Name],'Supplier' FROM Suppliers