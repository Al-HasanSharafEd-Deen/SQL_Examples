-------------------------------------------------  Part_2          ----------------------------------------------------------
-------------------------------------------------  Author Al-Hasan ----------------------------------------------------------
-------------------------------------------------  V:01            ----------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------
--=========================================================================================================================--

-- Go to DataBase To Use it
use MyCompany
--------------------------------------------------

-- 1.For each project, list the project name and the total hours per week (for all employees) spent on that project:
Select Prjct.Pname [Project Name] , SUM(WrkFr.Hours) 'Total Hours/Week'
From Project Prjct , Works_for WrkFr
Where Prjct.Pnumber = WrkFr.Pno
Group By Prjct.Pname

-- 2.For each department, retrieve the department name and the maximum, minimum and average salary of its employees:
Select Dprt.Dname [Department Name] , 
MAX(Emp.Salary) [Maxmum Salary],
MIN(Emp.Salary) 'Minmum Salary',
AVG(Emp.Salary) [Average Salary]
From Departments Dprt , Employee Emp
Where Dprt.Dnum = Emp.Dno
Group By Dprt.Dname
--=========================================================================================================================--