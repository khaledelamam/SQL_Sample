--Create a scalar function that takes date and returns Month name of that date.
------------------------------------------------------------------------------------
create function date1(@D date)
returns varchar(20)
             begin
			 declare @month varchar(20)
             select @month = format(@d,'MMMM') 
			 return @month
			 end
			 drop function date1
select dbo.date1('2000-01-01')
-------------------------------------------
--Create a tabled valued function that takes Student No and
--returns Department Name with Student full name.
-----------------------------------------------------------------
create function stud2 (@s int)
returns table
as 
return
(
select St_Fname+' '+St_Lname as fullname,Dept_Name as depname
from Student s,Department d
where  d.Dept_Id=@s and d.Dept_Id=s.Dept_Id
)

select *from stud2(20)
-------------------------------------------------------------
--Create a scalar function that takes Student ID and returns a message to user 
--If first name and Last name are null then display 'First name & last name are null'
--If First name is null then display 'first name is null'
--If Last name is null then display 'last name is null'
--Else display 'First name & last name are not null'
--------------------------------------------------------------------------------
--If first name and Last name are null then display 'First name & last name are null'
--If First name is null then display 'first name is null'
--If Last name is null then display 'last name is null'
---------------------------------------------------------------------------------------
--If first name and Last name are null then display 'First name & last name are  null'
-----------------------------------------------------------------------------------------
create function sids1(@si1 int)
returns varchar(50) 
as
         begin
              declare @d1 varchar(50)
		      select @d1=coalesce(isnull(st_fname,'fname null')+' '+isnull(St_Lname,'&lname null'),'First name & last name are null') from Student where  St_id=@si1	               			  	
		      return @d1
		end 
		DROP FUNCTION SIDS1
		select dbo.sids1(1)
-------------------------------------------------

-------------------------------------------------
--If First name is null then display 'first name is null'
----------------------------------------------------------
create function sids2 (@si2 int)
returns varchar(50) 
as
         begin
              declare @d2 varchar(50)		 		     
			  select @d2 = st_fname from student where st_id=@si2
			  if @d2  is null
			  begin
			  select @d2= 'First name is null'
			  end
			
		      return @d2  
		end 
		DROP FUNCTION SIDS2
		select dbo.sids2(14)
		------------------------------
create function sids3 (@si3 int)
returns varchar(50) 
as
         begin
              declare @d3 varchar(50)		 		     
			  select @d3 = St_Lname from student where st_id=@si3
			  if @d3  is null
			  begin
			  select @d3= 'Last name is null'
			  end
			
		      return @d3  
		end 
		DROP FUNCTION SIDS3
		select dbo.sids3(13)
------------------------------------------------------------------------
create function sids4 (@si4 int)
returns varchar(50) 
as
         begin
              declare @d4 varchar(50)		 		     
			  select @d4 = st_fname+' '+St_Lname from student where st_id=@si4
			  if @d4  is not null
			  begin
			  select @d4= 'First name and last name are not null'
			  end			
		      return @d4  
		end 
		DROP FUNCTION SIDS4
		select dbo.sids4(2)
-----------------------------------------------------------------
--Create a function that takes integer which represents
--manager ID and displays department name, Manager Name and hiring date 
---------------------------------------------------------------------------
		create function manaid(@mi int)
		returns table
		as
		return 
		(select Dept_Name,Dept_Manager,Manager_hiredate
		from Department 
		where Dept_Id=@mi
		)

		select * from manaid(10)
-----------------------------------------------------------------------------------
--Create multi-statements table-valued function that takes a string
--If string='first name' returns student first name
--If string='last name' returns student last name 
--If string='full name' returns Full Name from student table 
------------------------------------------------------------------------
create function fulln (@fn varchar(50))
returns @f table
            (
			id int,
			ename varchar(50)
			)
as          
          begin 
		  if @fn='first'
		  insert into @f
		  select St_Id ,isnull(St_Fname,'') from Student
		  if @fn ='last'
		  insert into @f
		  select St_Id,isnull(St_Lname,'') from Student
		  if @fn='full '
		  insert into @f
		  select st_id,isnull(st_fname+' '+st_lname,'') from student
		  return
		  end 
		
select * from fulln ('full')
----------------------------------------------------------------------------
--Write a query that returns the Student No and Student first name without the last char
select St_Id,substring(St_Fname,1,len(st_fname)-1)
from Student
-----------------------------------------------------------------------------------------
--Create a multi-statements table-valued function
--that takes 2 integers and returns the values between them.
create function multi(@y int,@t int)
returns @x table 
             (bet int 
			 )
			 as
			 begin 
			 if @y=1 and @t=2
			 insert into @x
			 select sum(St_Age) from student where St_Age between 21 and 25			
			 return
			 end
			 drop function multi
			 select * from multi (1,2)








			
			