-------------------------------------------------  Part_2          ----------------------------------------------------------
-------------------------------------------------  Author Al-Hasan ----------------------------------------------------------
-------------------------------------------------  V:01            ----------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------
--=========================================================================================================================--

-- Go to DataBase To Use it
use MyCompany
--------------------------------------------------

-- 1.Display the Department id, name and id and the name of its manager:
Select Dept.Dnum, Dept.Dname, Manager.SSN, Manager.Fname + ' ' + Manager.Lname As [Full Name]
From Departments Dept Inner Join Employee Manager
On Manager.SSN = Dept.MGRSSN

-- 2.Display the name of the departments and the name of the projects under its control:
Select Dept.Dname, Pname
From Departments Dept Inner Join Project Pro
On Dept.Dnum = Pro.Dnum

-- 3.Display the full data about all the dependence associated with the name of the employee they depend on:
Select Depns.*, Emp.Fname + ' ' + Emp.Lname 'Emp_Name'
From Dependent Depns Inner Join Employee Emp
On Emp.SSN = Depns.ESSN

-- 4.Display the Id, name and location of the projects in Cairo or Alex city:
Select Pro.Pnumber, Pro.Pname, Pro.Plocation
From Project Pro
Where City in ('Cairo' , 'Alex')

-- 5.Display the Projects full data of the projects with a name starting with "a" letter:
Select *
From Project Pro
Where pname Like 'a%'

-- 6.display all the employees in department 30 whose salary from 1000 to 2000 LE monthly:
Select *
From Employee 
Where Dno = 30 And Salary Between 1000 and 2000

-- 7.Retrieve the names of all employees in department 10 who work more than or equal 10 hours per week on the "AL Rabwah" project:
Select Fname + ' ' + Lname As Nume
From Employee Emp
Join Works_for WFOR
On Emp.SSN = WFOR.ESSn
Join Project Pro
On Pro.Pnumber = WFOR.Pno
Where Emp.Dno = 10 And WFOR.Hours >= 10 And Pro.Pname = 'AL Rabwah'

-- 8.Retrieve the names of all employees and the names of the projects they are working on, sorted by the project name:
Select Fname + ' ' + Lname As Nume , Pro.Pname
From Employee Emp
Join Works_for WFOR
On Emp.SSN = WFOR.ESSn
Join Project Pro
On Pro.Pnumber = WFOR.Pno
Order by Pro.Pnumber

/*9.For each project located in Cairo City , find the project number, the controlling department name 
,the department manager last name ,address and birthdate:*/
Select pro.Pnumber, Dept.Dname, Emp.Lname, Emp.Address, Emp.Bdate
From Project Pro
Join Departments Dept
On Dept.Dnum = Pro.Dnum
Join Employee Emp
On Emp.Superssn = Dept.MGRSSN
Where Pro.City = 'Cairo'
--=========================================================================================================================--