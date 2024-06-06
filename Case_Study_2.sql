create database casestudy2;

use casestudy2;

---------------create table location 
CREATE TABLE LOCATION (
  Location_ID INT PRIMARY KEY,
  City VARCHAR(50)
);

-----Insert values in location
INSERT INTO LOCATION (Location_ID, City)
VALUES (122, 'New York'),
       (123, 'Dallas'),
       (124, 'Chicago'),
       (167, 'Boston');

--------create table department
CREATE TABLE DEPARTMENT (
  Department_Id INT PRIMARY KEY,
  Name VARCHAR(50),
  Location_Id INT,
  FOREIGN KEY (Location_Id) REFERENCES LOCATION(Location_ID)
);

---------insert values in department
INSERT INTO DEPARTMENT (Department_Id, Name, Location_Id)
VALUES (10, 'Accounting', 122),
       (20, 'Sales', 124),
       (30, 'Research', 123),
       (40, 'Operations', 167);

---------Create Jobs table
CREATE TABLE JOB (
  Job_ID INT PRIMARY KEY,
  Designation VARCHAR(50)
);

-------Insert into Job table
INSERT  INTO JOB VALUES
(667, 'CLERK'),
(668,'STAFF'),
(669,'ANALYST'),
(670,'SALES_PERSON'),
(671,'MANAGER'),
(672, 'PRESIDENT')

------------create table employee
CREATE TABLE EMPLOYEE
(EMPLOYEE_ID INT,
LAST_NAME VARCHAR(20),
FIRST_NAME VARCHAR(20),
MIDDLE_NAME CHAR(1),
JOB_ID INT FOREIGN KEY
REFERENCES JOB(JOB_ID),
MANAGER_ID INT,
HIRE_DATE DATE,
SALARY INT,
COMM INT,
DEPARTMENT_ID  INT FOREIGN KEY
REFERENCES DEPARTMENT(DEPARTMENT_ID))


----------Insert into employee
INSERT INTO EMPLOYEE VALUES
(7369,'SMITH','JOHN','Q',667,7902,'17-DEC-84',800,NULL,20),
(7499,'ALLEN','KEVIN','J',670,7698,'20-FEB-84',1600,300,30),
(7505,'DOYLE','JEAN','K',671,7839,'04-APR-85',2850,NULl,30),
(7506,'DENNIS','LYNN','S',671,7839,'15-MAY-85',2750,NULL,30),
(7507,'BAKER','LESLIE','D',671,7839,'10-JUN-85',2200,NULL,40),
(7521,'WARK','CYNTHIA','D',670,7698,'22-FEB-85',1250,500,30)


----------Checking the tables-----------

select * from DEPARTMENT;
select * from EMPLOYEE;
select * from JOB;
select * from LOCATION;


/*
Simple Queries:
1. List all the employee details.*/
Select * from employee

--2. List all the department details.

Select * from department

--3. List all job details.

select * from job

--4. List all the locations.

select * from locations

--5. List out the First Name, Last Name, Salary, Commission for all Employees.

select first_name, last_name, salary, comm from employee;

/*6. List out the Employee ID, Last Name, Department ID for all employees and 
alias
Employee ID as "ID of the Employee", Last Name as "Name of the
Employee", Department ID as "Dep_id".*/

select employee_id as 'ID of the Employee', last_name 'Name of the Employee', department_id as 'Dep_id' from employee;

--7. List out the annual salary of the employees with their names only.

--solution1
select first_name, last_name, Salary from employee;
--solution2
select concat(first_name,' ',last_name), salary from employee;

WHERE Condition:
--1. List the details about "Smith".
select * from employee where last_name = 'Smith';

--2. List out the employees who are working in department 20.
select * from employee where department_id = 20;

--3. List out the employees who are earning salary between 2000 and 3000.
select * from employee where salary between 2000 and 3000;

--4. List out the employees who are working in department 10 or 20.

select * from employee where department_id in (10,20);

