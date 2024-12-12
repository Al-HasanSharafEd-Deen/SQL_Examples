-------------------------------------------------  Part_3          ----------------------------------------------------------
-------------------------------------------------  Author Al-Hasan ----------------------------------------------------------
-------------------------------------------------  V:01            ----------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------
--=========================================================================================================================--

-- Go to DataBase To Use it
use ITI
--------------------------------------------------

-- 1.Get all instructors Names without repetition:
Select Distinct Ins_Name
From Instructor

-- 2.Display instructor Name and Department Name:
-- Note: display all the instructors if they are attached to a department or not
Select Inst.Ins_Name, Dept.Dept_Name
From Instructor Inst left join Department Dept
on Dept.Dept_Id = Inst.Dept_Id

-- 3.Display student full name and the name of the course he is taking For only courses which have a grade:
Select St_Fname , Crs_Name , Grade
from Student St
join Stud_Course StCrs
On St.St_Id = StCrs.St_Id
join Course Crs
on Crs.Crs_Id = StCrs.Crs_Id
Where StCrs.Grade is not null

-- 4.Bouns
-- any Expression after @@ defined as Global Variable
Select @@VERSION -- Display Information About The SQL Server Version, Operating System, and Other Details.
Select @@SERVERNAME -- Display Information About The Server We Work in.
--=========================================================================================================================--