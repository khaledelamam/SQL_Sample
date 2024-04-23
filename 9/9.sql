--Display all the data from the Employee table (HumanResources Schema) 
--As an XML document “Use XML Raw”. “Use Adventure works DB” 
--Elements
--Attributes
-----------------------------------------------------------------------------
select * from HumanResources.Employee
for xml raw 'employee' ,elements,root'employee'
-------------------------------------------------------------------------------
--Display Each Department Name with its instructors. “Use ITI DB”
--Use XML Auto
--Use XML Path
----------------------------------------------------------------------
select Dept_Name,Ins_Name
from Department d,Instructor s
where d.Dept_Id=s.Dept_Id
for xml auto
----------------------------------------
select Dept_Name,Ins_Name
from Department d,Instructor s
where d.Dept_Id=s.Dept_Id
for xml path
--------------------------------------------------------------------------------------
--Use the following variable to create a new table “customers” inside the company DB.
 --Use OpenXML
declare @docs xml ='<customers>
              <customer FirstName="Bob" Zipcode="91126">
                     <order ID="12221">Laptop</order>
              </customer>
              <customer FirstName="Judy" Zipcode="23235">
                     <order ID="12221">Workstation</order>
              </customer>
              <customer FirstName="Howard" Zipcode="20009">
                     <order ID="3331122">Laptop</order>
              </customer>
              <customer FirstName="Mary" Zipcode="12345">
                     <order ID="555555">Server</order>
              </customer>
       </customers>'

declare @hdocs int
exec sp_xml_preparedocument @hdocs output,@docs
select * 
from openxml (@hdocs,'//customer')
with(cs_fname varchar(50) '@FirstName' ,

      zip int '@Zipcode',
     orid int 'order/@ID',
	 orders varchar(50) 'order'
     )
exec sp_xml_removedocument @hdocs 







--Create a stored procedure to show the number of students per department.
---------------------------------------------------------------------------
alter proc ns
as 
select st_id,d.Dept_Id
from student s,Department d
where d.Dept_Id=s.Dept_Id

execute ns
----------------------------------------
--Create a stored procedure that will check for the # of employees in the project p1 if they are more than 3
--print message to the user “'The number of employees in the project p1 is 3 or more'” if they are less display a message to the user
--“'The following employees work for the project p1'” in addition to the first name and last name of each one. 
--------------------------------------------------------------------------------------------------------------------------------------
use Company_SD
alter proc ne
as
declare @t varchar(50) ,@d varchar(50)
select @t= Enum
from sales.Employee e,WorkOn w
where WPnum='p1' and e.enum=w.WEnum
if @t>3 
begin
select 'The number of employees in the project p1 is 3 or more'
end
else
if @t<3 
begin
select 'The following employees work for the project p1'
end

execute ne

------------------------------------------------------------------------------
--Create a stored procedure that will be used in case there is an old employee
--has left the project and a new one become instead of him. The procedure should take 3 parameters (old Emp. number,
--new Emp. number and the project number) and it will be used to update works_on table. [Company DB]
------------------------------------------------------------------------------------------------------------------------
ALTER PROC MNMN (@NEW INT,@P VARCHAR(2),@OLD INT)
AS
UPDATE WorkOn
SET @NEW=WEnum , WPNUM=@P
WHERE WEnum=@OLD 

EXECUTE MNMN 2582 ,'P3',2581 
--------------------------------------------------------------------------------------------------
--Create an Audit table with the following structure 
------------------------------------------------------
create table black
(
pno nvarchar(20),
u_ame varchar(20),
m_date date,
o_budget int,
n_budget int
)

alter trigger vb
on  Company_SD.dbo.Projects
instead of update
as
if update (Budget)
    begin
   declare @old int,@new int ,@pnum nvarchar(2)
    select @pnum=pnum from Company_SD.dbo.Projects
    select @old=budget from deleted
    select @new =budget from inserted
    insert into Company_SD.DBO.black
    values (@pnum,SUSER_NAME(),getdate(),@old,@new)
	END
alter table projects disable trigger vb
alter table projects enable trigger vb
------------------------------------------------------------
--Create a trigger to prevent anyone from inserting a new record in the Department table [ITI DB]
--“Print a message for user to tell him that he can’t insert a new record in that table”
CREATE trigger t20
on department
AFTER INSERT
as
select 'Print a message for user to tell him that he can’t insert a new record in that table'

insert into Department(Dept_Id,Dept_Name)
values(80,'sd')
-----------------------------------------------------------------------------------------------------------
--Create a trigger that prevents the insertion Process for Employee table in March [Company DB].
----------------------------------------------------------------------------------------------------
create trigger t20
on employee
instead of insert 
as
if format(getdate(),'MMMM')='MARCH'
      BEGIN 
      SELECT 'NO INSERT'
     INSERT INTO EMPLOYEE
     SELECT * FROM inserted
     END
---------------------------------------------------
--Create a trigger that prevents users from altering any table in Company DB.
-----------------------------------------------------------------------------
alter TRIGGER T50
ON DATABASE
FOR ALTER_TABLE
AS
SELECT 'NO ALTER'
ROLLBACK;
ALTER DATABASE DISABLE TRIGGER T50
USE Company_SD
ALTER TABLE DEPARTMENT ADD  KHALED VARCHAR(50)
DROP TRIGGER dbo.t50


---------------------------------
--Create a trigger on student table after insert to add Row 
--in Student Audit table (Server User Name , Date, Note) 
--where note will be “[username] Insert New Row with Key=[Key Value] in table [table name]”
-------------------------------------------------------------------------------------------------
create table studentaudit
(
us_name nvarchar(50),
_date date,
note varchar(50)
)
alter trigger sb
on student 
after insert 
as 
declare @t nvarchar(50)
begin
insert into studentaudit
select SUSER_NAME(),getdate(),'['+SUSER_NAME()+']+Insert New Row with Key='+@t+' in table [student]'
from student t
end
insert into Student(St_Id,St_Fname)
values (46,'ahmed')
------------------------------------------------------------------
--Create a trigger on student table instead of delete to add Row 
--in Student Audit table (Server User Name, Date, Note) 
--where note will be“ try to delete Row with Key=[Key Value]”
----------------------------------------------------------------------
create trigger sb2
on student 
after delete 
as 
declare @t nvarchar(50)
begin
insert into Studentaudit
select SUSER_NAME(),getdate(),SUSER_NAME()+'try to delete row with key '+@t+' '
from student t
end

delete from Student
where St_Id=45

alter iti.dbo.student disable trigger sb1
