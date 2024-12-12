-------------------------------------------------  Part_1          ----------------------------------------------------------
-------------------------------------------------  Author Al-Hasan ----------------------------------------------------------
-------------------------------------------------  V:01            ----------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------
--=========================================================================================================================--

-- Go to DataBase To Use it
use ITI
--------------------------------------------------

-- 1.Display instructors who have salaries less than the average salary of all instructors:
--------------------------------------------------------------------------------------------
Select Ins_Id , Ins_Name, Salary
From Instructor
Where Salary < (Select AVG(Salary) From Instructor)

-- 2.Display the Department name that contains the instructor who receives the minimum salary:
-----------------------------------------------------------------------------------------------
Select Dprt.Dept_Name
From Department Dprt Join Instructor Inst
On Dprt.Dept_Id = Inst.Dept_Id
Where Inst.Salary = (Select MIN(Salary) From Instructor)

-- 3.Select max two salaries in instructor table.
--------------------------------------------------
Select TOP(2) Salary
From Instructor
Order by Salary DESC

-- 9.Write a query to select the highest two salaries in Each Department for instructors who have salaries. “Using one of Ranking Functions”:
----------------------------------------------------------------------------------------------------------------------------------------------
Select Dept_Id, Ins_Id, Ins_Name, Salary
From (Select Dept_Id, Ins_Id, Ins_Name, Salary,
	  ROW_NUMBER() OVER(PARTITION BY Dept_Id ORDER BY Salary DESC) 'Rank'
	  From Instructor
	  Where Salary Is not Null) [Rank Salaries]
Where Rank <= 2

-- 10.Write a query to select a random student from each department.  “Using one of Ranking Functions”:
--------------------------------------------------------------------------------------------------------
Select Dept_Id, st_Id, St_Fname, St_Lname
From (Select Dept_Id, st_Id, St_Fname, St_Lname,
	  ROW_NUMBER() OVER(PARTITION BY Dept_Id ORDER BY NEWID()) 'Rank'
	  From Student
	  Where Dept_Id Is not Null) [Random Students]
Where Rank = 1
--=========================================================================================================================--

-- Go to DataBase To Use it
use MyCompany
--------------------------------------------------

-- 4.Display the data of the department which has the smallest employee ID over all employees' ID:
---------------------------------------------------------------------------------------------------
Select *
From Departments dprts
Where dprts.Dnum = (Select dprts.Dnum
					From Employee 
					Where SSN = (Select MIN(SSN) From Employee))

-- 5.List the last name of all managers who have no dependents:
----------------------------------------------------------------
Select Emp.Lname
From Employee Emp
Where Emp.SSN NOT IN ( Select dpnt.ESSN From Dependent dpnt)

/* 6.For each department-- if its average salary is less than the average salary of all employees
displays its number, name and number of its employees*/
---------------------------------------------------------------------------------------------------
Select Dprt.Dnum , Dprt.Dname, COUNT(Emp.SSN) 'Emp Count'
From Departments Dprt Join Employee Emp
On Dprt.Dnum = Emp.Dno
Group By Dprt.Dnum , Dprt.Dname
Having AVG(Emp.Salary) < (Select AVG (Salary) From Employee)

-- 7.Try to get the max 2 salaries using subquery: 
---------------------------------------------------
Select DISTINCT Salary
From Employee
Where Salary IN (
    Select DISTINCT TOP 2 Salary
    From Employee
    Order By Salary DESC
)
Order By Salary DESC;

-- 8.Display the employee number and name if he/she has at least one dependent (use exists keyword) self-study:
----------------------------------------------------------------------------------------------------------------
Select Emp.SSN, Emp.Fname, Emp.Lname
From Employee Emp
Where EXISTS ( Select 1
			   From Dependent Dpnt
			   Where Emp.SSN = Dpnt.ESSN )

-- 9 and 10 afater number 3 in USE ITI ^
--=========================================================================================================================--

