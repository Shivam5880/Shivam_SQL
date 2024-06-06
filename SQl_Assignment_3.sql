create database sql_assignment_3;

use sql_assignment_3

---check the inserted table

select * from Jomato;


/*Question 1. Create a stored procedure to display the restaurant name, type and cuisine where the table booking is not zero*/

CREATE PROCEDURE DisplayRestaurantsWithTableBookingNotZero
AS
BEGIN
    SET NOCOUNT ON;
    
    SELECT RestaurantName, RestaurantType, CuisinesType
    FROM jomato
    WHERE TableBooking <> 'No';
END;

-----calling the procedure
EXEC DisplayRestaurantsWithTableBookingNotZero;

/*Question 2. Create a transaction and update the cuisine type ‘Cafe’ to ‘Cafeteria’. Check the result and rollback it.*/

BEGIN TRANSACTION;

UPDATE jomato
SET CuisinesType = 'Cafeteria'
WHERE CuisinesType = 'Cafe';

-- Check the result-- result should be no columns
SELECT * FROM jomato WHERE CuisinesType = 'Cafe';

-- Rollback the transaction
ROLLBACK TRANSACTION;

--Checking rollback succes
SELECT * FROM jomato WHERE CuisinesType = 'Cafe';

/*Question 3. Generate a row number column and find the top 5 areas with the highest rating of restaurants.*/

---This Question has two possible meanings thus two solutions
---1. Top 5 areas with average rating of restaurants with rownumber window funtion
select * from
(select area, avg(rating) as avg_rating, row_number() over (order by avg(rating) desc) as rownumber
from jomato 
group by area ) a
where a.rownumber <= 5;

---2. Top 5 areas with top 5 rated restaurants with rownumber window funtion

select Area, RestaurantName, Rating, rownumber from 
(select *, row_number() over (order by rating desc) as rownumber from jomato) a
where a.rownumber <= 5;

/*Question 4. Use the while loop to display the 1 to 50*/

DECLARE @counter INT = 1;

WHILE @counter <= 50
BEGIN
    PRINT @counter;
    SET @counter = @counter + 1;
END;

/*Question 5. Write a query to Create a Top rating view to store the generated top 5 highest rating of restaurants*/

CREATE VIEW TopRating AS
SELECT TOP 5 RestaurantName, Rating
FROM jomato
ORDER BY Rating DESC;

--Checking the view
SELECT *
FROM TopRating;

/*Question 6. Write a trigger that sends an email notification to the restaurant owner whenever a new record is inserted.*/


--First we will enable database email then create a procedure for sending email

CREATE PROCEDURE dbo.SendEmailNotification
    @RestaurantName NVARCHAR(100)
AS
BEGIN
    DECLARE @Subject NVARCHAR(255);
    DECLARE @Body NVARCHAR(MAX);
    
    SET @Subject = 'New Record Inserted for Restaurant: ' + @RestaurantName;
    SET @Body = 'A new record has been inserted for the restaurant: ' + @RestaurantName + '.';
    
    EXEC msdb.dbo.sp_send_dbmail
        @profile_name = 'YourProfileName',
        @recipients = 'owner@example.com',
        @subject = @Subject,
        @body = @Body;
END;

---Now we will write a trigger for sending the email.

CREATE TRIGGER SendEmailOnInsert
ON jomato
AFTER INSERT
AS
BEGIN
    DECLARE @RestaurantName NVARCHAR(100);
    
    SELECT @RestaurantName = RestaurantName
    FROM inserted;
    
    EXEC dbo.SendEmailNotification @RestaurantName;
END;


