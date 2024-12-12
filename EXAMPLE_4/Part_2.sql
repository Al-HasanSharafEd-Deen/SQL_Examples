-------------------------------------------------  Part_2          ----------------------------------------------------------
-------------------------------------------------  Author Al-Hasan ----------------------------------------------------------
-------------------------------------------------  V:01            ----------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------
--=========================================================================================================================--

-- Go to DataBase To Use it
use AdventureWorks2012
--------------------------------------------------

/*1.Display the SalesOrderID, ShipDate of the SalesOrderHearder table (Sales schema) to designate
SalesOrders that occurred within the period ‘7/28/2002’ and ‘7/29/2014’*/
---------------------------------------------------------------------------------------------------
Select SalesOrderID, ShipDate
From Sales.SalesOrderHeader
Where ShipDate Between '2002-07-28' And '2014-07-29'

-- 2.Display only Products(Production schema) with a StandardCost below $110.00 (show ProductID, Name only):
-------------------------------------------------------------------------------------------------------------
Select ProductID, Name
From Production.Product
Where StandardCost < 110.00

-- 3.Display ProductID, Name if its weight is unknown:
-------------------------------------------------------
Select ProductID, Name
From Production.Product
Where weight is null

-- 4.Display all Products with a Silver, Black, or Red Color:
--------------------------------------------------------------
Select ProductID, Name, Color
From Production.Product
Where Color in('Silver', 'Black' , 'Red')

-- 5.Display any Product with a Name starting with the letter B:
-----------------------------------------------------------------
Select ProductID, Name
From Production.Product
Where Name like 'B%'

-- 6.Run the following Query:
------------------------------
UPDATE Production.ProductDescription
SET Description = 'Chromoly steel_High of defects'
Where ProductDescriptionID = 3

-- 7.Then write a query that displays any Product description with underscore value in its description:
--------------------------------------------------------------------------------------------------------
Select ProductDescriptionID, Description
From Production.ProductDescription
Where Description LIKE '%_%'

-- 8.Display the Employees HireDate (note no repeated values are allowed):
---------------------------------------------------------------------------
Select DISTINCT HireDate
From HumanResources.Employee

/*9.Display the Product Name and its ListPrice within the values of 100 and 120 the list should
have the following format "The [product name] is only! [List price]" 
(the list will be sorted according to its ListPrice value)*/
-------------------------------------------------------------------------------------------------
Select 'The' + Name + 'is Only' + CAST(ListPrice AS varchar) [Product Information] --Cast to can display it with the other string
From Production.Product
Where ListPrice Between 100 And 120
Order By ListPrice
--=========================================================================================================================--