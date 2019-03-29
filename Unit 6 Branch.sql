-- Unit 6 Entertainment Agency/School Scheduling CSci 1040-51, Mackenzie Branch

--Chapter 15
--Pg 539
--#2
UPDATE Staff
SET StfAreaCode = '360'
WHERE StfZipCode IN ('98270', '98271')

--Chapter 16
--Pg 569
--#2
INSERT INTO Musical_Styles
(StyleID, StyleName)
VALUES (
(SELECT MAX(StyleID) FROM Musical_Styles) + 1, 'New  Age')

--#3
INSERT INTO Engagements
(CustomerID, EntertainerID, AgentID, StartDate, EndDate, StartTime, StopTime, ContractPrice)
SELECT Customers.CustomerID, Engagements.EntertainerID, Engagements.AgentID, '2013-08-01', 
		'2013-08-01', Engagements.StartTime, Engagements.StopTime, Engagements.ContractPrice
FROM (Customers
	INNER JOIN Engagements
	ON Customers.CustomerID = Engagements.CustomerID)
WHERE (Customers.CustFirstName = 'Doris') AND
	(Customers.CustLastName = 'Hartwig') AND
	(Engagements.StartDate = '2012-12-01')



--Chapter 17
--Pg 589
--#1
DELETE FROM Musical_Preferences
WHERE CustomerID NOT IN
(SELECT CustomerID
FROM Engagements)

DELETE FROM Customers
WHERE CustomerID NOT IN
(SELECT CustomerID
FROM Engagements)


--#2
DELETE FROM Musical_Preferences
WHERE StyleID NOT IN
(SELECT StyleID
FROM Entertainer_Styles)

DELETE FROM Musical_Styles
WHERE StyleID NOT IN
(SELECT StyleID
FROM Entertainer_Styles)