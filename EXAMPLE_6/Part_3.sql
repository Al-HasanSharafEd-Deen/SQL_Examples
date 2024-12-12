-------------------------------------------------  Assign_8         ----------------------------------------------------------
-------------------------------------------------  Author Al-Hasan   ----------------------------------------------------------
-------------------------------------------------  V:Part_3          ----------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------
--===========================================================================================================================--

-- 1.Create a stored procedure that calculates the sum of a given range of numbers:
-------------------------------------------------------------------------------------
GO
Create or Alter Procedure SP_SumNums @StartNum int , @EndNum int , @Sum int Output
As
	Begin
		Set @Sum = 0

		While @StartNum <= @EndNum
			Begin
				Set @Sum = @Sum + @StartNum
				Set @StartNum = @StartNum +  1
			End
	End
GO

-- 2.Create a stored procedure that calculates the area of a circle given its radius:
--------------------------------------------------------------------------------------
GO
Create Procedure SP_GetCircleArea @radius float , @Area float output
As
	Begin
		Set @Area = PI() * POWER(@radius , 2) -- by Search
	End
GO


/* 3.Create a stored procedure that calculates the age category based on a person's age
( Note: IF Age < 18 then Category is Child and if  Age >= 18 AND Age < 60
 then Category is Adult otherwise  Category is Senior):*/
 --------------------------------------------------------------------------------------
GO
Create Procedure SP_GetAgeCategory @Age int , @Category varchar(100) output
As
	Begin

	IF @Age < 18
		Set @Category = 'Child'
	Else IF @Age >= 18 and @Age < 60
		Set @Category = 'Adult'
	Else
		Set @Category = 'Senior'
	End
GO


/* 4.Create a stored procedure that determines the maximum, minimum, and average of a given set of numbers
( Note : set of numbers as Numbers = '5, 10, 15, 20, 25'):*/
 -----------------------------------------------------------------------------------------------------------
GO
Create Procedure SP_GetMaxMinAvgOfNums @Nums varchar(max) , @MaxNum int output, @MinNum int output , @Avg Float output
As
	Begin
		Create Table Test (value int )

		Insert Into Test (Value)
		Select Value 
		From string_split(@Nums , ',')
		------------------------------------
		Select @MaxNum = Max(Value) , @MinNum = Min(Value) , @Avg = Avg(Value)
		From Test
	End
GO
--===========================================================================================================================--