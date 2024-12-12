-------------------------------------------------  Part_1          ----------------------------------------------------------
-------------------------------------------------  Author Al-Hasan ----------------------------------------------------------
-------------------------------------------------  V:01            ----------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------
--=========================================================================================================================--

-- 1.1.	From The Previous Assignment insert at least 2 rows per table. 
-----------------------------------------------------------------------
-- Go to DataBase To Use it
use Sales
--------------------------------------------------

-- Insert To SalesOffices Table:
------------------------------
Insert Into SalesOffices --Number , Location , EmpId
Values
('Giza' , null),
('Korba' , null)

-- Insert To Employees Table:
------------------------------
Insert Into Employees -- Emp_Name , Office_Number
Values
('Al-Hasan Sharaf El-Deen', '1'),
('Loay Muhammad' , '2')

-- Insert To Property Table:
------------------------------
Insert Into Properties -- ProbId, Adress, City, State, Code, OfficeNum
Values
(01 ,'Giza','Doky','Cairo',001, 1),
(02 ,'Masr El-Gadida','Hegaz squre','Cairo',001, 2)

--Update Prob 2 code because i insert the 2 code is 001:
Update Properties
set Code = 002
Where PropId = 02

-- Insert To Owner Table:
------------------------------
Insert Into Owners -- OwnerId, OwnerName
Values
(10 ,'Medhat Nahed'),
(20 ,'Emad El-Deen Ali')

-- Insert To Own M:M Relationship Table:
------------------------------
Insert Into PropOwners -- OwnerId, PropId, Precent
Values
(10 , 2 , 077.22),
(20 , 1 , 045.34)
-----------------------------------------------------------------------------------------------------------------------------

-- 1.2.2.	Data Manipulation Language:
-----------------------------------------------------------------------
use ITI

-- 1.Insert your personal data to the student table as a new Student in department number 30.
Insert Into Student -- Fname , Lname , Address , Age , Dept_id , St_Super
Values(17 , 'Al-Hasan' , 'Sharaf El-Deen' , 'Alex' , 25 , 30 , NULL)

/*2.Insert Instructor with personal data of your friend as new Instructor in department number 30,
Salary= 4000, but don’t enter any value for bonus.*/
Insert Into Instructor (Ins_Id , Ins_Name , Salary)
Values(16 , 'Loay' , 4000)

-- 3.Upgrade Instructor salary by 20 % of its last value.
Update Instructor 
Set Salary += Salary *.20
Where Ins_Id =16
--=========================================================================================================================--