-------------------------------------------------  Exam_01           ----------------------------------------------------------
-------------------------------------------------  Author Al-Hasan   ----------------------------------------------------------
-------------------------------------------------  V:Part_2          ----------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------
--===========================================================================================================================--

-- Go to DataBase To Use it
use Library

-- 1.Write a query that displays Full name of an employee who has more than 3 letters in his/her First Name:
--------------------------------------------------------------------------------------------------------------
Select CONCAT_WS(' ' ,Fname , Lname) 'FullName'
From Employee
Where LEN(Fname) > 3

-- 2.Write a query to display the total number of Programming books available in the library with alias name ‘NO OF PROGRAMMING BOOKS’:
----------------------------------------------------------------------------------------------------------------------------------------
Select COUNT(*) 'NO OF PROGRAMMING BOOKS'
From Book Bk Join Category Ctgry
On Bk.Cat_id = Ctgry.Id
Where Ctgry.Cat_name = 'programming'

-- 3.Write a query to display the number of books published by (HarperCollins) with the alias name 'NO_OF_BOOKS':
-------------------------------------------------------------------------------------------------------------------
Select COUNT(*) 'NO OF BOOKS'
From Book Bk Join Publisher Publshr
On Bk.Publisher_id = Publshr.Id
Where Publshr.Name = 'HarperCollins'

-- 4.Write a query to display the User SSN and name, date of borrowing and due date of the User whose due date is before July 2022:
------------------------------------------------------------------------------------------------------------------------------------
Select Usr.SSN , Usr.User_Name , Bw.Borrow_date , Bw.Due_date
From Borrowing Bw Join Users Usr
On Bw.User_ssn = Usr.SSN
Where Bw.Due_date < '2022-07-01'

-- 5.Write a query to display book title, author name and display in the following format, [Book Title] is written by [Author Name]:
-------------------------------------------------------------------------------------------------------------------------------------
Select CONCAT_WS(' ', Bk.Title , 'is written by' , Auth.Name) 'Book Detial'
From Book Bk Join Book_Author BkAuth
On Bk.Id = BkAuth.Book_id
Join Author Auth
On BkAuth.Author_id = Auth.Id

-- 6.Write a query to display the name of users who have letter 'A' in their names:
------------------------------------------------------------------------------------
Select User_Name
From Users
Where User_Name like '%A%'

-- 7.Write a query that display user SSN who makes the most borrowing:
-----------------------------------------------------------------------
Select TOP(1) User_ssn ,COUNT(*) 'BorrowingTimes'
From Borrowing
Group By User_ssn 
Order By BorrowingTimes DESC

-- 8.Write a query that displays the total amount of money that each user paid for borrowing books:
----------------------------------------------------------------------------------------------------
Select User_ssn ,SUM(Amount) 'Total Amount For All Borrowing Operations'
From Borrowing
Group By User_ssn 

-- 9.write a query that displays the category which has the book that has the minimum amount of money for borrowing:
---------------------------------------------------------------------------------------------------------------------
Select Ctgry.Cat_name
From Borrowing Bw Join Book Bk
On Bw.Book_id = Bk.Id
Join Category Ctgry
On Bk.Cat_id = Ctgry.Id
Where Bw.Amount = (Select MIN(Amount)
				   From Borrowing)

-- 10.write a query that displays the email of an employee if it's not found, display address if it's not found, display date of birthday:
-------------------------------------------------------------------------------------------------------------------------------------------
Select COALESCE(Email , Address, 
	   Format(GetDate(),'yyy-MM-dd'),
	   Format(DOB,'yyy-MM-dd')) 'Emp Data'
From Employee

-- 11.Write a query to list the category and number of books in each category with the alias name 'Count Of Books':
---------------------------------------------------------------------------------------------------------------------
Select Ctgry.Cat_name , COUNT(Bk.Id)
From Book Bk Join Category Ctgry
On Bk.Cat_id = Ctgry.Id
Group By Ctgry.Cat_name

-- 12.Write a query that display books id which is not found in floor num = 1 and shelf-code = A1:
---------------------------------------------------------------------------------------------------
Select Bk.Id
From Book Bk Join Shelf Shlf
On Bk.Shelf_code = Shlf.Code
Where Floor_num != 1 Or Shlf.Code != 'A1'

