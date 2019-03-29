-- Unit 4 Entertainment Agency/School Scheduling CSci 1040-51, Mackenzie Branch

--School Scheduling Database
--#1
SELECT Buildings.BuildingName, Class_Rooms.ClassRoomID
FROM Class_Rooms
INNER JOIN Buildings
ON Class_Rooms.BuildingCode = Buildings.BuildingCode

--#2
SELECT Students.StudentID, (Students.StudFirstName +' '+ Students.StudLastName) AS Student, Subjects.SubjectID, Subjects.SubjectName
FROM (((Students
INNER JOIN Student_Schedules
ON Students.StudentID = Student_Schedules.StudentID)
INNER JOIN Classes
ON Student_Schedules.ClassID = Classes.ClassID)
INNER JOIN Subjects
ON Classes.SubjectID = Subjects.SubjectID)
INNER JOIN Student_Class_Status
ON Student_Schedules.ClassStatus = Student_Class_Status.ClassStatus 
WHERE Student_Class_Status.ClassStatus = '1'

--#3
SELECT (Staff.StfFirstName +' '+ Staff.StfLastname) AS Staff, Subjects.SubjectName
FROM (Staff
INNER JOIN Faculty_Subjects
ON Staff.StaffID = Faculty_Subjects.StaffID)
INNER JOIN Subjects
ON Faculty_Subjects.SubjectID = Subjects.SubjectID

--#4
SELECT StudentArt.StudFirstName, StudentArt.StudLastName
FROM 
	(SELECT DISTINCT Students.StudentID, Students.StudFirstName, Students.StudLastName
	FROM ((Students
	INNER JOIN Student_Schedules
	ON Students.StudentID = Student_Schedules.StudentID)
	INNER JOIN Classes
	ON Student_Schedules.ClassID = Classes.ClassID)
	INNER JOIN Subjects
	ON Classes.SubjectID = Subjects.SubjectID
	WHERE Subjects.CategoryID = 'ART'
		AND Student_Schedules.Grade >= '85')
	AS StudentArt
INNER JOIN
	(SELECT DISTINCT Students.StudentID, Students.StudFirstName, Students.StudLastName
	FROM ((Students
	INNER JOIN Student_Schedules
	ON Students.StudentID = Student_Schedules.StudentID)
	INNER JOIN Classes
	ON Student_Schedules.ClassID = Classes.ClassID)
	INNER JOIN Subjects
	ON Classes.SubjectID = Subjects.SubjectID
	WHERE Subjects.CategoryID = 'CIS'
		AND Student_Schedules.Grade >= '85')
		AS StudentCIS
ON StudentArt.StudentID = StudentCIS.StudentID


--Entertainment Agency Database
--#1
SELECT Agents.AgentID, (Agents.AgtFirstName + ' ' + AgtLastName) AS Agent, Engagements.EngagementNumber, Engagements.StartDate, Engagements.EndDate
FROM Agents
INNER JOIN Engagements
ON Agents.AgentID = Engagements.AgentID
ORDER BY StartDate

--#2
SELECT (Customers.CustFirstName +' '+ Customers.CustLastName) AS Customer, (Entertainers.EntStageName) AS Entertainer
FROM (Customers
INNER JOIN Engagements
ON Customers.CustomerID = Engagements.CustomerID)
INNER JOIN Entertainers
ON Entertainers.EntertainerID = Engagements.EntertainerID

--#3
SELECT (Agents.AgtFirstName +' '+ Agents.AgtLastName) AS Agent, Entertainers.EntStageName AS Entertainer, Agents.AgtZipCode AS ZipCode
FROM Agents
INNER JOIN Entertainers
ON Entertainers.EntZipCode = Agents.AgtZipCode
ORDER BY Agents.AgtFirstName