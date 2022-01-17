/*
Author: Steven Clark
Description : Answers to the 5 Interview Questions 
Created : 17/01/2022
*/

-- Question 1
SELECT COUNT(MiddleName) AS 'Middle Name Count'
FROM SalesLT.Customer
;
-- Question 2
SELECT TOP 1
   Left(FirstName,1) AS 'First Name Initial',
   Count(*) AS 'Initial Count'
FROM SalesLT.Customer
GROUP BY left(Customer.FirstName,1)
ORDER BY 'Initial Count' DESC
;

-- Question 3
SELECT 
    Cst.CompanyName AS 'Company Name',
    Adr.AddressID AS 'Address ID'
FROM SalesLT.Customer AS Cst
JOIN SalesLT.CustomerAddress AS CstAdr	ON CstAdr.CustomerID = Cst.CustomerID
JOIN SalesLT.Address AS Adr ON CstAdr.AddressID = Adr.AddressID
WHERE Cst.CompanyName = 'Family''s Favorite Bike Shop'
AND CstAdr.AddressType = 'Shipping'
;


-- Question 4
-- Note : 'Postal Order column' within question has been assumed to be 'Postal Code' Column.
WITH LargestOrder AS (
	SELECT TOP 1
		CustomerID, 
		SUM(TotalDue) AS [SUM TotalDue]
	FROM SalesLT.SalesOrderHeader
	GROUP BY CustomerID
	ORDER BY [SUM TotalDue] DESC
),
GetMainOfficePostalCode AS (
	SELECT 
		CstAdr.CustomerID,
		Adr.PostalCode
	FROM SalesLT.CustomerAddress AS CstAdr
	JOIN SalesLT.Address AS Adr ON CstAdr.AddressID = Adr.AddressID
	WHERE CstAdr.AddressType = 'Main Office'
)
SELECT PostalCode AS [Postal Code] 
FROM GetMainOfficePostalCode 
WHERE CustomerID = (
	SELECT CustomerID FROM LargestOrder
	)
;

--Question 5
SELECT ('Returns all Mountain Bikes, Road Bikes & Touring Bikes that have not had a sale.') AS 'Question 5 Answer'