-- 13.Write a query that displays the floor number , Number of Blocks and number of employees working on that floor:
---------------------------------------------------------------------------------------------------------------------
Select Flr.Number ,Flr.Num_blocks, COUNT(Emp.Id) 'Emp Num On The Floor'
From Employee Emp Join Floor Flr
On Emp.Floor_no = Flr.Number
Group By Flr.Num_blocks , Flr.Number

-- 14.Display Book Title and User Name to designate Borrowing that occurred within the period ‘3/1/2022’ and ‘10/1/2022’:
--------------------------------------------------------------------------------------------------------------------------
Select Bk.Title , Usr.User_Name
From Borrowing Bw Join Users Usr
On Bw.User_ssn = Usr.SSN
Join Book Bk 
On Bk.Id = Bw.Book_id
Where Bw.Borrow_date Between '2022-03-01' and '2022-10-01'

-- 15.Display Employee Full Name and Name Of his/her Supervisor as Supervisor Name:
-------------------------------------------------------------------------------------
Select CONCAT_WS(' ' , Emp.Fname , Emp.Lname) 'Employee Name',
	   CONCAT_WS(' ' , SuperEmp.Fname , SuperEmp.Lname) 'Supervisor Name'
From Employee Emp Join Employee SuperEmp
On Emp.Super_id = SuperEmp.Id

-- 16.Select Employee name and his/her salary but if there is no salary display Employee bonus:
------------------------------------------------------------------------------------------------
Select CONCAT_WS(' ', Fname , Lname) 'Full Name',
	   ISNULL(Salary,Bouns)
From Employee

-- 17.Display max and min salary for Employees:
---------------------------------------------------
Select	MAX(Salary) 'Max Salary',
		MIN(Salary) 'MIN Salary'
From Employee Emp

-- 18.Write a function that take Number and display if it is even or odd:
---------------------------------------------------------------------------
GO
Create Function CheckEvenOddNum(@Num int)
Returns Varchar(5)
As
BEGIN
	Return CASE
	When @Num %2 = 0 Then 'Even'
	ELSE 'Odd'
	END
END
GO

-- 19.write a function that take category name and display Title of books in that category:
---------------------------------------------------------------------------------------------
GO
Create Function GetBookCatTitle(@BkCategory Varchar(50))
Returns Table
As
Return(
	Select Bk.Title
	From Book Bk Join Category Ctgry
	On Bk.Cat_id = Ctgry.Id
	Where Ctgry.Cat_name = @BkCategory
    )
GO

-- 20.write a function that takes the phone of the user and displays Book Title ,user-name, amount of money and due-date.:
---------------------------------------------------------------------------------------------------------------------------
GO
Create Function GetUserBorrowingBkFromPhone(@PhoneNum Varchar(20))
Returns Table
As
Return(
	Select Bk.Title, U.User_Name, Bw.Amount, Bw.Due_date
    From Borrowing Bw Join Users U On Bw.User_ssn = U.SSN
    Join User_Phones UsrPhone On U.SSN = UsrPhone.User_ssn
    Join Book Bk On Bw.Book_id = Bk.Id
    Where UsrPhone.Phone_num = @PhoneNum
)
GO

/*21.return Message in the following format ([User Name] is Repeated [Count] times)
if it's not duplicated display msg with this format [user
name] is not duplicated,if it's not Found Return [User Name] is NotFound:*/
--------------------------------------------------------------------------------------
GO
Create Function CheckNameDuplication(@UsrName Varchar(30))
Returns Varchar(30)
As
BEGIN
	Declare @Count int
	Declare @Result Varchar(30)
    Select @Count = COUNT(*) 
	From Users Where User_Name = @UsrName

    IF @Count > 1
        Set @Result = @UsrName + ' is Repeated ' + CAST(@Count AS Varchar(30)) + ' times';
    ELSE IF @Count = 1
        Set @Result = @UsrName + ' is not duplicated'
    ELSE
        Set @Result = @UsrName + ' is Not Found'

	Return @Result
END
GO
-- 22.Create a scalar function that takes date and Format to return Date With That Format:
---------------------------------------------------------------------------------------------
GO
Create Function ChangeDateFormat(@Date Date, @Format Varchar(30))
Returns Varchar(30)
As
BEGIN
	Return Format(@Date, @Format)
