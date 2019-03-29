-- Unit 2 Sales Orders/Engagement Agency CSci 1040-51, Mackenzie Branch

--Sales Orders Database
--#1
SELECT VendName, VendCity
FROM Vendors
WHERE VendCity 
IN ('Ballard', 'Bellevue', 'Redmond')

--#2
SELECT *
FROM Engagements

--#3
SELECT EngagementNumber, StartDate
FROM Engagements
ORDER BY StartDate DESC, EngagementNumber ASC


--Page 155
--#1
SELECT CustFirstName + ' ' + CustLastName AS CustName, CustCity AS City
FROM Customers
ORDER BY CustCity

--#2
SELECT EntSTageName, EntWebPage
FROM Entertainers

--#3
SELECT AgtFirstName +' '+ AgtLastName AS Agent, DateHired, DATEADD(month, 6, CAST(DateHired AS DATE)) AS ReviewDate
FROM Agents