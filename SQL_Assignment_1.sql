create database sql_assignment

--Salesman table creation
CREATE TABLE Salesman (
    SalesmanId INT,
    Name VARCHAR(255),
    Commission DECIMAL(10, 2),
    City VARCHAR(255),
    Age INT
);

--Salesman table record insertion 
INSERT INTO Salesman (SalesmanId, Name, Commission, City, Age)
VALUES
    (101, 'Joe', 50, 'California', 17),
    (102, 'Simon', 75, 'Texas', 25),
    (103, 'Jessie', 105, 'Florida', 35),
    (104, 'Danny', 100, 'Texas', 22),
    (105, 'Lia', 65, 'New Jersey', 30);

--Customer table creation

CREATE TABLE Customer (
    SalesmanId INT,
    CustomerId INT,
    CustomerName VARCHAR(255),
    PurchaseAmount INT,
    );

--Customer table record insertion 

INSERT INTO Customer (SalesmanId, CustomerId, CustomerName, PurchaseAmount)
VALUES
    (101, 2345, 'Andrew', 550),
    (103, 1575, 'Lucky', 4500),
    (104, 2345, 'Andrew', 4000),
    (107, 3747, 'Remona', 2700),
    (110, 4004, 'Julia', 4545);


--Orders table Creation
CREATE TABLE Orders (OrderId int, CustomerId int, SalesmanId int, Orderdate Date, Amount money)

--Orders table record insertion 
INSERT INTO Orders Values 
(5001,2345,101,'2021-07-01',550),
(5003,1234,105,'2022-02-15',1500)

--Checking contents
Select * from Salesman;

Select * from Customer;

Select * from orders;

-------------------------------------SQL ASSIGNMENT------------------------------------------------------------/*1. Insert a new record in your Orders table.*/
insert into orders Values
(5002,3456,103,'2023-02-15',1000)

/*2. Add Primary key constraint for SalesmanId column in Salesman table. Add default
constraint for City column in Salesman table. Add Foreign key constraint for SalesmanId
column in Customer table. Add not null constraint in Customer_name column for the
Customer table*/

--Add Primary key constraint for SalesmanId column in Salesman table
ALTER TABLE salesman 
alter column SalesmanId int NOT NULL;
ALTER TABLE salesman
ADD CONSTRAINT PK_Salesman PRIMARY KEY (SalesmanId);

--Add default constraint for City column in Salesman table
ALTER TABLE salesman
ADD CONSTRAINT DF_Salesman_City DEFAULT 'Unknown' FOR City;


/*Fetch the data where the Customer’s name is ending with ‘N’ also get the purchase
amount value greater than 500*/
SELECT *
FROM salesman a
left join customer b on a.SalesmanId = b.SalesmanId
WHERE a.Name LIKE '%N' AND b.PurchaseAmount > 500;


/*Using SET operators, retrieve the first result with unique SalesmanId values from two
tables, and the other result containing SalesmanId with duplicates from two tables*/

-- Unique SalesmanId values
SELECT SalesmanId FROM salesman
UNION
SELECT SalesmanId FROM customer;

-- SalesmanId with duplicates
SELECT SalesmanId FROM salesman
UNION ALL
SELECT SalesmanId FROM customer;



/*Display the below columns which has the matching data.
Orderdate, Salesman Name, Customer Name, Commission, and City which has the
range of Purchase Amount between 500 to 150*/

SELECT 
    o.Orderdate,
    s.Name AS "Salesman Name",
    c.CustomerName AS "Customer Name",
    s.Commission,
    s.City
FROM 
    orders o
JOIN 
    salesman s ON o.SalesmanId = s.SalesmanId
JOIN 
    customer c ON o.CustomerId = c.CustomerId
WHERE 
    c.PurchaseAmount BETWEEN 150 AND 500;



/*Using right join fetch all the results from Salesman	and Orders table.*/
Select * 
from orders o
right join Salesman s on  s.SalesmanId = o.SalesmanId




