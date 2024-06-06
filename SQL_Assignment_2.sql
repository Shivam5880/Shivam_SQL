create database sql_assignment_2;
use sql_assignment_2;

---Import table into the database
---checking the table
select * from jomato;

--------------------------------------SQL Assignment 2------------------------------------------------------------------------

--/*Question 1. Create a user-defined functions to stuff the Chicken into ‘Quick Bites’. Eg: ‘Quick Chicken Bites’*/

CREATE FUNCTION dbo.StuffChickenIntoQuickBites (@restaurantType NVARCHAR(100))
RETURNS NVARCHAR(100)
AS
BEGIN
    DECLARE @modifiedType NVARCHAR(100)
    
    IF @restaurantType = 'Quick Bites'
    BEGIN
        SET @modifiedType = 'Quick Chicken Bites'
    END
    ELSE
    BEGIN
        SET @modifiedType = @restaurantType
    END
    
    RETURN @modifiedType
END

-- Update the RestaurantType column using the function
UPDATE jomato
SET RestaurantType = dbo.StuffChickenIntoQuickBites(RestaurantType)



/*Question 2. Use the function to display the restaurant name and cuisine type which has the maximum number of rating.*/

SELECT RestaurantName, dbo.StuffChickenIntoQuickBites(CuisinesType) AS CuisineType, No_of_rating
FROM jomato
WHERE No_of_Rating = (SELECT MAX(No_of_Rating) FROM jomato)


/* Question 3. Create a Rating Status column to display the rating as ‘Excellent’ if it has more than 4 
start rating, ‘Good’ if it has above 3.5 and below 4 star rating, ‘Average’ if it is above 3
and below 3.5 and ‘Bad’ if it is below 3 star rating*/
-- Add a new computed column to the table



ALTER TABLE jomato
ADD RatingStatus AS (
    CASE 
        WHEN Rating > 4 THEN 'Excellent'
        WHEN Rating > 3.5 AND Rating <= 4 THEN 'Good'
        WHEN Rating > 3 AND Rating <= 3.5 THEN 'Average'
        ELSE 'Bad'
    END
);



/*Question 4. Find the Ceil, floor and absolute values of the rating column and display the current date and separately display 
the year, month_name and day*/
-- Find the Ceil, floor and absolute values of the rating column
SELECT 
Rating,
CEILING(Rating) AS CeilRating,
FLOOR(Rating) AS FloorRating,
ABS(Rating) AS AbsoluteRating,
-- Get the current date
GETDATE() AS CurrentDate,
-- Display the year
YEAR(GETDATE()) AS CurrentYear,
-- Display the month name
DATENAME(MONTH, GETDATE()) AS CurrentMonthName,
-- Display the day
DAY(GETDATE()) AS CurrentDay
from jomato;


/*Question 5. Display the restaurant type and total average cost using rollup*/

SELECT 
    ISNULL(RestaurantType, 'Total') AS RestaurantType,
    SUM(AverageCost) AS TotalAverageCost
FROM 
    jomato
GROUP BY 
    RestaurantType WITH ROLLUP;

