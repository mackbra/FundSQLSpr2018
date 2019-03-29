SELECT Students.StudFirstName, Students.StudLastName
FROM 
	(SELECT DISTINCT Students.StudentID, Students.StudFirstName, Students.StudLastName
	FROM ((Students
	INNER JOIN Student_Schedules
	ON Students.StudentID = Student_Schedules.StudentID)
	INNER JOIN Classes
	ON Student_Schedules.ClassID = Classes.ClassID)
	INNER JOIN Subjects
	ON Classes.SubjectID = Subjects.SubjectID
	WHERE Subjects.CategoryID LIKE '%ART' AND Student_Schedules.Grade >=

