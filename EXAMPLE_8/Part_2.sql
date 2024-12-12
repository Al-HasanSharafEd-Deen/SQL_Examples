-------------------------------------------------  Assign_10         ----------------------------------------------------------
-------------------------------------------------  Author Al-Hasan   ----------------------------------------------------------
-------------------------------------------------  V:Part_2          ----------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------
--===========================================================================================================================--

-- 1.Create a table named ‘ReturnedBooks’ :
----------------------------------------------
Create Table ReturnedBooks
(
	User_SSN int Not Null,
	Book_Id int Not Null,
	Due_Date date Not Null,
	Return_Date date Not Null,
	Fees Dec(10,2)
)

--then create A trigger for ReturnedBooks Table:
-------------------------------------------------
Go
Create Or Alter Trigger CalculateFeesOnReturnedBooks
On ReturnedBooks
Instead Of Insert
As
BEGIN
    DECLARE @DueDate DATE, @ReturnDate DATE, @Fees DECIMAL(10, 2), @PreviousFees DECIMAL(10, 2);
    DECLARE @User_SSN INT, @Book_Id INT;

    -- Retrieve Data From Inserted
    SELECT 
        @DueDate = Due_Date, 
        @ReturnDate = Return_Date,
        @PreviousFees = Fees,
        @User_SSN = User_SSN,
        @Book_Id = Book_Id
    FROM INSERTED;

    -- Check If Return Date Exceeds Due Date
    IF @ReturnDate > @DueDate
    BEGIN
        -- Calculate Fee (20% of Previous Fees)
        SET @Fees = @PreviousFees * 0.2;

        -- Insert Data With Fees
        INSERT INTO ReturnedBooks (User_SSN, Book_Id, Due_Date, Return_Date, Fees)
        SELECT @User_SSN, @Book_Id, @DueDate, @ReturnDate, @Fees;
    END
    ELSE
    BEGIN
        -- Insert Data Without Fees
        INSERT INTO ReturnedBooks (User_SSN, Book_Id, Due_Date, Return_Date, Fees)
        SELECT @User_SSN, @Book_Id, @DueDate, @ReturnDate, 0;
    END
END
Go
---------------------------------------------------------------------------------------------------------------

-- 2.Create a trigger to prevent anyone from Modifying or Delete or Insert in the Instructor table:
---------------------------------------------------------------------------------------------------
Create Or Alter Trigger DisableDMLActionsOnInstructor 
On Instructor
Instead Of Insert, Update, Delete
As
BEGIN
    RAISERROR('You are not allowed to perform any action on the Instructor table.', 16, 1);
    ROLLBACK TRANSACTION;
END;

-- 3.Testing Referential Integrity:
------------------------------------
Create Clustered Index IX_Salary
On Instructor(Salary);
--The query fails with an error: "Cannot create more than one clustered index on table 'Instructor'."
---------------------------------------------------------------------------------------------------------

/*Try to Create Login With Your Name And give yourself access Only to Employee then allow this login
to select and insert data into tables and deny Delete and update:*/
--------------------------------------------------------------------------------------------------------

-- Create Login
-------------------------------------------------------------------------------------
Create Login AlHasan
With Password = 'AlHasan123'

-- Create User In Database
-------------------------------------------------------------------------------------
Create User AlHasanUser
For Login AlHasan

-- Grant SELECT And INSERT Permissions To Employee Table
-------------------------------------------------------------------------------------
Grant SELECT, INSERT
On Instructor To AlHasanUser

-- Deny DELETE And UPDATE Permissions On Employee Table
-------------------------------------------------------------------------------------
Deny Delete, Update
On Instructor To AlHasanUser

-- test:
------------------

-- select
Select * From Instructor

-- insert
Insert Into Instructor (Ins_Id, Ins_Name, Salary)
Values (101, 'Al-Hasan', 5000)

-- update
Update Instructor
Set Salary = 5500
Where Ins_Id = 101;

-- delete
Delete From Instructor
Where Ins_Id = 101;
--===========================================================================================================================--