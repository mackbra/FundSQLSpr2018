-- Unit 3 Sales Orders/Engagement Agency CSci 1040-51, Mackenzie Branch

--Sales Orders Database
--#1
SELECT VendName, VendCity
FROM Vendors
WHERE VendCity 
IN ('Ballard', 'Bellevue', 'Redmond')

--#2
SELECT ProductName, RetailPrice
FROM Products
WHERE RetailPrice >= 125
ORDER BY ProductName ASC

--#3
SELECT VendName
FROM Vendors
WHERE VendWebPage IS NULL


--Entertainment Agency Database
--#1
SELECT EngagementNumber, StartDate, EndDate
FROM Engagements
WHERE StartDate <= '2012-10-31' AND EndDate >= '2012-10-01'

--#2
SELECT EngagementNumber, StartDate, EndDate, StartTime
FROM Engagements
WHERE StartDate <= '2012-10-31' AND EndDate >= '2012-10-01'
AND StartTime BETWEEN '12:00' AND '17:00'

--#3
SELECT EngagementNumber, StartDate AS 'Date'
FROM Engagements
WHERE StartDate = EndDate