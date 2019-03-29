-- Unit 5 Entertainment Agency/School Scheduling CSci 1040-51, Mackenzie Branch

--Chapter 12
--Pg 443
--#1
SELECT AVG (Salary)
	AS AvgSalary
FROM Agents

--Pg 444
--#1
SELECT AVG(Duration)
	AS AvgClassDuration
FROM Classes

--#3
SELECT COUNT (ClassID)
	AS ClassesInRoom3346
FROM Classes
WHERE ClassRoomID = 3346



--Chapter 13
--Pg 476
--#1
SELECT Categories.CategoryDescription, COUNT(Subjects.SubjectID) AS ClassesOffered
FROM Categories
INNER JOIN Subjects
ON Categories.CategoryID = Subjects.CategoryID
GROUP BY Categories.CategoryDescription

--#2
SELECT Staff.StfFirstName +' '+ Staff.StfLastname AS StaffMember, COUNT (Faculty_Classes.ClassID) AS NumberofClassesTaught
FROM Staff
INNER JOIN Faculty_Classes
ON Staff.StaffID = Faculty_Classes.StaffID
GROUP BY
	Staff.StfFirstName, Staff.StfLastName