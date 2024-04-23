--Create a cursor for Employee table that increases Employee salary by 10% if Salary <3000 
--and increases it by 20% if Salary >=3000. Use company DB
---------------------------------------------------------------
declare c1 cursor 
for select Salary
    from employee
for update
declare @sal int
open c1
fetch c1 into @sal
while @@FETCH_STATUS=0
     begin 
	 if @sal >=3000
	 update Employee
	 set salary =@sal*1.20
	 where current of c1
	 else 
	 update Employee
	 set salary =@sal*1.10
	 where current of c1
	 fetch c1 into @sal 
	 end
close c1
deallocate c1
-----------------------------------------------------
--Display Department name with its manager name using cursor. Use ITI DB
--------------------------------------------------------------------------
declare c1 cursor
for select Dept_Name,Dept_Manager from Department
for read only
declare @dname varchar(20) , @mname varchar(20)
open c1
fetch c1 into @dname,@mname
while @@FETCH_STATUS=0
        begin 
		select @dname,@mname
		fetch c1 into @dname,@mname
		end
close c1
deallocate c1
----------------------------------------------------------------
--Try to display all students first name in one cell separated by comma. Using Cursor 
-------------------------------------------------------------------------------------
declare c1 cursor
for select st_fname from Student
for read only
declare @name varchar(20),@allnames varchar(50)
open c1 
fetch c1 into @name
while @@FETCH_STATUS=0
       begin 
	   select @allnames =concat(@allnames,',',@name)
	   fetch c1 into @name
	   end
select @allnames
close c1 
deallocate c1
---------------------------------------------------------------
--Create Snapshot for CompanyDB
---------------------------------
create database snapcomp
on (
name='Company_SD',
filename='d:\snapcomp.ss'
)
as snapshot of Company_SD