END
GO

-- 23.Create a stored procedure to show the number of books per Category:
---------------------------------------------------------------------------
GO
Create Procedure GetBooksCategory
As
BEGIN
    Select Ctgry.Cat_name 'Category', COUNT(Bk.Id) 'Num Of Books'
    From Category Ctgry Join Book Bk On Ctgry.Id = Bk.Cat_id
    Group By Ctgry.Cat_name;
END
GO

/*24.Create a stored procedure that will be used in case there is an old manager
who has left the floor and a new one becomes his replacement. 
The procedure should take 3 parameters (old Emp.id, new Emp.id and the floor number) and it will be used to update the floor table:*/
----------------------------------------------------------------------------------------------------------------------------------------
GO
Create Procedure UpdateFloorManager
	@OldEmpId int, @NewEmpId int, @FloorNum int
As
BEGIN
    Update Floor
    Set MG_ID = @NewEmpId
    Where MG_ID = @OldEmpId and Number = @FloorNum
END
GO

-- 25.Create a view AlexAndCairoEmp that displays Employee data for users who live in Alex or Cairo:
----------------------------------------------------------------------------------------------------
GO
Create View AlexAndCairoEmps 
As
Select *
From Employee
Where Address in ('Alex','Cairo')
GO

-- 26.create a view "V2" That displays number of books per shelf:
---------------------------------------------------------------------
GO
Create View V2 
As
Select Slf.Code 'Shelf Code' , COUNT(Bk.Id) 'Num Of Books'
From Shelf Slf Join Book Bk
On Slf.Code = Bk.Shelf_code
Group By Slf.Code
GO

-- 27.create a view "V3" That display the shelf code that have maximum number of books using the previous view "V2":
---------------------------------------------------------------------------------------------------------------------
GO
Create View  V3
As
Select [Shelf Code]
From V2
Where [Num Of Books] = (Select MAX([Num Of Books]) 
						From V2)
GO

-- 28. Create a table named ‘ReturnedBooks’ With the Following Structure:
Create Table ReturnedBooks (
    User_SSN int,
    Book_Id int,
    Due_Date Date,
    Return_Date Date,
    Fees DEC(10, 2)
)
/* then create A trigger that instead of inserting the data of returned bookchecks
if the return date is the due date or not if not so the user must pay a fee and it will be 20% of the amount that was paid before:*/
--------------------------------------------------------------------------------------------------------------------------------------
GO
Create or Alter Trigger CheckReturnedBook
On ReturnedBooks
Instead Of Insert
As
BEGIN
    Declare @User_SSN int, @Book_Id int, @Due_Date Date,
			@Return_Date Date, @Amount DEC(10, 2);

    Select @User_SSN = User_SSN, @Book_Id = Book_Id, @Due_Date = Due_Date, @Return_Date = Return_Date
    From inserted

    IF @Return_Date > @Due_Date
    BEGIN
        Select @Amount = Amount
		From Borrowing
		Where User_SSN = @User_SSN AND Book_Id = @Book_Id

        Insert Into ReturnedBooks (User_SSN, Book_Id, Due_Date, Return_Date, Fees)
        Values (@User_SSN, @Book_Id, @Due_Date, @Return_Date, @Amount * 0.2)
    END
   
   ELSE
    BEGIN
        Insert Into ReturnedBooks (User_SSN, Book_Id, Due_Date, Return_Date, Fees)
        Values (@User_SSN, @Book_Id, @Due_Date, @Return_Date, 0);
    END
END

/* 29.In the Floor table insert new Floor With Number of blocks 2 , employee
with SSN = 20 as a manager for this Floor,The start date for this manager
is Now. Do what is required if you know that : Mr.Omar Amr(SSN=5)
moved to be the manager of the new Floor (id = 7), and they give Mr. Ali Mohamed(his SSN =12) His position:*/
----------------------------------------------------------------------------------------------------------------
-- Insert the New Floor with SSN = 20 as Manager
Insert Into Floor (Number, Num_blocks, MG_ID, Hiring_Date)
Values (7, 2, 20, GETDATE())
-- Assign Mr. Omar Amr (SSN = 5) as Manager for the New Floor
Update Floor
Set MG_ID = 5
Where Number = 7
-- Assign Mr. Ali Mohamed (SSN = 12) to the Floor Previously Managed by Mr. Omar Amr
UPDATE Floor
Set MG_ID = 12
Where MG_ID = 5 and Number != 7

