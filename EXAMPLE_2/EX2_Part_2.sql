-------------------------------------------------  Part_2          ----------------------------------------------------------
-------------------------------------------------  Author Al-Hasan ----------------------------------------------------------
-------------------------------------------------  V:01            ----------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------
--=========================================================================================================================--

-- Go to DataBase To Use it
use MyCompany
--------------------------------------------------

-- 1.Display all the employees Data:
Select*
From Employee

-- 2.Display the employee First name, last name, Salary and Department number:
Select Fname, Lname, Salary, Dno
From Employee

-- 3.Display all the projects names, locations and the department which is responsible for it:
Select Pname, Plocation, Dnum
From Project

/*4.If you know that the company policy is to pay an annual commission for each employee
with specific percent equals 10% of his/her annual salary 
.Display each employee full name and his annual commission in an ANNUAL COMM column (alias).*/
Select Fname + ' ' + Lname AS fullName , (Salary *12*.10) AS [ANNUAL COMM] -- Know this by search
From Employee

-- 5.Display the employees Id, name who earns more than 1000 LE monthly:
Select SSN, Fname + ' ' + Lname AS FullName
From Employee
Where Salary >= 1000

--6.Display the employees Id, name who earns more than 10000 LE annually:
Select SSN, Fname + ' ' + Lname AS FullName
From Employee
Where Salary *12 >= 10000

--7.Display the names and salaries of the female employees:
Select SSN, Fname + ' ' + Lname AS FullName , Salary
From Employee
Where Sex = 'F'

--8.Display each department id, name which is managed by a manager with id equals 968574:
Select Dnum, Dname
From Departments
Where MGRSSN = 968574

--9.Display the ids, names and locations of  the projects which are controlled with department 10:
Select Pnumber, Pname
From Project
Where Dnum = 10
--=========================================================================================================================--