--5. Find out the employees who are not working in department 10 or 30.

select * from employee where department_id not in (10,30);

--6. List out the employees whose name starts with 'L'.

select * from employee where first_name like 'L%';

--7. List out the employees whose name starts with 'L' and ends with 'E'.

select * from employee where first_name like 'L%E';


--8. List out the employees whose name length is 4 and start with 'J'.

select * from employee where len(first_name) = 4 and first_name like 'J%';

--9. List out the employees who are working in department 30 and draw the salaries more than 2500.

select * from employee where department_id = 30 and salary > 2500;

--10. List out the employees who are not receiving commission.

select * from employee where comm is null;

--ORDER BY Clause:
--1. List out the Employee ID and Last Name in ascending order based on the Employee ID.

SELECT 
Employee_id,
Last_Name
FROM 
Employee
ORDER BY 
Employee_id ASC;


--2. List out the Employee ID and Name in descending order based on salary.

SELECT 
Employee_id,
CONCAT(First_Name, ' ', Last_Name) AS Name
FROM 
Employee
ORDER BY 
Salary DESC;


--3. List out the employee details according to their Last Name in ascending-order.

SELECT 
Employee_id,
Last_Name,
First_Name,
Middle_Name,
Job_ID,
Manager_id,
Hire_date,
Salary,
Comm,
Department_id
FROM 
Employee
ORDER BY 
Last_Name ASC;


--4. List out the employee details according to their Last Name in ascending order and then Department ID in descending order.

SELECT 
Employee_id,
Last_Name,
First_Name,
Middle_Name,
Job_ID,
Manager_id,
Hire_date,
Salary,
Comm,
Department_id
FROM 
Employee
ORDER BY 
Last_Name ASC,
Department_id DESC;



GROUP BY and HAVING Clause:
--1. List out the department wise maximum salary, minimum salary and average salary of the employees.
SELECT 
Department_id,
MAX(Salary) AS Max_Salary,
MIN(Salary) AS Min_Salary,
AVG(Salary) AS Avg_Salary
FROM 
Employee
GROUP BY 
Department_id;


--2. List out the job wise maximum salary, minimum salary and average salary of the employees.
SELECT 
e.Job_ID,
MAX(e.Salary) AS Max_Salary,
MIN(e.Salary) AS Min_Salary,
AVG(e.Salary) AS Avg_Salary
FROM 
Employee e
GROUP BY 
e.Job_ID;

--3. List out the number of employees who joined each month in ascending order.

SELECT 
MONTH(Hire_date) AS Join_Month,
COUNT(*) AS Num_of_Employees
FROM 
Employee
GROUP BY 
MONTH(Hire_date)
ORDER BY 
Join_Month ASC;


--4. List out the number of employees for each month and year in ascending order based on the year and month.

SELECT 
YEAR(Hire_date) AS Join_Year,
MONTH(Hire_date) AS Join_Month,
COUNT(*) AS Num_of_Employees
FROM 
Employee
GROUP BY 
YEAR(Hire_date),
MONTH(Hire_date)
ORDER BY 
Join_Year ASC,
Join_Month ASC;


--5. List out the Department ID having at least four employees.
SELECT 
Department_id,
COUNT(*) AS Num_of_Employees
FROM 
Employee
GROUP BY 
Department_id
HAVING 
COUNT(*) >= 4;


--6. How many employees joined in February month.

SELECT 
COUNT(*) AS Num_of_Employees
FROM 
Employee
WHERE 
MONTH(Hire_date) = 2; -- 2 represents February

--7. How many employees joined in May or June month.
SELECT 
COUNT(*) AS Num_of_Employees
FROM 
Employee
WHERE 
MONTH(Hire_date) IN (5, 6); -- 5 represents May and 6 represents June


--8. How many employees joined in 1985?

SELECT 
COUNT(*) AS Num_of_Employees
FROM 
Employee
WHERE 
YEAR(Hire_date) = 1985;

