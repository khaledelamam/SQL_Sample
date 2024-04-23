
--------------------------------
create rule r2 as @X=('NY')OR @X=('DS')OR @X=('KW')

create default def1 as ('NY')

SP_ADDTYPE LOC , 'NCHAR(2)'

SP_BINDRULE R2 ,LOC

sp_bindefault def1,loc

Create table dapartment 
(
Did nvarchar(2) primary key ,
Dname varchar(50),
location loc 
)
-----------------------------------
create table Employee 
(
Enum int,
Fname varchar(50),
Lname varchar(50),
Dnum nvarchar(2),
Salary int,
constraint c1 primary key (Enum),
constraint c2 foreign key (Dnum) references department(did),
constraint c3 unique (salary),
constraint c4 check (fname is not null),
constraint c5 check (lname is not null),
)
create rule r3 as @x<6000
sp_bindrule r3,'employee.salary'

INSERT INTO Employee(Enum,Fname,Lname,Dnum,Salary)
VALUES 
(
10102,'Ann','Jones','d3',3000,
18316,'John','Barrimore','d1',2400,
29346,'James','James','d2',2800,
9031,'Lisa'	,'Bertoni','d2',4000,
2581,'Elisa','Hansel','d2',3600,
28559,'Sybl','Moser','d1',2900
)
--------------------------------
CREATE TABLE Projects 
(
Pnum nvarchar(2) primary key ,
Pname varchar (50) ,
Budget int null 
)
alter table projects 

insert into Projects(Pnum,Pname,Budget)
values 
('p1'	,'Apollo',	120000,'p2'	,'Gemini',	95000,'p3'	,'Mercury',	185600)
-----------------------------
create table WorkOn
(
WEnum int NOT NULL,
WPnum nvarchar(2) NOT NULL,
Job varchar(50) NULL,
E_Date date NOT NULL DEFAULT (GETDATE()),
PRIMARY KEY (WEnum,WPnum),
constraint c8 foreign key  (WEnum) references employee (Enum),
constraint c9 foreign key (WPnum) references Projects (Pnum)
)

INSERT INTO WorkOn (WEnum,WPnum,Job,E_Date)
VALUES(
29346,'p1','Clerk','2007-1-4')
------------------------------------
CREATE SCHEMA COM 
CREATE SCHEMA RS
--	Create the following schema and transfer the following tables to it Company Schema 	Department table (Programmatically)
CREATE SCHEMA COM 
ALTER SCHEMA COM TRANSFER PROJECTS 
ALTER SCHEMA COM TRANSFER DEPARTMENT 
--Human Resource Schema  Employee table (Programmatically)
CREATE SCHEMA RS
ALTER SCHEMA RS TRANSFER EMPLOYEE 

-------------------------------------------
--Write query to display the constraints for the Employee table.
SELECT * FROM RS.EMPLOYEE
---------------------------------------
CREATE SYNONYM EMP
FOR RS.EMPLOYEE 
Select * from Employee --INVALID
Select * from RS.Employee --VALID 
Select * from Emp --INVALID
Select * from RS.Emp  --VALID 
----------------------------------------
--Increase the budget of the project where the manager number is 10102 by 10%.
CREATE SYNONYM PRO
FOR COMPANY_SD.COM.PROJECTS

UPDATE COMPANY_SD.COM.PROJECTS 
SET BUDGET =BUDGET*1.10
WHERE PNUM IN (SELECT WPnum FROM WorkOn W,COMPANY_SD.COM.PROJECTS P WHERE WENUM =10102 AND P.PNUM=W.WPnum)

---------------------------------------------
--Change the name of the department for which the employee named James works.The new department name is Sales.
INSERT INTO department (DID)
VALUES ('S1')
UPDATE Employee
SET Dnum='S1'
WHERE Fname='JAMES'
---------------------------------
--Change the enter date for the projects for those employees who work in project p1 and belong to department ‘Sales’. The new date is 12.12.2007.
UPDATE WorkOn
SET E_Date='2007-12-12'
WHERE WPnum='P1' AND  WEnum IN (SELECT Enum FROM Employee WHERE Dnum='S1')
-----------------------------------------------------------------------------------
--Delete the information in the works_on table for all employees who work for the department located in KW
DELETE 
FROM department
WHERE Did='D3'

