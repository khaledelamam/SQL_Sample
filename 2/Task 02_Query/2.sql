--Display all the employees Data
---------------------------------
--select *
--from Employee
---------------------------------


--Display the employee First name, last name, Salary and Department number
-------------------------------------------------------------------------
--select Fname,Lname,Salary,Dno
--from Employee
--------------------------------------------------------------------------


--Display all the projects names, locations and the department which is responsible about it.------------------------------------------------------------------------------------------------select Pname ,Plocation,Dnum--from Project--------------------------------------- --If you know that the company policy is to pay an annual commission for each
--employee with specific percent equals 10% of his/her annual salary .Display each
--employee full name and his annual commission in an ANNUAL COMM column
--(alias).-----------------------------------------------------------------------------------------select Fname+' '+Lname,Salary*0.10 as commission--from Employee-------------------------------------------------------------Display the employees Id, name who earns more than 1000 LE monthly--------------------------------------------------------------------------select SSN,Fname+' '+Lname--from Employee--WHERE Salary>1000---------------------------------------------------------------------------Display the employees Id, name who earns more than 10000 LE annually.----------------------------------------------------------------------------select SSN,Fname+' '+Lname--from Employee--WHERE  Salary>=10000/12----------------------------------------------------------------------------Display the names and salaries of the female employees----------------------------------------------------------select fname+' '+Lname,Salary--from Employee--where sex='f'------------------------------------------------------------Display each department id, name which managed by a manager with id equals 968574.-----------------------------------------------------------------------------------------select Dnum,Dname--from Departments--where MGRSSN = 968574------------------------------------------------------------------------------------------ --Dispaly the ids, names and locations of the pojects which controled with department 10. -------------------------------------------------------------------------------------------select Pnumber,Pname,Plocation--from project--where Dnum=10