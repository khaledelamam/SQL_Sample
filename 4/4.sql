--DQL
-------


--1.Display (Using Union Function)
--a.The name and the gender of the dependence that's gender is Female and depending on Female Employee.
--b.And the male dependence that depends on Male Employee.
--------------------------------------------------------------
select d.Dependent_name,d.Sex
from Employee e,Dependent d
where d.Sex='f' and E.SSN=d.ESSN
union
select d.Dependent_name,d.Sex
from Employee e,Dependent d
where d.Sex='m' and E.SSN=d.ESSN
--------------------------------------------------------------

--For each project, list the project name and the total hours per week (for all employees) spent on that project.
------------------------------------------------------------------------------------------------------------------
select pname ,sum(hours)
from Project p,Works_for w
where p.Pnumber=w.Pno
group by Pname
--------------------------------------------------------

--Display the data of the department which has the smallest employee ID over all employees' ID.
------------------------------------------------------------------------------------------------
select Fname+' '+Lname,d.Dnum,d.Dname,d.MGRSSN,d.[MGRStart Date]
from Departments d ,Employee e
where  e.ssn= (select min(ssn) from Employee)
-----------------------------------------------------------------------------------

--For each department, retrieve the department name and the maximum, minimum and average salary of its employees.
----------------------------------------------------------------------------------------------------------------------
select d.Dname,max(salary) as maxi,min(salary) as mini,avg(salary)as av
from Departments d,employee e
where d.Dnum=e.Dno
group by d.Dname
--------------------------------------------------------------------------------------


--List the last name of all managers who have no dependents.
----------------------------------------------------------------
select distinct e.lname,Dependent_name
from Employee e inner join  Employee s
on s.Superssn=e.SSN
left outer join 
Dependent de
on e.SSN=de.ESSN
where dependent_name is null
--------------------------------------------------------------------
--For each department-- if its average salary is less than the average salary of all employees
--display its number, name and number of its employees.
----------------------------------------------------------------------------------------
select ssn,Fname,Dnum, avg(Salary) as avg
from Employee e,Departments d
where d.Dnum=e.Dno
group by SSN ,Fname,Dnum
having AVG(salary)<(select avg(salary) from employee)
--------------------------------------------------------------------------

--Retrieve a list of employees and the projects they are working on ordered by department 
--and within each department, ordered alphabetically by last name, first name.
---------------------------------------------------------------------------------------------
select fname,lname,pname,d.dnum
from Employee e inner join Departments d
on d.Dnum=e.dno
inner join 
Project p
on d.Dnum=p.Dnum
order by d.dnum,Lname,Fname asc
-------------------------------------------------------

--Try to get the max 2 salaries using subquery
---------------------------------------------------
SELECT Salary
FROM (
    SELECT Salary, ROW_NUMBER() OVER (ORDER BY Salary DESC) AS salary_rank
    FROM Employee
) AS ranked_salaries
WHERE salary_rank <= 2;

select top (2) salary
from employee 
order by salary desc
------------------------------------------------------------------

--Get the full name of employees that is similar to any dependent name
------------------------------------------------------------------------
select distinct fname+' '+lname as fullname
from Employee e ,Dependent de
where e.SSN=de.ESSN
--------------------------------------------------------

--Try to update all salaries of employees who work in Project ‘Al Rabwah’ by 30%
-----------------------------------------------------------------------------------
update Employee
set salary=salary*1.30
where ssn =(select ESSn from Project p,Works_for w where pname ='Al Rabwah'and p.Pnumber=w.Pno)
------------------------------------------------------------------------------------------------------------
--Display the employee number and name if at least one of them have dependents (use
--exists keyword)
--------------------------------------------------------------------------------------------
create view view3 as
select ssn,fname+' '+lname as fullname 
from Employee e,Dependent de
where e.SSN=de.ESSN

create proc porc2 as
select ssn,fname+' '+lname as fullname 
from Employee e,Dependent de
where e.SSN=de.ESSN
go 
exec porc2
--------------------------------------------------------------


--DML
-------


--In the department table insert new department called "DEPT IT" 
--, with id 100, employee with SSN = 112233 as a manager for this department.
--The start date for this manager is '1-11-2006'
------------------------------------------------------------------------------
alter table departments 
add DEPT_IT int

insert into Departments
values ('DP4',40,112233,2006-01-11,100)
---------------------------------------------------
--Do what is required if you know that : Mrs.Noha Mohamed(SSN=968574) 
--moved to be the manager of the new department (id = 100), and they give you(your SSN =102672)
--her position (Dept. 20 manager) 
--First try to update her record in the department table
--Update your record to be department 20 manager.
--Update the data of employee number=102660 to be in your teamwork (he will be supervised by you) (your SSN =102672)
-------------------------------------------------------------------------------------------------------------------------

update Departments
set MGRSSN=102672
where MGRSSN=968574

update Departments
set MGRSSN=968574
where MGRSSN=112233


update Employee
set Superssn=102672
where Superssn=112233 
------------------------------------------
--Unfortunately the company ended the contract with Mr. Kamel Mohamed (SSN=223344)
--so try to delete his data from your database in case you know that you will be temporarily in his position.
--Hint: (Check if Mr. Kamel has dependents, works as a department manager
--, supervises any employees or works in any projects and handle these cases).
-------------------------------------------------------------------------------------------------------------------
delete 
from Dependent 
WHERE ESSN=223344

delete 
from Works_for
WHERE ESSn=223344 

delete 
from Project
WHERE Pnumber=200 

delete 
from Works_for
WHERE Pno=300


delete 
from Project
WHERE Pnumber=300 	


delete 
from Works_for
WHERE Pno=100


delete 
from Project
WHERE Dnum=10

delete 
from Employee
WHERE  ssn=123456 

delete 
from Dependent
WHERE  ESSN=112233

delete 
from Employee
WHERE  ssn=112233

delete 
from Dependent
WHERE ESSN=321654

delete 
from Employee
WHERE Dno=10

delete 
from Dependent
WHERE ESSN=512463


delete 
from Works_for
WHERE ESSN=512463


delete 
from Works_for
WHERE ESSn=968574

delete 
from Works_for
WHERE ESSn=669955 

delete 
from Works_for
WHERE ESSn=521634

delete 
from Project
WHERE Dnum=20

delete 
from Project
WHERE Dnum=30

delete 
from Employee
WHERE Superssn=512463

delete 
from Employee
WHERE Superssn=968574

delete 
from Departments
WHERE MGRSSN=968574


delete 
from Employee
WHERE SSN=968574

delete 
from Departments
WHERE MGRSSN=102672

delete 
from Employee
WHERE Superssn=102672

delete 
from Employee
WHERE ssn=102660

update Employee
set Superssn = NULL
WHERE Superssn=321654

delete 
from Employee
WHERE ssn=321654

update Employee
set Dno =NULL
where Dno=10

Delete 
from Departments
where Dnum=10

Delete 
from Employee
where ssn=223344







or

delete 
from Dependent 
WHERE ESSN=223344

delete 
from Works_for
WHERE ESSn=223344 

delete 
from Project
WHERE Pnumber=200 


UPDATE EMPLOYEE 
SET DNO =NULL
WHERE DNO=10

UPDATE Employee
SET Superssn=NULL
WHERE Dno=10

UPDATE PROJECT  
SET Dnum=Null
WHERE Pnumber=200

update Employee
set Superssn=NULL
WHERE Superssn=223344

update Departments
set MGRSSN =NULL
WHERE MGRSSN=223344

DELETE 
FROM Employee
WHERE SSN =223344




