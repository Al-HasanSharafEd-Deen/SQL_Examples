-------------------------------------------------  Assign_10         ----------------------------------------------------------
-------------------------------------------------  Author Al-Hasan   ----------------------------------------------------------
-------------------------------------------------  V:Part_3          ----------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------
--===========================================================================================================================--

-- Go to DataBase To Use it
use RouteCompany

/* 1.Create the following tables with all the required information and
load the required data as specified in each table using insert statements[at least two rows]:*/
--------------------------------------------------------------------------------------------------

-- 1.1.Create Department Table:
----------------------------
Create Table Department
(
	DeptNo CHAR(5) PRIMARY KEY,
    DeptName VARCHAR(50) NOT NULL,
    Location VARCHAR(50) NOT NULL
)
-- Insert Sample Data:
-----------------------
Insert Into Department 
Values ('d1', 'Research' , 'NY'),('d2', 'Accounting' , 'DS'),('d3', 'Marketing' , 'KW')

-- 1.2.Create Department Table:
----------------------------
Create Table Employee
(
	EmpNo INT PRIMARY KEY,
    EmpFname VARCHAR(50) Not Null,
    EmpLname VARCHAR(50) Not Null,
    Salary DEC(10, 2) UNIQUE Not Null,
    DeptNo CHAR(5) Not Null REFERENCES Department(DeptNo)
)
-- Insert Sample Data:
-----------------------
Insert Into Employee (EmpNo, EmpFname, EmpLname, DeptNo, Salary)
Values (25348, 'Mathew', 'Smith', 'd3', 2500  ),
       (10102, 'Ann', 'Jones', 'd3', 3000     ),
       (18316, 'John', 'Barrymore', 'd1', 2400),
       (29346, 'James', 'James', 'd2', 2800   ),
       (9031,  'Lisa', 'Bertoni', 'd2', 4000  ),
       (2581,  'Elisa', 'Hansel', 'd2', 3600  ),
       (28559, 'Sybl', 'Moser', 'd1', 2900    )

-- 1.3.Create Project Table by Wizard:
---------------------------------------
-- Insert Sample Data by Wizard
---------------------------------------

-- 1.4.Create Works_on Table by Wizard:
---------------------------------------
-- Insert Sample Data by Wizard
---------------------------------------


-- 1.5.Testing Referential Integrity:
--------------------------------------
-- 1:
Insert Into Works_on (EmpNo, ProjectNo, Job, Enter_Date)
Values (11111, 'p1', 'Clerk', '2024-12-01')
-- Foreign key constraint with Employee table So This will fail  

-- 2:
Update Works_on
Set EmpNo = 11111
Where EmpNo = 10102
-- Foreign key constraint with Employee table So This will fail

-- 3:
Update Employee
Set EmpNo = 22222
Where EmpNo = 10102
-- This will fail Beacuse the foreign key dependency in Works_on

-- 4:
Delete From Employee
Where EmpNo = 10102;
-- This will fail Beacuse the foreign key dependency in Works_on
-----------------------------------------------------------------

-- 1.6.Table Modification:
---------------------------

-- 1: 
ALTER Table Employee
Add TelephoneNumber VARCHAR(15)

--2:
ALTER Table Employee
DROP COLUMN TelephoneNumber

-- 3:
-- Create Diagram
---------------------------------------------------------------------------------


/* 2.Create the following schema and transfer the following tables to it 
         --Company Schema 
                 1. Department table 
                 2..Project table 
         --Human Resource Schema
                 1.Employee table:*/
------------------------------------------------------------------------------- 

-- 2.1: Create Schemas
------------------------
Create Schema Company
Create Schema HumanResource

-- 2.2: Move tables:
-----------------------
ALTER Schema Company 
TRANSFER dbo.Department

ALTER Schema Company 
TRANSFER dbo.Project

ALTER Schema HumanResource 
TRANSFER dbo.Employee
------------------------------------------------------------------------------- 

-- 3.Increase the budget of the project where the manager number is 10102 by 10%:
---------------------------------------------------------------------------------- 
UPDATE Company.Project
Set Budget *= 1.1
Where ProjectNo IN (Select ProjectNo
                    From Works_on
                    Where EmpNo = 10102)
---------------------------------------------------------------------------------- 


-- 4.Change the name of the department for which the employee named James works. The new department name is Sales:
-------------------------------------------------------------------------------------------------------------------
UPDATE Company.Department
Set DeptName = 'Sales'
Where DeptNo = (Select DeptNo
				From HumanResource.Employee
				Where EmpFname = 'James')
---------------------------------------------------------------------------------- 

/*5.Change the enter date for the projects for those employees
who work in project p1 and belong to department ‘Sales’. The new date is 12.12.2007:*/
-------------------------------------------------------------------------------------------------------------------
UPDATE dbo.Works_on
Set Enter_Date = '2007-12-12'
Where ProjectNo = 'p1'
  AND EmpNo IN (Select EmpNo
                From HumanResource.Employee
                Where DeptNo = (Select DeptNo
                                From Company.Department
                                Where DeptName = 'Sales')
			   )
---------------------------------------------------------------------------------- 

--6.Delete the information in the works_on table for all employees who work for the department located in KW:
-------------------------------------------------------------------------------------------------------------------
DELETE From dbo.Works_on
Where EmpNo IN (Select EmpNo
                From HumanResource.Employee
                Where DeptNo = (Select DeptNo
                                From Company.Department
                                Where Location = 'KW')
				)
--===========================================================================================================================--