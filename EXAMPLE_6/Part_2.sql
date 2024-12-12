-------------------------------------------------  Assign_8         ----------------------------------------------------------
-------------------------------------------------  Author Al-Hasan   ----------------------------------------------------------
-------------------------------------------------  V:Part_2          ----------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------
--===========================================================================================================================--

-- 1.Create a stored procedure to show the number of students per department.[use ITI DB] :
------------------------------------------------------------------------------------------
-- Go to DataBase To Use it
use ITI
GO
Create Procedure SP_GetStudentsDeparmtent
As
	Begin
	Select Dept.Dept_Name , Count(Stdnt.St_Id) 'NumOfStudents'
	From Student Stdnt join Department Dept
	On Stdnt.Dept_Id = Dept.Dept_Id
	Group by Dept.Dept_Name
	End
GO

/*2.Create a stored procedure that will check for the Number of employees in the project 100
if they are more than 3 print message to the user “'The number of employees in the project 100 is 3 or more'”
if they are less display a message to the user “'The following employees work for the project 100'” 
in addition to the first name and last name of each one. [MyCompany DB]:*/
------------------------------------------------------------------------------------------------------------------
-- Go to DataBase To Use it
use MyCompany
GO
Create Procedure SP_GetEmployeesNumber
AS
	Begin
		Declare @EmployeesNum int

		Select  @EmployeesNum=  Count(ESSN)
		From Works_For
		Where Pno = 100

		If (@EmployeesNum > 3)
			Select 'The number of employees in the project 100 is 3 or more'
		Else
			Select 'The following employees work for the project 100'

			Select CONCAT_WS (' ' , Fname , Lname) 'FullName'
			From Employee Emp join Works_for WrksFor
			On Emp.SSN = WrksFor.ESSn
			Where Pno = 100
	End
GO

/* 3.Create a stored procedure that will be used in case an old employee has left the project and a new one becomes his replacement.
The procedure should take 3 parameters (old Emp. number, new Emp. number and the project number)
and it will be used to update works_on table. [MyCompany DB]:*/
--------------------------------------------------------------------------------------------------------------------------------------
GO
Create Procedure SP_UpdateEmpProject @OldEmp int , @NewEmp int , @Prjctnum int
As
	Begin
		Update Works_for
		Set ESSn = @NewEmp
		Where ESSn = @OldEmp and Pno = @Prjctnum
	End
GO
--===========================================================================================================================--