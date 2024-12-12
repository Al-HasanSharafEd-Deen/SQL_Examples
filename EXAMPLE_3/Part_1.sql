-------------------------------------------------  Part_1          ----------------------------------------------------------
-------------------------------------------------  Author Al-Hasan ----------------------------------------------------------
-------------------------------------------------  V:01            ----------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------
--=========================================================================================================================--

-- Go to DataBase To Use it
use ITI
--------------------------------------------------

-- 1.Retrieve a number of students who have a value in their age:
Select COUNT(*)
From Student 
Where St_Age Is Not Null

-- 2.Display number of courses for each topic name:
Select Tpc.Top_Name [Topic Name], COUNT(Crs.Crs_Id) [Num Of Courses]
From Course Crs , Topic Tpc
Where Tpc.Top_Id = Crs.Top_Id
Group By Tpc.Top_Name

-- 3.Display student with the following Format (use isNull function):
Select Std.St_Id [Student ID] ,ISNULL(Std.St_Fname, ' ') + ' ' + ISNULL(Std.St_Lname, ' ') 'Student Full Name', 
ISNULL(Dpt.Dept_Name, 'NO Dept Known')  [Department Name]
From Student Std Left Join Department Dpt -- I did this Left Join To View this FUNC Work (ISNULL(Dpt.Dept_Name, 'NO Dept Known'))
On Dpt.Dept_Id = Std.Dept_Id

-- 4.Select instructor name and his salary but if there is no salary display value ‘0000’ . “use one of Null Function”:
Select Ins_Name , COALESCE(CAST(Salary As varchar), '0000')
From Instructor

-- 5.Select Supervisor first name and the count of students who supervises on them:
Select SprSt.St_Fname [Supervisor First Name],
COUNT(Std.St_Id) 'count of students'
From Student Std , Student SprSt
Where SprSt.St_Id = Std.St_Id
Group By SprSt.St_Fname

-- 6.Display max and min salary for instructors:
Select MAX(Salary) [Maxmum Salary],
MIN(Salary) 'Minmum Salary'
From Instructor

-- 7.Select Average Salary for instructors:
Select AVG(Salary) [Average Salary]
From Instructor
--=========================================================================================================================--