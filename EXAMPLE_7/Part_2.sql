-------------------------------------------------  Assign_9          ----------------------------------------------------------
-------------------------------------------------  Author Al-Hasan   ----------------------------------------------------------
-------------------------------------------------  V:Part_2          ----------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------
--===========================================================================================================================--

-- Go to DataBase To Use it
use MyCompany
--------------------------------------------------

-- 1.Create a trigger that prevents the insertion Process for Employee table in March:
----------------------------------------------------------------------------------------
GO
Create Trigger T_PreventEmployeeInsertionProcess
On Employee
Instead of Insert
As
	Begin
		IF Format(GetDate() , 'MM') = 'March'
			Print 'You can''t insert a record in march'
		Else
			Insert into Employee
			Select *
			From Inserted

	End
GO

--2.Create an Audit table with the following structure:
-----------------------------------------------------------
-- Go to DataBase To Use it
use IKEA_Company
--------------------------------------------------

Create Table Audit
(
    ProjectNo int,
    UserName varchar(30),
    ModifiedDate Date,
    Budget_Old int,
    Budget_New int
)

/*This table will be used to audit the update trials on the Budget column (Project table, Company DB)
If a user updated the budget column then the project number, username that made that update,
the date of the modification and the value of the old and the new budget will be inserted into the Audit table
(Note: This process will take place only if the user updated the budget column)*/
GO
Create Trigger HR.BudgetUpdate
On HR.Project
After Update
As
	If Update(Budget)
		Begin
			Declare @projectNum int , @OldBudget int , @NewBudget int

			Select @OldBudget = Budget from deleted
			Select @NewBudget = Budget From inserted
			Select @projectNum = ProjectNo From inserted

			Insert Into [Audit]
			Values (@projectNum , USER_NAME() , GetDate() , @OldBudget , @NewBudget)
		End
GO
--===========================================================================================================================--