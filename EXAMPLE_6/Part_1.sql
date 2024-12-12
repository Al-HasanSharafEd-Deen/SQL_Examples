-------------------------------------------------  Assign_8         ----------------------------------------------------------
-------------------------------------------------  Author Al-Hasan   ----------------------------------------------------------
-------------------------------------------------  V:Part_1          ----------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------
--===========================================================================================================================--

-- Go to DataBase To Use it
use ITI
--------------------------------------------------

-- 1.Create a view that displays the student's full name, course name if the student has a grade more than 50:
-------------------------------------------------------------------------------------------------------------------
GO
Create View vw_StudentsGradeMoreThan50
As
	Select CONCAT_WS(' ' , Stdnt.St_Fname ,  Stdnt.St_Lname) 'FullName' , Crs.Crs_Name  'CourseName' , StCrs.Grade
	From Student Stdnt join Stud_Course StCrs
	On Stdnt.St_Id = StCrs.St_Id join Course Crs
	On Crs.Crs_Id = StCrs.Crs_Id
	Where StCrs.Grade > 50
GO

-- 2.Create an Encrypted view that displays manager names and the topics they teach:
-------------------------------------------------------------------------------------
GO
Create View vw_GetManagersNameTopics
With Encryption
As
Select Distinct Inst.Ins_Name , Tpc.Top_Name
From Instructor Inst join Department Dept
On Inst.Ins_Id = Dept.Dept_Manager join Ins_Course InsCrs
On InsCrs.Ins_Id = InsCrs.Ins_Id join Course Crs
On InsCrs.Crs_Id = Crs.Crs_Id join Topic Tpc
On Crs.Top_Id = Tpc.Top_Id
GO

/*3.Create a view that will display Instructor Name, Department Name for the ‘SD’ or ‘Java’ Department
“use Schema binding”:*/
------------------------------------------------------------------------------------------------------------
GO
Create view vw_GetInstructorsSDJava
With SchemaBinding
As
	Select  Inst.Ins_Name , Dept.Dept_Name
	From dbo.Instructor Inst join dbo.Department Dept
	On Inst.Dept_Id = Dept.Dept_Id
	Where Dept.Dept_Name in ('SD' , 'Java')
GO
--describe what is the meaning of Schema Binding:
/*Schema Binding: It prevents any modifications to the underlying tables (like dropping columns) 
that would affect the view definition.*/

-- 4.Create a view “V1” that displays student data for students who live in Alex or Cairo:
-------------------------------------------------------------------------------------------
GO
Create View V1
As

	Select *
	From Student
	Where St_Address in ('Alex' , 'Cairo')
	With Check option
GO
-- Prevent the users to run the following query:
Update V1 set st_address='tanta'
Where st_address='alex'
/*Message:The attempted insert or update failed because the target view either specifies WITH CHECK OPTION
or spans a view that specifies WITH CHECK OPTION and one or more rows resulting from the operation did not qualify 
under the CHECK OPTION constraint. - The statement has been terminated.*/

-- 5.Create a view that will display the project name and the number of employees working on it. (Use MyCompany DB):
--------------------------------------------------------------------------------------------------------------------
-- Go to DataBase To Use it
use MyCompany
GO
Create View vw_GetProjectData
As
	
	Select Prjct.Pname , Count(WrksFor.ESSN) 'EmployeesNumber'
	From Project Prjct join Works_for WrksFor
	On Prjct.Pnumber = WrksFor.Pno
	Group By Prjct.Pname
GO

-- Using IKEA Company DB
/*1.Create a view named “v_clerk” that will display employee Number, project Number,
the date of hiring of all the jobs of the type 'Clerk':*/
-------------------------------------------------------------------------------------
-- Go to DataBase To Use it
use IKEA_Company

GO
Create View v_clerk 
As
Select EmpNo 'EmployeeNumber' , ProjectNo 'ProjectNumber' , Enter_Date 'DateOfHiring'
From Works_on
Where Job = 'Clerk'
GO

-- 2.Create view named  “v_without_budget” that will display all the projects data without budget:
---------------------------------------------------------------------------------------------------
GO
Create View v_without_budget
As
	Select ProjectNo , ProjectName
	From HR.Project
GO

-- 3.Create view named  “v_count “ that will display the project name and the Number of jobs in it:
----------------------------------------------------------------------------------------------------
GO
Create View v_Count
As

	Select Prjct.ProjectName , Count(WrkOn.job) 'NumoJobs'
	From HR.Project Prjct join Works_on WrkOn
	On WrkOn.ProjectNo = Prjct.ProjectNo
	Group by Prjct.ProjectName
GO

/*4.Create view named ” v_project_p2” that will display the emp# s for the project# ‘p2’
(use the previously created view  “v_clerk”):*/
----------------------------------------------------------------------------------------------------
GO
Create View v_project_p2
As
	Select EmployeeNumber
	From v_clerk
	Where ProjectNumber = 2 --Project Num Is Int Data Type So That I filterd by 2 Not P2
GO

-- 5.modify the view named  “v_without_budget”  to display all DATA in project p1 and p2:
------------------------------------------------------------------------------------------
GO
Create or Alter View v_without_budget
As
	Select ProjectNo , ProjectName
	From HR.Project
	Where ProjectNo in (1 , 2)--Project Num Is Int Data Type So That I filterd by 1 , 2 Not P1 , P2
GO

-- 6.Delete the views  “v_ clerk” and “v_count”:
-------------------------------------------------
DROP View v_clerk , v_Count

-- 7.Create view that will display the emp# and emp last name who works on deptNumber is ‘d2’:
----------------------------------------------------------------------------------------------
GO
Create view vw_GetEmployeeDepartment
As
	Select EmpNo , EmpLname
	From HR.Employee
	Where DeptNo = 2 --Dept Num Is Int Data Type So That I filterd by 2 Not P2
GO

-- 8.Display the employee  lastname that contains letter “J” (Use the previous view created in Q#7):
------------------------------------------------------------------------------------------------------
Select EmpLname
From vw_GetEmployeeDepartment
Where EmpLname like '%J%' -- Empty Record

-- 9.Create view named “v_dept” that will display the department# and department name:
--------------------------------------------------------------------------------------
GO
Create or Alter View v_dept 
As
	Select DeptNo 'DepartNumber' , DeptName 'DepartName'
	From Department
GO

-- 10.using the previous view try enter new department data where dept# is (d4) and dept name is ‘Development’:
----------------------------------------------------------------------------------------------------------------
Insert Into v_dept
Values (4 , 'Development')
-- Violation of PRIMARY KEY constraint 'PK__Departme__0148CAAE2CE4D0FE'. Cannot insert duplicate key in object 'dbo.Department'. The duplicate key value is (4).

/* 11.Create view name “v_2006_check” that will display employee Number,
the project Number where he works and the date of joining the project which must be from the first of January
and the last of December 2006.this view will be used to insert data so make sure
that the coming new data must match the condition:*/
------------------------------------------------------------------------------------------------------------------
GO
Create View v_2006_check
As
	Select EmpNo 'EmployeeNumber' , ProjectNo 'ProjectNumber' , Enter_Date
	From Works_on
	Where Enter_Date between '01-01-2006' and '12-31-2006'
	With Check option
GO
--===========================================================================================================================--


