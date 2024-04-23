--Create a view that displays student full name, course name if the student has a grade more than 50. 
----------------------------------------------------------------------------------------------------------
alter view sc (Fullname,name)
as 
select St_Fname+' '+St_Lname as Fullname ,Crs_Name
from student s,Course c,Stud_Course sc 
where grade >50 and s.St_Id=sc.St_Id and c.Crs_Id=sc.Crs_Id

select * from sc
-----------------------------------------------------------------
--Create an Encrypted view that displays manager names and the topics they teach
-------------------------------------------------------------------------------------
alter view mt (mana,name)
with encryption 
as 
select Dept_Manager,Dept_Desc
from Department
select*from mt
----------------------------------------------------
--Create a view that will display Instructor Name, Department Name for the ‘SD’ or ‘Java’ Department 
--“use Schema binding” and describe what is the meaning of Schema Binding
----------------------------------------------------------------------------------------------------------
alter view dbo.di (nemo,memo)
with SCHEMABINDING
as 
select i.Ins_Name,d.Dept_Name
from dbo.Department d , dbo.Instructor i
where d.Dept_Id=i.Dept_Id and d.Dept_Name in ('sd','java')  
select* from di
------------------------------------------------------------------------------
--Create a view “V1” that displays student data for student who lives in Alex or Cairo. 
--Note: Prevent the users to run the following query 
--Update V1 set st_address=’tanta’
--Where st_address=’alex’;
-----------------------------------------------------------------------------------------
alter view v1  (i,d,l,a,m,t,p)
as
select *
from Student
where St_Address in ('alex','cairo')

update v1 
set a='tanta'
where a ='alex'

select * from v1
------------------------------------------
--Create index on column (Hiredate) that allow u to cluster the data in table Department. What will happen? it will not agree that because the clustered in this table dept_id as 'pk'
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
create clustered index hiredate
on department (dept_id)
select * from Department with (index=hiredate)
------------------------------------------------------
--Create index that allow u to enter unique ages in student table. What will happen? it will not agree that because the has two nulls insid it 
-----------------------------------------------------------------------------------------------------------------------------------------------
create unique index i4
on student (st_age)
-----------------------------------------------
--Create temporary table [Session based] on Company DB to save employee name and his today task.
-------------------------------------------------------------------------------------------------
use Company_SD
create table #ename
(name varchar(50),
task varchar(20))
-----------------------------------
--Create a view that will display the project name and the number of employees work on it. “Use Company DB”
--------------------------------------------------------------------------------------------------------------
create view pe (p,e)
as 
select Pname,Fname
from Project p,Employee e, departments d
where d.dnum=e.Dno and d.dnum=p.Dnum
select * from pe
--------------------------------------------------
--Using Merge statement between the following two tables [User ID, Transaction Amount]
--------------------------------------------------------------------------------------
merge into LastTransaction as l
using DailyTransaction as D
when matched the 
update 
set Lid=Did
when not matched  then
insert 
values (userid,transactionamount)
---------------------------------------------
--Create view named   “v_clerk” that will display employee#,project#, the date of hiring of all the jobs of the type 'Clerk'.
-------------------------------------------------------------------------------------------------------------------------------
create view v_clerk
as 
select wenum,wpnum
from workon w
where job ='clerk'
select * from v_clerk
------------------------------------------------
--Create view named  “v_without_budget” that will display all the projects data 
--without budget
-----------------------------------------------------------------------------------
create view v_without_budget
as
select pnum from projects

select * from  v_without_budget
-------------------------------------------------------------------------
--Create view named  “v_count “ that will display the project name and the # of jobs in it
---------------------------------------------------------------------------------------------
create view vcount
as
select wpnum,job
from workon

select * from vcount
------------------------------------------------------
--Create view named ” v_project_p2” that will display the emp# s for the project# ‘p2’
--use the previously created view  “v_clerk”
-------------------------------------------------------------------------------------------
create view v_project_p2 
as select * from v_clerk where wpnum='p2'

select * from v_project_p2 
-----------------------------------------------------
--modifey the view named  “v_without_budget”  to display all DATA in project p1 and p2 
---------------------------------------------------------------------------------------
alter view v_without_budget
as
select * from projects where pnum in ('p1','p2')

select * from v_without_budget
----------------------------------------------------------------------------------------
--Delete the views  “v_ clerk” and “v_count”
----------------------------------------------
drop view v_clerk 
drop view vcount
----------------------------------------------
--Create view that will display the emp# and emp lastname who works on dept# is ‘d2’
alter view ed
with schemabinding
as
select e.ssn,e.lname
from dbo.employee e,dbo.departments d
where d.dnum=e.dno and d.dname='dp2'

select * from ed
------------------------------------------------------------------
--Display the employee  lastname that contains letter “J”
--Use the previous view created in Q#7
------------------------------------------------------------
alter view lj
as 
select * from ed where lname like '%j'

select * from lj
---------------------------------------------------------------
--Create view named “v_dept” that will display the department# and department name
----------------------------------------------------------------------------------
alter view v_dept 
as
select did,dname
from department

select * from v_dept
------------------------------------------------------------------
--using the previous view try enter new department data where dept# is ’d4’ and dept name is ‘Development’
------------------------------------------------------------------------------------------------------------
insert into v_dept (did,dname)
values ('d4','development')
-----------------------------------------------------------------------------------
--Create view name “v_2006_check” that will display employee#, the project #where he works 
--and the date of joining the project which must be from the first of January and the last of December 2006.
--this view will be used to insert data so make sure that the coming new data must match the condition
------------------------------------------------------------------------------------------------------------
create view v_2006_check
as 
select wenum,wpnum
from workon
where e_date between '2006-01-01' and '2006-12-31'

select * from v_2006_check
--------------------------------------------------------

