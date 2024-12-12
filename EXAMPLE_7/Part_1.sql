-------------------------------------------------  Assign_9         ----------------------------------------------------------
-------------------------------------------------  Author Al-Hasan   ----------------------------------------------------------
-------------------------------------------------  V:Part_1          ----------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------
--===========================================================================================================================--

-- Go to DataBase To Use it
use ITI
--------------------------------------------------

/* 1.Create a trigger to prevent anyone from inserting a new record in the Department table
( Display a message for user to tell him that he can’t insert a new record in that table ):*/
------------------------------------------------------------------------------------------------
GO
Create Trigger T_PreventInsertingInDept
On Department
Instead Of Insert 
AS
	Print 'You can’t insert a new record in that table now '
GO

-- 2.Create a table named “StudentAudit”. Its Columns are (Server User Name , Date, Note):
-------------------------------------------------------------------------------------------
Create Table StudentAudit 
(
[Server User Name] Varchar(50),
[Date] Date,
Note varchar(50)
)

-- 3.Create a trigger on student table after insert to add Row in StudentAudit table:
--------------------------------------------------------------------------------------
GO
Create Trigger T_AddRowAfterInsert
On Student
After Insert
As
   BEGIN
       Insert Into StudentAudit
       Select 
           SUSER_NAME() AS UserName, 
           GETDATE() AS InsertedAt, 
           CONCAT_WS(' ', SUSER_NAME(), 'Insert New Row with Key =', St_Id, 'in table student') 'Note'
       From 
           inserted
   END
GO

-- 4.Create a trigger on student table instead of delete to add Row in StudentAudit table:
-------------------------------------------------------------------------------------------
GO
Create OR Alter Trigger T_PreventDeleteStudent
ON Student
Instead of delete
As
   BEGIN
       Insert Into StudentAudit
       Select  
           SUSER_NAME() 'UserName', 
           GETDATE() 'DeleteTime', 
           CONCAT_WS(' ', SUSER_NAME(), 'try to delete Row with id =', St_Id) 'Note'
       From
           deleted
   
       -- Prevent delete
       Print 'Deletion is not allowed on the Student table.';
   END
GO
--===========================================================================================================================--