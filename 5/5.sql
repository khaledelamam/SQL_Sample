--Part-1: Use ITI DB
---------------------------------------------------------------
--Retrieve number of students who have a value in their age
------------------------------------------------------------
select St_Id
from Student
where St_Age is not null
-------------------------------------------------

--Get all instructors Names without repetition
-------------------------------------------------
select distinct Ins_Name
from Instructor 
----------------------------------------------------------

--Display student with the following Format (use isNull function)
--------------------------------------------------------------------
select St_Id,St_Fname+' '+St_Lname as Fullname,Dept_Name
from Student s,Department d
where d.Dept_Id=s.Dept_Id and St_Fname+' '+St_Lname is null
-------------------------------------------------------------------

--Display instructor Name and Department Name 
---------------------------------------------
select Ins_Name,Dept_Name
from Instructor i ,Department d
where d.Dept_Id=i.Dept_Id
--------------------------------------------------

--Display student full name and the name of the course he is taking For only courses which have a grade  
------------------------------------------------------------------------------------------------------------
select St_Fname+' '+St_Lname,Crs_Name
from Student s inner join Stud_Course sc
on s.St_Id=sc.St_Id
inner join 
Course c
on c.Crs_Id=sc.Crs_Id and grade is not null
------------------------------------------------------

--Display number of courses for each topic name
--------------------------------------------------
select Crs_Id,Top_Name
from course c,Topic t
where t.Top_Id=c.Top_Id
-----------------------------------------------
select Max(salary) as Max ,Min(salary) as Min
from Instructor
---------------------------------------------------

--Display instructors who have salaries less than the average salary of all instructors.
-----------------------------------------------------------------------------------------
select avg(Salary)
from Instructor
having avg(salary)<(select avg(salary) from Instructor)
----------------------------------------------------------------------

--Display the Department name that contains the instructor who receives the minimum salary
--------------------------------------------------------------------------------------------
select Dept_Name,min(salary)
from Department d,Instructor i
where d.Dept_Id=i.Dept_Id
group by Dept_Name
---------------------------------------------------

--Select max two salaries in instructor table
-----------------------------------------------
select top(2)salary
from Instructor
order by Salary desc
--------------------------------------------------

--Select instructor name and his salary but if there is no salary display instructor bonus. “use one of coalesce Function”
----------------------------------------------------------------------------------------------------------------------------
select Ins_Name ,Salary,coalesce(salary,1)as coalesced
from Instructor
------------------------------------------------------------

--Select Average Salary for instructors 
---------------------------------------------
select avg(salary)
from Instructor
-------------------------------------------

--Select Student first name and the data of his supervisor 
-----------------------------------------------------------
select St_Fname,Dept_Manager
from Student s,Department d
where d.Dept_Id=s.Dept_Id
-----------------------------------------------

--Write a query to select the highest two salaries in Each Department for instructors who have salaries. 
--“using one of Ranking Functions”
----------------------------------------------------------------------------------------------------------
select *
from(select*,ROW_NUMBER() over (order by salary DESC) as RN
from Instructor) AS NEWTABLE
WHERE RN<=2

-----------------------------------------------------------------------------------

--Write a query to select a random  student from each department.  “using one of Ranking Functions”
----------------------------------------------------------------------------------------------------------
select st_fname,DENSE_RANK()over(order by dept_id) as random
from Student
order by newid()
---------------------------------------------------------------------------------------------------------------
--Part-2: Use AdventureWorks DB
-----------------------------------------

--Display the SalesOrderID, ShipDate of the SalesOrderHearder table 
--(Sales schema) to designate SalesOrders that occurred within the period ‘7/28/2002’ and ‘7/29/2014’
-------------------------------------------------------------------------------------------------------------
select SalesOrderID,ShipDate
from Sales.SalesOrderHeader 
where OrderDate between '2002-07-07'and '2014-07-29'
---------------------------------------------------------------------

--Display only Products(Production schema) with a StandardCost below $110.00 (show ProductID, Name only)
-----------------------------------------------------------------------------------------------------------
select ProductID,Name
from Production.Product
where StandardCost<110
----------------------------------------------------------------

--Display ProductID, Name if its weight is unknown
---------------------------------------------------------
select ProductID,name
from Production.Product
where Weight is null
------------------------------------

--Display all Products with a Silver, Black, or Red Color
--------------------------------------------------------------
select Production.Product.Name
from Production.Product
where color ='silver' or color ='black' or color ='red'
------------------------------------------------------------------

--Display any Product with a Name starting with the letter B
------------------------------------------------------------------
select Name
from Production.Product
where name like 'b%'
-------------------------------------------------------------------

--Calculate sum of TotalDue for each OrderDate in Sales.SalesOrderHeader table for the period
--between  '7/1/2001' and '7/31/2014'
---------------------------------------------------------------------------------------------------
select sum(TotalDue)
from Sales.SalesOrderHeader
where OrderDate between '2001-07-01' and '2014-07-31'
------------------------------------------------------------------

--Display the Employees HireDate (note no repeated values are allowed)
-------------------------------------------------------------------------
select distinct HireDate
from HumanResources.Employee
------------------------------------

--Calculate the average of the unique ListPrices in the Product table
-------------------------------------------------------------------------
select  distinct avg(ListPrice)
from Production.Product
-----------------------------------------------

--Display the Product Name and its ListPrice within the values of 100 and 
--120 the list should has the following format "The [product name] is only! [List price]"
--(the list will be sorted according to its ListPrice value)
----------------------------------------------------------------------------------------------
select Name
from Production.Product
where ListPrice between 100 and 120
order by ListPrice desc
------------------------------------------------------

--Transfer the rowguid ,Name, SalesPersonID, Demographics from Sales.Store table in a newly created table named [store_Archive]
--Note: Check your database to see the new table and how many rows in it?
--Try the previous query but without transferring the data? 
-------------------------------------------------------------------
select rowguid,Name,SalesPersonID,Demographics into store_Archive
from AdventureWorks2012.Sales.Store
where 1=2
------------------------------------------------------------------------

--Using union statement, retrieve the today’s date in different styles
---------------------------------------------------------------------------
select format(getdate(),'dd-mm-yyyy' )
union
select format(getdate(),'dddd  mmmm yyyy')
union
select format (getdate(),'dd-mm-yyyy mm:ss tt')
union
select format (getdate(), 'dd/mm/yyyy')