/*Create view name (v_2006_check) that will display Manager id, FloorNumber where he/she works , Number of Blocks and the Hiring Date
which must be from the first of March and the end of May 2022.this view will be used to insert data so make sure that the coming new data must
match the condition then try to insert this 2 rows and
Mention What will happen:*/
-------------------------------------------------------------------------------------------------------------------------------------------------
GO
Create View v_2006_check
As
Select MG_ID, Number 'FloorNumber', Num_blocks, Hiring_Date
From Floor
Where Hiring_Date Between '2022-03-01' and '2022-05-31'
GO
-- Try Insert New Rows
Insert Into v_2006_check (MG_ID, FloorNumber, Num_blocks, Hiring_Date)
Values (2, 6, 2, '2023-07-08')
-- What will happen?
-- This will fail due to the date condition

Insert Into v_2006_check (MG_ID, FloorNumber, Num_blocks, Hiring_Date)
Values (4, 8, 1, '2022-04-08') 
--What will happen?
-- This will succeed

/* 31.Create a trigger to prevent anyone from Modifying or Delete or Insert in the Employee table
( Display a message for user to tell him that he can’t take any action with this Table):*/
-----------------------------------------------------------------------------------------------------
GO
Create or Alter Trigger PreventModifyingEmployee
On Employee
After Insert, Update, Delete
As
BEGIN
    ROLLBACK TRANSACTION
    Print 'You cannot modify, delete, or insert into the Employee table.';
END
GO

-- 32.Testing Referential Integrity , Mention What Will Happen When:
-------------------------------------------------------------------
-- A.Add a new User Phone Number with User_SSN = 50 in User_Phones Table:
Insert Into User_Phones (User_SSN, Phone_num)
Values (50, '0123456789')
-- Fails 
-- The INSERT statement conflicted with the FOREIGN KEY constraint "FK_User_phones_User".

-- B.Modify the employee id 20 in the employee table to 21:
-----------------------------------------------------------
Update Employee
Set Id = 21
Where Id = 20 
-- Fails -- ID is referenced in other tables
-- Cannot update identity column 'Id'.

-- C.Delete the employee with id 1:
----------------------------------
Delete From Employee
Where Id = 1
-- Fails -- ID is referenced in other tables
-- The DELETE statement conflicted with the REFERENCE constraint "FK_Borrowing_Employee"

-- D.Delete the employee with id 12:
-------------------------------------
Delete From Employee
Where Id = 12
-- Fails -- ID is referenced in other tables
-- The DELETE statement conflicted with the REFERENCE constraint "FK_Borrowing_Employee"

-- E.Create an index on column (Salary) that allows you to cluster the data in table Employee:
-------------------------------------------------------------------------------------------------
Create Clustered Index IX_Employee_Salary
On Employee(Salary)
-- Fails -- Drop existing clustered index 'PK_Employee' before creating another
-- Cannot create more than one clustered index on table 'Employee'

/* 33.Try to Create Login With Your Name And give yourself access Only to Employee and Floor tables
then allow this login to select and insert data into tables and deny Delete and update:*/
-----------------------------------------------------------------------------------------------------
Create Login AlHasanAmeer
With Password = 'AlHasan123'

-- Create User In Database
-------------------------------------------------------------------------------------
Create User AlHasanAmeerUser
For Login AlHasanAmeer

-- Grant SELECT And INSERT Permissions To Employee and Floor Tables
---------------------------------------------------------------------
Grant Select, Insert
On Employee  To AlHasanAmeerUser

Grant Select, Insert
On Floor  To AlHasanAmeerUser

-- Deny DELETE And UPDATE Permissions On Employee and Floor Tables
----------------------------------------------------------------------
Deny Delete, Update
On Employee To AlHasanAmeerUser

Deny Delete, Update
On Floor To AlHasanAmeerUser

--===========================================================================================================================--