--9. How many employees joined each month in 1985?
SELECT 
MONTH(Hire_date) AS Join_Month,
COUNT(*) AS Num_of_Employees
FROM 
Employee
WHERE 
YEAR(Hire_date) = 1985
GROUP BY 
MONTH(Hire_date);


--10. How many employees were joined in April 1985?

SELECT 
COUNT(*) AS Num_of_Employees
FROM 
Employee
WHERE 
YEAR(Hire_date) = 1985
AND MONTH(Hire_date) = 4; -- 4 represents April


--11. Which is the Department ID having greater than or equal to 3 employees joining in April 1985?

SELECT 
Department_id
FROM 
Employee
WHERE 
YEAR(Hire_date) = 1985
AND MONTH(Hire_date) = 4
GROUP BY 
Department_id
HAVING 
COUNT(*) >= 3;



Joins:
--1. List out employees with their department names.

SELECT 
e.Employee_id,
e.Last_Name,
e.First_Name,
e.Middle_Name,
e.Job_ID,
e.Manager_id,
e.Hire_date,
e.Salary,
e.Comm,
d.Name AS Department_Name
FROM 
Employee e
JOIN 
Department d ON e.Department_id = d.Department_id;

--2. Display employees with their designations.
SELECT 
e.Employee_id,
e.Last_Name,
e.First_Name,
e.Middle_Name,
j.Designation AS Job_Title
FROM 
Employee e
JOIN 
Job j ON e.Job_ID = j.Job_Id;


--3. Display the employees with their department names and city.
SELECT 
    e.Employee_id,
    e.Last_Name,
    e.First_Name,
    e.Middle_Name,
    d.Name AS Department_Name,
    l.City
FROM 
    Employee e
JOIN 
    Department d ON e.Department_id = d.Department_id
JOIN 
    Location l ON d.Location_id = l.Location_id;


--4. How many employees are working in different departments? Display with department names.
SELECT 
d.Name AS Department_Name,
COUNT(*) AS Num_of_Employees
FROM 
Employee e
JOIN 
Department d ON e.Department_id = d.Department_id
GROUP BY 
d.Name;


--5. How many employees are working in the sales department?

SELECT 
COUNT(*) AS Num_of_Employees
FROM 
Employee e
JOIN 
Department d ON e.Department_id = d.Department_id
WHERE 
d.Name = 'Sales';


--6. Which is the department having greater than or equal to 3 employees and display the department names in ascending order.

SELECT 
d.Name AS Department_Name
FROM 
Employee e
JOIN 
Department d ON e.Department_id = d.Department_id
GROUP BY 
d.Name
HAVING 
COUNT(*) >= 3
ORDER BY 
d.Name ASC;


--7. How many employees are working in 'Dallas'?

SELECT 
COUNT(*) AS Num_of_Employees
FROM 
Employee e
JOIN 
Department d ON e.Department_id = d.Department_id
JOIN 
Location l ON d.Location_id = l.Location_id
WHERE 
l.City = 'Dallas';

--8. Display all employees in sales or operation departments.

SELECT 
e.Employee_id,
e.Last_Name,
e.First_Name,
e.Middle_Name,
d.Name AS Department_Name
FROM 
Employee e
JOIN 
Department d ON e.Department_id = d.Department_id
WHERE 
d.Name IN ('Sales', 'Operations');


--CONDITIONAL STATEMENT
--1. Display the employee details with salary grades. Use conditional statement to create a grade column.
SELECT 
Employee_id,
Last_Name,
First_Name,
Middle_Name,
Salary,
CASE
    WHEN Salary >= 2000 THEN 'Grade A'
    WHEN Salary >= 1000 AND Salary < 20000 THEN 'Grade B'
    ELSE 'Grade C'
END AS Grade
FROM 
Employee;



