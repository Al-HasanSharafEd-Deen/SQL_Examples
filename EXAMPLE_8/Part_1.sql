-------------------------------------------------  Assign_10         ----------------------------------------------------------
-------------------------------------------------  Author Al-Hasan   ----------------------------------------------------------
-------------------------------------------------  V:Part_1          ----------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------
--===========================================================================================================================--

-- Go to DataBase To Use it
use ITI
--------------------------------------------------

-- 1.Create an index on column (Hiredate) that allows you to cluster the data in table Department:
---------------------------------------------------------------------------------------------------
Create Clustered Index Ix_Manager_Hiredate
On Department (Manager_Hiredate)

-- What will happen?
-- The table already has  a clustered index, the query will fail because a table can only have one clustered index.
-- Error Message: Cannot create more than one clustered index on table 'Department'. Drop the existing clustered index 'PK_Department' before creating another.
-------------------------------------------------------------------------------------------------------------------------------------

-- 2.Create an index that allows you to enter unique ages in the student table:
--------------------------------------------------------------------------------
Create Unique Index Ix_St_Age
On Student (St_Age)

-- What will happen?
-- There are duplicate values already present in St_Age, the query will fail.
-- Error Message: The CREATE UNIQUE INDEX statement terminated because a duplicate key was found for the object name 'dbo.Student' and the index name 'Ix_St_Age'. The duplicate key value is (<NULL>).
-- The statement has been terminated.
-------------------------------------------------------------------------------------------------------------------------------------

/*3.Try to Create Login Named(RouteStudent) who can access Only student and Course tables from ITI DB
then allow him to select and insert data into tables and deny Delete and update:*/
-------------------------------------------------------------------------------------------------------

-- Create Login for RouteStudent
-------------------------------------------------------------------
Create LOGIN RouteStudent
With PASSWORD = 'Route1234'

-- Create User for Login:
--------------------------
Create USER RouteStudentUser
For LOGIN RouteStudent

-- Grant Access to Student and Course Tables:
----------------------------------------------
GRANT SELECT, INSERT 
ON Student 
TO RouteStudentUser

GRANT SELECT, INSERT 
ON Course 
TO RouteStudentUser

-- Deny DELETE and UPDATE Privileges on Student and Course:
------------------------------------------------------------
DENY DELETE, UPDATE 
ON Student 
TO RouteStudentUser

DENY DELETE, UPDATE 
ON Course 
TO RouteStudentUser
--===========================================================================================================================--