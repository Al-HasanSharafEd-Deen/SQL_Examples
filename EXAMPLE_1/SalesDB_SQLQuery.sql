-------------------------------------------------  Sales Database  ----------------------------------------------------------
-------------------------------------------------  Author Al-Hasan ----------------------------------------------------------
-------------------------------------------------  V:01            ----------------------------------------------------------

--=========================================================================================================================--
-- Craete Database
Create Database Sales

-- Go to DataBase To Use it
use Sales
--------------------------------------------------
-- Create Table and Column:

-- Sales Offices Table
Create Table SalesOffices
(
Number int Primary Key Identity,
Location varchar(30) not null,
EmpId int Unique
)

-- Employees Table
Create Table Employees
(
Id int Primary Key Identity(1,1),
Name varchar(30) not null,
OfficeNum int References SalesOffices(Number)
)
-- Make EmpId Foreign Key After Create Employees Table
Alter Table SalesOffices
Add foreign key (EmpId) References Employees(Id)

-- Property Table
Create Table Properties
(
PropId int Primary Key,
Adress varchar(30) not null,
City varchar (30) not null,
State varchar(30) not null,
Code int,
OfficeNum int References SalesOffices(Number)
)

-- Owner Table
Create Table Owners
(
OwnerId int Primary Key,
OwnerName Varchar(30) not null
)

--Create Own M:M Relationship Table
Create Table PropOwners
(
OwnId int References Owners(OwnerId) not null,
PropId int References Properties(PropId) not null,
Precent dec(5,2) not null,
Primary Key (OwnId , PropId)
)
--=========================================================================================================================--