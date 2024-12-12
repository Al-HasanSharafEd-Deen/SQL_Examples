-------------------------------------------------  Assign_7          ----------------------------------------------------------
-------------------------------------------------  Author Al-Hasan   ----------------------------------------------------------
-------------------------------------------------  V:01              ----------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------
--===========================================================================================================================--

-- Go to DataBase To Use it
use ITI
--------------------------------------------------
Go
-- 1.Create a scalar function that takes a date and returns the Month name of that date:
-----------------------------------------------------------------------------------------
Create Function GetMonthName(@InputDate Date)
Returns Varchar(20)
As
Begin
	Return DATENAME(MONTH, @InputDate)
End
Go
-- Example:
Select dbo.GetMonthName(GETDATE()) As [Month Name]
Go

-- 2.Create a multi-statements table-valued function that takes 2 integers and returns the values between them:
----------------------------------------------------------------------------------------------------------------
Create Function GetValuesBetween2Num(@StartNum int, @EndNum int)
Returns @Values Table (Value int)
As
Begin
	Declare @Count int = @StartNum
	While @Count <= @EndNum
	Begin
		Insert Into @Values (Value) Values (@Count)
		Set @Count += 1

	End
	Return
End
Go
-- Example:
Select * From dbo.GetValuesBetween2Num(1,6)
Go

-- 3.Create a table-valued function that takes Student No and returns Department Name with Student full name:
--------------------------------------------------------------------------------------------------------------
Create Function GetDataOfStudent(@StudentNo int)
Returns Table
As 
Return
(
	Select Dprt.Dept_Name [Dept Name] , CONCAT_WS(' ', Std.St_Fname, Std.St_Lname) 'Student Name'
	From Student Std Join Department Dprt
	On Dprt.Dept_Id = Std.Dept_Id
	Where Std.St_Id = @StudentNo
)
Go
--Example:
Select * From dbo.GetDataOfStudent(6)
Go

-- 4.Create a scalar function that takes Student ID and returns a message to user:
-----------------------------------------------------------------------------------
Create Function CheckNameStdNull(@StudentNo int)
Returns varchar(50)
As
Begin
	Declare @Message varchar(50)
	Select @Message =
		Case  -- I solved it in first by IF and ELSE IF but I don't love it, Search if we can use Switch Cases as programming and found this.
			When St_Fname Is Null And St_Lname Is Null Then 'First name & last name are null'
			When St_Fname Is Null Then 'First name is null'
			When St_Lname Is Null Then 'Last name is null'
			Else 'First name & last name are not null'
		End
	From Student 
	where St_Id = @StudentNo
	Return @Message
End
Go
--Example:
Select dbo.CheckNameStdNull(6) 'System Message'
Go

/*5.Create a function that takes an integer which represents the format of the Manager hiring date
and displays department name, Manager Name and hiring date with this format:*/
----------------------------------------------------------------------------------------------------
Create Function GetDataOfManager(@Format int)
Returns Table
As
Return
(
	Select Dept_Name 'Department Name', (Select Ins_Name
										 From Instructor
										 Where Ins_Id = Dept_Manager) 'Manager Name',
										 CONVERT(Varchar, Manager_Hiredate, @Format) 'Hiring Date'
	From Department
)
Go
--Example:
Select * From dbo.GetDataOfManager(101)
Select * From dbo.GetDataOfManager(111)
Go

--6.Create multi-statement table-valued function that takes a string:
----------------------------------------------------------------------
Create Function CheckNameStdNull2(@InputString Varchar(50))
Returns @Result Table (Message Varchar(50))
As
Begin
	Declare @FirstName Varchar(50)
    Declare @LastName Varchar(50)

    -- Retrieve the first and last name for the
    Select TOP 1 @FirstName = St_Fname, @LastName = St_Lname
    From Student

    -- Check the conditions and insert into the result table
    If @FirstName IS NULL AND @LastName IS NULL
        Insert Into @Result Values ('First name & last name are null')
    Else If @FirstName IS NULL
        Insert Into @Result Values ('First name is null')
    Else If @LastName IS NULL
        Insert Into @Result Values ('Last name is null')
    Else
        Insert Into @Result Values ('First name & last name are not null')

    Return
End
GO
--Example:
Select * From dbo.CheckNameStdNull2('Test')
Go

-- 7.Create function that takes project number and display all employees in this project (Use My Company DB):
--------------------------------------------------------------------------------------------------------------
Use MyCompany
go
Create Function GetEmpOnProject(@ProjectNum int)
Returns Table
As
Return
(
	Select Emp.Fname [Emp Name], Prjct.Pname [Project Name]
	From Employee Emp Join Works_for WrkFor
	On Emp.SSN = WrkFor.ESSn
	Join Project Prjct
	On Prjct.Pnumber = WrkFor.Pno
	Where Prjct.Pnumber = @ProjectNum
)
Go
--Example:
Select * From dbo.GetEmpOnProject(400)
--===========================================================================================================================--