--2. List out the number of employees grade wise. Use conditional statement to create a grade column.
SELECT 
CASE
    WHEN Salary >= 2000 THEN 'Grade A'
    WHEN Salary >= 1000 AND Salary < 20000 THEN 'Grade B'
    ELSE 'Grade C'
END AS Grade,
count(*) As Num_of_employees
FROM 
Employee
Group by 
CASE
    WHEN Salary >= 2000 THEN 'Grade A'
    WHEN Salary >= 1000 AND Salary < 20000 THEN 'Grade B'
    ELSE 'Grade C'
End;



--3. Display the employee salary grades and the number of employees between 2000 to 5000 range of salary.

SELECT 
CASE
    WHEN Salary >= 2000 THEN 'Grade A'
    WHEN Salary >= 1000 AND Salary < 20000 THEN 'Grade B'
    ELSE 'Grade C'
END AS Grade,
count(*) As Num_of_employees
FROM 
Employee
Where Salary >=2000 and Salary <=5000
Group by 
CASE
    WHEN Salary >= 2000 THEN 'Grade A'
    WHEN Salary >= 1000 AND Salary < 20000 THEN 'Grade B'
    ELSE 'Grade C'
End;



--Subqueries:
--1. Display the employees list who got the maximum salary.

SELECT 
    Employee_id,
    Last_Name,
    First_Name,
    Middle_Name,
    Salary
FROM 
    Employee
WHERE 
    Salary = (SELECT MAX(Salary) FROM Employee);


--2. Display the employees who are working in the sales department.
SELECT 
    Employee_id,
    Last_Name,
    First_Name,
    Middle_Name
FROM 
    Employee
WHERE 
    Department_id = (SELECT Department_id FROM Department WHERE Name = 'Sales');

--3. Display the employees who are working as 'Clerk'.
SELECT 
    e.Employee_id,
    e.Last_Name,
    e.First_Name,
    e.Middle_Name
FROM 
    Employee e
WHERE 
    e.Job_ID = (SELECT Job_Id FROM Job WHERE Designation = 'Clerk');

--4. Display the list of employees who are living in 'Boston'.

SELECT 
Employee_id,
Last_Name,
First_Name,
Middle_Name
FROM 
Employee
WHERE 
Department_id IN (SELECT Department_id FROM Department WHERE Location_id IN (SELECT Location_id FROM Location WHERE City = 'Boston'));

--5. Find out the number of employees working in the sales department.

SELECT 
COUNT(*) AS Num_of_Employees
FROM 
Employee
WHERE 
Department_id = (SELECT Department_id FROM Department WHERE Name = 'Sales');

--6. Update the salaries of employees who are working as clerks on the basis of 10%.

UPDATE Employee
SET Salary = Salary * 1.1
WHERE Job_ID = (SELECT Job_ID FROM Job WHERE Designation = 'Clerk');


--7. Display the second highest salary drawing employee details.
SELECT 
Employee_id,
Last_Name,
First_Name,
Middle_Name,
Salary
FROM 
Employee
WHERE 
Salary = (
SELECT MAX(Salary) 
FROM Employee 
WHERE Salary < (
    SELECT MAX(Salary) 
    FROM Employee
)
);


--8. List out the employees who earn more than every employee in department 30.


SELECT 
Employee_id,
Last_Name,
First_Name,
Middle_Name,
Salary
FROM 
Employee
WHERE 
Salary > (
SELECT MAX(Salary)
FROM Employee
WHERE Department_id = 30
);

--9. Find out which department has no employees.

SELECT 
Department_id,
Name AS Department_Name
FROM 
Department
WHERE 
Department_id NOT IN (SELECT DISTINCT Department_id FROM Employee);


--10. Find out the employees who earn greater than the average salary for their department.*/

SELECT 
e.Employee_id,
e.Last_Name,
e.First_Name,
e.Middle_Name,
e.Salary
FROM 
Employee e
WHERE 
e.Salary > (SELECT 
AVG(Salary)
FROM 
Employee
WHERE 
Department_id = e.Department_id);




