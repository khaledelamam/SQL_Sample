--Display the Department id, name and id and the name of its manager.
----------------------------------------------------------------------
select Dnum,Dname,MGRSSN,Fname
from Employee e ,Departments d
where d.Dnum =e.Dno
-------------------------------------------------

--Display the name of the departments and the name of the projects under its control
------------------------------------------------------------------------------------
select d.Dnum,Pname
from Departments d ,Project p
where d.Dnum=p.Dnum
--------------------------------------------------------------


--Display the full data about all the dependence associated with the name of the employee they depend on him/her
-------------------------------------------------------------------------------------------------------------------
select Fname,Dependent_name
from employee e, Dependent d
where e.SSN=d.ESSN
-------------------------------------------


--Display the Id, name and location of the projects in Cairo or Alex city
------------------------------------------------------------------------------
select Pnumber,Pname,Plocation
from Project 
-where City='alex' or city ='cairo'
-----------------------------------------------------


--Display the Projects full data of the projects with a name starts with "a" letter.--------------------------------------------------------------------------------------select *from Projectwhere Pname like 'a%'-------------------------------------------------------------display all the employees in department 30 whose salary from 1000 to 2000 LE monthly-----------------------------------------------------------------------------------------select Fname+' '+Lnamefrom Employee where Salary between 1000 and 2000 and Dno=30-----------------------------------------------------------------Retrieve the names of all employees in department 10 who works more than or equal10 hours per week on "AL Rabwah" project.-----------------------------------------------------------------------------------------------------------------------------select  Fname+' '+Lnamefrom Employee e ,Project p ,Works_for wwhere p.Dnum=10 and Hours>=10 and Pname='AL Rabwah' and e.SSN=w.ESSn and p.Pnumber=w.Pno-------------------------------------------------------------------------------------------------Find the names of the employees who directly supervised with Kamel Mohamed-----------------------------------------------------------------------------select Fname+' '+Lnamefrom Employeewhere Superssn=223344---------------------------------------------------Retrieve the names of all employees and the names of the projects they are working on, sorted by the project name----------------------------------------------------------------------------------------------------------------------select  fname+' '+Lname as FullName,Pnamefrom Employee e ,Project p,Works_for wwhere e.SSN=w.ESSn and p.Pnumber=w.Pnoorder by Pname asc----------------------------------------------For each project located in Cairo City , find the project number, the controlling
--department name ,the department manager last name ,address and birthdate
-----------------------------------------------------------------------------------
select Pnumber,p.Dnum ,Lname,Address,Bdate
from Project p ,Departments d,Employee e
where City='cairo' and e.Superssn=d.MGRSSN and d.Dnum=p.Dnum
------------------------------------------------------------------------


--Display All Employees data and the data of their dependents even if they have no dependents
---------------------------------------------------------------------------------------------
select e.*,d.*
from Employee e LEFT JOIN Dependent D
on e.SSN=d.ESSN
--------------------------------------------------
--Data Manipulating Language
----------------------------------

Insert your personal data to the employee table as a new employee in department number 30,
SSN = 102672, Superssn = 112233, salary=3000.
-----------------------------------------------------
insert into employee (dno,ssn,Superssn,Salary)
values (30,102672,112233,3000)
------------------------------------------------------


Insert another employee with personal data your friend as new employee in department number 30,
SSN = 102660, but don’t enter any value for salary or manager number to him.

insert into Employee( Fname,Lname,SSN,Bdate,Address,sex,Dno)
values('ahmed','mostafa',102660,1999-06-01,'63sakrkorish','m',30)

--Upgrade your salary by 20 % of its last value.
----------------------------------------------------
update Employee
set Salary=+0.20
where ssn =102660


