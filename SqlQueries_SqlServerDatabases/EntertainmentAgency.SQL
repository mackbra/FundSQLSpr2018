CREATE DATABASE EntertainmentAgencyExample
GO

use EntertainmentAgencyExample
GO

CREATE TABLE Agents (
	AgentID int NOT NULL ,
	AgtFirstName nvarchar (25) NULL ,
	AgtLastName nvarchar (25) NULL ,
	AgtStreetAddress nvarchar (50) NULL ,
	AgtCity nvarchar (30) NULL ,
	AgtState nvarchar (2) NULL ,
	AgtZipCode nvarchar (10) NULL ,
	AgtPhoneNumber nvarchar (15) NULL ,
	DateHired date NULL ,
	Salary money NULL ,
	CommissionRate float(24) NULL
)
GO

CREATE TABLE Customers (
	CustomerID int NOT NULL ,
	CustFirstName nvarchar (25) NULL ,
	CustLastName nvarchar (25) NULL ,
	CustStreetAddress nvarchar (50) NULL ,
	CustCity nvarchar (30) NULL ,
	CustState nvarchar (2) NULL ,
	CustZipCode nvarchar (10) NULL ,
	CustPhoneNumber nvarchar (15) NULL 
)
GO

CREATE TABLE Engagements (
	EngagementNumber int NOT NULL ,
	StartDate date NULL ,
	EndDate date NULL ,
	StartTime time NULL ,
	StopTime time NULL ,
	ContractPrice money NULL ,
	CustomerID int NULL ,
	AgentID int NULL ,
	EntertainerID int NULL 
)
GO

CREATE TABLE Entertainer_Members (
	EntertainerID int NOT NULL ,
	MemberID int NOT NULL ,
	Status smallint NULL 
)
GO

CREATE TABLE Entertainer_Styles (
	EntertainerID int NOT NULL ,
	StyleID smallint NOT NULL , 
        StyleStrength smallint NOT NULL 
)
GO

CREATE TABLE Entertainers (
	EntertainerID int NOT NULL ,
	EntStageName nvarchar (50) NULL ,
	EntSSN nvarchar (12) NULL ,
	EntStreetAddress nvarchar (50) NULL ,
	EntCity nvarchar (30) NULL ,
	EntState nvarchar (2) NULL ,
	EntZipCode nvarchar (10) NULL ,
	EntPhoneNumber nvarchar (15) NULL ,
	EntWebPage nvarchar (50) NULL ,
	EntEMailAddress nvarchar (50) NULL ,
	DateEntered date NULL 
)
GO

CREATE TABLE Members (
	MemberID int NOT NULL ,
	MbrFirstName nvarchar (25) NULL ,
	MbrLastName nvarchar (25) NULL ,
	MbrPhoneNumber nvarchar (15) NULL ,
	Gender nvarchar (2) NULL 
)
GO

CREATE TABLE Musical_Preferences (
	CustomerID int NOT NULL ,
	StyleID smallint NOT NULL ,
        PreferenceSeq smallint NOT NULL 
)
GO

CREATE TABLE Musical_Styles (
	StyleID smallint NOT NULL ,
	StyleName nvarchar (75) NULL 
)
GO

CREATE TABLE ztblDays (
        DateField date NOT NULL 
)
GO

CREATE TABLE ztblMonths ( 
        MonthYear nvarchar (15) NULL ,
        YearNumber smallint NOT NULL ,
        MonthNumber smallint NOT NULL ,
        MonthStart date NULL ,
        MonthEnd date NULL ,
        January smallint NULL ,
        February smallint NULL ,
        March smallint NULL ,
        April smallint NULL ,
        May smallint NULL ,
        June smallint NULL ,
        July smallint NULL ,
        August smallint NULL ,
        September smallint NULL ,
        October smallint NULL ,
        November smallint NULL ,
        December smallint NULL 
)
GO

CREATE TABLE ztblSkipLabels (
        LabelCount int NOT NULL  
)
GO

CREATE TABLE ztblWeeks ( 
        WeekStart date NOT NULL ,
        WeekEnd date NULL 
)
GO

ALTER TABLE Agents ADD 
	CONSTRAINT Salary_Default DEFAULT (0) FOR Salary,
	CONSTRAINT Commission_Rate_Default DEFAULT (0) FOR CommissionRate,
	CONSTRAINT Agents_PK PRIMARY KEY   
	(
		AgentID
	)  
GO

 CREATE  INDEX AgtZipCode ON Agents(AgtZipCode)
GO

ALTER TABLE Customers ADD 
	CONSTRAINT Customers_PK PRIMARY KEY   
	(
		CustomerID
	)  
GO

 CREATE  INDEX CustZipCode ON Customers(CustZipCode)
GO

ALTER TABLE Engagements ADD 
	CONSTRAINT Engagement_Number_Default DEFAULT (0) FOR EngagementNumber,
	CONSTRAINT Contract_Price_Default DEFAULT (0) FOR ContractPrice,
	CONSTRAINT Customer_ID_Default DEFAULT (0) FOR CustomerID,
	CONSTRAINT EN_Agent_ID_Default DEFAULT (0) FOR AgentID,
	CONSTRAINT EN_Entertainer_ID_Default DEFAULT (0) FOR EntertainerID,
	CONSTRAINT Engagements_PK PRIMARY KEY   
	(
		EngagementNumber
	)  
GO

 CREATE  INDEX AgentsEngagements ON Engagements(AgentID)
GO

 CREATE  INDEX CustomersEngagements ON Engagements(CustomerID)
GO

 CREATE  INDEX EntertainersEngagements ON Engagements(EntertainerID)
GO

ALTER TABLE Entertainer_Members ADD 
	CONSTRAINT EM_Member_ID_Default DEFAULT (0) FOR MemberID,
	CONSTRAINT EM_Status_Default DEFAULT (0) FOR Status,
	CONSTRAINT Entertainer_Members_PK PRIMARY KEY   
	(
		EntertainerID,
		MemberID
	)  
GO

 CREATE  INDEX EntertainersEntertainerMembers ON Entertainer_Members(EntertainerID)
GO

 CREATE  INDEX MembersEntertainerMembers ON Entertainer_Members(MemberID)
GO

ALTER TABLE Entertainer_Styles ADD 
	CONSTRAINT EN_Styles_Default DEFAULT (0) FOR StyleID,
	CONSTRAINT Entertainer_Styles_PK PRIMARY KEY   
	(
		EntertainerID,
		StyleID
	)  
GO

 CREATE  INDEX EntertainersEntertainerStyles ON Entertainer_Styles(EntertainerID)
GO

 CREATE  INDEX MusicalStylesEntStyles ON Entertainer_Styles(StyleID)
GO

ALTER TABLE Entertainers ADD 
	CONSTRAINT Entertainers_PK PRIMARY KEY   
	(
		EntertainerID
	)  
GO

 CREATE  UNIQUE  INDEX EntertainerID ON Entertainers(EntertainerID)
GO

 CREATE  INDEX EntZipCode ON Entertainers(EntZipCode)
GO

ALTER TABLE Members ADD 
	CONSTRAINT Member_ID_Default DEFAULT (0) FOR MemberID,
	CONSTRAINT Members_PK PRIMARY KEY   
	(
		MemberID
	)  
GO

 CREATE  INDEX MemberID ON Members(MemberID)
GO

ALTER TABLE Musical_Preferences ADD 
	CONSTRAINT MP_Customer_ID_Default DEFAULT (0) FOR CustomerID,
	CONSTRAINT MP_Style_ID_Default DEFAULT (0) FOR StyleID,
	CONSTRAINT Musical_Preferences_PK PRIMARY KEY   
	(
		CustomerID,
		StyleID
	)  
GO

 CREATE  INDEX CustomersMusicalPreferences ON Musical_Preferences(CustomerID)
GO

 CREATE  INDEX StyleID ON Musical_Preferences(StyleID)
GO

ALTER TABLE Musical_Styles ADD 
	CONSTRAINT MS_Style_ID_Default DEFAULT (0) FOR StyleID,
	CONSTRAINT Musical_Styles_PK PRIMARY KEY   
	(
		StyleID
	)  
GO

ALTER TABLE ztblDays ADD 
        CONSTRAINT ztblDays_PK PRIMARY KEY 
        ( 
                DateField 
        )
GO

ALTER TABLE ztblMonths ADD 
        CONSTRAINT January_Default DEFAULT (0) FOR January, 
        CONSTRAINT February_Default DEFAULT (0) FOR February, 
        CONSTRAINT March_Default DEFAULT (0) FOR March, 
        CONSTRAINT April_Default DEFAULT (0) FOR April, 
        CONSTRAINT May_Default DEFAULT (0) FOR May, 
        CONSTRAINT June_Default DEFAULT (0) FOR June, 
        CONSTRAINT July_Default DEFAULT (0) FOR July, 
        CONSTRAINT August_Default DEFAULT (0) FOR August, 
        CONSTRAINT September_Default DEFAULT (0) FOR september, 
        CONSTRAINT October_Default DEFAULT (0) FOR October, 
        CONSTRAINT November_Default DEFAULT (0) FOR November, 
        CONSTRAINT December_Default DEFAULT (0) FOR December, 
        CONSTRAINT ztblMonths_PK PRIMARY KEY 
        ( 
                YearNumber, 
                MonthNumber
        )
GO

 CREATE UNIQUE INDEX ztblMontths_MonthEnd ON ztblMonths(MonthEnd) 
GO

 CREATE UNIQUE INDEX ztblMonths_MonthStart ON ztblMonths(MonthStart) 
GO

 CREATE UNIQUE INDEX ztblMonths_MonthYear ON ztblMonths(MonthYear) 
GO

ALTER TABLE ztblSkipLabels ADD 
        CONSTRAINT ztblSkipLabels_PK PRIMARY KEY 
        (
                LabelCount 
        ) 
GO

ALTER TABLE ztblWeeks ADD 
        CONSTRAINT ztblWeeks_PK PRIMARY KEY 
        ( 
                WeekStart 
        ) 
GO

ALTER TABLE Engagements ADD 
	CONSTRAINT Engagements_FK00 FOREIGN KEY 
	(
		AgentID
	) REFERENCES Agents (
		AgentID
	),
	CONSTRAINT Engagements_FK01 FOREIGN KEY 
	(
		CustomerID
	) REFERENCES Customers (
		CustomerID
	),
	CONSTRAINT Engagements_FK02 FOREIGN KEY 
	(
		EntertainerID
	) REFERENCES Entertainers (
		EntertainerID
	)
GO

ALTER TABLE Entertainer_Members ADD 
	CONSTRAINT Entertainer_Members_FK00 FOREIGN KEY 
	(
		EntertainerID
	) REFERENCES Entertainers (
		EntertainerID
	),
	CONSTRAINT Entertainer_Members_FK01 FOREIGN KEY 
	(
		MemberID
	) REFERENCES Members (
		MemberID
	)
GO

ALTER TABLE Entertainer_Styles ADD 
	CONSTRAINT Entertainer_Styles_FK00 FOREIGN KEY 
	(
		EntertainerID
	) REFERENCES Entertainers (
		EntertainerID
	),
	CONSTRAINT Entertainer_Styles_FK01 FOREIGN KEY 
	(
		StyleID
	) REFERENCES Musical_Styles (
		StyleID
	)
GO

ALTER TABLE Musical_Preferences ADD 
	CONSTRAINT Musical_Preferences_FK00 FOREIGN KEY 
	(
		CustomerID
	) REFERENCES Customers (
		CustomerID
	),
	CONSTRAINT Musical_Preferences_FK01 FOREIGN KEY 
	(
		StyleID
	) REFERENCES Musical_Styles (
		StyleID
	)
GO


CREATE DATABASE EntertainmentAgencyModify
GO

use EntertainmentAgencyModify
GO

CREATE TABLE Agents (
	AgentID int IDENTITY (1, 1) NOT NULL ,
	AgtFirstName nvarchar (25) NULL ,
	AgtLastName nvarchar (25) NULL ,
	AgtStreetAddress nvarchar (50) NULL ,
	AgtCity nvarchar (30) NULL ,
	AgtState nvarchar (2) NULL ,
	AgtZipCode nvarchar (10) NULL ,
	AgtPhoneNumber nvarchar (15) NULL ,
	DateHired date NULL ,
	Salary money NULL ,
	CommissionRate float(24) NULL ,
)
GO

CREATE TABLE Customers (
	CustomerID int IDENTITY (1, 1) NOT NULL ,
	CustFirstName nvarchar (25) NULL ,
	CustLastName nvarchar (25) NULL ,
	CustStreetAddress nvarchar (50) NULL ,
	CustCity nvarchar (30) NULL ,
	CustState nvarchar (2) NULL ,
	CustZipCode nvarchar (10) NULL ,
	CustPhoneNumber nvarchar (15) NULL 
)
GO

CREATE TABLE Engagements (
	EngagementNumber int IDENTITY (1, 1) NOT NULL ,
	StartDate date NULL ,
	EndDate date NULL ,
	StartTime time NULL ,
	StopTime time NULL ,
	ContractPrice money NULL ,
	CustomerID int NULL ,
	AgentID int NULL ,
	EntertainerID int NULL 
)
GO

CREATE TABLE Engagements_Archive (
	EngagementNumber int NOT NULL ,
	StartDate date NULL ,
	EndDate date NULL ,
	StartTime time NULL ,
	StopTime time NULL ,
	ContractPrice money NULL ,
	CustomerID int NULL ,
	AgentID int NULL ,
	EntertainerID int NULL 
)
GO

CREATE TABLE Entertainer_Members (
	EntertainerID int NOT NULL ,
	MemberID int NOT NULL ,
	Status smallint NULL 
)
GO

CREATE TABLE Entertainer_Styles (
	EntertainerID int NOT NULL ,
	StyleID int NOT NULL 
)
GO

CREATE TABLE Entertainers (
	EntertainerID int IDENTITY (1, 1) NOT NULL ,
	EntStageName nvarchar (50) NULL ,
	EntSSN nvarchar (12) NULL ,
	EntStreetAddress nvarchar (50) NULL ,
	EntCity nvarchar (30) NULL ,
	EntState nvarchar (2) NULL ,
	EntZipCode nvarchar (10) NULL ,
	EntPhoneNumber nvarchar (15) NULL ,
	EntWebPage nvarchar (50) NULL ,
	EntEMailAddress nvarchar (50) NULL ,
	DateEntered date NULL ,
	EntPricePerDay money NULL 
)
GO

CREATE TABLE Members (
	MemberID int IDENTITY (1, 1) NOT NULL ,
	MbrFirstName nvarchar (25) NULL ,
	MbrLastName nvarchar (25) NULL ,
	MbrPhoneNumber nvarchar (15) NULL ,
	Gender nvarchar (2) NULL 
)
GO

CREATE TABLE Musical_Preferences (
	CustomerID int NOT NULL ,
	StyleID int NOT NULL 
)
GO

CREATE TABLE Musical_Styles (
	StyleID int IDENTITY (1, 1) NOT NULL ,
	StyleName nvarchar (75) NULL 
)
GO

 ALTER TABLE Agents ADD 
	CONSTRAINT Salary_Default DEFAULT (0) FOR Salary,
	CONSTRAINT Commision_Rate_Default DEFAULT (0) FOR CommissionRate,
	CONSTRAINT Agents_PK PRIMARY KEY   
	(
		AgentID
	)  
GO

 CREATE  INDEX AgtZipCode ON Agents(AgtZipCode)
GO

ALTER TABLE Customers ADD 
	CONSTRAINT Customers_PK PRIMARY KEY   
	(
		CustomerID
	)  
GO

 CREATE  INDEX CustZipCode ON Customers(CustZipCode)
GO

ALTER TABLE Engagements ADD 
	CONSTRAINT Contract_Price_Default DEFAULT (0) FOR ContractPrice,
	CONSTRAINT EN_Customer_ID_Default DEFAULT (0) FOR CustomerID,
	CONSTRAINT EN_Agent_ID_Default DEFAULT (0) FOR AgentID,
	CONSTRAINT EN_Entertainer_ID_Default DEFAULT (0) FOR EntertainerID,
	CONSTRAINT Engagements_PK PRIMARY KEY   
	(
		EngagementNumber
	)  
GO

 CREATE  INDEX AgentsEngagements ON Engagements(AgentID)
GO

 CREATE  INDEX CustomerID ON Engagements(CustomerID)
GO

 CREATE  INDEX EmployeeID ON Engagements(AgentID)
GO

 CREATE  INDEX EntertainerID ON Engagements(EntertainerID)
GO

ALTER TABLE Engagements_Archive ADD
        CONSTRAINT Engagements_Archive_PK PRIMARY KEY 
        (
                EngagementNumber
        )
GO

CREATE  INDEX CustomerID ON Engagements_Archive(CustomerID)
GO

CREATE  INDEX EmployeeID ON Engagements_Archive(AgentID)
GO

CREATE  INDEX EntertainerID ON Engagements_Archive(EntertainerID)
GO

ALTER TABLE Entertainer_Members ADD 
	CONSTRAINT EM_Member_ID_Default DEFAULT (0) FOR MemberID,
	CONSTRAINT EM_Status_Default DEFAULT (0) FOR Status,
	CONSTRAINT Entertainer_Members_PK PRIMARY KEY   
	(
		EntertainerID,
		MemberID
	)  
GO

 CREATE  INDEX EntertainersEntertainerMembers ON Entertainer_Members(EntertainerID)
GO

 CREATE  INDEX MembersEntertainerMembers ON Entertainer_Members(MemberID)
GO

ALTER TABLE Entertainer_Styles ADD 
	CONSTRAINT ES_Style_ID_Default DEFAULT (0) FOR StyleID,
	CONSTRAINT Entertainer_Styles_PK PRIMARY KEY   
	(
		EntertainerID,
		StyleID
	)  
GO

 CREATE  INDEX EntertainersEntertainerStyles ON Entertainer_Styles(EntertainerID)
GO

 CREATE  INDEX MusicalStylesEntStyles ON Entertainer_Styles(StyleID)
GO

ALTER TABLE Entertainers ADD 
	CONSTRAINT Entertainers_PK PRIMARY KEY   
	(
		EntertainerID
	)  
GO

 CREATE  INDEX EntZipCode ON Entertainers(EntZipCode)
GO

ALTER TABLE Members ADD 
	CONSTRAINT Members_PK PRIMARY KEY   
	(
		MemberID
	)  
GO

ALTER TABLE Musical_Preferences ADD 
	CONSTRAINT MP_Customer_ID_Default DEFAULT (0) FOR CustomerID,
	CONSTRAINT MP_Style_ID_Default DEFAULT (0) FOR StyleID,
	CONSTRAINT Musical_Preferences_PK PRIMARY KEY   
	(
		CustomerID,
		StyleID
	)  
GO

 CREATE  INDEX CustomerID ON Musical_Preferences(CustomerID)
GO

 CREATE  INDEX StyleID ON Musical_Preferences(StyleID)
GO

ALTER TABLE Musical_Styles ADD 
	CONSTRAINT Musical_Styles_PK PRIMARY KEY   
	(
		StyleID
	)  
GO

ALTER TABLE Engagements ADD 
	CONSTRAINT Engagements_FK00 FOREIGN KEY 
	(
		AgentID
	) REFERENCES Agents (
		AgentID
	),
	CONSTRAINT Engagements_FK01 FOREIGN KEY 
	(
		CustomerID
	) REFERENCES Customers (
		CustomerID
	),
	CONSTRAINT Engagements_FK02 FOREIGN KEY 
	(
		EntertainerID
	) REFERENCES Entertainers (
		EntertainerID
	)
GO

ALTER TABLE Entertainer_Members ADD 
	CONSTRAINT Entertainer_Members_FK00 FOREIGN KEY 
	(
		EntertainerID
	) REFERENCES Entertainers (
		EntertainerID
	),
	CONSTRAINT Entertainer_Members_FK01 FOREIGN KEY 
	(
		MemberID
	) REFERENCES Members (
		MemberID
	)
GO

ALTER TABLE Entertainer_Styles ADD 
	CONSTRAINT Entertainer_Styles_FK00 FOREIGN KEY 
	(
		EntertainerID
	) REFERENCES Entertainers (
		EntertainerID
	) ON DELETE CASCADE,
	CONSTRAINT Entertainer_Styles_FK01 FOREIGN KEY 
	(
		StyleID
	) REFERENCES Musical_Styles (
		StyleID
	)
GO

ALTER TABLE Musical_Preferences ADD 
	CONSTRAINT Musical_Preferences_FK00 FOREIGN KEY 
	(
		CustomerID
	) REFERENCES Customers (
		CustomerID
	) ON DELETE CASCADE,
	CONSTRAINT Musical_Preferences_FK01 FOREIGN KEY 
	(
		StyleID
	) REFERENCES Musical_Styles (
		StyleID
	)
GO


USE EntertainmentAgencyExample;
INSERT INTO Customers
  (CustomerID, CustFirstName, CustLastName, CustStreetAddress, 
   CustCity, CustState, CustZipCode, CustPhoneNumber)
  VALUES (10001, 'Doris', 'Hartwig', '4726 - 11th Ave. N.E.', 
   'Seattle', 'WA', '98105', '555-2671');
INSERT INTO Customers
  (CustomerID, CustFirstName, CustLastName, CustStreetAddress, 
   CustCity, CustState, CustZipCode, CustPhoneNumber)
  VALUES (10002, 'Deb', 'Waldal', '908 W. Capital Way', 
   'Tacoma', 'WA', '98413', '555-2496');
INSERT INTO Customers
  (CustomerID, CustFirstName, CustLastName, CustStreetAddress, 
   CustCity, CustState, CustZipCode, CustPhoneNumber)
  VALUES (10003, 'Peter', 'Brehm', '722 Moss Bay Blvd.', 
   'Kirkland', 'WA', '98033', '555-2501');
INSERT INTO Customers
  (CustomerID, CustFirstName, CustLastName, CustStreetAddress, 
   CustCity, CustState, CustZipCode, CustPhoneNumber)
  VALUES (10004, 'Dean', 'McCrae', '4110 Old Redmond Rd.', 
   'Redmond', 'WA', '98052', '555-2506');
INSERT INTO Customers
  (CustomerID, CustFirstName, CustLastName, CustStreetAddress, 
   CustCity, CustState, CustZipCode, CustPhoneNumber)
  VALUES (10005, 'Elizabeth', 'Hallmark', 'Route 2, Box 203B', 
   'Auburn', 'WA', '98002', '555-2521');
INSERT INTO Customers
  (CustomerID, CustFirstName, CustLastName, CustStreetAddress, 
   CustCity, CustState, CustZipCode, CustPhoneNumber)
  VALUES (10006, 'Matt', 'Berg', '908 W. Capital Way', 
   'Tacoma', 'WA', '98413', '555-2581');
INSERT INTO Customers
  (CustomerID, CustFirstName, CustLastName, CustStreetAddress, 
   CustCity, CustState, CustZipCode, CustPhoneNumber)
  VALUES (10007, 'Liz', 'Keyser', '13920 S.E. 40th Street', 
   'Bellevue', 'WA', '98006', '555-2556');
INSERT INTO Customers
  (CustomerID, CustFirstName, CustLastName, CustStreetAddress, 
   CustCity, CustState, CustZipCode, CustPhoneNumber)
  VALUES (10008, 'Darren', 'Gehring', '2601 Seaview Lane', 
   'Kirkland', 'WA', '98033', '555-2616');
INSERT INTO Customers
  (CustomerID, CustFirstName, CustLastName, CustStreetAddress, 
   CustCity, CustState, CustZipCode, CustPhoneNumber)
  VALUES (10009, 'Sarah', 'Thompson', '2222 Springer Road', 
   'Bellevue', 'WA', '98006', '555-2626');
INSERT INTO Customers
  (CustomerID, CustFirstName, CustLastName, CustStreetAddress, 
   CustCity, CustState, CustZipCode, CustPhoneNumber)
  VALUES (10010, 'Zachary', 'Ehrlich', '12330 Kingman Drive', 
   'Kirkland', 'WA', '98033', '555-2721');
INSERT INTO Customers
  (CustomerID, CustFirstName, CustLastName, CustStreetAddress, 
   CustCity, CustState, CustZipCode, CustPhoneNumber)
  VALUES (10011, 'Joyce', 'Bonnicksen', '2424 Thames Drive', 
   'Bellevue', 'WA', '98006', '555-2726');
INSERT INTO Customers
  (CustomerID, CustFirstName, CustLastName, CustStreetAddress, 
   CustCity, CustState, CustZipCode, CustPhoneNumber)
  VALUES (10012, 'Kerry', 'Patterson', '777 Fenexet Blvd', 
   'Redmond', 'WA', '98052', '555-0399');
INSERT INTO Customers
  (CustomerID, CustFirstName, CustLastName, CustStreetAddress, 
   CustCity, CustState, CustZipCode, CustPhoneNumber)
  VALUES (10013, 'Estella', 'Pundt', '2500 Rosales Lane', 
   'Bellevue', 'WA', '98006', '555-9938');
INSERT INTO Customers
  (CustomerID, CustFirstName, CustLastName, CustStreetAddress, 
   CustCity, CustState, CustZipCode, CustPhoneNumber)
  VALUES (10014, 'Mark', 'Rosales', '323 Advocate Lane', 
   'Bellevue', 'WA', '98006', '555-2286');
INSERT INTO Customers
  (CustomerID, CustFirstName, CustLastName, CustStreetAddress, 
   CustCity, CustState, CustZipCode, CustPhoneNumber)
  VALUES (10015, 'Carol', 'Viescas', '754 Fourth Ave', 
   'Seattle', 'WA', '98115', '555-2296');
 
INSERT INTO Entertainers
  (EntertainerID, EntStageName, EntSSN, EntStreetAddress, 
   EntCity, EntState, EntZipCode, EntPhoneNumber, EntWebPage, 
   EntEMailAddress, DateEntered)
  VALUES (1001, 'Carol Peacock Trio', '888-90-1121', 
   '4110 Old Redmond Rd.', 'Redmond', 'WA', '98052', 
   '555-2691', 'www.cptrio.com', 'carolp@cptrio.com', 
   '1997-05-24');
INSERT INTO Entertainers
  (EntertainerID, EntStageName, EntSSN, EntStreetAddress, 
   EntCity, EntState, EntZipCode, EntPhoneNumber, EntWebPage, 
   EntEMailAddress, DateEntered)
  VALUES (1002, 'Topazz', '888-50-1061', '16 Maple Lane', 
   'Auburn', 'WA', '98002', '555-2591', 'www.topazz.com', 
   NULL, '1996-02-14');
INSERT INTO Entertainers
  (EntertainerID, EntStageName, EntSSN, EntStreetAddress, 
   EntCity, EntState, EntZipCode, EntPhoneNumber, EntWebPage, 
   EntEMailAddress, DateEntered)
  VALUES (1003, 'JV & the Deep Six', '888-18-1013', 
   '15127 NE 24th, #383', 'Redmond', 'WA', '98052', 
   '555-2511', 'www.jvd6.com', 'jv@myspring.com', '1998-03-18');
INSERT INTO Entertainers
  (EntertainerID, EntStageName, EntSSN, EntStreetAddress, 
   EntCity, EntState, EntZipCode, EntPhoneNumber, EntWebPage, 
   EntEMailAddress, DateEntered)
  VALUES (1004, 'Jim Glynn', '888-26-1025', '13920 S.E. 40th Street', 
   'Bellevue', 'WA', '98009', '555-2531', NULL, NULL, 
   '1996-04-01');
INSERT INTO Entertainers
  (EntertainerID, EntStageName, EntSSN, EntStreetAddress, 
   EntCity, EntState, EntZipCode, EntPhoneNumber, EntWebPage, 
   EntEMailAddress, DateEntered)
  VALUES (1005, 'Jazz Persuasion', '888-30-1031', '233 West Valley Hwy', 
   'Bellevue', 'WA', '98005', '555-2541', 'www.jazzper.com', 
   NULL, '1997-05-12');
INSERT INTO Entertainers
  (EntertainerID, EntStageName, EntSSN, EntStreetAddress, 
   EntCity, EntState, EntZipCode, EntPhoneNumber, EntWebPage, 
   EntEMailAddress, DateEntered)
  VALUES (1006, 'Modern Dance', '888-66-1085', 'Route 2, Box 203B', 
   'Woodinville', 'WA', '98072', '555-2631', 'www.moderndance.com', 
   'mikeh@moderndance.com', '1995-05-16');
INSERT INTO Entertainers
  (EntertainerID, EntStageName, EntSSN, EntStreetAddress, 
   EntCity, EntState, EntZipCode, EntPhoneNumber, EntWebPage, 
   EntEMailAddress, DateEntered)
  VALUES (1007, 'Coldwater Cattle Company', '888-38-1043', 
   '4726 - 11th Ave. N.E.', 'Seattle', 'WA', '98105', 
   '555-2561', 'www.coldwatercows.com', NULL, '1995-11-30');
INSERT INTO Entertainers
  (EntertainerID, EntStageName, EntSSN, EntStreetAddress, 
   EntCity, EntState, EntZipCode, EntPhoneNumber, EntWebPage, 
   EntEMailAddress, DateEntered)
  VALUES (1008, 'Country Feeling', '888-98-1133', 'PO Box 223311', 
   'Seattle', 'WA', '98125', '555-2711', NULL, NULL, 
   '1996-02-28');
INSERT INTO Entertainers
  (EntertainerID, EntStageName, EntSSN, EntStreetAddress, 
   EntCity, EntState, EntZipCode, EntPhoneNumber, EntWebPage, 
   EntEMailAddress, DateEntered)
  VALUES (1009, 'Katherine Ehrlich', '888-61-1103', 
   '777 Fenexet Blvd', 'Woodinville', 'WA', '98072', 
   '555-0399', NULL, 'ke@mzo.com', '1998-09-13');
INSERT INTO Entertainers
  (EntertainerID, EntStageName, EntSSN, EntStreetAddress, 
   EntCity, EntState, EntZipCode, EntPhoneNumber, EntWebPage, 
   EntEMailAddress, DateEntered)
  VALUES (1010, 'Saturday Revue', '888-64-1109', '3887 Easy Street', 
   'Seattle', 'WA', '98125', '555-0039', 'www.satrevue.com', 
   'edz@coolness.com', '1995-01-20');
INSERT INTO Entertainers
  (EntertainerID, EntStageName, EntSSN, EntStreetAddress, 
   EntCity, EntState, EntZipCode, EntPhoneNumber, EntWebPage, 
   EntEMailAddress, DateEntered)
  VALUES (1011, 'Julia Schnebly', '888-65-1111', '2343 Harmony Lane', 
   'Seattle', 'WA', '99837', '555-9936', NULL, NULL, 
   '1996-04-12');
INSERT INTO Entertainers
  (EntertainerID, EntStageName, EntSSN, EntStreetAddress, 
   EntCity, EntState, EntZipCode, EntPhoneNumber, EntWebPage, 
   EntEMailAddress, DateEntered)
  VALUES (1012, 'Susan McLain', '888-70-1121', '511 Lenora Ave', 
   'Bellevue', 'WA', '98006', '555-2301', 'www.greensleeves.com', 
   'susan@gs.com', '1998-10-12');
INSERT INTO Entertainers
  (EntertainerID, EntStageName, EntSSN, EntStreetAddress, 
   EntCity, EntState, EntZipCode, EntPhoneNumber, EntWebPage, 
   EntEMailAddress, DateEntered)
  VALUES (1013, 'Caroline Coie Cuartet', '888-71-1123', 
   '298 Forest Lane', 'Auburn', 'WA', '98002', '555-2306', 
   NULL, 'carolinec@willow.com', '1997-07-11');
 
INSERT INTO Agents
  (AgentID, AgtFirstName, AgtLastName, AgtStreetAddress, 
   AgtCity, AgtState, AgtZipCode, AgtPhoneNumber, DateHired, 
   Salary, CommissionRate)
  VALUES (1, 'William', 'Thompson', '122 Spring River Drive', 
   'Redmond', 'WA', '98053', '555-2681', '1997-05-15', 
   35000, 0.04);
INSERT INTO Agents
  (AgentID, AgtFirstName, AgtLastName, AgtStreetAddress, 
   AgtCity, AgtState, AgtZipCode, AgtPhoneNumber, DateHired, 
   Salary, CommissionRate)
  VALUES (2, 'Scott', 'Bishop', '66 Spring Valley Drive', 
   'Seattle', 'WA', '98125', '555-2666', '1998-02-05', 
   27000, 0.04);
INSERT INTO Agents
  (AgentID, AgtFirstName, AgtLastName, AgtStreetAddress, 
   AgtCity, AgtState, AgtZipCode, AgtPhoneNumber, DateHired, 
   Salary, CommissionRate)
  VALUES (3, 'Carol', 'Viescas', '667 Red River Road', 
   'Bellevue', 'WA', '98006', '555-2571', '1997-11-19', 
   30000, 0.05);
INSERT INTO Agents
  (AgentID, AgtFirstName, AgtLastName, AgtStreetAddress, 
   AgtCity, AgtState, AgtZipCode, AgtPhoneNumber, DateHired, 
   Salary, CommissionRate)
  VALUES (4, 'Karen', 'Smith', '30301 - 166th Ave. N.E.', 
   'Seattle', 'WA', '98125', '555-2551', '1998-03-05', 
   22000, 0.055);
INSERT INTO Agents
  (AgentID, AgtFirstName, AgtLastName, AgtStreetAddress, 
   AgtCity, AgtState, AgtZipCode, AgtPhoneNumber, DateHired, 
   Salary, CommissionRate)
  VALUES (5, 'Marianne', 'Wier', '908 W. Capital Way', 
   'Tacoma', 'WA', '98413', '555-2606', '1998-02-02', 
   24500, 0.045);
INSERT INTO Agents
  (AgentID, AgtFirstName, AgtLastName, AgtStreetAddress, 
   AgtCity, AgtState, AgtZipCode, AgtPhoneNumber, DateHired, 
   Salary, CommissionRate)
  VALUES (6, 'John', 'Kennedy', '16679 NE 41st Court', 
   'Seattle', 'WA', '98125', '555-2621', '1997-05-15', 
   33000, 0.06);
INSERT INTO Agents
  (AgentID, AgtFirstName, AgtLastName, AgtStreetAddress, 
   AgtCity, AgtState, AgtZipCode, AgtPhoneNumber, DateHired, 
   Salary, CommissionRate)
  VALUES (7, 'Caleb', 'Viescas', '4501 Wetland Road', 
   'Redmond', 'WA', '98052', '555-0037', '1998-02-16', 
   22100, 0.035);
INSERT INTO Agents
  (AgentID, AgtFirstName, AgtLastName, AgtStreetAddress, 
   AgtCity, AgtState, AgtZipCode, AgtPhoneNumber, DateHired, 
   Salary, CommissionRate)
  VALUES (8, 'Maria', 'Patterson', '3445 Cheyenne Road', 
   'Bellevue', 'WA', '98006', '555-2291', '1997-09-03', 
   30000, 0.04);
INSERT INTO Agents
  (AgentID, AgtFirstName, AgtLastName, AgtStreetAddress, 
   AgtCity, AgtState, AgtZipCode, AgtPhoneNumber, DateHired, 
   Salary, CommissionRate)
  VALUES (9, 'Daffy', 'Dumbwit', '1234 Main Street', 
   'Kirkland', 'WA', '98033', '555-1234', '2000-02-05', 
   50, 0.01);
 
INSERT INTO Engagements
  (EngagementNumber, StartDate, EndDate, StartTime, 
   StopTime, ContractPrice, CustomerID, AgentID, EntertainerID)
  VALUES (2, '2012-09-01', '2012-09-05', '13:00:00', 
   '15:00:00', 200, 10006, 4, 1004);
INSERT INTO Engagements
  (EngagementNumber, StartDate, EndDate, StartTime, 
   StopTime, ContractPrice, CustomerID, AgentID, EntertainerID)
  VALUES (3, '2012-09-10', '2012-09-15', '13:00:00', 
   '15:00:00', 590, 10001, 3, 1005);
INSERT INTO Engagements
  (EngagementNumber, StartDate, EndDate, StartTime, 
   StopTime, ContractPrice, CustomerID, AgentID, EntertainerID)
  VALUES (4, '2012-09-11', '2012-09-17', '20:00:00', 
   '00:00:00', 470, 10007, 3, 1004);
INSERT INTO Engagements
  (EngagementNumber, StartDate, EndDate, StartTime, 
   StopTime, ContractPrice, CustomerID, AgentID, EntertainerID)
  VALUES (5, '2012-09-11', '2012-09-14', '16:00:00', 
   '19:00:00', 1130, 10006, 5, 1003);
INSERT INTO Engagements
  (EngagementNumber, StartDate, EndDate, StartTime, 
   StopTime, ContractPrice, CustomerID, AgentID, EntertainerID)
  VALUES (6, '2012-09-10', '2012-09-14', '15:00:00', 
   '21:00:00', 2300, 10014, 7, 1008);
INSERT INTO Engagements
  (EngagementNumber, StartDate, EndDate, StartTime, 
   StopTime, ContractPrice, CustomerID, AgentID, EntertainerID)
  VALUES (7, '2012-09-11', '2012-09-18', '17:00:00', 
   '20:00:00', 770, 10004, 4, 1002);
INSERT INTO Engagements
  (EngagementNumber, StartDate, EndDate, StartTime, 
   StopTime, ContractPrice, CustomerID, AgentID, EntertainerID)
  VALUES (8, '2012-09-18', '2012-09-25', '20:00:00', 
   '23:00:00', 1850, 10006, 3, 1007);
INSERT INTO Engagements
  (EngagementNumber, StartDate, EndDate, StartTime, 
   StopTime, ContractPrice, CustomerID, AgentID, EntertainerID)
  VALUES (9, '2012-09-18', '2012-09-28', '19:00:00', 
   '21:00:00', 1370, 10010, 2, 1010);
INSERT INTO Engagements
  (EngagementNumber, StartDate, EndDate, StartTime, 
   StopTime, ContractPrice, CustomerID, AgentID, EntertainerID)
  VALUES (10, '2012-09-17', '2012-09-26', '13:00:00', 
   '17:00:00', 3650, 10005, 3, 1003);
INSERT INTO Engagements
  (EngagementNumber, StartDate, EndDate, StartTime, 
   StopTime, ContractPrice, CustomerID, AgentID, EntertainerID)
  VALUES (11, '2012-09-15', '2012-09-16', '18:00:00', 
   '00:00:00', 950, 10005, 4, 1008);
INSERT INTO Engagements
  (EngagementNumber, StartDate, EndDate, StartTime, 
   StopTime, ContractPrice, CustomerID, AgentID, EntertainerID)
  VALUES (12, '2012-09-18', '2012-09-26', '18:00:00', 
   '22:00:00', 1670, 10014, 8, 1001);
INSERT INTO Engagements
  (EngagementNumber, StartDate, EndDate, StartTime, 
   StopTime, ContractPrice, CustomerID, AgentID, EntertainerID)
  VALUES (13, '2012-09-17', '2012-09-20', '20:00:00', 
   '23:00:00', 770, 10003, 1, 1006);
INSERT INTO Engagements
  (EngagementNumber, StartDate, EndDate, StartTime, 
   StopTime, ContractPrice, CustomerID, AgentID, EntertainerID)
  VALUES (14, '2012-09-24', '2012-09-29', '16:00:00', 
   '22:00:00', 2750, 10001, 1, 1008);
INSERT INTO Engagements
  (EngagementNumber, StartDate, EndDate, StartTime, 
   StopTime, ContractPrice, CustomerID, AgentID, EntertainerID)
  VALUES (15, '2012-09-24', '2012-09-29', '17:00:00', 
   '19:00:00', 770, 10007, 1, 1013);
INSERT INTO Engagements
  (EngagementNumber, StartDate, EndDate, StartTime, 
   StopTime, ContractPrice, CustomerID, AgentID, EntertainerID)
  VALUES (16, '2012-10-02', '2012-10-06', '20:00:00', 
   '01:00:00', 1550, 10010, 5, 1013);
INSERT INTO Engagements
  (EngagementNumber, StartDate, EndDate, StartTime, 
   StopTime, ContractPrice, CustomerID, AgentID, EntertainerID)
  VALUES (17, '2012-09-29', '2012-10-02', '18:00:00', 
   '20:00:00', 530, 10002, 8, 1010);
INSERT INTO Engagements
  (EngagementNumber, StartDate, EndDate, StartTime, 
   StopTime, ContractPrice, CustomerID, AgentID, EntertainerID)
  VALUES (19, '2012-09-29', '2012-10-05', '20:00:00', 
   '23:00:00', 365, 10009, 8, 1004);
INSERT INTO Engagements
  (EngagementNumber, StartDate, EndDate, StartTime, 
   StopTime, ContractPrice, CustomerID, AgentID, EntertainerID)
  VALUES (21, '2012-09-30', '2012-10-03', '12:00:00', 
   '16:00:00', 1490, 10005, 1, 1003);
INSERT INTO Engagements
  (EngagementNumber, StartDate, EndDate, StartTime, 
   StopTime, ContractPrice, CustomerID, AgentID, EntertainerID)
  VALUES (22, '2012-09-30', '2012-10-05', '12:00:00', 
   '15:00:00', 590, 10004, 5, 1002);
INSERT INTO Engagements
  (EngagementNumber, StartDate, EndDate, StartTime, 
   StopTime, ContractPrice, CustomerID, AgentID, EntertainerID)
  VALUES (23, '2012-09-30', '2012-09-30', '20:00:00', 
   '00:00:00', 290, 10012, 4, 1013);
INSERT INTO Engagements
  (EngagementNumber, StartDate, EndDate, StartTime, 
   StopTime, ContractPrice, CustomerID, AgentID, EntertainerID)
  VALUES (24, '2012-10-01', '2012-10-07', '12:00:00', 
   '18:00:00', 1940, 10001, 4, 1001);
INSERT INTO Engagements
  (EngagementNumber, StartDate, EndDate, StartTime, 
   StopTime, ContractPrice, CustomerID, AgentID, EntertainerID)
  VALUES (26, '2012-10-09', '2012-10-14', '17:00:00', 
   '22:00:00', 950, 10001, 6, 1002);
INSERT INTO Engagements
  (EngagementNumber, StartDate, EndDate, StartTime, 
   StopTime, ContractPrice, CustomerID, AgentID, EntertainerID)
  VALUES (27, '2012-10-07', '2012-10-12', '12:00:00', 
   '16:00:00', 2210, 10015, 7, 1003);
INSERT INTO Engagements
  (EngagementNumber, StartDate, EndDate, StartTime, 
   StopTime, ContractPrice, CustomerID, AgentID, EntertainerID)
  VALUES (28, '2012-10-06', '2012-10-15', '17:00:00', 
   '22:00:00', 3800, 10003, 4, 1007);
INSERT INTO Engagements
  (EngagementNumber, StartDate, EndDate, StartTime, 
   StopTime, ContractPrice, CustomerID, AgentID, EntertainerID)
  VALUES (30, '2012-10-06', '2012-10-08', '17:00:00', 
   '22:00:00', 275, 10009, 5, 1011);
INSERT INTO Engagements
  (EngagementNumber, StartDate, EndDate, StartTime, 
   StopTime, ContractPrice, CustomerID, AgentID, EntertainerID)
  VALUES (31, '2012-10-07', '2012-10-16', '16:00:00', 
   '20:00:00', 2450, 10002, 8, 1010);
INSERT INTO Engagements
  (EngagementNumber, StartDate, EndDate, StartTime, 
   StopTime, ContractPrice, CustomerID, AgentID, EntertainerID)
  VALUES (32, '2012-10-07', '2012-10-16', '13:00:00', 
   '15:00:00', 1250, 10010, 7, 1013);
INSERT INTO Engagements
  (EngagementNumber, StartDate, EndDate, StartTime, 
   StopTime, ContractPrice, CustomerID, AgentID, EntertainerID)
  VALUES (34, '2012-10-14', '2012-10-20', '16:00:00', 
   '18:00:00', 680, 10004, 8, 1005);
INSERT INTO Engagements
  (EngagementNumber, StartDate, EndDate, StartTime, 
   StopTime, ContractPrice, CustomerID, AgentID, EntertainerID)
  VALUES (35, '2012-10-14', '2012-10-15', '19:00:00', 
   '23:00:00', 410, 10005, 8, 1001);
INSERT INTO Engagements
  (EngagementNumber, StartDate, EndDate, StartTime, 
   StopTime, ContractPrice, CustomerID, AgentID, EntertainerID)
  VALUES (36, '2012-10-13', '2012-10-23', '18:00:00', 
   '22:00:00', 710, 10014, 3, 1011);
INSERT INTO Engagements
  (EngagementNumber, StartDate, EndDate, StartTime, 
   StopTime, ContractPrice, CustomerID, AgentID, EntertainerID)
  VALUES (37, '2012-10-13', '2012-10-19', '14:00:00', 
   '19:00:00', 2675, 10006, 3, 1008);
INSERT INTO Engagements
  (EngagementNumber, StartDate, EndDate, StartTime, 
   StopTime, ContractPrice, CustomerID, AgentID, EntertainerID)
  VALUES (38, '2012-10-14', '2012-10-18', '14:00:00', 
   '20:00:00', 1850, 10013, 4, 1006);
INSERT INTO Engagements
  (EngagementNumber, StartDate, EndDate, StartTime, 
   StopTime, ContractPrice, CustomerID, AgentID, EntertainerID)
  VALUES (41, '2012-10-20', '2012-10-28', '18:00:00', 
   '21:00:00', 860, 10013, 3, 1002);
INSERT INTO Engagements
  (EngagementNumber, StartDate, EndDate, StartTime, 
   StopTime, ContractPrice, CustomerID, AgentID, EntertainerID)
  VALUES (42, '2012-10-20', '2012-10-26', '17:00:00', 
   '22:00:00', 2150, 10002, 1, 1013);
INSERT INTO Engagements
  (EngagementNumber, StartDate, EndDate, StartTime, 
   StopTime, ContractPrice, CustomerID, AgentID, EntertainerID)
  VALUES (43, '2012-10-21', '2012-10-21', '14:00:00', 
   '16:00:00', 140, 10001, 8, 1001);
INSERT INTO Engagements
  (EngagementNumber, StartDate, EndDate, StartTime, 
   StopTime, ContractPrice, CustomerID, AgentID, EntertainerID)
  VALUES (44, '2012-10-22', '2012-10-26', '14:00:00', 
   '19:00:00', 1925, 10006, 3, 1008);
INSERT INTO Engagements
  (EngagementNumber, StartDate, EndDate, StartTime, 
   StopTime, ContractPrice, CustomerID, AgentID, EntertainerID)
  VALUES (45, '2012-10-21', '2012-10-28', '14:00:00', 
   '18:00:00', 530, 10015, 1, 1012);
INSERT INTO Engagements
  (EngagementNumber, StartDate, EndDate, StartTime, 
   StopTime, ContractPrice, CustomerID, AgentID, EntertainerID)
  VALUES (46, '2012-10-28', '2012-11-05', '15:00:00', 
   '17:00:00', 1400, 10009, 4, 1008);
INSERT INTO Engagements
  (EngagementNumber, StartDate, EndDate, StartTime, 
   StopTime, ContractPrice, CustomerID, AgentID, EntertainerID)
  VALUES (48, '2012-11-05', '2012-11-06', '16:00:00', 
   '22:00:00', 950, 10002, 1, 1007);
INSERT INTO Engagements
  (EngagementNumber, StartDate, EndDate, StartTime, 
   StopTime, ContractPrice, CustomerID, AgentID, EntertainerID)
  VALUES (49, '2012-11-13', '2012-11-19', '12:00:00', 
   '14:00:00', 680, 10014, 5, 1001);
INSERT INTO Engagements
  (EngagementNumber, StartDate, EndDate, StartTime, 
   StopTime, ContractPrice, CustomerID, AgentID, EntertainerID)
  VALUES (51, '2012-11-13', '2012-11-14', '20:00:00', 
   '01:00:00', 650, 10013, 3, 1013);
INSERT INTO Engagements
  (EngagementNumber, StartDate, EndDate, StartTime, 
   StopTime, ContractPrice, CustomerID, AgentID, EntertainerID)
  VALUES (52, '2012-11-13', '2012-11-14', '16:00:00', 
   '21:00:00', 650, 10010, 3, 1006);
INSERT INTO Engagements
  (EngagementNumber, StartDate, EndDate, StartTime, 
   StopTime, ContractPrice, CustomerID, AgentID, EntertainerID)
  VALUES (53, '2012-11-11', '2012-11-12', '17:00:00', 
   '19:00:00', 350, 10002, 5, 1007);
INSERT INTO Engagements
  (EngagementNumber, StartDate, EndDate, StartTime, 
   StopTime, ContractPrice, CustomerID, AgentID, EntertainerID)
  VALUES (55, '2012-11-19', '2012-11-26', '20:00:00', 
   '02:00:00', 770, 10002, 3, 1011);
INSERT INTO Engagements
  (EngagementNumber, StartDate, EndDate, StartTime, 
   StopTime, ContractPrice, CustomerID, AgentID, EntertainerID)
  VALUES (56, '2012-11-25', '2012-11-28', '14:00:00', 
   '19:00:00', 1550, 10010, 3, 1007);
INSERT INTO Engagements
  (EngagementNumber, StartDate, EndDate, StartTime, 
   StopTime, ContractPrice, CustomerID, AgentID, EntertainerID)
  VALUES (58, '2012-12-01', '2012-12-04', '17:00:00', 
   '23:00:00', 770, 10001, 2, 1002);
INSERT INTO Engagements
  (EngagementNumber, StartDate, EndDate, StartTime, 
   StopTime, ContractPrice, CustomerID, AgentID, EntertainerID)
  VALUES (59, '2012-12-01', '2012-12-04', '15:00:00', 
   '19:00:00', 290, 10004, 6, 1012);
INSERT INTO Engagements
  (EngagementNumber, StartDate, EndDate, StartTime, 
   StopTime, ContractPrice, CustomerID, AgentID, EntertainerID)
  VALUES (60, '2012-12-02', '2012-12-04', '13:00:00', 
   '17:00:00', 230, 10010, 8, 1004);
INSERT INTO Engagements
  (EngagementNumber, StartDate, EndDate, StartTime, 
   StopTime, ContractPrice, CustomerID, AgentID, EntertainerID)
  VALUES (61, '2012-12-03', '2012-12-10', '17:00:00', 
   '20:00:00', 410, 10015, 8, 1011);
INSERT INTO Engagements
  (EngagementNumber, StartDate, EndDate, StartTime, 
   StopTime, ContractPrice, CustomerID, AgentID, EntertainerID)
  VALUES (62, '2012-12-09', '2012-12-10', '20:00:00', 
   '01:00:00', 500, 10003, 2, 1005);
INSERT INTO Engagements
  (EngagementNumber, StartDate, EndDate, StartTime, 
   StopTime, ContractPrice, CustomerID, AgentID, EntertainerID)
  VALUES (63, '2012-12-18', '2012-12-21', '14:00:00', 
   '16:00:00', 650, 10009, 3, 1008);
INSERT INTO Engagements
  (EngagementNumber, StartDate, EndDate, StartTime, 
   StopTime, ContractPrice, CustomerID, AgentID, EntertainerID)
  VALUES (64, '2012-12-25', '2013-01-03', '14:00:00', 
   '16:00:00', 1250, 10007, 3, 1013);
INSERT INTO Engagements
  (EngagementNumber, StartDate, EndDate, StartTime, 
   StopTime, ContractPrice, CustomerID, AgentID, EntertainerID)
  VALUES (66, '2012-12-22', '2012-12-29', '20:00:00', 
   '02:00:00', 2930, 10005, 5, 1006);
INSERT INTO Engagements
  (EngagementNumber, StartDate, EndDate, StartTime, 
   StopTime, ContractPrice, CustomerID, AgentID, EntertainerID)
  VALUES (68, '2012-12-24', '2012-12-29', '16:00:00', 
   '22:00:00', 1670, 10009, 1, 1005);
INSERT INTO Engagements
  (EngagementNumber, StartDate, EndDate, StartTime, 
   StopTime, ContractPrice, CustomerID, AgentID, EntertainerID)
  VALUES (69, '2012-12-22', '2012-12-23', '15:00:00', 
   '18:00:00', 500, 10004, 7, 1008);
INSERT INTO Engagements
  (EngagementNumber, StartDate, EndDate, StartTime, 
   StopTime, ContractPrice, CustomerID, AgentID, EntertainerID)
  VALUES (70, '2012-12-23', '2012-12-26', '13:00:00', 
   '15:00:00', 410, 10010, 6, 1001);
INSERT INTO Engagements
  (EngagementNumber, StartDate, EndDate, StartTime, 
   StopTime, ContractPrice, CustomerID, AgentID, EntertainerID)
  VALUES (71, '2012-12-22', '2012-12-27', '14:00:00', 
   '17:00:00', 1670, 10002, 1, 1003);
INSERT INTO Engagements
  (EngagementNumber, StartDate, EndDate, StartTime, 
   StopTime, ContractPrice, CustomerID, AgentID, EntertainerID)
  VALUES (72, '2012-12-22', '2013-01-01', '20:00:00', 
   '01:00:00', 875, 10012, 4, 1011);
INSERT INTO Engagements
  (EngagementNumber, StartDate, EndDate, StartTime, 
   StopTime, ContractPrice, CustomerID, AgentID, EntertainerID)
  VALUES (73, '2012-12-29', '2013-01-07', '19:00:00', 
   '22:00:00', 1400, 10014, 5, 1001);
INSERT INTO Engagements
  (EngagementNumber, StartDate, EndDate, StartTime, 
   StopTime, ContractPrice, CustomerID, AgentID, EntertainerID)
  VALUES (74, '2013-01-01', '2013-01-06', '13:00:00', 
   '15:00:00', 590, 10004, 1, 1005);
INSERT INTO Engagements
  (EngagementNumber, StartDate, EndDate, StartTime, 
   StopTime, ContractPrice, CustomerID, AgentID, EntertainerID)
  VALUES (75, '2013-01-01', '2013-01-11', '17:00:00', 
   '20:00:00', 2525, 10001, 7, 1007);
INSERT INTO Engagements
  (EngagementNumber, StartDate, EndDate, StartTime, 
   StopTime, ContractPrice, CustomerID, AgentID, EntertainerID)
  VALUES (76, '2012-12-30', '2013-01-03', '16:00:00', 
   '22:00:00', 500, 10005, 7, 1012);
INSERT INTO Engagements
  (EngagementNumber, StartDate, EndDate, StartTime, 
   StopTime, ContractPrice, CustomerID, AgentID, EntertainerID)
  VALUES (77, '2012-12-30', '2013-01-04', '17:00:00', 
   '20:00:00', 1670, 10015, 5, 1003);
INSERT INTO Engagements
  (EngagementNumber, StartDate, EndDate, StartTime, 
   StopTime, ContractPrice, CustomerID, AgentID, EntertainerID)
  VALUES (78, '2013-01-01', '2013-01-03', '16:00:00', 
   '20:00:00', 770, 10010, 4, 1010);
INSERT INTO Engagements
  (EngagementNumber, StartDate, EndDate, StartTime, 
   StopTime, ContractPrice, CustomerID, AgentID, EntertainerID)
  VALUES (79, '2012-12-30', '2013-01-03', '12:00:00', 
   '17:00:00', 1550, 10006, 8, 1006);
INSERT INTO Engagements
  (EngagementNumber, StartDate, EndDate, StartTime, 
   StopTime, ContractPrice, CustomerID, AgentID, EntertainerID)
  VALUES (80, '2012-12-31', '2013-01-01', '17:00:00', 
   '21:00:00', 650, 10002, 5, 1008);
INSERT INTO Engagements
  (EngagementNumber, StartDate, EndDate, StartTime, 
   StopTime, ContractPrice, CustomerID, AgentID, EntertainerID)
  VALUES (81, '2013-01-01', '2013-01-09', '13:00:00', 
   '17:00:00', 1130, 10013, 4, 1002);
INSERT INTO Engagements
  (EngagementNumber, StartDate, EndDate, StartTime, 
   StopTime, ContractPrice, CustomerID, AgentID, EntertainerID)
  VALUES (82, '2013-01-08', '2013-01-09', '20:00:00', 
   '01:00:00', 950, 10014, 8, 1003);
INSERT INTO Engagements
  (EngagementNumber, StartDate, EndDate, StartTime, 
   StopTime, ContractPrice, CustomerID, AgentID, EntertainerID)
  VALUES (83, '2013-01-06', '2013-01-10', '13:00:00', 
   '15:00:00', 650, 10010, 2, 1006);
INSERT INTO Engagements
  (EngagementNumber, StartDate, EndDate, StartTime, 
   StopTime, ContractPrice, CustomerID, AgentID, EntertainerID)
  VALUES (84, '2013-01-06', '2013-01-11', '17:00:00', 
   '19:00:00', 230, 10007, 3, 1012);
INSERT INTO Engagements
  (EngagementNumber, StartDate, EndDate, StartTime, 
   StopTime, ContractPrice, CustomerID, AgentID, EntertainerID)
  VALUES (85, '2013-01-06', '2013-01-08', '14:00:00', 
   '19:00:00', 1175, 10015, 4, 1008);
INSERT INTO Engagements
  (EngagementNumber, StartDate, EndDate, StartTime, 
   StopTime, ContractPrice, CustomerID, AgentID, EntertainerID)
  VALUES (87, '2013-01-04', '2013-01-06', '16:00:00', 
   '19:00:00', 275, 10007, 6, 1008);
INSERT INTO Engagements
  (EngagementNumber, StartDate, EndDate, StartTime, 
   StopTime, ContractPrice, CustomerID, AgentID, EntertainerID)
  VALUES (88, '2013-01-07', '2013-01-17', '12:00:00', 
   '14:00:00', 1370, 10004, 8, 1013);
INSERT INTO Engagements
  (EngagementNumber, StartDate, EndDate, StartTime, 
   StopTime, ContractPrice, CustomerID, AgentID, EntertainerID)
  VALUES (89, '2013-01-06', '2013-01-07', '14:00:00', 
   '16:00:00', 290, 10003, 8, 1010);
INSERT INTO Engagements
  (EngagementNumber, StartDate, EndDate, StartTime, 
   StopTime, ContractPrice, CustomerID, AgentID, EntertainerID)
  VALUES (90, '2013-01-08', '2013-01-08', '20:00:00', 
   '02:00:00', 320, 10006, 5, 1001);
INSERT INTO Engagements
  (EngagementNumber, StartDate, EndDate, StartTime, 
   StopTime, ContractPrice, CustomerID, AgentID, EntertainerID)
  VALUES (91, '2013-01-05', '2013-01-12', '13:00:00', 
   '19:00:00', 770, 10009, 3, 1004);
INSERT INTO Engagements
  (EngagementNumber, StartDate, EndDate, StartTime, 
   StopTime, ContractPrice, CustomerID, AgentID, EntertainerID)
  VALUES (92, '2013-01-12', '2013-01-16', '19:00:00', 
   '00:00:00', 1925, 10012, 6, 1008);
INSERT INTO Engagements
  (EngagementNumber, StartDate, EndDate, StartTime, 
   StopTime, ContractPrice, CustomerID, AgentID, EntertainerID)
  VALUES (95, '2013-01-15', '2013-01-18', '20:00:00', 
   '01:00:00', 1550, 10010, 6, 1007);
INSERT INTO Engagements
  (EngagementNumber, StartDate, EndDate, StartTime, 
   StopTime, ContractPrice, CustomerID, AgentID, EntertainerID)
  VALUES (96, '2013-01-22', '2013-01-31', '15:00:00', 
   '17:00:00', 950, 10009, 6, 1005);
INSERT INTO Engagements
  (EngagementNumber, StartDate, EndDate, StartTime, 
   StopTime, ContractPrice, CustomerID, AgentID, EntertainerID)
  VALUES (97, '2013-01-19', '2013-01-19', '17:00:00', 
   '21:00:00', 110, 10012, 8, 1004);
INSERT INTO Engagements
  (EngagementNumber, StartDate, EndDate, StartTime, 
   StopTime, ContractPrice, CustomerID, AgentID, EntertainerID)
  VALUES (98, '2013-01-20', '2013-01-27', '20:00:00', 
   '02:00:00', 2930, 10012, 2, 1010);
INSERT INTO Engagements
  (EngagementNumber, StartDate, EndDate, StartTime, 
   StopTime, ContractPrice, CustomerID, AgentID, EntertainerID)
  VALUES (99, '2013-01-22', '2013-02-22', '14:00:00', 
   '20:00:00', 14105, 10005, 6, 1008);
INSERT INTO Engagements
  (EngagementNumber, StartDate, EndDate, StartTime, 
   StopTime, ContractPrice, CustomerID, AgentID, EntertainerID)
  VALUES (100, '2013-01-19', '2013-01-23', '12:00:00', 
   '18:00:00', 1850, 10015, 3, 1006);
INSERT INTO Engagements
  (EngagementNumber, StartDate, EndDate, StartTime, 
   StopTime, ContractPrice, CustomerID, AgentID, EntertainerID)
  VALUES (101, '2013-01-22', '2013-01-30', '14:00:00', 
   '18:00:00', 1670, 10004, 5, 1001);
INSERT INTO Engagements
  (EngagementNumber, StartDate, EndDate, StartTime, 
   StopTime, ContractPrice, CustomerID, AgentID, EntertainerID)
  VALUES (102, '2013-01-22', '2013-01-31', '12:00:00', 
   '15:00:00', 2300, 10013, 5, 1007);
INSERT INTO Engagements
  (EngagementNumber, StartDate, EndDate, StartTime, 
   StopTime, ContractPrice, CustomerID, AgentID, EntertainerID)
  VALUES (103, '2013-01-21', '2013-01-27', '12:00:00', 
   '17:00:00', 575, 10010, 4, 1011);
INSERT INTO Engagements
  (EngagementNumber, StartDate, EndDate, StartTime, 
   StopTime, ContractPrice, CustomerID, AgentID, EntertainerID)
  VALUES (104, '2013-01-28', '2013-02-01', '13:00:00', 
   '16:00:00', 1400, 10010, 6, 1003);
INSERT INTO Engagements
  (EngagementNumber, StartDate, EndDate, StartTime, 
   StopTime, ContractPrice, CustomerID, AgentID, EntertainerID)
  VALUES (105, '2013-01-27', '2013-02-01', '12:00:00', 
   '17:00:00', 1850, 10002, 4, 1013);
INSERT INTO Engagements
  (EngagementNumber, StartDate, EndDate, StartTime, 
   StopTime, ContractPrice, CustomerID, AgentID, EntertainerID)
  VALUES (106, '2013-01-29', '2013-02-01', '15:00:00', 
   '18:00:00', 770, 10003, 6, 1006);
INSERT INTO Engagements
  (EngagementNumber, StartDate, EndDate, StartTime, 
   StopTime, ContractPrice, CustomerID, AgentID, EntertainerID)
  VALUES (107, '2013-01-29', '2013-01-30', '16:00:00', 
   '21:00:00', 200, 10007, 4, 1004);
INSERT INTO Engagements
  (EngagementNumber, StartDate, EndDate, StartTime, 
   StopTime, ContractPrice, CustomerID, AgentID, EntertainerID)
  VALUES (108, '2013-02-02', '2013-02-04', '18:00:00', 
   '00:00:00', 320, 10004, 5, 1012);
INSERT INTO Engagements
  (EngagementNumber, StartDate, EndDate, StartTime, 
   StopTime, ContractPrice, CustomerID, AgentID, EntertainerID)
  VALUES (109, '2013-02-11', '2013-02-15', '13:00:00', 
   '19:00:00', 1850, 10014, 5, 1010);
INSERT INTO Engagements
  (EngagementNumber, StartDate, EndDate, StartTime, 
   StopTime, ContractPrice, CustomerID, AgentID, EntertainerID)
  VALUES (110, '2013-02-11', '2013-02-19', '15:00:00', 
   '19:00:00', 1670, 10006, 8, 1001);
INSERT INTO Engagements
  (EngagementNumber, StartDate, EndDate, StartTime, 
   StopTime, ContractPrice, CustomerID, AgentID, EntertainerID)
  VALUES (111, '2013-02-12', '2013-02-14', '15:00:00', 
   '18:00:00', 185, 10012, 1, 1004);
INSERT INTO Engagements
  (EngagementNumber, StartDate, EndDate, StartTime, 
   StopTime, ContractPrice, CustomerID, AgentID, EntertainerID)
  VALUES (112, '2013-02-19', '2013-02-24', '18:00:00', 
   '22:00:00', 410, 10015, 7, 1011);
INSERT INTO Engagements
  (EngagementNumber, StartDate, EndDate, StartTime, 
   StopTime, ContractPrice, CustomerID, AgentID, EntertainerID)
  VALUES (114, '2013-02-19', '2013-02-28', '12:00:00', 
   '17:00:00', 1550, 10005, 1, 1002);
INSERT INTO Engagements
  (EngagementNumber, StartDate, EndDate, StartTime, 
   StopTime, ContractPrice, CustomerID, AgentID, EntertainerID)
  VALUES (115, '2013-02-19', '2013-02-22', '12:00:00', 
   '18:00:00', 1490, 10007, 5, 1013);
INSERT INTO Engagements
  (EngagementNumber, StartDate, EndDate, StartTime, 
   StopTime, ContractPrice, CustomerID, AgentID, EntertainerID)
  VALUES (116, '2013-02-16', '2013-02-25', '14:00:00', 
   '19:00:00', 800, 10003, 6, 1012);
INSERT INTO Engagements
  (EngagementNumber, StartDate, EndDate, StartTime, 
   StopTime, ContractPrice, CustomerID, AgentID, EntertainerID)
  VALUES (118, '2013-02-18', '2013-02-18', '19:00:00', 
   '00:00:00', 350, 10014, 1, 1010);
INSERT INTO Engagements
  (EngagementNumber, StartDate, EndDate, StartTime, 
   StopTime, ContractPrice, CustomerID, AgentID, EntertainerID)
  VALUES (119, '2013-02-19', '2013-02-28', '18:00:00', 
   '21:00:00', 500, 10012, 2, 1004);
INSERT INTO Engagements
  (EngagementNumber, StartDate, EndDate, StartTime, 
   StopTime, ContractPrice, CustomerID, AgentID, EntertainerID)
  VALUES (120, '2013-02-17', '2013-02-20', '20:00:00', 
   '23:00:00', 950, 10002, 7, 1008);
INSERT INTO Engagements
  (EngagementNumber, StartDate, EndDate, StartTime, 
   StopTime, ContractPrice, CustomerID, AgentID, EntertainerID)
  VALUES (121, '2013-02-16', '2013-02-22', '17:00:00', 
   '23:00:00', 2570, 10004, 3, 1006);
INSERT INTO Engagements
  (EngagementNumber, StartDate, EndDate, StartTime, 
   StopTime, ContractPrice, CustomerID, AgentID, EntertainerID)
  VALUES (122, '2013-02-24', '2013-02-27', '15:00:00', 
   '19:00:00', 1010, 10014, 5, 1010);
INSERT INTO Engagements
  (EngagementNumber, StartDate, EndDate, StartTime, 
   StopTime, ContractPrice, CustomerID, AgentID, EntertainerID)
  VALUES (123, '2013-02-25', '2013-02-28', '16:00:00', 
   '20:00:00', 770, 10013, 1, 1001);
INSERT INTO Engagements
  (EngagementNumber, StartDate, EndDate, StartTime, 
   StopTime, ContractPrice, CustomerID, AgentID, EntertainerID)
  VALUES (124, '2013-02-23', '2013-03-02', '14:00:00', 
   '17:00:00', 1850, 10006, 1, 1008);
INSERT INTO Engagements
  (EngagementNumber, StartDate, EndDate, StartTime, 
   StopTime, ContractPrice, CustomerID, AgentID, EntertainerID)
  VALUES (125, '2013-02-23', '2013-02-28', '13:00:00', 
   '15:00:00', 1130, 10001, 3, 1003);
INSERT INTO Engagements
  (EngagementNumber, StartDate, EndDate, StartTime, 
   StopTime, ContractPrice, CustomerID, AgentID, EntertainerID)
  VALUES (126, '2013-02-24', '2013-03-03', '18:00:00', 
   '20:00:00', 1010, 10009, 6, 1006);
INSERT INTO Engagements
  (EngagementNumber, StartDate, EndDate, StartTime, 
   StopTime, ContractPrice, CustomerID, AgentID, EntertainerID)
  VALUES (127, '2013-02-24', '2013-02-28', '20:00:00', 
   '22:00:00', 500, 10010, 4, 1005);
INSERT INTO Engagements
  (EngagementNumber, StartDate, EndDate, StartTime, 
   StopTime, ContractPrice, CustomerID, AgentID, EntertainerID)
  VALUES (128, '2013-02-26', '2013-02-28', '19:00:00', 
   '01:00:00', 320, 10003, 4, 1011);
INSERT INTO Engagements
  (EngagementNumber, StartDate, EndDate, StartTime, 
   StopTime, ContractPrice, CustomerID, AgentID, EntertainerID)
  VALUES (129, '2013-02-24', '2013-03-05', '17:00:00', 
   '21:00:00', 2450, 10004, 5, 1013);
INSERT INTO Engagements
  (EngagementNumber, StartDate, EndDate, StartTime, 
   StopTime, ContractPrice, CustomerID, AgentID, EntertainerID)
  VALUES (131, '2013-03-03', '2013-03-12', '15:00:00', 
   '17:00:00', 1850, 10014, 1, 1003);
 
INSERT INTO Members
  (MemberID, MbrFirstName, MbrLastName, MbrPhoneNumber, 
   Gender)
  VALUES (101, 'David', 'Hamilton', '555-2701', 'M');
INSERT INTO Members
  (MemberID, MbrFirstName, MbrLastName, MbrPhoneNumber, 
   Gender)
  VALUES (102, 'Suzanne', 'Viescas', '555-2686', 'F');
INSERT INTO Members
  (MemberID, MbrFirstName, MbrLastName, MbrPhoneNumber, 
   Gender)
  VALUES (103, 'Gary', 'Hallmark', '555-2676', 'M');
INSERT INTO Members
  (MemberID, MbrFirstName, MbrLastName, MbrPhoneNumber, 
   Gender)
  VALUES (104, 'Jeffrey', 'Smith', '555-2596', 'M');
INSERT INTO Members
  (MemberID, MbrFirstName, MbrLastName, MbrPhoneNumber, 
   Gender)
  VALUES (105, 'Robert', 'Brown', '555-2491', 'M');
INSERT INTO Members
  (MemberID, MbrFirstName, MbrLastName, MbrPhoneNumber, 
   Gender)
  VALUES (106, 'Mariya', 'Sergienko', '555-2526', 'F');
INSERT INTO Members
  (MemberID, MbrFirstName, MbrLastName, MbrPhoneNumber, 
   Gender)
  VALUES (107, 'Sara', 'Sheskey', '555-2566', 'F');
INSERT INTO Members
  (MemberID, MbrFirstName, MbrLastName, MbrPhoneNumber, 
   Gender)
  VALUES (108, 'Rachel', 'Patterson', '555-2546', 'F');
INSERT INTO Members
  (MemberID, MbrFirstName, MbrLastName, MbrPhoneNumber, 
   Gender)
  VALUES (109, 'David', 'Viescas', '555-2661', 'M');
INSERT INTO Members
  (MemberID, MbrFirstName, MbrLastName, MbrPhoneNumber, 
   Gender)
  VALUES (110, 'Manuela', 'Seidel', '555-2641', 'F');
INSERT INTO Members
  (MemberID, MbrFirstName, MbrLastName, MbrPhoneNumber, 
   Gender)
  VALUES (111, 'Kathryn', 'Patterson', '555-2651', 
   'F');
INSERT INTO Members
  (MemberID, MbrFirstName, MbrLastName, MbrPhoneNumber, 
   Gender)
  VALUES (112, 'Kendra', 'Bonnicksen', '555-2716', 
   'F');
INSERT INTO Members
  (MemberID, MbrFirstName, MbrLastName, MbrPhoneNumber, 
   Gender)
  VALUES (113, 'Steve', 'Pundt', '555-9938', 'M');
INSERT INTO Members
  (MemberID, MbrFirstName, MbrLastName, MbrPhoneNumber, 
   Gender)
  VALUES (114, 'George', 'Chavez', '555-9930', 'M');
INSERT INTO Members
  (MemberID, MbrFirstName, MbrLastName, MbrPhoneNumber, 
   Gender)
  VALUES (115, 'Joe', 'Rosales III', '555-2281', 'M');
INSERT INTO Members
  (MemberID, MbrFirstName, MbrLastName, MbrPhoneNumber, 
   Gender)
  VALUES (116, 'Angel', 'Kennedy', '555-2311', 'M');
INSERT INTO Members
  (MemberID, MbrFirstName, MbrLastName, MbrPhoneNumber, 
   Gender)
  VALUES (117, 'Luke', 'Patterson', '555-2316', 'M');
INSERT INTO Members
  (MemberID, MbrFirstName, MbrLastName, MbrPhoneNumber, 
   Gender)
  VALUES (118, 'Janice', 'Galvin', '555-2691', 'F');
INSERT INTO Members
  (MemberID, MbrFirstName, MbrLastName, MbrPhoneNumber, 
   Gender)
  VALUES (119, 'John', 'Viescas', '555-2511', 'M');
INSERT INTO Members
  (MemberID, MbrFirstName, MbrLastName, MbrPhoneNumber, 
   Gender)
  VALUES (120, 'Michael', 'Hernandez', '555-2711', 
   'M');
INSERT INTO Members
  (MemberID, MbrFirstName, MbrLastName, MbrPhoneNumber, 
   Gender)
  VALUES (121, 'Katherine', 'Ehrlich', '555-0399', 
   'F');
INSERT INTO Members
  (MemberID, MbrFirstName, MbrLastName, MbrPhoneNumber, 
   Gender)
  VALUES (122, 'Julia', 'Schnebly', '555-9936', 'F');
INSERT INTO Members
  (MemberID, MbrFirstName, MbrLastName, MbrPhoneNumber, 
   Gender)
  VALUES (123, 'Susan', 'McLain', '555-2301', 'F');
INSERT INTO Members
  (MemberID, MbrFirstName, MbrLastName, MbrPhoneNumber, 
   Gender)
  VALUES (124, 'Caroline', 'Coie', '555-2306', 'F');
INSERT INTO Members
  (MemberID, MbrFirstName, MbrLastName, MbrPhoneNumber, 
   Gender)
  VALUES (125, 'Jim', 'Glynn', '555-2531', NULL);
 
INSERT INTO Entertainer_Members
  (EntertainerID, MemberID, Status)
  VALUES (1001, 106, 1);
INSERT INTO Entertainer_Members
  (EntertainerID, MemberID, Status)
  VALUES (1001, 107, 1);
INSERT INTO Entertainer_Members
  (EntertainerID, MemberID, Status)
  VALUES (1001, 118, 2);
INSERT INTO Entertainer_Members
  (EntertainerID, MemberID, Status)
  VALUES (1002, 120, 2);
INSERT INTO Entertainer_Members
  (EntertainerID, MemberID, Status)
  VALUES (1002, 121, 1);
INSERT INTO Entertainer_Members
  (EntertainerID, MemberID, Status)
  VALUES (1003, 102, 1);
INSERT INTO Entertainer_Members
  (EntertainerID, MemberID, Status)
  VALUES (1003, 103, 1);
INSERT INTO Entertainer_Members
  (EntertainerID, MemberID, Status)
  VALUES (1003, 104, 1);
INSERT INTO Entertainer_Members
  (EntertainerID, MemberID, Status)
  VALUES (1003, 109, 1);
INSERT INTO Entertainer_Members
  (EntertainerID, MemberID, Status)
  VALUES (1003, 117, 1);
INSERT INTO Entertainer_Members
  (EntertainerID, MemberID, Status)
  VALUES (1003, 119, 2);
INSERT INTO Entertainer_Members
  (EntertainerID, MemberID, Status)
  VALUES (1004, 125, 2);
INSERT INTO Entertainer_Members
  (EntertainerID, MemberID, Status)
  VALUES (1005, 116, 1);
INSERT INTO Entertainer_Members
  (EntertainerID, MemberID, Status)
  VALUES (1005, 120, 2);
INSERT INTO Entertainer_Members
  (EntertainerID, MemberID, Status)
  VALUES (1005, 121, 1);
INSERT INTO Entertainer_Members
  (EntertainerID, MemberID, Status)
  VALUES (1006, 104, 1);
INSERT INTO Entertainer_Members
  (EntertainerID, MemberID, Status)
  VALUES (1006, 113, 1);
INSERT INTO Entertainer_Members
  (EntertainerID, MemberID, Status)
  VALUES (1006, 118, 1);
INSERT INTO Entertainer_Members
  (EntertainerID, MemberID, Status)
  VALUES (1006, 120, 2);
INSERT INTO Entertainer_Members
  (EntertainerID, MemberID, Status)
  VALUES (1007, 101, 1);
INSERT INTO Entertainer_Members
  (EntertainerID, MemberID, Status)
  VALUES (1007, 102, 1);
INSERT INTO Entertainer_Members
  (EntertainerID, MemberID, Status)
  VALUES (1007, 105, 1);
INSERT INTO Entertainer_Members
  (EntertainerID, MemberID, Status)
  VALUES (1007, 107, 2);
INSERT INTO Entertainer_Members
  (EntertainerID, MemberID, Status)
  VALUES (1007, 110, 1);
INSERT INTO Entertainer_Members
  (EntertainerID, MemberID, Status)
  VALUES (1008, 103, 1);
INSERT INTO Entertainer_Members
  (EntertainerID, MemberID, Status)
  VALUES (1008, 105, 1);
INSERT INTO Entertainer_Members
  (EntertainerID, MemberID, Status)
  VALUES (1008, 111, 1);
INSERT INTO Entertainer_Members
  (EntertainerID, MemberID, Status)
  VALUES (1008, 114, 2);
INSERT INTO Entertainer_Members
  (EntertainerID, MemberID, Status)
  VALUES (1008, 115, 1);
INSERT INTO Entertainer_Members
  (EntertainerID, MemberID, Status)
  VALUES (1009, 121, 2);
INSERT INTO Entertainer_Members
  (EntertainerID, MemberID, Status)
  VALUES (1010, 108, 1);
INSERT INTO Entertainer_Members
  (EntertainerID, MemberID, Status)
  VALUES (1010, 112, 2);
INSERT INTO Entertainer_Members
  (EntertainerID, MemberID, Status)
  VALUES (1010, 123, 1);
INSERT INTO Entertainer_Members
  (EntertainerID, MemberID, Status)
  VALUES (1010, 124, 1);
INSERT INTO Entertainer_Members
  (EntertainerID, MemberID, Status)
  VALUES (1011, 122, 2);
INSERT INTO Entertainer_Members
  (EntertainerID, MemberID, Status)
  VALUES (1012, 123, 2);
INSERT INTO Entertainer_Members
  (EntertainerID, MemberID, Status)
  VALUES (1013, 112, 1);
INSERT INTO Entertainer_Members
  (EntertainerID, MemberID, Status)
  VALUES (1013, 114, 1);
INSERT INTO Entertainer_Members
  (EntertainerID, MemberID, Status)
  VALUES (1013, 117, 1);
INSERT INTO Entertainer_Members
  (EntertainerID, MemberID, Status)
  VALUES (1013, 124, 2);
 
INSERT INTO Musical_Styles
  (StyleID, StyleName)
  VALUES (1, '40''s Ballroom Music');
INSERT INTO Musical_Styles
  (StyleID, StyleName)
  VALUES (2, '50''s Music');
INSERT INTO Musical_Styles
  (StyleID, StyleName)
  VALUES (3, '60''s Music');
INSERT INTO Musical_Styles
  (StyleID, StyleName)
  VALUES (4, '70''s Music');
INSERT INTO Musical_Styles
  (StyleID, StyleName)
  VALUES (5, '80''s Music');
INSERT INTO Musical_Styles
  (StyleID, StyleName)
  VALUES (6, 'Country');
INSERT INTO Musical_Styles
  (StyleID, StyleName)
  VALUES (7, 'Classical');
INSERT INTO Musical_Styles
  (StyleID, StyleName)
  VALUES (8, 'Classic Rock & Roll');
INSERT INTO Musical_Styles
  (StyleID, StyleName)
  VALUES (9, 'Rap');
INSERT INTO Musical_Styles
  (StyleID, StyleName)
  VALUES (10, 'Contemporary');
INSERT INTO Musical_Styles
  (StyleID, StyleName)
  VALUES (11, 'Country Rock');
INSERT INTO Musical_Styles
  (StyleID, StyleName)
  VALUES (12, 'Elvis');
INSERT INTO Musical_Styles
  (StyleID, StyleName)
  VALUES (13, 'Folk');
INSERT INTO Musical_Styles
  (StyleID, StyleName)
  VALUES (14, 'Chamber Music');
INSERT INTO Musical_Styles
  (StyleID, StyleName)
  VALUES (15, 'Jazz');
INSERT INTO Musical_Styles
  (StyleID, StyleName)
  VALUES (16, 'Karaoke');
INSERT INTO Musical_Styles
  (StyleID, StyleName)
  VALUES (17, 'Motown');
INSERT INTO Musical_Styles
  (StyleID, StyleName)
  VALUES (18, 'Modern Rock');
INSERT INTO Musical_Styles
  (StyleID, StyleName)
  VALUES (19, 'Rhythm and Blues');
INSERT INTO Musical_Styles
  (StyleID, StyleName)
  VALUES (20, 'Show Tunes');
INSERT INTO Musical_Styles
  (StyleID, StyleName)
  VALUES (21, 'Standards');
INSERT INTO Musical_Styles
  (StyleID, StyleName)
  VALUES (22, 'Top 40 Hits');
INSERT INTO Musical_Styles
  (StyleID, StyleName)
  VALUES (23, 'Variety');
INSERT INTO Musical_Styles
  (StyleID, StyleName)
  VALUES (24, 'Salsa');
INSERT INTO Musical_Styles
  (StyleID, StyleName)
  VALUES (25, '90''s Music');
 
INSERT INTO Entertainer_Styles
  (EntertainerID, StyleID, StyleStrength)
  VALUES (1001, 10, 2);
INSERT INTO Entertainer_Styles
  (EntertainerID, StyleID, StyleStrength)
  VALUES (1001, 20, 1);
INSERT INTO Entertainer_Styles
  (EntertainerID, StyleID, StyleStrength)
  VALUES (1001, 21, 3);
INSERT INTO Entertainer_Styles
  (EntertainerID, StyleID, StyleStrength)
  VALUES (1002, 17, 2);
INSERT INTO Entertainer_Styles
  (EntertainerID, StyleID, StyleStrength)
  VALUES (1002, 19, 1);
INSERT INTO Entertainer_Styles
  (EntertainerID, StyleID, StyleStrength)
  VALUES (1002, 23, 3);
INSERT INTO Entertainer_Styles
  (EntertainerID, StyleID, StyleStrength)
  VALUES (1003, 3, 1);
INSERT INTO Entertainer_Styles
  (EntertainerID, StyleID, StyleStrength)
  VALUES (1003, 8, 2);
INSERT INTO Entertainer_Styles
  (EntertainerID, StyleID, StyleStrength)
  VALUES (1004, 13, 1);
INSERT INTO Entertainer_Styles
  (EntertainerID, StyleID, StyleStrength)
  VALUES (1005, 15, 3);
INSERT INTO Entertainer_Styles
  (EntertainerID, StyleID, StyleStrength)
  VALUES (1005, 19, 1);
INSERT INTO Entertainer_Styles
  (EntertainerID, StyleID, StyleStrength)
  VALUES (1005, 24, 2);
INSERT INTO Entertainer_Styles
  (EntertainerID, StyleID, StyleStrength)
  VALUES (1006, 22, 3);
INSERT INTO Entertainer_Styles
  (EntertainerID, StyleID, StyleStrength)
  VALUES (1006, 23, 1);
INSERT INTO Entertainer_Styles
  (EntertainerID, StyleID, StyleStrength)
  VALUES (1006, 24, 2);
INSERT INTO Entertainer_Styles
  (EntertainerID, StyleID, StyleStrength)
  VALUES (1007, 6, 2);
INSERT INTO Entertainer_Styles
  (EntertainerID, StyleID, StyleStrength)
  VALUES (1007, 11, 1);
INSERT INTO Entertainer_Styles
  (EntertainerID, StyleID, StyleStrength)
  VALUES (1008, 3, 2);
INSERT INTO Entertainer_Styles
  (EntertainerID, StyleID, StyleStrength)
  VALUES (1008, 6, 1);
INSERT INTO Entertainer_Styles
  (EntertainerID, StyleID, StyleStrength)
  VALUES (1009, 7, 2);
INSERT INTO Entertainer_Styles
  (EntertainerID, StyleID, StyleStrength)
  VALUES (1009, 14, 1);
INSERT INTO Entertainer_Styles
  (EntertainerID, StyleID, StyleStrength)
  VALUES (1009, 21, 3);
INSERT INTO Entertainer_Styles
  (EntertainerID, StyleID, StyleStrength)
  VALUES (1010, 4, 2);
INSERT INTO Entertainer_Styles
  (EntertainerID, StyleID, StyleStrength)
  VALUES (1010, 21, 3);
INSERT INTO Entertainer_Styles
  (EntertainerID, StyleID, StyleStrength)
  VALUES (1010, 22, 1);
INSERT INTO Entertainer_Styles
  (EntertainerID, StyleID, StyleStrength)
  VALUES (1011, 7, 2);
INSERT INTO Entertainer_Styles
  (EntertainerID, StyleID, StyleStrength)
  VALUES (1011, 14, 1);
INSERT INTO Entertainer_Styles
  (EntertainerID, StyleID, StyleStrength)
  VALUES (1011, 20, 3);
INSERT INTO Entertainer_Styles
  (EntertainerID, StyleID, StyleStrength)
  VALUES (1012, 7, 2);
INSERT INTO Entertainer_Styles
  (EntertainerID, StyleID, StyleStrength)
  VALUES (1012, 13, 1);
INSERT INTO Entertainer_Styles
  (EntertainerID, StyleID, StyleStrength)
  VALUES (1013, 10, 2);
INSERT INTO Entertainer_Styles
  (EntertainerID, StyleID, StyleStrength)
  VALUES (1013, 15, 1);
 
INSERT INTO Musical_Preferences
  (CustomerID, StyleID, PreferenceSeq)
  VALUES (10001, 10, 2);
INSERT INTO Musical_Preferences
  (CustomerID, StyleID, PreferenceSeq)
  VALUES (10001, 22, 1);
INSERT INTO Musical_Preferences
  (CustomerID, StyleID, PreferenceSeq)
  VALUES (10002, 3, 1);
INSERT INTO Musical_Preferences
  (CustomerID, StyleID, PreferenceSeq)
  VALUES (10002, 8, 2);
INSERT INTO Musical_Preferences
  (CustomerID, StyleID, PreferenceSeq)
  VALUES (10003, 17, 2);
INSERT INTO Musical_Preferences
  (CustomerID, StyleID, PreferenceSeq)
  VALUES (10003, 19, 1);
INSERT INTO Musical_Preferences
  (CustomerID, StyleID, PreferenceSeq)
  VALUES (10004, 15, 1);
INSERT INTO Musical_Preferences
  (CustomerID, StyleID, PreferenceSeq)
  VALUES (10004, 21, 2);
INSERT INTO Musical_Preferences
  (CustomerID, StyleID, PreferenceSeq)
  VALUES (10005, 7, 2);
INSERT INTO Musical_Preferences
  (CustomerID, StyleID, PreferenceSeq)
  VALUES (10005, 14, 1);
INSERT INTO Musical_Preferences
  (CustomerID, StyleID, PreferenceSeq)
  VALUES (10006, 13, 2);
INSERT INTO Musical_Preferences
  (CustomerID, StyleID, PreferenceSeq)
  VALUES (10006, 23, 1);
INSERT INTO Musical_Preferences
  (CustomerID, StyleID, PreferenceSeq)
  VALUES (10007, 4, 2);
INSERT INTO Musical_Preferences
  (CustomerID, StyleID, PreferenceSeq)
  VALUES (10007, 8, 1);
INSERT INTO Musical_Preferences
  (CustomerID, StyleID, PreferenceSeq)
  VALUES (10007, 19, 3);
INSERT INTO Musical_Preferences
  (CustomerID, StyleID, PreferenceSeq)
  VALUES (10008, 10, 1);
INSERT INTO Musical_Preferences
  (CustomerID, StyleID, PreferenceSeq)
  VALUES (10008, 21, 2);
INSERT INTO Musical_Preferences
  (CustomerID, StyleID, PreferenceSeq)
  VALUES (10009, 6, 2);
INSERT INTO Musical_Preferences
  (CustomerID, StyleID, PreferenceSeq)
  VALUES (10009, 11, 1);
INSERT INTO Musical_Preferences
  (CustomerID, StyleID, PreferenceSeq)
  VALUES (10009, 18, 3);
INSERT INTO Musical_Preferences
  (CustomerID, StyleID, PreferenceSeq)
  VALUES (10010, 15, 2);
INSERT INTO Musical_Preferences
  (CustomerID, StyleID, PreferenceSeq)
  VALUES (10010, 19, 1);
INSERT INTO Musical_Preferences
  (CustomerID, StyleID, PreferenceSeq)
  VALUES (10010, 24, 3);
INSERT INTO Musical_Preferences
  (CustomerID, StyleID, PreferenceSeq)
  VALUES (10011, 1, 2);
INSERT INTO Musical_Preferences
  (CustomerID, StyleID, PreferenceSeq)
  VALUES (10011, 7, 3);
INSERT INTO Musical_Preferences
  (CustomerID, StyleID, PreferenceSeq)
  VALUES (10011, 21, 1);
INSERT INTO Musical_Preferences
  (CustomerID, StyleID, PreferenceSeq)
  VALUES (10012, 10, 2);
INSERT INTO Musical_Preferences
  (CustomerID, StyleID, PreferenceSeq)
  VALUES (10012, 20, 1);
INSERT INTO Musical_Preferences
  (CustomerID, StyleID, PreferenceSeq)
  VALUES (10013, 15, 1);
INSERT INTO Musical_Preferences
  (CustomerID, StyleID, PreferenceSeq)
  VALUES (10013, 24, 2);
INSERT INTO Musical_Preferences
  (CustomerID, StyleID, PreferenceSeq)
  VALUES (10014, 5, 3);
INSERT INTO Musical_Preferences
  (CustomerID, StyleID, PreferenceSeq)
  VALUES (10014, 18, 2);
INSERT INTO Musical_Preferences
  (CustomerID, StyleID, PreferenceSeq)
  VALUES (10014, 22, 1);
INSERT INTO Musical_Preferences
  (CustomerID, StyleID, PreferenceSeq)
  VALUES (10015, 1, 3);
INSERT INTO Musical_Preferences
  (CustomerID, StyleID, PreferenceSeq)
  VALUES (10015, 20, 2);
INSERT INTO Musical_Preferences
  (CustomerID, StyleID, PreferenceSeq)
  VALUES (10015, 21, 1);
 
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-01-01');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-01-02');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-01-03');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-01-04');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-01-05');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-01-06');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-01-07');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-01-08');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-01-09');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-01-10');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-01-11');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-01-12');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-01-13');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-01-14');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-01-15');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-01-16');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-01-17');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-01-18');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-01-19');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-01-20');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-01-21');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-01-22');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-01-23');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-01-24');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-01-25');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-01-26');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-01-27');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-01-28');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-01-29');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-01-30');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-01-31');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-02-01');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-02-02');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-02-03');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-02-04');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-02-05');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-02-06');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-02-07');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-02-08');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-02-09');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-02-10');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-02-11');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-02-12');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-02-13');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-02-14');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-02-15');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-02-16');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-02-17');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-02-18');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-02-19');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-02-20');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-02-21');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-02-22');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-02-23');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-02-24');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-02-25');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-02-26');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-02-27');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-02-28');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-02-29');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-03-01');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-03-02');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-03-03');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-03-04');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-03-05');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-03-06');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-03-07');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-03-08');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-03-09');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-03-10');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-03-11');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-03-12');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-03-13');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-03-14');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-03-15');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-03-16');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-03-17');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-03-18');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-03-19');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-03-20');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-03-21');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-03-22');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-03-23');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-03-24');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-03-25');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-03-26');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-03-27');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-03-28');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-03-29');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-03-30');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-03-31');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-04-01');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-04-02');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-04-03');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-04-04');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-04-05');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-04-06');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-04-07');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-04-08');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-04-09');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-04-10');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-04-11');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-04-12');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-04-13');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-04-14');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-04-15');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-04-16');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-04-17');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-04-18');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-04-19');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-04-20');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-04-21');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-04-22');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-04-23');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-04-24');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-04-25');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-04-26');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-04-27');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-04-28');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-04-29');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-04-30');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-05-01');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-05-02');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-05-03');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-05-04');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-05-05');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-05-06');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-05-07');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-05-08');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-05-09');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-05-10');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-05-11');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-05-12');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-05-13');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-05-14');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-05-15');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-05-16');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-05-17');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-05-18');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-05-19');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-05-20');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-05-21');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-05-22');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-05-23');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-05-24');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-05-25');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-05-26');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-05-27');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-05-28');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-05-29');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-05-30');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-05-31');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-06-01');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-06-02');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-06-03');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-06-04');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-06-05');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-06-06');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-06-07');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-06-08');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-06-09');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-06-10');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-06-11');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-06-12');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-06-13');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-06-14');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-06-15');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-06-16');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-06-17');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-06-18');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-06-19');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-06-20');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-06-21');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-06-22');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-06-23');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-06-24');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-06-25');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-06-26');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-06-27');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-06-28');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-06-29');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-06-30');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-07-01');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-07-02');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-07-03');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-07-04');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-07-05');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-07-06');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-07-07');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-07-08');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-07-09');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-07-10');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-07-11');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-07-12');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-07-13');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-07-14');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-07-15');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-07-16');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-07-17');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-07-18');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-07-19');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-07-20');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-07-21');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-07-22');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-07-23');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-07-24');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-07-25');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-07-26');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-07-27');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-07-28');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-07-29');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-07-30');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-07-31');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-08-01');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-08-02');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-08-03');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-08-04');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-08-05');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-08-06');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-08-07');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-08-08');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-08-09');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-08-10');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-08-11');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-08-12');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-08-13');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-08-14');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-08-15');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-08-16');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-08-17');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-08-18');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-08-19');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-08-20');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-08-21');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-08-22');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-08-23');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-08-24');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-08-25');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-08-26');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-08-27');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-08-28');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-08-29');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-08-30');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-08-31');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-09-01');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-09-02');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-09-03');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-09-04');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-09-05');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-09-06');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-09-07');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-09-08');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-09-09');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-09-10');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-09-11');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-09-12');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-09-13');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-09-14');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-09-15');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-09-16');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-09-17');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-09-18');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-09-19');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-09-20');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-09-21');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-09-22');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-09-23');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-09-24');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-09-25');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-09-26');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-09-27');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-09-28');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-09-29');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-09-30');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-10-01');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-10-02');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-10-03');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-10-04');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-10-05');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-10-06');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-10-07');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-10-08');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-10-09');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-10-10');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-10-11');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-10-12');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-10-13');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-10-14');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-10-15');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-10-16');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-10-17');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-10-18');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-10-19');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-10-20');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-10-21');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-10-22');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-10-23');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-10-24');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-10-25');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-10-26');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-10-27');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-10-28');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-10-29');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-10-30');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-10-31');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-11-01');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-11-02');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-11-03');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-11-04');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-11-05');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-11-06');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-11-07');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-11-08');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-11-09');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-11-10');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-11-11');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-11-12');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-11-13');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-11-14');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-11-15');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-11-16');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-11-17');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-11-18');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-11-19');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-11-20');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-11-21');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-11-22');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-11-23');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-11-24');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-11-25');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-11-26');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-11-27');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-11-28');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-11-29');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-11-30');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-12-01');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-12-02');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-12-03');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-12-04');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-12-05');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-12-06');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-12-07');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-12-08');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-12-09');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-12-10');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-12-11');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-12-12');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-12-13');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-12-14');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-12-15');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-12-16');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-12-17');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-12-18');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-12-19');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-12-20');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-12-21');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-12-22');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-12-23');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-12-24');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-12-25');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-12-26');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-12-27');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-12-28');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-12-29');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-12-30');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2012-12-31');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-01-01');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-01-02');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-01-03');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-01-04');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-01-05');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-01-06');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-01-07');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-01-08');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-01-09');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-01-10');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-01-11');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-01-12');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-01-13');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-01-14');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-01-15');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-01-16');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-01-17');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-01-18');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-01-19');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-01-20');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-01-21');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-01-22');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-01-23');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-01-24');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-01-25');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-01-26');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-01-27');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-01-28');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-01-29');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-01-30');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-01-31');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-02-01');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-02-02');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-02-03');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-02-04');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-02-05');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-02-06');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-02-07');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-02-08');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-02-09');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-02-10');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-02-11');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-02-12');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-02-13');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-02-14');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-02-15');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-02-16');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-02-17');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-02-18');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-02-19');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-02-20');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-02-21');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-02-22');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-02-23');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-02-24');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-02-25');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-02-26');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-02-27');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-02-28');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-03-01');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-03-02');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-03-03');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-03-04');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-03-05');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-03-06');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-03-07');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-03-08');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-03-09');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-03-10');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-03-11');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-03-12');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-03-13');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-03-14');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-03-15');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-03-16');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-03-17');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-03-18');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-03-19');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-03-20');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-03-21');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-03-22');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-03-23');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-03-24');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-03-25');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-03-26');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-03-27');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-03-28');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-03-29');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-03-30');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-03-31');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-04-01');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-04-02');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-04-03');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-04-04');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-04-05');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-04-06');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-04-07');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-04-08');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-04-09');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-04-10');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-04-11');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-04-12');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-04-13');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-04-14');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-04-15');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-04-16');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-04-17');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-04-18');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-04-19');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-04-20');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-04-21');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-04-22');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-04-23');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-04-24');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-04-25');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-04-26');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-04-27');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-04-28');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-04-29');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-04-30');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-05-01');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-05-02');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-05-03');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-05-04');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-05-05');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-05-06');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-05-07');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-05-08');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-05-09');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-05-10');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-05-11');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-05-12');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-05-13');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-05-14');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-05-15');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-05-16');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-05-17');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-05-18');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-05-19');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-05-20');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-05-21');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-05-22');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-05-23');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-05-24');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-05-25');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-05-26');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-05-27');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-05-28');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-05-29');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-05-30');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-05-31');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-06-01');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-06-02');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-06-03');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-06-04');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-06-05');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-06-06');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-06-07');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-06-08');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-06-09');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-06-10');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-06-11');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-06-12');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-06-13');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-06-14');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-06-15');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-06-16');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-06-17');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-06-18');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-06-19');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-06-20');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-06-21');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-06-22');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-06-23');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-06-24');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-06-25');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-06-26');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-06-27');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-06-28');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-06-29');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-06-30');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-07-01');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-07-02');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-07-03');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-07-04');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-07-05');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-07-06');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-07-07');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-07-08');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-07-09');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-07-10');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-07-11');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-07-12');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-07-13');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-07-14');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-07-15');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-07-16');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-07-17');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-07-18');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-07-19');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-07-20');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-07-21');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-07-22');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-07-23');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-07-24');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-07-25');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-07-26');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-07-27');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-07-28');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-07-29');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-07-30');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-07-31');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-08-01');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-08-02');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-08-03');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-08-04');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-08-05');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-08-06');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-08-07');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-08-08');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-08-09');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-08-10');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-08-11');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-08-12');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-08-13');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-08-14');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-08-15');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-08-16');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-08-17');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-08-18');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-08-19');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-08-20');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-08-21');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-08-22');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-08-23');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-08-24');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-08-25');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-08-26');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-08-27');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-08-28');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-08-29');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-08-30');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-08-31');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-09-01');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-09-02');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-09-03');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-09-04');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-09-05');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-09-06');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-09-07');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-09-08');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-09-09');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-09-10');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-09-11');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-09-12');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-09-13');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-09-14');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-09-15');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-09-16');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-09-17');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-09-18');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-09-19');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-09-20');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-09-21');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-09-22');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-09-23');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-09-24');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-09-25');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-09-26');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-09-27');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-09-28');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-09-29');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-09-30');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-10-01');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-10-02');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-10-03');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-10-04');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-10-05');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-10-06');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-10-07');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-10-08');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-10-09');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-10-10');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-10-11');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-10-12');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-10-13');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-10-14');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-10-15');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-10-16');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-10-17');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-10-18');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-10-19');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-10-20');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-10-21');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-10-22');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-10-23');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-10-24');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-10-25');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-10-26');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-10-27');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-10-28');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-10-29');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-10-30');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-10-31');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-11-01');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-11-02');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-11-03');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-11-04');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-11-05');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-11-06');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-11-07');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-11-08');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-11-09');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-11-10');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-11-11');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-11-12');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-11-13');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-11-14');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-11-15');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-11-16');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-11-17');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-11-18');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-11-19');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-11-20');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-11-21');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-11-22');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-11-23');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-11-24');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-11-25');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-11-26');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-11-27');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-11-28');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-11-29');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-11-30');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-12-01');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-12-02');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-12-03');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-12-04');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-12-05');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-12-06');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-12-07');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-12-08');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-12-09');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-12-10');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-12-11');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-12-12');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-12-13');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-12-14');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-12-15');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-12-16');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-12-17');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-12-18');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-12-19');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-12-20');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-12-21');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-12-22');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-12-23');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-12-24');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-12-25');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-12-26');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-12-27');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-12-28');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-12-29');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-12-30');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2013-12-31');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-01-01');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-01-02');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-01-03');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-01-04');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-01-05');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-01-06');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-01-07');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-01-08');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-01-09');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-01-10');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-01-11');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-01-12');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-01-13');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-01-14');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-01-15');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-01-16');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-01-17');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-01-18');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-01-19');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-01-20');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-01-21');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-01-22');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-01-23');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-01-24');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-01-25');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-01-26');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-01-27');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-01-28');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-01-29');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-01-30');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-01-31');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-02-01');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-02-02');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-02-03');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-02-04');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-02-05');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-02-06');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-02-07');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-02-08');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-02-09');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-02-10');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-02-11');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-02-12');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-02-13');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-02-14');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-02-15');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-02-16');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-02-17');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-02-18');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-02-19');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-02-20');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-02-21');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-02-22');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-02-23');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-02-24');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-02-25');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-02-26');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-02-27');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-02-28');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-03-01');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-03-02');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-03-03');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-03-04');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-03-05');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-03-06');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-03-07');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-03-08');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-03-09');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-03-10');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-03-11');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-03-12');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-03-13');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-03-14');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-03-15');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-03-16');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-03-17');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-03-18');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-03-19');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-03-20');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-03-21');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-03-22');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-03-23');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-03-24');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-03-25');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-03-26');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-03-27');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-03-28');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-03-29');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-03-30');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-03-31');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-04-01');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-04-02');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-04-03');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-04-04');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-04-05');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-04-06');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-04-07');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-04-08');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-04-09');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-04-10');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-04-11');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-04-12');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-04-13');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-04-14');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-04-15');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-04-16');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-04-17');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-04-18');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-04-19');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-04-20');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-04-21');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-04-22');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-04-23');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-04-24');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-04-25');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-04-26');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-04-27');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-04-28');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-04-29');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-04-30');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-05-01');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-05-02');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-05-03');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-05-04');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-05-05');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-05-06');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-05-07');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-05-08');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-05-09');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-05-10');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-05-11');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-05-12');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-05-13');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-05-14');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-05-15');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-05-16');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-05-17');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-05-18');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-05-19');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-05-20');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-05-21');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-05-22');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-05-23');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-05-24');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-05-25');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-05-26');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-05-27');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-05-28');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-05-29');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-05-30');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-05-31');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-06-01');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-06-02');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-06-03');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-06-04');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-06-05');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-06-06');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-06-07');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-06-08');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-06-09');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-06-10');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-06-11');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-06-12');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-06-13');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-06-14');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-06-15');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-06-16');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-06-17');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-06-18');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-06-19');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-06-20');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-06-21');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-06-22');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-06-23');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-06-24');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-06-25');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-06-26');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-06-27');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-06-28');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-06-29');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-06-30');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-07-01');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-07-02');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-07-03');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-07-04');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-07-05');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-07-06');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-07-07');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-07-08');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-07-09');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-07-10');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-07-11');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-07-12');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-07-13');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-07-14');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-07-15');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-07-16');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-07-17');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-07-18');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-07-19');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-07-20');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-07-21');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-07-22');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-07-23');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-07-24');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-07-25');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-07-26');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-07-27');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-07-28');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-07-29');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-07-30');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-07-31');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-08-01');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-08-02');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-08-03');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-08-04');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-08-05');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-08-06');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-08-07');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-08-08');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-08-09');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-08-10');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-08-11');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-08-12');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-08-13');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-08-14');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-08-15');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-08-16');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-08-17');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-08-18');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-08-19');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-08-20');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-08-21');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-08-22');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-08-23');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-08-24');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-08-25');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-08-26');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-08-27');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-08-28');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-08-29');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-08-30');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-08-31');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-09-01');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-09-02');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-09-03');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-09-04');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-09-05');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-09-06');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-09-07');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-09-08');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-09-09');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-09-10');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-09-11');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-09-12');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-09-13');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-09-14');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-09-15');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-09-16');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-09-17');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-09-18');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-09-19');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-09-20');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-09-21');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-09-22');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-09-23');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-09-24');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-09-25');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-09-26');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-09-27');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-09-28');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-09-29');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-09-30');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-10-01');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-10-02');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-10-03');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-10-04');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-10-05');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-10-06');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-10-07');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-10-08');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-10-09');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-10-10');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-10-11');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-10-12');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-10-13');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-10-14');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-10-15');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-10-16');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-10-17');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-10-18');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-10-19');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-10-20');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-10-21');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-10-22');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-10-23');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-10-24');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-10-25');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-10-26');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-10-27');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-10-28');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-10-29');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-10-30');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-10-31');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-11-01');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-11-02');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-11-03');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-11-04');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-11-05');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-11-06');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-11-07');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-11-08');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-11-09');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-11-10');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-11-11');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-11-12');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-11-13');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-11-14');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-11-15');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-11-16');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-11-17');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-11-18');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-11-19');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-11-20');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-11-21');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-11-22');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-11-23');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-11-24');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-11-25');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-11-26');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-11-27');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-11-28');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-11-29');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-11-30');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-12-01');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-12-02');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-12-03');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-12-04');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-12-05');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-12-06');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-12-07');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-12-08');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-12-09');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-12-10');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-12-11');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-12-12');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-12-13');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-12-14');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-12-15');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-12-16');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-12-17');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-12-18');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-12-19');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-12-20');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-12-21');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-12-22');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-12-23');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-12-24');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-12-25');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-12-26');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-12-27');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-12-28');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-12-29');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-12-30');
INSERT INTO ztblDays
  (DateField)
  VALUES ('2014-12-31');
 
INSERT INTO ztblMonths
  (MonthYear, YearNumber, MonthNumber, MonthStart, 
   MonthEnd, January, February, March, April, May, 
   June, July, August, September, October, November, 
   December)
  VALUES ('January 2012', 2012, 1, '2012-01-01', '2012-01-31', 
   1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO ztblMonths
  (MonthYear, YearNumber, MonthNumber, MonthStart, 
   MonthEnd, January, February, March, April, May, 
   June, July, August, September, October, November, 
   December)
  VALUES ('February 2012', 2012, 2, '2012-02-01', '2012-02-29', 
   0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO ztblMonths
  (MonthYear, YearNumber, MonthNumber, MonthStart, 
   MonthEnd, January, February, March, April, May, 
   June, July, August, September, October, November, 
   December)
  VALUES ('March 2012', 2012, 3, '2012-03-01', '2012-03-31', 
   0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO ztblMonths
  (MonthYear, YearNumber, MonthNumber, MonthStart, 
   MonthEnd, January, February, March, April, May, 
   June, July, August, September, October, November, 
   December)
  VALUES ('April 2012', 2012, 4, '2012-04-01', '2012-04-30', 
   0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO ztblMonths
  (MonthYear, YearNumber, MonthNumber, MonthStart, 
   MonthEnd, January, February, March, April, May, 
   June, July, August, September, October, November, 
   December)
  VALUES ('May 2012', 2012, 5, '2012-05-01', '2012-05-31', 
   0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO ztblMonths
  (MonthYear, YearNumber, MonthNumber, MonthStart, 
   MonthEnd, January, February, March, April, May, 
   June, July, August, September, October, November, 
   December)
  VALUES ('June 2012', 2012, 6, '2012-06-01', '2012-06-30', 
   0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0);
INSERT INTO ztblMonths
  (MonthYear, YearNumber, MonthNumber, MonthStart, 
   MonthEnd, January, February, March, April, May, 
   June, July, August, September, October, November, 
   December)
  VALUES ('July 2012', 2012, 7, '2012-07-01', '2012-07-31', 
   0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0);
INSERT INTO ztblMonths
  (MonthYear, YearNumber, MonthNumber, MonthStart, 
   MonthEnd, January, February, March, April, May, 
   June, July, August, September, October, November, 
   December)
  VALUES ('August 2012', 2012, 8, '2012-08-01', '2012-08-31', 
   0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0);
INSERT INTO ztblMonths
  (MonthYear, YearNumber, MonthNumber, MonthStart, 
   MonthEnd, January, February, March, April, May, 
   June, July, August, September, October, November, 
   December)
  VALUES ('September 2012', 2012, 9, '2012-09-01', 
   '2012-09-30', 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0);
INSERT INTO ztblMonths
  (MonthYear, YearNumber, MonthNumber, MonthStart, 
   MonthEnd, January, February, March, April, May, 
   June, July, August, September, October, November, 
   December)
  VALUES ('October 2012', 2012, 10, '2012-10-01', '2012-10-31', 
   0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0);
INSERT INTO ztblMonths
  (MonthYear, YearNumber, MonthNumber, MonthStart, 
   MonthEnd, January, February, March, April, May, 
   June, July, August, September, October, November, 
   December)
  VALUES ('November 2012', 2012, 11, '2012-11-01', 
   '2012-11-30', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0);
INSERT INTO ztblMonths
  (MonthYear, YearNumber, MonthNumber, MonthStart, 
   MonthEnd, January, February, March, April, May, 
   June, July, August, September, October, November, 
   December)
  VALUES ('December 2012', 2012, 12, '2012-12-01', 
   '2012-12-31', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1);
INSERT INTO ztblMonths
  (MonthYear, YearNumber, MonthNumber, MonthStart, 
   MonthEnd, January, February, March, April, May, 
   June, July, August, September, October, November, 
   December)
  VALUES ('January 2013', 2013, 1, '2013-01-01', '2013-01-31', 
   1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO ztblMonths
  (MonthYear, YearNumber, MonthNumber, MonthStart, 
   MonthEnd, January, February, March, April, May, 
   June, July, August, September, October, November, 
   December)
  VALUES ('February 2013', 2013, 2, '2013-02-01', '2013-02-28', 
   0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO ztblMonths
  (MonthYear, YearNumber, MonthNumber, MonthStart, 
   MonthEnd, January, February, March, April, May, 
   June, July, August, September, October, November, 
   December)
  VALUES ('March 2013', 2013, 3, '2013-03-01', '2013-03-31', 
   0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO ztblMonths
  (MonthYear, YearNumber, MonthNumber, MonthStart, 
   MonthEnd, January, February, March, April, May, 
   June, July, August, September, October, November, 
   December)
  VALUES ('April 2013', 2013, 4, '2013-04-01', '2013-04-30', 
   0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO ztblMonths
  (MonthYear, YearNumber, MonthNumber, MonthStart, 
   MonthEnd, January, February, March, April, May, 
   June, July, August, September, October, November, 
   December)
  VALUES ('May 2013', 2013, 5, '2013-05-01', '2013-05-31', 
   0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO ztblMonths
  (MonthYear, YearNumber, MonthNumber, MonthStart, 
   MonthEnd, January, February, March, April, May, 
   June, July, August, September, October, November, 
   December)
  VALUES ('June 2013', 2013, 6, '2013-06-01', '2013-06-30', 
   0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0);
INSERT INTO ztblMonths
  (MonthYear, YearNumber, MonthNumber, MonthStart, 
   MonthEnd, January, February, March, April, May, 
   June, July, August, September, October, November, 
   December)
  VALUES ('July 2013', 2013, 7, '2013-07-01', '2013-07-31', 
   0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0);
INSERT INTO ztblMonths
  (MonthYear, YearNumber, MonthNumber, MonthStart, 
   MonthEnd, January, February, March, April, May, 
   June, July, August, September, October, November, 
   December)
  VALUES ('August 2013', 2013, 8, '2013-08-01', '2013-08-31', 
   0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0);
INSERT INTO ztblMonths
  (MonthYear, YearNumber, MonthNumber, MonthStart, 
   MonthEnd, January, February, March, April, May, 
   June, July, August, September, October, November, 
   December)
  VALUES ('September 2013', 2013, 9, '2013-09-01', 
   '2013-09-30', 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0);
INSERT INTO ztblMonths
  (MonthYear, YearNumber, MonthNumber, MonthStart, 
   MonthEnd, January, February, March, April, May, 
   June, July, August, September, October, November, 
   December)
  VALUES ('October 2013', 2013, 10, '2013-10-01', '2013-10-31', 
   0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0);
INSERT INTO ztblMonths
  (MonthYear, YearNumber, MonthNumber, MonthStart, 
   MonthEnd, January, February, March, April, May, 
   June, July, August, September, October, November, 
   December)
  VALUES ('November 2013', 2013, 11, '2013-11-01', 
   '2013-11-30', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0);
INSERT INTO ztblMonths
  (MonthYear, YearNumber, MonthNumber, MonthStart, 
   MonthEnd, January, February, March, April, May, 
   June, July, August, September, October, November, 
   December)
  VALUES ('December 2013', 2013, 12, '2013-12-01', 
   '2013-12-31', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1);
INSERT INTO ztblMonths
  (MonthYear, YearNumber, MonthNumber, MonthStart, 
   MonthEnd, January, February, March, April, May, 
   June, July, August, September, October, November, 
   December)
  VALUES ('January 2014', 2014, 1, '2014-01-01', '2014-01-31', 
   1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO ztblMonths
  (MonthYear, YearNumber, MonthNumber, MonthStart, 
   MonthEnd, January, February, March, April, May, 
   June, July, August, September, October, November, 
   December)
  VALUES ('February 2014', 2014, 2, '2014-02-01', '2014-02-28', 
   0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO ztblMonths
  (MonthYear, YearNumber, MonthNumber, MonthStart, 
   MonthEnd, January, February, March, April, May, 
   June, July, August, September, October, November, 
   December)
  VALUES ('March 2014', 2014, 3, '2014-03-01', '2014-03-31', 
   0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO ztblMonths
  (MonthYear, YearNumber, MonthNumber, MonthStart, 
   MonthEnd, January, February, March, April, May, 
   June, July, August, September, October, November, 
   December)
  VALUES ('April 2014', 2014, 4, '2014-04-01', '2014-04-30', 
   0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO ztblMonths
  (MonthYear, YearNumber, MonthNumber, MonthStart, 
   MonthEnd, January, February, March, April, May, 
   June, July, August, September, October, November, 
   December)
  VALUES ('May 2014', 2014, 5, '2014-05-01', '2014-05-31', 
   0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO ztblMonths
  (MonthYear, YearNumber, MonthNumber, MonthStart, 
   MonthEnd, January, February, March, April, May, 
   June, July, August, September, October, November, 
   December)
  VALUES ('June 2014', 2014, 6, '2014-06-01', '2014-06-30', 
   0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0);
INSERT INTO ztblMonths
  (MonthYear, YearNumber, MonthNumber, MonthStart, 
   MonthEnd, January, February, March, April, May, 
   June, July, August, September, October, November, 
   December)
  VALUES ('July 2014', 2014, 7, '2014-07-01', '2014-07-31', 
   0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0);
INSERT INTO ztblMonths
  (MonthYear, YearNumber, MonthNumber, MonthStart, 
   MonthEnd, January, February, March, April, May, 
   June, July, August, September, October, November, 
   December)
  VALUES ('August 2014', 2014, 8, '2014-08-01', '2014-08-31', 
   0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0);
INSERT INTO ztblMonths
  (MonthYear, YearNumber, MonthNumber, MonthStart, 
   MonthEnd, January, February, March, April, May, 
   June, July, August, September, October, November, 
   December)
  VALUES ('September 2014', 2014, 9, '2014-09-01', 
   '2014-09-30', 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0);
INSERT INTO ztblMonths
  (MonthYear, YearNumber, MonthNumber, MonthStart, 
   MonthEnd, January, February, March, April, May, 
   June, July, August, September, October, November, 
   December)
  VALUES ('October 2014', 2014, 10, '2014-10-01', '2014-10-31', 
   0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0);
INSERT INTO ztblMonths
  (MonthYear, YearNumber, MonthNumber, MonthStart, 
   MonthEnd, January, February, March, April, May, 
   June, July, August, September, October, November, 
   December)
  VALUES ('November 2014', 2014, 11, '2014-11-01', 
   '2014-11-30', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0);
INSERT INTO ztblMonths
  (MonthYear, YearNumber, MonthNumber, MonthStart, 
   MonthEnd, January, February, March, April, May, 
   June, July, August, September, October, November, 
   December)
  VALUES ('December 2014', 2014, 12, '2014-12-01', 
   '2014-12-31', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1);
 
INSERT INTO ztblSkipLabels
  (LabelCount)
  VALUES (1);
INSERT INTO ztblSkipLabels
  (LabelCount)
  VALUES (2);
INSERT INTO ztblSkipLabels
  (LabelCount)
  VALUES (3);
INSERT INTO ztblSkipLabels
  (LabelCount)
  VALUES (4);
INSERT INTO ztblSkipLabels
  (LabelCount)
  VALUES (5);
INSERT INTO ztblSkipLabels
  (LabelCount)
  VALUES (6);
INSERT INTO ztblSkipLabels
  (LabelCount)
  VALUES (7);
INSERT INTO ztblSkipLabels
  (LabelCount)
  VALUES (8);
INSERT INTO ztblSkipLabels
  (LabelCount)
  VALUES (9);
INSERT INTO ztblSkipLabels
  (LabelCount)
  VALUES (10);
INSERT INTO ztblSkipLabels
  (LabelCount)
  VALUES (11);
INSERT INTO ztblSkipLabels
  (LabelCount)
  VALUES (12);
INSERT INTO ztblSkipLabels
  (LabelCount)
  VALUES (13);
INSERT INTO ztblSkipLabels
  (LabelCount)
  VALUES (14);
INSERT INTO ztblSkipLabels
  (LabelCount)
  VALUES (15);
INSERT INTO ztblSkipLabels
  (LabelCount)
  VALUES (16);
INSERT INTO ztblSkipLabels
  (LabelCount)
  VALUES (17);
INSERT INTO ztblSkipLabels
  (LabelCount)
  VALUES (18);
INSERT INTO ztblSkipLabels
  (LabelCount)
  VALUES (19);
INSERT INTO ztblSkipLabels
  (LabelCount)
  VALUES (20);
INSERT INTO ztblSkipLabels
  (LabelCount)
  VALUES (21);
INSERT INTO ztblSkipLabels
  (LabelCount)
  VALUES (22);
INSERT INTO ztblSkipLabels
  (LabelCount)
  VALUES (23);
INSERT INTO ztblSkipLabels
  (LabelCount)
  VALUES (24);
INSERT INTO ztblSkipLabels
  (LabelCount)
  VALUES (25);
INSERT INTO ztblSkipLabels
  (LabelCount)
  VALUES (26);
INSERT INTO ztblSkipLabels
  (LabelCount)
  VALUES (27);
INSERT INTO ztblSkipLabels
  (LabelCount)
  VALUES (28);
INSERT INTO ztblSkipLabels
  (LabelCount)
  VALUES (29);
INSERT INTO ztblSkipLabels
  (LabelCount)
  VALUES (30);
INSERT INTO ztblSkipLabels
  (LabelCount)
  VALUES (31);
INSERT INTO ztblSkipLabels
  (LabelCount)
  VALUES (32);
INSERT INTO ztblSkipLabels
  (LabelCount)
  VALUES (33);
INSERT INTO ztblSkipLabels
  (LabelCount)
  VALUES (34);
INSERT INTO ztblSkipLabels
  (LabelCount)
  VALUES (35);
INSERT INTO ztblSkipLabels
  (LabelCount)
  VALUES (36);
INSERT INTO ztblSkipLabels
  (LabelCount)
  VALUES (37);
INSERT INTO ztblSkipLabels
  (LabelCount)
  VALUES (38);
INSERT INTO ztblSkipLabels
  (LabelCount)
  VALUES (39);
INSERT INTO ztblSkipLabels
  (LabelCount)
  VALUES (40);
INSERT INTO ztblSkipLabels
  (LabelCount)
  VALUES (41);
INSERT INTO ztblSkipLabels
  (LabelCount)
  VALUES (42);
INSERT INTO ztblSkipLabels
  (LabelCount)
  VALUES (43);
INSERT INTO ztblSkipLabels
  (LabelCount)
  VALUES (44);
INSERT INTO ztblSkipLabels
  (LabelCount)
  VALUES (45);
INSERT INTO ztblSkipLabels
  (LabelCount)
  VALUES (46);
INSERT INTO ztblSkipLabels
  (LabelCount)
  VALUES (47);
INSERT INTO ztblSkipLabels
  (LabelCount)
  VALUES (48);
INSERT INTO ztblSkipLabels
  (LabelCount)
  VALUES (49);
INSERT INTO ztblSkipLabels
  (LabelCount)
  VALUES (50);
INSERT INTO ztblSkipLabels
  (LabelCount)
  VALUES (51);
INSERT INTO ztblSkipLabels
  (LabelCount)
  VALUES (52);
INSERT INTO ztblSkipLabels
  (LabelCount)
  VALUES (53);
INSERT INTO ztblSkipLabels
  (LabelCount)
  VALUES (54);
INSERT INTO ztblSkipLabels
  (LabelCount)
  VALUES (55);
INSERT INTO ztblSkipLabels
  (LabelCount)
  VALUES (56);
INSERT INTO ztblSkipLabels
  (LabelCount)
  VALUES (57);
INSERT INTO ztblSkipLabels
  (LabelCount)
  VALUES (58);
INSERT INTO ztblSkipLabels
  (LabelCount)
  VALUES (59);
INSERT INTO ztblSkipLabels
  (LabelCount)
  VALUES (60);
 
INSERT INTO ztblWeeks
  (WeekStart, WeekEnd)
  VALUES ('2012-01-01', '2012-01-07');
INSERT INTO ztblWeeks
  (WeekStart, WeekEnd)
  VALUES ('2012-01-08', '2012-01-14');
INSERT INTO ztblWeeks
  (WeekStart, WeekEnd)
  VALUES ('2012-01-15', '2012-01-21');
INSERT INTO ztblWeeks
  (WeekStart, WeekEnd)
  VALUES ('2012-01-22', '2012-01-28');
INSERT INTO ztblWeeks
  (WeekStart, WeekEnd)
  VALUES ('2012-01-29', '2012-02-04');
INSERT INTO ztblWeeks
  (WeekStart, WeekEnd)
  VALUES ('2012-02-05', '2012-02-11');
INSERT INTO ztblWeeks
  (WeekStart, WeekEnd)
  VALUES ('2012-02-12', '2012-02-18');
INSERT INTO ztblWeeks
  (WeekStart, WeekEnd)
  VALUES ('2012-02-19', '2012-02-25');
INSERT INTO ztblWeeks
  (WeekStart, WeekEnd)
  VALUES ('2012-02-26', '2012-03-03');
INSERT INTO ztblWeeks
  (WeekStart, WeekEnd)
  VALUES ('2012-03-04', '2012-03-10');
INSERT INTO ztblWeeks
  (WeekStart, WeekEnd)
  VALUES ('2012-03-11', '2012-03-17');
INSERT INTO ztblWeeks
  (WeekStart, WeekEnd)
  VALUES ('2012-03-18', '2012-03-24');
INSERT INTO ztblWeeks
  (WeekStart, WeekEnd)
  VALUES ('2012-03-25', '2012-03-31');
INSERT INTO ztblWeeks
  (WeekStart, WeekEnd)
  VALUES ('2012-04-01', '2012-04-07');
INSERT INTO ztblWeeks
  (WeekStart, WeekEnd)
  VALUES ('2012-04-08', '2012-04-14');
INSERT INTO ztblWeeks
  (WeekStart, WeekEnd)
  VALUES ('2012-04-15', '2012-04-21');
INSERT INTO ztblWeeks
  (WeekStart, WeekEnd)
  VALUES ('2012-04-22', '2012-04-28');
INSERT INTO ztblWeeks
  (WeekStart, WeekEnd)
  VALUES ('2012-04-29', '2012-05-05');
INSERT INTO ztblWeeks
  (WeekStart, WeekEnd)
  VALUES ('2012-05-06', '2012-05-12');
INSERT INTO ztblWeeks
  (WeekStart, WeekEnd)
  VALUES ('2012-05-13', '2012-05-19');
INSERT INTO ztblWeeks
  (WeekStart, WeekEnd)
  VALUES ('2012-05-20', '2012-05-26');
INSERT INTO ztblWeeks
  (WeekStart, WeekEnd)
  VALUES ('2012-05-27', '2012-06-02');
INSERT INTO ztblWeeks
  (WeekStart, WeekEnd)
  VALUES ('2012-06-03', '2012-06-09');
INSERT INTO ztblWeeks
  (WeekStart, WeekEnd)
  VALUES ('2012-06-10', '2012-06-16');
INSERT INTO ztblWeeks
  (WeekStart, WeekEnd)
  VALUES ('2012-06-17', '2012-06-23');
INSERT INTO ztblWeeks
  (WeekStart, WeekEnd)
  VALUES ('2012-06-24', '2012-06-30');
INSERT INTO ztblWeeks
  (WeekStart, WeekEnd)
  VALUES ('2012-07-01', '2012-07-07');
INSERT INTO ztblWeeks
  (WeekStart, WeekEnd)
  VALUES ('2012-07-08', '2012-07-14');
INSERT INTO ztblWeeks
  (WeekStart, WeekEnd)
  VALUES ('2012-07-15', '2012-07-21');
INSERT INTO ztblWeeks
  (WeekStart, WeekEnd)
  VALUES ('2012-07-22', '2012-07-28');
INSERT INTO ztblWeeks
  (WeekStart, WeekEnd)
  VALUES ('2012-07-29', '2012-08-04');
INSERT INTO ztblWeeks
  (WeekStart, WeekEnd)
  VALUES ('2012-08-05', '2012-08-11');
INSERT INTO ztblWeeks
  (WeekStart, WeekEnd)
  VALUES ('2012-08-12', '2012-08-18');
INSERT INTO ztblWeeks
  (WeekStart, WeekEnd)
  VALUES ('2012-08-19', '2012-08-25');
INSERT INTO ztblWeeks
  (WeekStart, WeekEnd)
  VALUES ('2012-08-26', '2012-09-01');
INSERT INTO ztblWeeks
  (WeekStart, WeekEnd)
  VALUES ('2012-09-02', '2012-09-08');
INSERT INTO ztblWeeks
  (WeekStart, WeekEnd)
  VALUES ('2012-09-09', '2012-09-15');
INSERT INTO ztblWeeks
  (WeekStart, WeekEnd)
  VALUES ('2012-09-16', '2012-09-22');
INSERT INTO ztblWeeks
  (WeekStart, WeekEnd)
  VALUES ('2012-09-23', '2012-09-29');
INSERT INTO ztblWeeks
  (WeekStart, WeekEnd)
  VALUES ('2012-09-30', '2012-10-06');
INSERT INTO ztblWeeks
  (WeekStart, WeekEnd)
  VALUES ('2012-10-07', '2012-10-13');
INSERT INTO ztblWeeks
  (WeekStart, WeekEnd)
  VALUES ('2012-10-14', '2012-10-20');
INSERT INTO ztblWeeks
  (WeekStart, WeekEnd)
  VALUES ('2012-10-21', '2012-10-27');
INSERT INTO ztblWeeks
  (WeekStart, WeekEnd)
  VALUES ('2012-10-28', '2012-11-03');
INSERT INTO ztblWeeks
  (WeekStart, WeekEnd)
  VALUES ('2012-11-04', '2012-11-10');
INSERT INTO ztblWeeks
  (WeekStart, WeekEnd)
  VALUES ('2012-11-11', '2012-11-17');
INSERT INTO ztblWeeks
  (WeekStart, WeekEnd)
  VALUES ('2012-11-18', '2012-11-24');
INSERT INTO ztblWeeks
  (WeekStart, WeekEnd)
  VALUES ('2012-11-25', '2012-12-01');
INSERT INTO ztblWeeks
  (WeekStart, WeekEnd)
  VALUES ('2012-12-02', '2012-12-08');
INSERT INTO ztblWeeks
  (WeekStart, WeekEnd)
  VALUES ('2012-12-09', '2012-12-15');
INSERT INTO ztblWeeks
  (WeekStart, WeekEnd)
  VALUES ('2012-12-16', '2012-12-22');
INSERT INTO ztblWeeks
  (WeekStart, WeekEnd)
  VALUES ('2012-12-23', '2012-12-29');
INSERT INTO ztblWeeks
  (WeekStart, WeekEnd)
  VALUES ('2012-12-30', '2013-01-05');
INSERT INTO ztblWeeks
  (WeekStart, WeekEnd)
  VALUES ('2013-01-06', '2013-01-12');
INSERT INTO ztblWeeks
  (WeekStart, WeekEnd)
  VALUES ('2013-01-13', '2013-01-19');
INSERT INTO ztblWeeks
  (WeekStart, WeekEnd)
  VALUES ('2013-01-20', '2013-01-26');
INSERT INTO ztblWeeks
  (WeekStart, WeekEnd)
  VALUES ('2013-01-27', '2013-02-02');
INSERT INTO ztblWeeks
  (WeekStart, WeekEnd)
  VALUES ('2013-02-03', '2013-02-09');
INSERT INTO ztblWeeks
  (WeekStart, WeekEnd)
  VALUES ('2013-02-10', '2013-02-16');
INSERT INTO ztblWeeks
  (WeekStart, WeekEnd)
  VALUES ('2013-02-17', '2013-02-23');
INSERT INTO ztblWeeks
  (WeekStart, WeekEnd)
  VALUES ('2013-02-24', '2013-03-02');
INSERT INTO ztblWeeks
  (WeekStart, WeekEnd)
  VALUES ('2013-03-03', '2013-03-09');
INSERT INTO ztblWeeks
  (WeekStart, WeekEnd)
  VALUES ('2013-03-10', '2013-03-16');
INSERT INTO ztblWeeks
  (WeekStart, WeekEnd)
  VALUES ('2013-03-17', '2013-03-23');
INSERT INTO ztblWeeks
  (WeekStart, WeekEnd)
  VALUES ('2013-03-24', '2013-03-30');
INSERT INTO ztblWeeks
  (WeekStart, WeekEnd)
  VALUES ('2013-03-31', '2013-04-06');
INSERT INTO ztblWeeks
  (WeekStart, WeekEnd)
  VALUES ('2013-04-07', '2013-04-13');
INSERT INTO ztblWeeks
  (WeekStart, WeekEnd)
  VALUES ('2013-04-14', '2013-04-20');
INSERT INTO ztblWeeks
  (WeekStart, WeekEnd)
  VALUES ('2013-04-21', '2013-04-27');
INSERT INTO ztblWeeks
  (WeekStart, WeekEnd)
  VALUES ('2013-04-28', '2013-05-04');
INSERT INTO ztblWeeks
  (WeekStart, WeekEnd)
  VALUES ('2013-05-05', '2013-05-11');
INSERT INTO ztblWeeks
  (WeekStart, WeekEnd)
  VALUES ('2013-05-12', '2013-05-18');
INSERT INTO ztblWeeks
  (WeekStart, WeekEnd)
  VALUES ('2013-05-19', '2013-05-25');
INSERT INTO ztblWeeks
  (WeekStart, WeekEnd)
  VALUES ('2013-05-26', '2013-06-01');
INSERT INTO ztblWeeks
  (WeekStart, WeekEnd)
  VALUES ('2013-06-02', '2013-06-08');
INSERT INTO ztblWeeks
  (WeekStart, WeekEnd)
  VALUES ('2013-06-09', '2013-06-15');
INSERT INTO ztblWeeks
  (WeekStart, WeekEnd)
  VALUES ('2013-06-16', '2013-06-22');
INSERT INTO ztblWeeks
  (WeekStart, WeekEnd)
  VALUES ('2013-06-23', '2013-06-29');
INSERT INTO ztblWeeks
  (WeekStart, WeekEnd)
  VALUES ('2013-06-30', '2013-07-06');
INSERT INTO ztblWeeks
  (WeekStart, WeekEnd)
  VALUES ('2013-07-07', '2013-07-13');
INSERT INTO ztblWeeks
  (WeekStart, WeekEnd)
  VALUES ('2013-07-14', '2013-07-20');
INSERT INTO ztblWeeks
  (WeekStart, WeekEnd)
  VALUES ('2013-07-21', '2013-07-27');
INSERT INTO ztblWeeks
  (WeekStart, WeekEnd)
  VALUES ('2013-07-28', '2013-08-03');
INSERT INTO ztblWeeks
  (WeekStart, WeekEnd)
  VALUES ('2013-08-04', '2013-08-10');
INSERT INTO ztblWeeks
  (WeekStart, WeekEnd)
  VALUES ('2013-08-11', '2013-08-17');
INSERT INTO ztblWeeks
  (WeekStart, WeekEnd)
  VALUES ('2013-08-18', '2013-08-24');
INSERT INTO ztblWeeks
  (WeekStart, WeekEnd)
  VALUES ('2013-08-25', '2013-08-31');
INSERT INTO ztblWeeks
  (WeekStart, WeekEnd)
  VALUES ('2013-09-01', '2013-09-07');
INSERT INTO ztblWeeks
  (WeekStart, WeekEnd)
  VALUES ('2013-09-08', '2013-09-14');
INSERT INTO ztblWeeks
  (WeekStart, WeekEnd)
  VALUES ('2013-09-15', '2013-09-21');
INSERT INTO ztblWeeks
  (WeekStart, WeekEnd)
  VALUES ('2013-09-22', '2013-09-28');
INSERT INTO ztblWeeks
  (WeekStart, WeekEnd)
  VALUES ('2013-09-29', '2013-10-05');
INSERT INTO ztblWeeks
  (WeekStart, WeekEnd)
  VALUES ('2013-10-06', '2013-10-12');
INSERT INTO ztblWeeks
  (WeekStart, WeekEnd)
  VALUES ('2013-10-13', '2013-10-19');
INSERT INTO ztblWeeks
  (WeekStart, WeekEnd)
  VALUES ('2013-10-20', '2013-10-26');
INSERT INTO ztblWeeks
  (WeekStart, WeekEnd)
  VALUES ('2013-10-27', '2013-11-02');
INSERT INTO ztblWeeks
  (WeekStart, WeekEnd)
  VALUES ('2013-11-03', '2013-11-09');
INSERT INTO ztblWeeks
  (WeekStart, WeekEnd)
  VALUES ('2013-11-10', '2013-11-16');
INSERT INTO ztblWeeks
  (WeekStart, WeekEnd)
  VALUES ('2013-11-17', '2013-11-23');
INSERT INTO ztblWeeks
  (WeekStart, WeekEnd)
  VALUES ('2013-11-24', '2013-11-30');
INSERT INTO ztblWeeks
  (WeekStart, WeekEnd)
  VALUES ('2013-12-01', '2013-12-07');
INSERT INTO ztblWeeks
  (WeekStart, WeekEnd)
  VALUES ('2013-12-08', '2013-12-14');
INSERT INTO ztblWeeks
  (WeekStart, WeekEnd)
  VALUES ('2013-12-15', '2013-12-21');
INSERT INTO ztblWeeks
  (WeekStart, WeekEnd)
  VALUES ('2013-12-22', '2013-12-28');
INSERT INTO ztblWeeks
  (WeekStart, WeekEnd)
  VALUES ('2013-12-29', '2014-01-04');
INSERT INTO ztblWeeks
  (WeekStart, WeekEnd)
  VALUES ('2014-01-05', '2014-01-11');
INSERT INTO ztblWeeks
  (WeekStart, WeekEnd)
  VALUES ('2014-01-12', '2014-01-18');
INSERT INTO ztblWeeks
  (WeekStart, WeekEnd)
  VALUES ('2014-01-19', '2014-01-25');
INSERT INTO ztblWeeks
  (WeekStart, WeekEnd)
  VALUES ('2014-01-26', '2014-02-01');
INSERT INTO ztblWeeks
  (WeekStart, WeekEnd)
  VALUES ('2014-02-02', '2014-02-08');
INSERT INTO ztblWeeks
  (WeekStart, WeekEnd)
  VALUES ('2014-02-09', '2014-02-15');
INSERT INTO ztblWeeks
  (WeekStart, WeekEnd)
  VALUES ('2014-02-16', '2014-02-22');
INSERT INTO ztblWeeks
  (WeekStart, WeekEnd)
  VALUES ('2014-02-23', '2014-03-01');
INSERT INTO ztblWeeks
  (WeekStart, WeekEnd)
  VALUES ('2014-03-02', '2014-03-08');
INSERT INTO ztblWeeks
  (WeekStart, WeekEnd)
  VALUES ('2014-03-09', '2014-03-15');
INSERT INTO ztblWeeks
  (WeekStart, WeekEnd)
  VALUES ('2014-03-16', '2014-03-22');
INSERT INTO ztblWeeks
  (WeekStart, WeekEnd)
  VALUES ('2014-03-23', '2014-03-29');
INSERT INTO ztblWeeks
  (WeekStart, WeekEnd)
  VALUES ('2014-03-30', '2014-04-05');
INSERT INTO ztblWeeks
  (WeekStart, WeekEnd)
  VALUES ('2014-04-06', '2014-04-12');
INSERT INTO ztblWeeks
  (WeekStart, WeekEnd)
  VALUES ('2014-04-13', '2014-04-19');
INSERT INTO ztblWeeks
  (WeekStart, WeekEnd)
  VALUES ('2014-04-20', '2014-04-26');
INSERT INTO ztblWeeks
  (WeekStart, WeekEnd)
  VALUES ('2014-04-27', '2014-05-03');
INSERT INTO ztblWeeks
  (WeekStart, WeekEnd)
  VALUES ('2014-05-04', '2014-05-10');
INSERT INTO ztblWeeks
  (WeekStart, WeekEnd)
  VALUES ('2014-05-11', '2014-05-17');
INSERT INTO ztblWeeks
  (WeekStart, WeekEnd)
  VALUES ('2014-05-18', '2014-05-24');
INSERT INTO ztblWeeks
  (WeekStart, WeekEnd)
  VALUES ('2014-05-25', '2014-05-31');
INSERT INTO ztblWeeks
  (WeekStart, WeekEnd)
  VALUES ('2014-06-01', '2014-06-07');
INSERT INTO ztblWeeks
  (WeekStart, WeekEnd)
  VALUES ('2014-06-08', '2014-06-14');
INSERT INTO ztblWeeks
  (WeekStart, WeekEnd)
  VALUES ('2014-06-15', '2014-06-21');
INSERT INTO ztblWeeks
  (WeekStart, WeekEnd)
  VALUES ('2014-06-22', '2014-06-28');
INSERT INTO ztblWeeks
  (WeekStart, WeekEnd)
  VALUES ('2014-06-29', '2014-07-05');
INSERT INTO ztblWeeks
  (WeekStart, WeekEnd)
  VALUES ('2014-07-06', '2014-07-12');
INSERT INTO ztblWeeks
  (WeekStart, WeekEnd)
  VALUES ('2014-07-13', '2014-07-19');
INSERT INTO ztblWeeks
  (WeekStart, WeekEnd)
  VALUES ('2014-07-20', '2014-07-26');
INSERT INTO ztblWeeks
  (WeekStart, WeekEnd)
  VALUES ('2014-07-27', '2014-08-02');
INSERT INTO ztblWeeks
  (WeekStart, WeekEnd)
  VALUES ('2014-08-03', '2014-08-09');
INSERT INTO ztblWeeks
  (WeekStart, WeekEnd)
  VALUES ('2014-08-10', '2014-08-16');
INSERT INTO ztblWeeks
  (WeekStart, WeekEnd)
  VALUES ('2014-08-17', '2014-08-23');
INSERT INTO ztblWeeks
  (WeekStart, WeekEnd)
  VALUES ('2014-08-24', '2014-08-30');
INSERT INTO ztblWeeks
  (WeekStart, WeekEnd)
  VALUES ('2014-08-31', '2014-09-06');
INSERT INTO ztblWeeks
  (WeekStart, WeekEnd)
  VALUES ('2014-09-07', '2014-09-13');
INSERT INTO ztblWeeks
  (WeekStart, WeekEnd)
  VALUES ('2014-09-14', '2014-09-20');
INSERT INTO ztblWeeks
  (WeekStart, WeekEnd)
  VALUES ('2014-09-21', '2014-09-27');
INSERT INTO ztblWeeks
  (WeekStart, WeekEnd)
  VALUES ('2014-09-28', '2014-10-04');
INSERT INTO ztblWeeks
  (WeekStart, WeekEnd)
  VALUES ('2014-10-05', '2014-10-11');
INSERT INTO ztblWeeks
  (WeekStart, WeekEnd)
  VALUES ('2014-10-12', '2014-10-18');
INSERT INTO ztblWeeks
  (WeekStart, WeekEnd)
  VALUES ('2014-10-19', '2014-10-25');
INSERT INTO ztblWeeks
  (WeekStart, WeekEnd)
  VALUES ('2014-10-26', '2014-11-01');
INSERT INTO ztblWeeks
  (WeekStart, WeekEnd)
  VALUES ('2014-11-02', '2014-11-08');
INSERT INTO ztblWeeks
  (WeekStart, WeekEnd)
  VALUES ('2014-11-09', '2014-11-15');
INSERT INTO ztblWeeks
  (WeekStart, WeekEnd)
  VALUES ('2014-11-16', '2014-11-22');
INSERT INTO ztblWeeks
  (WeekStart, WeekEnd)
  VALUES ('2014-11-23', '2014-11-29');
INSERT INTO ztblWeeks
  (WeekStart, WeekEnd)
  VALUES ('2014-11-30', '2014-12-06');
INSERT INTO ztblWeeks
  (WeekStart, WeekEnd)
  VALUES ('2014-12-07', '2014-12-13');
INSERT INTO ztblWeeks
  (WeekStart, WeekEnd)
  VALUES ('2014-12-14', '2014-12-20');
INSERT INTO ztblWeeks
  (WeekStart, WeekEnd)
  VALUES ('2014-12-21', '2014-12-27');
 
GO

USE EntertainmentAgencyModify;
SET IDENTITY_INSERT Customers ON
GO
INSERT INTO Customers
  (CustomerID, CustFirstName, CustLastName, CustStreetAddress, 
   CustCity, CustState, CustZipCode, CustPhoneNumber)
  VALUES (10001, 'Doris', 'Hartwig', '4726 - 11th Ave. N.E.', 
   'Seattle', 'WA', '98105', '555-2671');
INSERT INTO Customers
  (CustomerID, CustFirstName, CustLastName, CustStreetAddress, 
   CustCity, CustState, CustZipCode, CustPhoneNumber)
  VALUES (10002, 'Deb', 'Waldal', '908 W. Capital Way', 
   'Tacoma', 'WA', '98413', '555-2496');
INSERT INTO Customers
  (CustomerID, CustFirstName, CustLastName, CustStreetAddress, 
   CustCity, CustState, CustZipCode, CustPhoneNumber)
  VALUES (10003, 'Peter', 'Brehm', '722 Moss Bay Blvd.', 
   'Kirkland', 'WA', '98033', '555-2501');
INSERT INTO Customers
  (CustomerID, CustFirstName, CustLastName, CustStreetAddress, 
   CustCity, CustState, CustZipCode, CustPhoneNumber)
  VALUES (10004, 'Dean', 'McCrae', '4110 Old Redmond Rd.', 
   'Redmond', 'WA', '98052', '555-2506');
INSERT INTO Customers
  (CustomerID, CustFirstName, CustLastName, CustStreetAddress, 
   CustCity, CustState, CustZipCode, CustPhoneNumber)
  VALUES (10005, 'Elizabeth', 'Hallmark', 'Route 2, Box 203B', 
   'Auburn', 'WA', '98002', '555-2521');
INSERT INTO Customers
  (CustomerID, CustFirstName, CustLastName, CustStreetAddress, 
   CustCity, CustState, CustZipCode, CustPhoneNumber)
  VALUES (10006, 'Matt', 'Berg', '908 W. Capital Way', 
   'Tacoma', 'WA', '98413', '555-2581');
INSERT INTO Customers
  (CustomerID, CustFirstName, CustLastName, CustStreetAddress, 
   CustCity, CustState, CustZipCode, CustPhoneNumber)
  VALUES (10007, 'Liz', 'Keyser', '13920 S.E. 40th Street', 
   'Bellevue', 'WA', '98006', '555-2556');
INSERT INTO Customers
  (CustomerID, CustFirstName, CustLastName, CustStreetAddress, 
   CustCity, CustState, CustZipCode, CustPhoneNumber)
  VALUES (10008, 'Darren', 'Gehring', '2601 Seaview Lane', 
   'Kirkland', 'WA', '98033', '555-2616');
INSERT INTO Customers
  (CustomerID, CustFirstName, CustLastName, CustStreetAddress, 
   CustCity, CustState, CustZipCode, CustPhoneNumber)
  VALUES (10009, 'Sarah', 'Thompson', '2222 Springer Road', 
   'Bellevue', 'WA', '98006', '555-2626');
INSERT INTO Customers
  (CustomerID, CustFirstName, CustLastName, CustStreetAddress, 
   CustCity, CustState, CustZipCode, CustPhoneNumber)
  VALUES (10010, 'Zachary', 'Ehrlich', '12330 Kingman Drive', 
   'Kirkland', 'WA', '98033', '555-2721');
INSERT INTO Customers
  (CustomerID, CustFirstName, CustLastName, CustStreetAddress, 
   CustCity, CustState, CustZipCode, CustPhoneNumber)
  VALUES (10011, 'Joyce', 'Bonnicksen', '2424 Thames Drive', 
   'Bellevue', 'WA', '98006', '555-2726');
INSERT INTO Customers
  (CustomerID, CustFirstName, CustLastName, CustStreetAddress, 
   CustCity, CustState, CustZipCode, CustPhoneNumber)
  VALUES (10012, 'Kerry', 'Patterson', '777 Fenexet Blvd', 
   'Redmond', 'WA', '98052', '555-0399');
INSERT INTO Customers
  (CustomerID, CustFirstName, CustLastName, CustStreetAddress, 
   CustCity, CustState, CustZipCode, CustPhoneNumber)
  VALUES (10013, 'Estella', 'Pundt', '2500 Rosales Lane', 
   'Bellevue', 'WA', '98006', '555-9938');
INSERT INTO Customers
  (CustomerID, CustFirstName, CustLastName, CustStreetAddress, 
   CustCity, CustState, CustZipCode, CustPhoneNumber)
  VALUES (10014, 'Mark', 'Rosales', '323 Advocate Lane', 
   'Bellevue', 'WA', '98006', '555-2286');
INSERT INTO Customers
  (CustomerID, CustFirstName, CustLastName, CustStreetAddress, 
   CustCity, CustState, CustZipCode, CustPhoneNumber)
  VALUES (10015, 'Carol', 'Viescas', '754 Fourth Ave', 
   'Seattle', 'WA', '98115', '555-2296');
SET IDENTITY_INSERT Customers OFF
GO
SET IDENTITY_INSERT Entertainers ON
GO
INSERT INTO Entertainers
  (EntertainerID, EntStageName, EntSSN, EntStreetAddress, 
   EntCity, EntState, EntZipCode, EntPhoneNumber, EntWebPage, 
   EntEMailAddress, DateEntered, EntPricePerDay)
  VALUES (1001, 'Carol Peacock Trio', '888-90-1121', 
   '4110 Old Redmond Rd.', 'Redmond', 'WA', '98052', 
   '555-2691', 'www.cptrio.com', 'carolp@cptrio.com', 
   '1997-05-24', 175);
INSERT INTO Entertainers
  (EntertainerID, EntStageName, EntSSN, EntStreetAddress, 
   EntCity, EntState, EntZipCode, EntPhoneNumber, EntWebPage, 
   EntEMailAddress, DateEntered, EntPricePerDay)
  VALUES (1002, 'Topazz', '888-50-1061', '16 Maple Lane', 
   'Auburn', 'WA', '98002', '555-2591', 'www.topazz.com', 
   NULL, '1996-02-14', 120);
INSERT INTO Entertainers
  (EntertainerID, EntStageName, EntSSN, EntStreetAddress, 
   EntCity, EntState, EntZipCode, EntPhoneNumber, EntWebPage, 
   EntEMailAddress, DateEntered, EntPricePerDay)
  VALUES (1003, 'JV & the Deep Six', '888-18-1013', 
   '15127 NE 24th, #383', 'Redmond', 'WA', '98052', 
   '555-2511', 'www.jvd6.com', 'jv@myspring.com', '1998-03-18', 
   275);
INSERT INTO Entertainers
  (EntertainerID, EntStageName, EntSSN, EntStreetAddress, 
   EntCity, EntState, EntZipCode, EntPhoneNumber, EntWebPage, 
   EntEMailAddress, DateEntered, EntPricePerDay)
  VALUES (1004, 'Jim Glynn', '888-26-1025', '13920 S.E. 40th Street', 
   'Bellevue', 'WA', '98009', '555-2531', NULL, NULL, 
   '1996-04-01', 60);
INSERT INTO Entertainers
  (EntertainerID, EntStageName, EntSSN, EntStreetAddress, 
   EntCity, EntState, EntZipCode, EntPhoneNumber, EntWebPage, 
   EntEMailAddress, DateEntered, EntPricePerDay)
  VALUES (1005, 'Jazz Persuasion', '888-30-1031', '233 West Valley Hwy', 
   'Bellevue', 'WA', '98005', '555-2541', 'www.jazzper.com', 
   NULL, '1997-05-12', 125);
INSERT INTO Entertainers
  (EntertainerID, EntStageName, EntSSN, EntStreetAddress, 
   EntCity, EntState, EntZipCode, EntPhoneNumber, EntWebPage, 
   EntEMailAddress, DateEntered, EntPricePerDay)
  VALUES (1006, 'Modern Dance', '888-66-1085', 'Route 2, Box 203B', 
   'Woodinville', 'WA', '98072', '555-2631', 'www.moderndance.com', 
   'mikeh@moderndance.com', '1995-05-16', 250);
INSERT INTO Entertainers
  (EntertainerID, EntStageName, EntSSN, EntStreetAddress, 
   EntCity, EntState, EntZipCode, EntPhoneNumber, EntWebPage, 
   EntEMailAddress, DateEntered, EntPricePerDay)
  VALUES (1007, 'Coldwater Cattle Company', '888-38-1043', 
   '4726 - 11th Ave. N.E.', 'Seattle', 'WA', '98105', 
   '555-2561', 'www.coldwatercows.com', NULL, '1995-11-30', 
   275);
INSERT INTO Entertainers
  (EntertainerID, EntStageName, EntSSN, EntStreetAddress, 
   EntCity, EntState, EntZipCode, EntPhoneNumber, EntWebPage, 
   EntEMailAddress, DateEntered, EntPricePerDay)
  VALUES (1008, 'Country Feeling', '888-98-1133', 'PO Box 223311', 
   'Seattle', 'WA', '98125', '555-2711', NULL, NULL, 
   '1996-02-28', 280);
INSERT INTO Entertainers
  (EntertainerID, EntStageName, EntSSN, EntStreetAddress, 
   EntCity, EntState, EntZipCode, EntPhoneNumber, EntWebPage, 
   EntEMailAddress, DateEntered, EntPricePerDay)
  VALUES (1009, 'Katherine Ehrlich', '888-61-1103', 
   '777 Fenexet Blvd', 'Woodinville', 'WA', '98072', 
   '555-0399', NULL, 'ke@mzo.com', '1998-09-13', 145);
INSERT INTO Entertainers
  (EntertainerID, EntStageName, EntSSN, EntStreetAddress, 
   EntCity, EntState, EntZipCode, EntPhoneNumber, EntWebPage, 
   EntEMailAddress, DateEntered, EntPricePerDay)
  VALUES (1010, 'Saturday Revue', '888-64-1109', '3887 Easy Street', 
   'Seattle', 'WA', '98125', '555-0039', 'www.satrevue.com', 
   'edz@coolness.com', '1995-01-20', 250);
INSERT INTO Entertainers
  (EntertainerID, EntStageName, EntSSN, EntStreetAddress, 
   EntCity, EntState, EntZipCode, EntPhoneNumber, EntWebPage, 
   EntEMailAddress, DateEntered, EntPricePerDay)
  VALUES (1011, 'Julia Schnebly', '888-65-1111', '2343 Harmony Lane', 
   'Seattle', 'WA', '99837', '555-9936', NULL, NULL, 
   '1996-04-12', 90);
INSERT INTO Entertainers
  (EntertainerID, EntStageName, EntSSN, EntStreetAddress, 
   EntCity, EntState, EntZipCode, EntPhoneNumber, EntWebPage, 
   EntEMailAddress, DateEntered, EntPricePerDay)
  VALUES (1012, 'Susan McLain', '888-70-1121', '511 Lenora Ave', 
   'Bellevue', 'WA', '98006', '555-2301', 'www.greensleeves.com', 
   'susan@gs.com', '1998-10-12', 75);
INSERT INTO Entertainers
  (EntertainerID, EntStageName, EntSSN, EntStreetAddress, 
   EntCity, EntState, EntZipCode, EntPhoneNumber, EntWebPage, 
   EntEMailAddress, DateEntered, EntPricePerDay)
  VALUES (1013, 'Caroline Coie Cuartet', '888-71-1123', 
   '298 Forest Lane', 'Auburn', 'WA', '98002', '555-2306', 
   NULL, 'carolinec@willow.com', '1997-07-11', 250);
SET IDENTITY_INSERT Entertainers OFF
GO
SET IDENTITY_INSERT Agents ON
GO
INSERT INTO Agents
  (AgentID, AgtFirstName, AgtLastName, AgtStreetAddress, 
   AgtCity, AgtState, AgtZipCode, AgtPhoneNumber, DateHired, 
   Salary, CommissionRate)
  VALUES (1, 'William', 'Thompson', '122 Spring River Drive', 
   'Redmond', 'WA', '98053', '555-2681', '1997-05-15', 
   35000, 0.04);
INSERT INTO Agents
  (AgentID, AgtFirstName, AgtLastName, AgtStreetAddress, 
   AgtCity, AgtState, AgtZipCode, AgtPhoneNumber, DateHired, 
   Salary, CommissionRate)
  VALUES (2, 'Scott', 'Bishop', '66 Spring Valley Drive', 
   'Seattle', 'WA', '98125', '555-2666', '1998-02-05', 
   27000, 0.04);
INSERT INTO Agents
  (AgentID, AgtFirstName, AgtLastName, AgtStreetAddress, 
   AgtCity, AgtState, AgtZipCode, AgtPhoneNumber, DateHired, 
   Salary, CommissionRate)
  VALUES (3, 'Carol', 'Viescas', '667 Red River Road', 
   'Bellevue', 'WA', '98006', '555-2571', '1997-11-19', 
   30000, 0.05);
INSERT INTO Agents
  (AgentID, AgtFirstName, AgtLastName, AgtStreetAddress, 
   AgtCity, AgtState, AgtZipCode, AgtPhoneNumber, DateHired, 
   Salary, CommissionRate)
  VALUES (4, 'Karen', 'Smith', '30301 - 166th Ave. N.E.', 
   'Seattle', 'WA', '98125', '555-2551', '1998-03-05', 
   22000, 0.055);
INSERT INTO Agents
  (AgentID, AgtFirstName, AgtLastName, AgtStreetAddress, 
   AgtCity, AgtState, AgtZipCode, AgtPhoneNumber, DateHired, 
   Salary, CommissionRate)
  VALUES (5, 'Marianne', 'Wier', '908 W. Capital Way', 
   'Tacoma', 'WA', '98413', '555-2606', '1998-02-02', 
   24500, 0.045);
INSERT INTO Agents
  (AgentID, AgtFirstName, AgtLastName, AgtStreetAddress, 
   AgtCity, AgtState, AgtZipCode, AgtPhoneNumber, DateHired, 
   Salary, CommissionRate)
  VALUES (6, 'John', 'Kennedy', '16679 NE 41st Court', 
   'Seattle', 'WA', '98125', '555-2621', '1997-05-15', 
   33000, 0.06);
INSERT INTO Agents
  (AgentID, AgtFirstName, AgtLastName, AgtStreetAddress, 
   AgtCity, AgtState, AgtZipCode, AgtPhoneNumber, DateHired, 
   Salary, CommissionRate)
  VALUES (7, 'Caleb', 'Viescas', '4501 Wetland Road', 
   'Redmond', 'WA', '98052', '555-0037', '1998-02-16', 
   22100, 0.035);
INSERT INTO Agents
  (AgentID, AgtFirstName, AgtLastName, AgtStreetAddress, 
   AgtCity, AgtState, AgtZipCode, AgtPhoneNumber, DateHired, 
   Salary, CommissionRate)
  VALUES (8, 'Maria', 'Patterson', '3445 Cheyenne Road', 
   'Bellevue', 'WA', '98006', '555-2291', '1997-09-03', 
   30000, 0.04);
INSERT INTO Agents
  (AgentID, AgtFirstName, AgtLastName, AgtStreetAddress, 
   AgtCity, AgtState, AgtZipCode, AgtPhoneNumber, DateHired, 
   Salary, CommissionRate)
  VALUES (9, 'Daffy', 'Dumbwit', '1234 Main Street', 
   'Kirkland', 'WA', '98033', '555-1234', '2000-02-05', 
   50, 0.01);
SET IDENTITY_INSERT Agents OFF
GO
SET IDENTITY_INSERT Engagements ON
GO
INSERT INTO Engagements
  (EngagementNumber, StartDate, EndDate, StartTime, 
   StopTime, ContractPrice, CustomerID, AgentID, EntertainerID)
  VALUES (2, '2012-09-01', '2012-09-05', '13:00:00', 
   '15:00:00', 200, 10006, 4, 1004);
INSERT INTO Engagements
  (EngagementNumber, StartDate, EndDate, StartTime, 
   StopTime, ContractPrice, CustomerID, AgentID, EntertainerID)
  VALUES (3, '2012-09-10', '2012-09-15', '13:00:00', 
   '15:00:00', 590, 10001, 3, 1005);
INSERT INTO Engagements
  (EngagementNumber, StartDate, EndDate, StartTime, 
   StopTime, ContractPrice, CustomerID, AgentID, EntertainerID)
  VALUES (4, '2012-09-11', '2012-09-17', '20:00:00', 
   '00:00:00', 470, 10007, 3, 1004);
INSERT INTO Engagements
  (EngagementNumber, StartDate, EndDate, StartTime, 
   StopTime, ContractPrice, CustomerID, AgentID, EntertainerID)
  VALUES (5, '2012-09-11', '2012-09-14', '16:00:00', 
   '19:00:00', 1130, 10006, 5, 1003);
INSERT INTO Engagements
  (EngagementNumber, StartDate, EndDate, StartTime, 
   StopTime, ContractPrice, CustomerID, AgentID, EntertainerID)
  VALUES (6, '2012-09-10', '2012-09-14', '15:00:00', 
   '21:00:00', 2300, 10014, 7, 1008);
INSERT INTO Engagements
  (EngagementNumber, StartDate, EndDate, StartTime, 
   StopTime, ContractPrice, CustomerID, AgentID, EntertainerID)
  VALUES (7, '2012-09-11', '2012-09-18', '17:00:00', 
   '20:00:00', 770, 10004, 4, 1002);
INSERT INTO Engagements
  (EngagementNumber, StartDate, EndDate, StartTime, 
   StopTime, ContractPrice, CustomerID, AgentID, EntertainerID)
  VALUES (8, '2012-09-18', '2012-09-25', '20:00:00', 
   '23:00:00', 1850, 10006, 3, 1007);
INSERT INTO Engagements
  (EngagementNumber, StartDate, EndDate, StartTime, 
   StopTime, ContractPrice, CustomerID, AgentID, EntertainerID)
  VALUES (9, '2012-09-18', '2012-09-28', '19:00:00', 
   '21:00:00', 1370, 10010, 2, 1010);
INSERT INTO Engagements
  (EngagementNumber, StartDate, EndDate, StartTime, 
   StopTime, ContractPrice, CustomerID, AgentID, EntertainerID)
  VALUES (10, '2012-09-17', '2012-09-26', '13:00:00', 
   '17:00:00', 3650, 10005, 3, 1003);
INSERT INTO Engagements
  (EngagementNumber, StartDate, EndDate, StartTime, 
   StopTime, ContractPrice, CustomerID, AgentID, EntertainerID)
  VALUES (11, '2012-09-15', '2012-09-16', '18:00:00', 
   '00:00:00', 950, 10005, 4, 1008);
INSERT INTO Engagements
  (EngagementNumber, StartDate, EndDate, StartTime, 
   StopTime, ContractPrice, CustomerID, AgentID, EntertainerID)
  VALUES (12, '2012-09-18', '2012-09-26', '18:00:00', 
   '22:00:00', 1670, 10014, 8, 1001);
INSERT INTO Engagements
  (EngagementNumber, StartDate, EndDate, StartTime, 
   StopTime, ContractPrice, CustomerID, AgentID, EntertainerID)
  VALUES (13, '2012-09-17', '2012-09-20', '20:00:00', 
   '23:00:00', 770, 10003, 1, 1006);
INSERT INTO Engagements
  (EngagementNumber, StartDate, EndDate, StartTime, 
   StopTime, ContractPrice, CustomerID, AgentID, EntertainerID)
  VALUES (14, '2012-09-24', '2012-09-29', '16:00:00', 
   '22:00:00', 2750, 10001, 1, 1008);
INSERT INTO Engagements
  (EngagementNumber, StartDate, EndDate, StartTime, 
   StopTime, ContractPrice, CustomerID, AgentID, EntertainerID)
  VALUES (15, '2012-09-24', '2012-09-29', '17:00:00', 
   '19:00:00', 770, 10007, 1, 1013);
INSERT INTO Engagements
  (EngagementNumber, StartDate, EndDate, StartTime, 
   StopTime, ContractPrice, CustomerID, AgentID, EntertainerID)
  VALUES (16, '2012-10-02', '2012-10-06', '20:00:00', 
   '01:00:00', 1550, 10010, 5, 1013);
INSERT INTO Engagements
  (EngagementNumber, StartDate, EndDate, StartTime, 
   StopTime, ContractPrice, CustomerID, AgentID, EntertainerID)
  VALUES (17, '2012-09-29', '2012-10-02', '18:00:00', 
   '20:00:00', 530, 10002, 8, 1010);
INSERT INTO Engagements
  (EngagementNumber, StartDate, EndDate, StartTime, 
   StopTime, ContractPrice, CustomerID, AgentID, EntertainerID)
  VALUES (19, '2012-09-29', '2012-10-05', '20:00:00', 
   '23:00:00', 365, 10009, 8, 1004);
INSERT INTO Engagements
  (EngagementNumber, StartDate, EndDate, StartTime, 
   StopTime, ContractPrice, CustomerID, AgentID, EntertainerID)
  VALUES (21, '2012-09-30', '2012-10-03', '12:00:00', 
   '16:00:00', 1490, 10005, 1, 1003);
INSERT INTO Engagements
  (EngagementNumber, StartDate, EndDate, StartTime, 
   StopTime, ContractPrice, CustomerID, AgentID, EntertainerID)
  VALUES (22, '2012-09-30', '2012-10-05', '12:00:00', 
   '15:00:00', 590, 10004, 5, 1002);
INSERT INTO Engagements
  (EngagementNumber, StartDate, EndDate, StartTime, 
   StopTime, ContractPrice, CustomerID, AgentID, EntertainerID)
  VALUES (23, '2012-09-30', '2012-09-30', '20:00:00', 
   '00:00:00', 290, 10012, 4, 1013);
INSERT INTO Engagements
  (EngagementNumber, StartDate, EndDate, StartTime, 
   StopTime, ContractPrice, CustomerID, AgentID, EntertainerID)
  VALUES (24, '2012-10-01', '2012-10-07', '12:00:00', 
   '18:00:00', 1940, 10001, 4, 1001);
INSERT INTO Engagements
  (EngagementNumber, StartDate, EndDate, StartTime, 
   StopTime, ContractPrice, CustomerID, AgentID, EntertainerID)
  VALUES (26, '2012-10-09', '2012-10-14', '17:00:00', 
   '22:00:00', 950, 10001, 6, 1002);
INSERT INTO Engagements
  (EngagementNumber, StartDate, EndDate, StartTime, 
   StopTime, ContractPrice, CustomerID, AgentID, EntertainerID)
  VALUES (27, '2012-10-07', '2012-10-12', '12:00:00', 
   '16:00:00', 2210, 10015, 7, 1003);
INSERT INTO Engagements
  (EngagementNumber, StartDate, EndDate, StartTime, 
   StopTime, ContractPrice, CustomerID, AgentID, EntertainerID)
  VALUES (28, '2012-10-06', '2012-10-15', '17:00:00', 
   '22:00:00', 3800, 10003, 4, 1007);
INSERT INTO Engagements
  (EngagementNumber, StartDate, EndDate, StartTime, 
   StopTime, ContractPrice, CustomerID, AgentID, EntertainerID)
  VALUES (30, '2012-10-06', '2012-10-08', '17:00:00', 
   '22:00:00', 275, 10009, 5, 1011);
INSERT INTO Engagements
  (EngagementNumber, StartDate, EndDate, StartTime, 
   StopTime, ContractPrice, CustomerID, AgentID, EntertainerID)
  VALUES (31, '2012-10-07', '2012-10-16', '16:00:00', 
   '20:00:00', 2450, 10002, 8, 1010);
INSERT INTO Engagements
  (EngagementNumber, StartDate, EndDate, StartTime, 
   StopTime, ContractPrice, CustomerID, AgentID, EntertainerID)
  VALUES (32, '2012-10-07', '2012-10-16', '13:00:00', 
   '15:00:00', 1250, 10010, 7, 1013);
INSERT INTO Engagements
  (EngagementNumber, StartDate, EndDate, StartTime, 
   StopTime, ContractPrice, CustomerID, AgentID, EntertainerID)
  VALUES (34, '2012-10-14', '2012-10-20', '16:00:00', 
   '18:00:00', 680, 10004, 8, 1005);
INSERT INTO Engagements
  (EngagementNumber, StartDate, EndDate, StartTime, 
   StopTime, ContractPrice, CustomerID, AgentID, EntertainerID)
  VALUES (35, '2012-10-14', '2012-10-15', '19:00:00', 
   '23:00:00', 410, 10005, 8, 1001);
INSERT INTO Engagements
  (EngagementNumber, StartDate, EndDate, StartTime, 
   StopTime, ContractPrice, CustomerID, AgentID, EntertainerID)
  VALUES (36, '2012-10-13', '2012-10-23', '18:00:00', 
   '22:00:00', 710, 10014, 3, 1011);
INSERT INTO Engagements
  (EngagementNumber, StartDate, EndDate, StartTime, 
   StopTime, ContractPrice, CustomerID, AgentID, EntertainerID)
  VALUES (37, '2012-10-13', '2012-10-19', '14:00:00', 
   '19:00:00', 2675, 10006, 3, 1008);
INSERT INTO Engagements
  (EngagementNumber, StartDate, EndDate, StartTime, 
   StopTime, ContractPrice, CustomerID, AgentID, EntertainerID)
  VALUES (38, '2012-10-14', '2012-10-18', '14:00:00', 
   '20:00:00', 1850, 10013, 4, 1006);
INSERT INTO Engagements
  (EngagementNumber, StartDate, EndDate, StartTime, 
   StopTime, ContractPrice, CustomerID, AgentID, EntertainerID)
  VALUES (41, '2012-10-20', '2012-10-28', '18:00:00', 
   '21:00:00', 860, 10013, 3, 1002);
INSERT INTO Engagements
  (EngagementNumber, StartDate, EndDate, StartTime, 
   StopTime, ContractPrice, CustomerID, AgentID, EntertainerID)
  VALUES (42, '2012-10-20', '2012-10-26', '17:00:00', 
   '22:00:00', 2150, 10002, 1, 1013);
INSERT INTO Engagements
  (EngagementNumber, StartDate, EndDate, StartTime, 
   StopTime, ContractPrice, CustomerID, AgentID, EntertainerID)
  VALUES (43, '2012-10-21', '2012-10-21', '14:00:00', 
   '16:00:00', 140, 10001, 8, 1001);
INSERT INTO Engagements
  (EngagementNumber, StartDate, EndDate, StartTime, 
   StopTime, ContractPrice, CustomerID, AgentID, EntertainerID)
  VALUES (44, '2012-10-22', '2012-10-26', '14:00:00', 
   '19:00:00', 1925, 10006, 3, 1008);
INSERT INTO Engagements
  (EngagementNumber, StartDate, EndDate, StartTime, 
   StopTime, ContractPrice, CustomerID, AgentID, EntertainerID)
  VALUES (45, '2012-10-21', '2012-10-28', '14:00:00', 
   '18:00:00', 530, 10015, 1, 1012);
INSERT INTO Engagements
  (EngagementNumber, StartDate, EndDate, StartTime, 
   StopTime, ContractPrice, CustomerID, AgentID, EntertainerID)
  VALUES (46, '2012-10-28', '2012-11-05', '15:00:00', 
   '17:00:00', 1400, 10009, 4, 1008);
INSERT INTO Engagements
  (EngagementNumber, StartDate, EndDate, StartTime, 
   StopTime, ContractPrice, CustomerID, AgentID, EntertainerID)
  VALUES (48, '2012-11-05', '2012-11-06', '16:00:00', 
   '22:00:00', 950, 10002, 1, 1007);
INSERT INTO Engagements
  (EngagementNumber, StartDate, EndDate, StartTime, 
   StopTime, ContractPrice, CustomerID, AgentID, EntertainerID)
  VALUES (49, '2012-11-13', '2012-11-19', '12:00:00', 
   '14:00:00', 680, 10014, 5, 1001);
INSERT INTO Engagements
  (EngagementNumber, StartDate, EndDate, StartTime, 
   StopTime, ContractPrice, CustomerID, AgentID, EntertainerID)
  VALUES (51, '2012-11-13', '2012-11-14', '20:00:00', 
   '01:00:00', 650, 10013, 3, 1013);
INSERT INTO Engagements
  (EngagementNumber, StartDate, EndDate, StartTime, 
   StopTime, ContractPrice, CustomerID, AgentID, EntertainerID)
  VALUES (52, '2012-11-13', '2012-11-14', '16:00:00', 
   '21:00:00', 650, 10010, 3, 1006);
INSERT INTO Engagements
  (EngagementNumber, StartDate, EndDate, StartTime, 
   StopTime, ContractPrice, CustomerID, AgentID, EntertainerID)
  VALUES (53, '2012-11-11', '2012-11-12', '17:00:00', 
   '19:00:00', 350, 10002, 5, 1007);
INSERT INTO Engagements
  (EngagementNumber, StartDate, EndDate, StartTime, 
   StopTime, ContractPrice, CustomerID, AgentID, EntertainerID)
  VALUES (55, '2012-11-19', '2012-11-26', '20:00:00', 
   '02:00:00', 770, 10002, 3, 1011);
INSERT INTO Engagements
  (EngagementNumber, StartDate, EndDate, StartTime, 
   StopTime, ContractPrice, CustomerID, AgentID, EntertainerID)
  VALUES (56, '2012-11-25', '2012-11-28', '14:00:00', 
   '19:00:00', 1550, 10010, 3, 1007);
INSERT INTO Engagements
  (EngagementNumber, StartDate, EndDate, StartTime, 
   StopTime, ContractPrice, CustomerID, AgentID, EntertainerID)
  VALUES (58, '2012-12-01', '2012-12-04', '17:00:00', 
   '23:00:00', 770, 10001, 2, 1002);
INSERT INTO Engagements
  (EngagementNumber, StartDate, EndDate, StartTime, 
   StopTime, ContractPrice, CustomerID, AgentID, EntertainerID)
  VALUES (59, '2012-12-01', '2012-12-04', '15:00:00', 
   '19:00:00', 290, 10004, 6, 1012);
INSERT INTO Engagements
  (EngagementNumber, StartDate, EndDate, StartTime, 
   StopTime, ContractPrice, CustomerID, AgentID, EntertainerID)
  VALUES (60, '2012-12-02', '2012-12-04', '13:00:00', 
   '17:00:00', 230, 10010, 8, 1004);
INSERT INTO Engagements
  (EngagementNumber, StartDate, EndDate, StartTime, 
   StopTime, ContractPrice, CustomerID, AgentID, EntertainerID)
  VALUES (61, '2012-12-03', '2012-12-10', '17:00:00', 
   '20:00:00', 410, 10015, 8, 1011);
INSERT INTO Engagements
  (EngagementNumber, StartDate, EndDate, StartTime, 
   StopTime, ContractPrice, CustomerID, AgentID, EntertainerID)
  VALUES (62, '2012-12-09', '2012-12-10', '20:00:00', 
   '01:00:00', 500, 10003, 2, 1005);
INSERT INTO Engagements
  (EngagementNumber, StartDate, EndDate, StartTime, 
   StopTime, ContractPrice, CustomerID, AgentID, EntertainerID)
  VALUES (63, '2012-12-18', '2012-12-21', '14:00:00', 
   '16:00:00', 650, 10009, 3, 1008);
INSERT INTO Engagements
  (EngagementNumber, StartDate, EndDate, StartTime, 
   StopTime, ContractPrice, CustomerID, AgentID, EntertainerID)
  VALUES (64, '2012-12-25', '2013-01-03', '14:00:00', 
   '16:00:00', 1250, 10007, 3, 1013);
INSERT INTO Engagements
  (EngagementNumber, StartDate, EndDate, StartTime, 
   StopTime, ContractPrice, CustomerID, AgentID, EntertainerID)
  VALUES (66, '2012-12-22', '2012-12-29', '20:00:00', 
   '02:00:00', 2930, 10005, 5, 1006);
INSERT INTO Engagements
  (EngagementNumber, StartDate, EndDate, StartTime, 
   StopTime, ContractPrice, CustomerID, AgentID, EntertainerID)
  VALUES (68, '2012-12-24', '2012-12-29', '16:00:00', 
   '22:00:00', 1670, 10009, 1, 1005);
INSERT INTO Engagements
  (EngagementNumber, StartDate, EndDate, StartTime, 
   StopTime, ContractPrice, CustomerID, AgentID, EntertainerID)
  VALUES (69, '2012-12-22', '2012-12-23', '15:00:00', 
   '18:00:00', 500, 10004, 7, 1008);
INSERT INTO Engagements
  (EngagementNumber, StartDate, EndDate, StartTime, 
   StopTime, ContractPrice, CustomerID, AgentID, EntertainerID)
  VALUES (70, '2012-12-23', '2012-12-26', '13:00:00', 
   '15:00:00', 410, 10010, 6, 1001);
INSERT INTO Engagements
  (EngagementNumber, StartDate, EndDate, StartTime, 
   StopTime, ContractPrice, CustomerID, AgentID, EntertainerID)
  VALUES (71, '2012-12-22', '2012-12-27', '14:00:00', 
   '17:00:00', 1670, 10002, 1, 1003);
INSERT INTO Engagements
  (EngagementNumber, StartDate, EndDate, StartTime, 
   StopTime, ContractPrice, CustomerID, AgentID, EntertainerID)
  VALUES (72, '2012-12-22', '2013-01-01', '20:00:00', 
   '01:00:00', 875, 10012, 4, 1011);
INSERT INTO Engagements
  (EngagementNumber, StartDate, EndDate, StartTime, 
   StopTime, ContractPrice, CustomerID, AgentID, EntertainerID)
  VALUES (73, '2012-12-29', '2013-01-07', '19:00:00', 
   '22:00:00', 1400, 10014, 5, 1001);
INSERT INTO Engagements
  (EngagementNumber, StartDate, EndDate, StartTime, 
   StopTime, ContractPrice, CustomerID, AgentID, EntertainerID)
  VALUES (74, '2013-01-01', '2013-01-06', '13:00:00', 
   '15:00:00', 590, 10004, 1, 1005);
INSERT INTO Engagements
  (EngagementNumber, StartDate, EndDate, StartTime, 
   StopTime, ContractPrice, CustomerID, AgentID, EntertainerID)
  VALUES (75, '2013-01-01', '2013-01-11', '17:00:00', 
   '20:00:00', 2525, 10001, 7, 1007);
INSERT INTO Engagements
  (EngagementNumber, StartDate, EndDate, StartTime, 
   StopTime, ContractPrice, CustomerID, AgentID, EntertainerID)
  VALUES (76, '2012-12-30', '2013-01-03', '16:00:00', 
   '22:00:00', 500, 10005, 7, 1012);
INSERT INTO Engagements
  (EngagementNumber, StartDate, EndDate, StartTime, 
   StopTime, ContractPrice, CustomerID, AgentID, EntertainerID)
  VALUES (77, '2012-12-30', '2013-01-04', '17:00:00', 
   '20:00:00', 1670, 10015, 5, 1003);
INSERT INTO Engagements
  (EngagementNumber, StartDate, EndDate, StartTime, 
   StopTime, ContractPrice, CustomerID, AgentID, EntertainerID)
  VALUES (78, '2013-01-01', '2013-01-03', '16:00:00', 
   '20:00:00', 770, 10010, 4, 1010);
INSERT INTO Engagements
  (EngagementNumber, StartDate, EndDate, StartTime, 
   StopTime, ContractPrice, CustomerID, AgentID, EntertainerID)
  VALUES (79, '2012-12-30', '2013-01-03', '12:00:00', 
   '17:00:00', 1550, 10006, 8, 1006);
INSERT INTO Engagements
  (EngagementNumber, StartDate, EndDate, StartTime, 
   StopTime, ContractPrice, CustomerID, AgentID, EntertainerID)
  VALUES (80, '2012-12-31', '2013-01-01', '17:00:00', 
   '21:00:00', 650, 10002, 5, 1008);
INSERT INTO Engagements
  (EngagementNumber, StartDate, EndDate, StartTime, 
   StopTime, ContractPrice, CustomerID, AgentID, EntertainerID)
  VALUES (81, '2013-01-01', '2013-01-09', '13:00:00', 
   '17:00:00', 1130, 10013, 4, 1002);
INSERT INTO Engagements
  (EngagementNumber, StartDate, EndDate, StartTime, 
   StopTime, ContractPrice, CustomerID, AgentID, EntertainerID)
  VALUES (82, '2013-01-08', '2013-01-09', '20:00:00', 
   '01:00:00', 950, 10014, 8, 1003);
INSERT INTO Engagements
  (EngagementNumber, StartDate, EndDate, StartTime, 
   StopTime, ContractPrice, CustomerID, AgentID, EntertainerID)
  VALUES (83, '2013-01-06', '2013-01-10', '13:00:00', 
   '15:00:00', 650, 10010, 2, 1006);
INSERT INTO Engagements
  (EngagementNumber, StartDate, EndDate, StartTime, 
   StopTime, ContractPrice, CustomerID, AgentID, EntertainerID)
  VALUES (84, '2013-01-06', '2013-01-11', '17:00:00', 
   '19:00:00', 230, 10007, 3, 1012);
INSERT INTO Engagements
  (EngagementNumber, StartDate, EndDate, StartTime, 
   StopTime, ContractPrice, CustomerID, AgentID, EntertainerID)
  VALUES (85, '2013-01-06', '2013-01-08', '14:00:00', 
   '19:00:00', 1175, 10015, 4, 1008);
INSERT INTO Engagements
  (EngagementNumber, StartDate, EndDate, StartTime, 
   StopTime, ContractPrice, CustomerID, AgentID, EntertainerID)
  VALUES (87, '2013-01-04', '2013-01-06', '16:00:00', 
   '19:00:00', 275, 10007, 6, 1008);
INSERT INTO Engagements
  (EngagementNumber, StartDate, EndDate, StartTime, 
   StopTime, ContractPrice, CustomerID, AgentID, EntertainerID)
  VALUES (88, '2013-01-07', '2013-01-17', '12:00:00', 
   '14:00:00', 1370, 10004, 8, 1013);
INSERT INTO Engagements
  (EngagementNumber, StartDate, EndDate, StartTime, 
   StopTime, ContractPrice, CustomerID, AgentID, EntertainerID)
  VALUES (89, '2013-01-06', '2013-01-07', '14:00:00', 
   '16:00:00', 290, 10003, 8, 1010);
INSERT INTO Engagements
  (EngagementNumber, StartDate, EndDate, StartTime, 
   StopTime, ContractPrice, CustomerID, AgentID, EntertainerID)
  VALUES (90, '2013-01-08', '2013-01-08', '20:00:00', 
   '02:00:00', 320, 10006, 5, 1001);
INSERT INTO Engagements
  (EngagementNumber, StartDate, EndDate, StartTime, 
   StopTime, ContractPrice, CustomerID, AgentID, EntertainerID)
  VALUES (91, '2013-01-05', '2013-01-12', '13:00:00', 
   '19:00:00', 770, 10009, 3, 1004);
INSERT INTO Engagements
  (EngagementNumber, StartDate, EndDate, StartTime, 
   StopTime, ContractPrice, CustomerID, AgentID, EntertainerID)
  VALUES (92, '2013-01-12', '2013-01-16', '19:00:00', 
   '00:00:00', 1925, 10012, 6, 1008);
INSERT INTO Engagements
  (EngagementNumber, StartDate, EndDate, StartTime, 
   StopTime, ContractPrice, CustomerID, AgentID, EntertainerID)
  VALUES (95, '2013-01-15', '2013-01-18', '20:00:00', 
   '01:00:00', 1550, 10010, 6, 1007);
INSERT INTO Engagements
  (EngagementNumber, StartDate, EndDate, StartTime, 
   StopTime, ContractPrice, CustomerID, AgentID, EntertainerID)
  VALUES (96, '2013-01-22', '2013-01-31', '15:00:00', 
   '17:00:00', 950, 10009, 6, 1005);
INSERT INTO Engagements
  (EngagementNumber, StartDate, EndDate, StartTime, 
   StopTime, ContractPrice, CustomerID, AgentID, EntertainerID)
  VALUES (97, '2013-01-19', '2013-01-19', '17:00:00', 
   '21:00:00', 110, 10012, 8, 1004);
INSERT INTO Engagements
  (EngagementNumber, StartDate, EndDate, StartTime, 
   StopTime, ContractPrice, CustomerID, AgentID, EntertainerID)
  VALUES (98, '2013-01-20', '2013-01-27', '20:00:00', 
   '02:00:00', 2930, 10012, 2, 1010);
INSERT INTO Engagements
  (EngagementNumber, StartDate, EndDate, StartTime, 
   StopTime, ContractPrice, CustomerID, AgentID, EntertainerID)
  VALUES (99, '2013-01-22', '2013-02-22', '14:00:00', 
   '20:00:00', 14105, 10005, 6, 1008);
INSERT INTO Engagements
  (EngagementNumber, StartDate, EndDate, StartTime, 
   StopTime, ContractPrice, CustomerID, AgentID, EntertainerID)
  VALUES (100, '2013-01-19', '2013-01-23', '12:00:00', 
   '18:00:00', 1850, 10015, 3, 1006);
INSERT INTO Engagements
  (EngagementNumber, StartDate, EndDate, StartTime, 
   StopTime, ContractPrice, CustomerID, AgentID, EntertainerID)
  VALUES (101, '2013-01-22', '2013-01-30', '14:00:00', 
   '18:00:00', 1670, 10004, 5, 1001);
INSERT INTO Engagements
  (EngagementNumber, StartDate, EndDate, StartTime, 
   StopTime, ContractPrice, CustomerID, AgentID, EntertainerID)
  VALUES (102, '2013-01-22', '2013-01-31', '12:00:00', 
   '15:00:00', 2300, 10013, 5, 1007);
INSERT INTO Engagements
  (EngagementNumber, StartDate, EndDate, StartTime, 
   StopTime, ContractPrice, CustomerID, AgentID, EntertainerID)
  VALUES (103, '2013-01-21', '2013-01-27', '12:00:00', 
   '17:00:00', 575, 10010, 4, 1011);
INSERT INTO Engagements
  (EngagementNumber, StartDate, EndDate, StartTime, 
   StopTime, ContractPrice, CustomerID, AgentID, EntertainerID)
  VALUES (104, '2013-01-28', '2013-02-01', '13:00:00', 
   '16:00:00', 1400, 10010, 6, 1003);
INSERT INTO Engagements
  (EngagementNumber, StartDate, EndDate, StartTime, 
   StopTime, ContractPrice, CustomerID, AgentID, EntertainerID)
  VALUES (105, '2013-01-27', '2013-02-01', '12:00:00', 
   '17:00:00', 1850, 10002, 4, 1013);
INSERT INTO Engagements
  (EngagementNumber, StartDate, EndDate, StartTime, 
   StopTime, ContractPrice, CustomerID, AgentID, EntertainerID)
  VALUES (106, '2013-01-29', '2013-02-01', '15:00:00', 
   '18:00:00', 770, 10003, 6, 1006);
INSERT INTO Engagements
  (EngagementNumber, StartDate, EndDate, StartTime, 
   StopTime, ContractPrice, CustomerID, AgentID, EntertainerID)
  VALUES (107, '2013-01-29', '2013-01-30', '16:00:00', 
   '21:00:00', 200, 10007, 4, 1004);
INSERT INTO Engagements
  (EngagementNumber, StartDate, EndDate, StartTime, 
   StopTime, ContractPrice, CustomerID, AgentID, EntertainerID)
  VALUES (108, '2013-02-02', '2013-02-04', '18:00:00', 
   '00:00:00', 320, 10004, 5, 1012);
INSERT INTO Engagements
  (EngagementNumber, StartDate, EndDate, StartTime, 
   StopTime, ContractPrice, CustomerID, AgentID, EntertainerID)
  VALUES (109, '2013-02-11', '2013-02-15', '13:00:00', 
   '19:00:00', 1850, 10014, 5, 1010);
INSERT INTO Engagements
  (EngagementNumber, StartDate, EndDate, StartTime, 
   StopTime, ContractPrice, CustomerID, AgentID, EntertainerID)
  VALUES (110, '2013-02-11', '2013-02-19', '15:00:00', 
   '19:00:00', 1670, 10006, 8, 1001);
INSERT INTO Engagements
  (EngagementNumber, StartDate, EndDate, StartTime, 
   StopTime, ContractPrice, CustomerID, AgentID, EntertainerID)
  VALUES (111, '2013-02-12', '2013-02-14', '15:00:00', 
   '18:00:00', 185, 10012, 1, 1004);
INSERT INTO Engagements
  (EngagementNumber, StartDate, EndDate, StartTime, 
   StopTime, ContractPrice, CustomerID, AgentID, EntertainerID)
  VALUES (112, '2013-02-19', '2013-02-24', '18:00:00', 
   '22:00:00', 410, 10015, 7, 1011);
INSERT INTO Engagements
  (EngagementNumber, StartDate, EndDate, StartTime, 
   StopTime, ContractPrice, CustomerID, AgentID, EntertainerID)
  VALUES (114, '2013-02-19', '2013-02-28', '12:00:00', 
   '17:00:00', 1550, 10005, 1, 1002);
INSERT INTO Engagements
  (EngagementNumber, StartDate, EndDate, StartTime, 
   StopTime, ContractPrice, CustomerID, AgentID, EntertainerID)
  VALUES (115, '2013-02-19', '2013-02-22', '12:00:00', 
   '18:00:00', 1490, 10007, 5, 1013);
INSERT INTO Engagements
  (EngagementNumber, StartDate, EndDate, StartTime, 
   StopTime, ContractPrice, CustomerID, AgentID, EntertainerID)
  VALUES (116, '2013-02-16', '2013-02-25', '14:00:00', 
   '19:00:00', 800, 10003, 6, 1012);
INSERT INTO Engagements
  (EngagementNumber, StartDate, EndDate, StartTime, 
   StopTime, ContractPrice, CustomerID, AgentID, EntertainerID)
  VALUES (118, '2013-02-18', '2013-02-18', '19:00:00', 
   '00:00:00', 350, 10014, 1, 1010);
INSERT INTO Engagements
  (EngagementNumber, StartDate, EndDate, StartTime, 
   StopTime, ContractPrice, CustomerID, AgentID, EntertainerID)
  VALUES (119, '2013-02-19', '2013-02-28', '18:00:00', 
   '21:00:00', 500, 10012, 2, 1004);
INSERT INTO Engagements
  (EngagementNumber, StartDate, EndDate, StartTime, 
   StopTime, ContractPrice, CustomerID, AgentID, EntertainerID)
  VALUES (120, '2013-02-17', '2013-02-20', '20:00:00', 
   '23:00:00', 950, 10002, 7, 1008);
INSERT INTO Engagements
  (EngagementNumber, StartDate, EndDate, StartTime, 
   StopTime, ContractPrice, CustomerID, AgentID, EntertainerID)
  VALUES (121, '2013-02-16', '2013-02-22', '17:00:00', 
   '23:00:00', 2570, 10004, 3, 1006);
INSERT INTO Engagements
  (EngagementNumber, StartDate, EndDate, StartTime, 
   StopTime, ContractPrice, CustomerID, AgentID, EntertainerID)
  VALUES (122, '2013-02-24', '2013-02-27', '15:00:00', 
   '19:00:00', 1010, 10014, 5, 1010);
INSERT INTO Engagements
  (EngagementNumber, StartDate, EndDate, StartTime, 
   StopTime, ContractPrice, CustomerID, AgentID, EntertainerID)
  VALUES (123, '2013-02-25', '2013-02-28', '16:00:00', 
   '20:00:00', 770, 10013, 1, 1001);
INSERT INTO Engagements
  (EngagementNumber, StartDate, EndDate, StartTime, 
   StopTime, ContractPrice, CustomerID, AgentID, EntertainerID)
  VALUES (124, '2013-02-23', '2013-03-02', '14:00:00', 
   '17:00:00', 1850, 10006, 1, 1008);
INSERT INTO Engagements
  (EngagementNumber, StartDate, EndDate, StartTime, 
   StopTime, ContractPrice, CustomerID, AgentID, EntertainerID)
  VALUES (125, '2013-02-23', '2013-02-28', '13:00:00', 
   '15:00:00', 1130, 10001, 3, 1003);
INSERT INTO Engagements
  (EngagementNumber, StartDate, EndDate, StartTime, 
   StopTime, ContractPrice, CustomerID, AgentID, EntertainerID)
  VALUES (126, '2013-02-24', '2013-03-03', '18:00:00', 
   '20:00:00', 1010, 10009, 6, 1006);
INSERT INTO Engagements
  (EngagementNumber, StartDate, EndDate, StartTime, 
   StopTime, ContractPrice, CustomerID, AgentID, EntertainerID)
  VALUES (127, '2013-02-24', '2013-02-28', '20:00:00', 
   '22:00:00', 500, 10010, 4, 1005);
INSERT INTO Engagements
  (EngagementNumber, StartDate, EndDate, StartTime, 
   StopTime, ContractPrice, CustomerID, AgentID, EntertainerID)
  VALUES (128, '2013-02-26', '2013-02-28', '19:00:00', 
   '01:00:00', 320, 10003, 4, 1011);
INSERT INTO Engagements
  (EngagementNumber, StartDate, EndDate, StartTime, 
   StopTime, ContractPrice, CustomerID, AgentID, EntertainerID)
  VALUES (129, '2013-02-24', '2013-03-05', '17:00:00', 
   '21:00:00', 2450, 10004, 5, 1013);
INSERT INTO Engagements
  (EngagementNumber, StartDate, EndDate, StartTime, 
   StopTime, ContractPrice, CustomerID, AgentID, EntertainerID)
  VALUES (131, '2013-03-03', '2013-03-12', '15:00:00', 
   '17:00:00', 1850, 10014, 1, 1003);
SET IDENTITY_INSERT Engagements OFF
GO
SET IDENTITY_INSERT Members ON
GO
INSERT INTO Members
  (MemberID, MbrFirstName, MbrLastName, MbrPhoneNumber, 
   Gender)
  VALUES (101, 'David', 'Hamilton', '555-2701', 'M');
INSERT INTO Members
  (MemberID, MbrFirstName, MbrLastName, MbrPhoneNumber, 
   Gender)
  VALUES (102, 'Suzanne', 'Viescas', '555-2686', 'F');
INSERT INTO Members
  (MemberID, MbrFirstName, MbrLastName, MbrPhoneNumber, 
   Gender)
  VALUES (103, 'Gary', 'Hallmark', '555-2676', 'M');
INSERT INTO Members
  (MemberID, MbrFirstName, MbrLastName, MbrPhoneNumber, 
   Gender)
  VALUES (104, 'Jeffrey', 'Smith', '555-2596', 'M');
INSERT INTO Members
  (MemberID, MbrFirstName, MbrLastName, MbrPhoneNumber, 
   Gender)
  VALUES (105, 'Robert', 'Brown', '555-2491', 'M');
INSERT INTO Members
  (MemberID, MbrFirstName, MbrLastName, MbrPhoneNumber, 
   Gender)
  VALUES (106, 'Mariya', 'Sergienko', '555-2526', 'F');
INSERT INTO Members
  (MemberID, MbrFirstName, MbrLastName, MbrPhoneNumber, 
   Gender)
  VALUES (107, 'Sara', 'Sheskey', '555-2566', 'F');
INSERT INTO Members
  (MemberID, MbrFirstName, MbrLastName, MbrPhoneNumber, 
   Gender)
  VALUES (108, 'Rachel', 'Patterson', '555-2546', 'F');
INSERT INTO Members
  (MemberID, MbrFirstName, MbrLastName, MbrPhoneNumber, 
   Gender)
  VALUES (109, 'David', 'Viescas', '555-2661', 'M');
INSERT INTO Members
  (MemberID, MbrFirstName, MbrLastName, MbrPhoneNumber, 
   Gender)
  VALUES (110, 'Manuela', 'Seidel', '555-2641', 'F');
INSERT INTO Members
  (MemberID, MbrFirstName, MbrLastName, MbrPhoneNumber, 
   Gender)
  VALUES (111, 'Kathryn', 'Patterson', '555-2651', 
   'F');
INSERT INTO Members
  (MemberID, MbrFirstName, MbrLastName, MbrPhoneNumber, 
   Gender)
  VALUES (112, 'Kendra', 'Bonnicksen', '555-2716', 
   'F');
INSERT INTO Members
  (MemberID, MbrFirstName, MbrLastName, MbrPhoneNumber, 
   Gender)
  VALUES (113, 'Steve', 'Pundt', '555-9938', 'M');
INSERT INTO Members
  (MemberID, MbrFirstName, MbrLastName, MbrPhoneNumber, 
   Gender)
  VALUES (114, 'George', 'Chavez', '555-9930', 'M');
INSERT INTO Members
  (MemberID, MbrFirstName, MbrLastName, MbrPhoneNumber, 
   Gender)
  VALUES (115, 'Joe', 'Rosales III', '555-2281', 'M');
INSERT INTO Members
  (MemberID, MbrFirstName, MbrLastName, MbrPhoneNumber, 
   Gender)
  VALUES (116, 'Angel', 'Kennedy', '555-2311', 'M');
INSERT INTO Members
  (MemberID, MbrFirstName, MbrLastName, MbrPhoneNumber, 
   Gender)
  VALUES (117, 'Luke', 'Patterson', '555-2316', 'M');
INSERT INTO Members
  (MemberID, MbrFirstName, MbrLastName, MbrPhoneNumber, 
   Gender)
  VALUES (118, 'Janice', 'Galvin', '555-2691', 'F');
INSERT INTO Members
  (MemberID, MbrFirstName, MbrLastName, MbrPhoneNumber, 
   Gender)
  VALUES (119, 'John', 'Viescas', '555-2511', 'M');
INSERT INTO Members
  (MemberID, MbrFirstName, MbrLastName, MbrPhoneNumber, 
   Gender)
  VALUES (120, 'Michael', 'Hernandez', '555-2711', 
   'M');
INSERT INTO Members
  (MemberID, MbrFirstName, MbrLastName, MbrPhoneNumber, 
   Gender)
  VALUES (121, 'Katherine', 'Ehrlich', '555-0399', 
   'F');
INSERT INTO Members
  (MemberID, MbrFirstName, MbrLastName, MbrPhoneNumber, 
   Gender)
  VALUES (122, 'Julia', 'Schnebly', '555-9936', 'F');
INSERT INTO Members
  (MemberID, MbrFirstName, MbrLastName, MbrPhoneNumber, 
   Gender)
  VALUES (123, 'Susan', 'McLain', '555-2301', 'F');
INSERT INTO Members
  (MemberID, MbrFirstName, MbrLastName, MbrPhoneNumber, 
   Gender)
  VALUES (124, 'Caroline', 'Coie', '555-2306', 'F');
INSERT INTO Members
  (MemberID, MbrFirstName, MbrLastName, MbrPhoneNumber, 
   Gender)
  VALUES (125, 'Jim', 'Glynn', '555-2531', NULL);
SET IDENTITY_INSERT Members OFF
GO
INSERT INTO Entertainer_Members
  (EntertainerID, MemberID, Status)
  VALUES (1001, 106, 1);
INSERT INTO Entertainer_Members
  (EntertainerID, MemberID, Status)
  VALUES (1001, 107, 1);
INSERT INTO Entertainer_Members
  (EntertainerID, MemberID, Status)
  VALUES (1001, 118, 2);
INSERT INTO Entertainer_Members
  (EntertainerID, MemberID, Status)
  VALUES (1002, 120, 2);
INSERT INTO Entertainer_Members
  (EntertainerID, MemberID, Status)
  VALUES (1002, 121, 1);
INSERT INTO Entertainer_Members
  (EntertainerID, MemberID, Status)
  VALUES (1003, 102, 1);
INSERT INTO Entertainer_Members
  (EntertainerID, MemberID, Status)
  VALUES (1003, 103, 1);
INSERT INTO Entertainer_Members
  (EntertainerID, MemberID, Status)
  VALUES (1003, 104, 1);
INSERT INTO Entertainer_Members
  (EntertainerID, MemberID, Status)
  VALUES (1003, 109, 1);
INSERT INTO Entertainer_Members
  (EntertainerID, MemberID, Status)
  VALUES (1003, 117, 1);
INSERT INTO Entertainer_Members
  (EntertainerID, MemberID, Status)
  VALUES (1003, 119, 2);
INSERT INTO Entertainer_Members
  (EntertainerID, MemberID, Status)
  VALUES (1004, 125, 2);
INSERT INTO Entertainer_Members
  (EntertainerID, MemberID, Status)
  VALUES (1005, 116, 1);
INSERT INTO Entertainer_Members
  (EntertainerID, MemberID, Status)
  VALUES (1005, 120, 2);
INSERT INTO Entertainer_Members
  (EntertainerID, MemberID, Status)
  VALUES (1005, 121, 1);
INSERT INTO Entertainer_Members
  (EntertainerID, MemberID, Status)
  VALUES (1006, 104, 1);
INSERT INTO Entertainer_Members
  (EntertainerID, MemberID, Status)
  VALUES (1006, 113, 1);
INSERT INTO Entertainer_Members
  (EntertainerID, MemberID, Status)
  VALUES (1006, 118, 1);
INSERT INTO Entertainer_Members
  (EntertainerID, MemberID, Status)
  VALUES (1006, 120, 2);
INSERT INTO Entertainer_Members
  (EntertainerID, MemberID, Status)
  VALUES (1007, 101, 1);
INSERT INTO Entertainer_Members
  (EntertainerID, MemberID, Status)
  VALUES (1007, 102, 1);
INSERT INTO Entertainer_Members
  (EntertainerID, MemberID, Status)
  VALUES (1007, 105, 1);
INSERT INTO Entertainer_Members
  (EntertainerID, MemberID, Status)
  VALUES (1007, 107, 2);
INSERT INTO Entertainer_Members
  (EntertainerID, MemberID, Status)
  VALUES (1007, 110, 1);
INSERT INTO Entertainer_Members
  (EntertainerID, MemberID, Status)
  VALUES (1008, 103, 1);
INSERT INTO Entertainer_Members
  (EntertainerID, MemberID, Status)
  VALUES (1008, 105, 1);
INSERT INTO Entertainer_Members
  (EntertainerID, MemberID, Status)
  VALUES (1008, 111, 1);
INSERT INTO Entertainer_Members
  (EntertainerID, MemberID, Status)
  VALUES (1008, 114, 2);
INSERT INTO Entertainer_Members
  (EntertainerID, MemberID, Status)
  VALUES (1008, 115, 1);
INSERT INTO Entertainer_Members
  (EntertainerID, MemberID, Status)
  VALUES (1009, 121, 2);
INSERT INTO Entertainer_Members
  (EntertainerID, MemberID, Status)
  VALUES (1010, 108, 1);
INSERT INTO Entertainer_Members
  (EntertainerID, MemberID, Status)
  VALUES (1010, 112, 2);
INSERT INTO Entertainer_Members
  (EntertainerID, MemberID, Status)
  VALUES (1010, 123, 1);
INSERT INTO Entertainer_Members
  (EntertainerID, MemberID, Status)
  VALUES (1010, 124, 1);
INSERT INTO Entertainer_Members
  (EntertainerID, MemberID, Status)
  VALUES (1011, 122, 2);
INSERT INTO Entertainer_Members
  (EntertainerID, MemberID, Status)
  VALUES (1012, 123, 2);
INSERT INTO Entertainer_Members
  (EntertainerID, MemberID, Status)
  VALUES (1013, 112, 1);
INSERT INTO Entertainer_Members
  (EntertainerID, MemberID, Status)
  VALUES (1013, 114, 1);
INSERT INTO Entertainer_Members
  (EntertainerID, MemberID, Status)
  VALUES (1013, 117, 1);
INSERT INTO Entertainer_Members
  (EntertainerID, MemberID, Status)
  VALUES (1013, 124, 2);
SET IDENTITY_INSERT Musical_Styles ON
GO
INSERT INTO Musical_Styles
  (StyleID, StyleName)
  VALUES (1, '40''s Ballroom Music');
INSERT INTO Musical_Styles
  (StyleID, StyleName)
  VALUES (2, '50''s Music');
INSERT INTO Musical_Styles
  (StyleID, StyleName)
  VALUES (3, '60''s Music');
INSERT INTO Musical_Styles
  (StyleID, StyleName)
  VALUES (4, '70''s Music');
INSERT INTO Musical_Styles
  (StyleID, StyleName)
  VALUES (5, '80''s Music');
INSERT INTO Musical_Styles
  (StyleID, StyleName)
  VALUES (6, 'Country');
INSERT INTO Musical_Styles
  (StyleID, StyleName)
  VALUES (7, 'Classical');
INSERT INTO Musical_Styles
  (StyleID, StyleName)
  VALUES (8, 'Classic Rock & Roll');
INSERT INTO Musical_Styles
  (StyleID, StyleName)
  VALUES (9, 'Rap');
INSERT INTO Musical_Styles
  (StyleID, StyleName)
  VALUES (10, 'Contemporary');
INSERT INTO Musical_Styles
  (StyleID, StyleName)
  VALUES (11, 'Country Rock');
INSERT INTO Musical_Styles
  (StyleID, StyleName)
  VALUES (12, 'Elvis');
INSERT INTO Musical_Styles
  (StyleID, StyleName)
  VALUES (13, 'Folk');
INSERT INTO Musical_Styles
  (StyleID, StyleName)
  VALUES (14, 'Chamber Music');
INSERT INTO Musical_Styles
  (StyleID, StyleName)
  VALUES (15, 'Jazz');
INSERT INTO Musical_Styles
  (StyleID, StyleName)
  VALUES (16, 'Karaoke');
INSERT INTO Musical_Styles
  (StyleID, StyleName)
  VALUES (17, 'Motown');
INSERT INTO Musical_Styles
  (StyleID, StyleName)
  VALUES (18, 'Modern Rock');
INSERT INTO Musical_Styles
  (StyleID, StyleName)
  VALUES (19, 'Rhythm and Blues');
INSERT INTO Musical_Styles
  (StyleID, StyleName)
  VALUES (20, 'Show Tunes');
INSERT INTO Musical_Styles
  (StyleID, StyleName)
  VALUES (21, 'Standards');
INSERT INTO Musical_Styles
  (StyleID, StyleName)
  VALUES (22, 'Top 40 Hits');
INSERT INTO Musical_Styles
  (StyleID, StyleName)
  VALUES (23, 'Variety');
INSERT INTO Musical_Styles
  (StyleID, StyleName)
  VALUES (24, 'Salsa');
INSERT INTO Musical_Styles
  (StyleID, StyleName)
  VALUES (25, '90''s Music');
SET IDENTITY_INSERT Musical_Styles OFF
GO
INSERT INTO Entertainer_Styles
  (EntertainerID, StyleID)
  VALUES (1001, 10);
INSERT INTO Entertainer_Styles
  (EntertainerID, StyleID)
  VALUES (1001, 20);
INSERT INTO Entertainer_Styles
  (EntertainerID, StyleID)
  VALUES (1001, 21);
INSERT INTO Entertainer_Styles
  (EntertainerID, StyleID)
  VALUES (1002, 17);
INSERT INTO Entertainer_Styles
  (EntertainerID, StyleID)
  VALUES (1002, 19);
INSERT INTO Entertainer_Styles
  (EntertainerID, StyleID)
  VALUES (1002, 23);
INSERT INTO Entertainer_Styles
  (EntertainerID, StyleID)
  VALUES (1003, 3);
INSERT INTO Entertainer_Styles
  (EntertainerID, StyleID)
  VALUES (1003, 8);
INSERT INTO Entertainer_Styles
  (EntertainerID, StyleID)
  VALUES (1004, 13);
INSERT INTO Entertainer_Styles
  (EntertainerID, StyleID)
  VALUES (1005, 15);
INSERT INTO Entertainer_Styles
  (EntertainerID, StyleID)
  VALUES (1005, 19);
INSERT INTO Entertainer_Styles
  (EntertainerID, StyleID)
  VALUES (1005, 24);
INSERT INTO Entertainer_Styles
  (EntertainerID, StyleID)
  VALUES (1006, 22);
INSERT INTO Entertainer_Styles
  (EntertainerID, StyleID)
  VALUES (1006, 23);
INSERT INTO Entertainer_Styles
  (EntertainerID, StyleID)
  VALUES (1006, 24);
INSERT INTO Entertainer_Styles
  (EntertainerID, StyleID)
  VALUES (1007, 6);
INSERT INTO Entertainer_Styles
  (EntertainerID, StyleID)
  VALUES (1007, 11);
INSERT INTO Entertainer_Styles
  (EntertainerID, StyleID)
  VALUES (1008, 3);
INSERT INTO Entertainer_Styles
  (EntertainerID, StyleID)
  VALUES (1008, 6);
INSERT INTO Entertainer_Styles
  (EntertainerID, StyleID)
  VALUES (1009, 7);
INSERT INTO Entertainer_Styles
  (EntertainerID, StyleID)
  VALUES (1009, 14);
INSERT INTO Entertainer_Styles
  (EntertainerID, StyleID)
  VALUES (1009, 21);
INSERT INTO Entertainer_Styles
  (EntertainerID, StyleID)
  VALUES (1010, 4);
INSERT INTO Entertainer_Styles
  (EntertainerID, StyleID)
  VALUES (1010, 21);
INSERT INTO Entertainer_Styles
  (EntertainerID, StyleID)
  VALUES (1010, 22);
INSERT INTO Entertainer_Styles
  (EntertainerID, StyleID)
  VALUES (1011, 7);
INSERT INTO Entertainer_Styles
  (EntertainerID, StyleID)
  VALUES (1011, 14);
INSERT INTO Entertainer_Styles
  (EntertainerID, StyleID)
  VALUES (1011, 20);
INSERT INTO Entertainer_Styles
  (EntertainerID, StyleID)
  VALUES (1012, 7);
INSERT INTO Entertainer_Styles
  (EntertainerID, StyleID)
  VALUES (1012, 13);
INSERT INTO Entertainer_Styles
  (EntertainerID, StyleID)
  VALUES (1013, 10);
INSERT INTO Entertainer_Styles
  (EntertainerID, StyleID)
  VALUES (1013, 15);
INSERT INTO Musical_Preferences
  (CustomerID, StyleID)
  VALUES (10001, 10);
INSERT INTO Musical_Preferences
  (CustomerID, StyleID)
  VALUES (10001, 22);
INSERT INTO Musical_Preferences
  (CustomerID, StyleID)
  VALUES (10002, 3);
INSERT INTO Musical_Preferences
  (CustomerID, StyleID)
  VALUES (10002, 8);
INSERT INTO Musical_Preferences
  (CustomerID, StyleID)
  VALUES (10003, 17);
INSERT INTO Musical_Preferences
  (CustomerID, StyleID)
  VALUES (10003, 19);
INSERT INTO Musical_Preferences
  (CustomerID, StyleID)
  VALUES (10004, 15);
INSERT INTO Musical_Preferences
  (CustomerID, StyleID)
  VALUES (10004, 21);
INSERT INTO Musical_Preferences
  (CustomerID, StyleID)
  VALUES (10005, 7);
INSERT INTO Musical_Preferences
  (CustomerID, StyleID)
  VALUES (10005, 14);
INSERT INTO Musical_Preferences
  (CustomerID, StyleID)
  VALUES (10006, 13);
INSERT INTO Musical_Preferences
  (CustomerID, StyleID)
  VALUES (10006, 23);
INSERT INTO Musical_Preferences
  (CustomerID, StyleID)
  VALUES (10007, 4);
INSERT INTO Musical_Preferences
  (CustomerID, StyleID)
  VALUES (10007, 8);
INSERT INTO Musical_Preferences
  (CustomerID, StyleID)
  VALUES (10007, 19);
INSERT INTO Musical_Preferences
  (CustomerID, StyleID)
  VALUES (10008, 10);
INSERT INTO Musical_Preferences
  (CustomerID, StyleID)
  VALUES (10008, 21);
INSERT INTO Musical_Preferences
  (CustomerID, StyleID)
  VALUES (10009, 6);
INSERT INTO Musical_Preferences
  (CustomerID, StyleID)
  VALUES (10009, 11);
INSERT INTO Musical_Preferences
  (CustomerID, StyleID)
  VALUES (10009, 18);
INSERT INTO Musical_Preferences
  (CustomerID, StyleID)
  VALUES (10010, 15);
INSERT INTO Musical_Preferences
  (CustomerID, StyleID)
  VALUES (10010, 19);
INSERT INTO Musical_Preferences
  (CustomerID, StyleID)
  VALUES (10010, 24);
INSERT INTO Musical_Preferences
  (CustomerID, StyleID)
  VALUES (10011, 1);
INSERT INTO Musical_Preferences
  (CustomerID, StyleID)
  VALUES (10011, 7);
INSERT INTO Musical_Preferences
  (CustomerID, StyleID)
  VALUES (10011, 21);
INSERT INTO Musical_Preferences
  (CustomerID, StyleID)
  VALUES (10012, 10);
INSERT INTO Musical_Preferences
  (CustomerID, StyleID)
  VALUES (10012, 20);
INSERT INTO Musical_Preferences
  (CustomerID, StyleID)
  VALUES (10013, 15);
INSERT INTO Musical_Preferences
  (CustomerID, StyleID)
  VALUES (10013, 24);
INSERT INTO Musical_Preferences
  (CustomerID, StyleID)
  VALUES (10014, 5);
INSERT INTO Musical_Preferences
  (CustomerID, StyleID)
  VALUES (10014, 18);
INSERT INTO Musical_Preferences
  (CustomerID, StyleID)
  VALUES (10014, 22);
INSERT INTO Musical_Preferences
  (CustomerID, StyleID)
  VALUES (10015, 1);
INSERT INTO Musical_Preferences
  (CustomerID, StyleID)
  VALUES (10015, 20);
INSERT INTO Musical_Preferences
  (CustomerID, StyleID)
  VALUES (10015, 21);
GO

USE EntertainmentAgencyModify;
GO
CREATE PROCEDURE CH15_Calculate_Entertainment_ContractPrice
AS 
UPDATE  Engagements
SET        ContractPrice = ROUND(1.15 * (DateDiff(d, StartDate, EndDate) + 1) *
             (SELECT     EntPricePerDay
              FROM          Entertainers
              WHERE      Entertainers.EntertainerID = Engagements.EntertainerID), 0);
GO

CREATE VIEW CH15_Calculate_Entertainment_ContractPrice_Query
AS 
SELECT EngagementNumber, StartDate, EndDate, ContractPrice, ROUND(1.15 * (DateDiff(d, StartDate, EndDate) + 1) *
             (SELECT     EntPricePerDay
              FROM          Entertainers
              WHERE      Entertainers.EntertainerID = Engagements.EntertainerID), 0)
AS NewContractPrice, EntertainerID
FROM Engagements;
GO

CREATE PROCEDURE CH15_Discount_Good_Customers_October
AS 
UPDATE    Engagements
SET              ContractPrice = ROUND(ContractPrice * 0.98, 0)
WHERE     (CustomerID IN
              (SELECT     Engagements.CustomerID
               FROM          Engagements
               WHERE      (Engagements.StartDate <= '10/31/2012') 
                 AND (Engagements.EndDate >= '10/1/2012')
               GROUP BY Engagements.CustomerID
               HAVING      SUM(Engagements.ContractPrice) > 3000));
GO

CREATE VIEW CH15_Discount_Good_Customers_October_Query
AS 
SELECT      ContractPrice, ROUND(ContractPrice * 0.98, 0) AS NewContractPrice
FROM Engagements 
WHERE     (CustomerID IN
              (SELECT     Engagements.CustomerID
               FROM          Engagements
               WHERE      (Engagements.StartDate <= '10/31/2012') 
                 AND (Engagements.EndDate >= '10/1/2012')
               GROUP BY Engagements.CustomerID
               HAVING      SUM(Engagements.ContractPrice) > 3000)) ;
GO

CREATE PROCEDURE CH15_Give_Agents_6Percent_Raise
AS 
UPDATE    Agents
SET          Salary = ROUND(Salary * 1.06, 0);
GO

CREATE VIEW CH15_Give_Agents_6Percent_Raise_Query
AS 
SELECT Agents.AgentID, Agents.AgtFirstName, Agents.AgtLastName, Agents.Salary, Round((Salary)*1.06,0) AS NewSalary
FROM    Agents;
GO

CREATE PROCEDURE CH15_Reward_Good_Agents
AS 
UPDATE    Agents
SET          CommissionRate = CommissionRate + 0.005
WHERE     (AgentID IN
            (SELECT     AgentID
             FROM          Engagements
             GROUP BY AgentID
             HAVING      SUM(ContractPrice) > 20000));
GO

CREATE VIEW CH15_Reward_Good_Agents_Query
AS 
SELECT      CommissionRate, CommissionRate + 0.005 AS NewCommissionRate
FROM   Agents
WHERE     (AgentID IN
            (SELECT     AgentID
             FROM          Engagements
             GROUP BY AgentID
             HAVING      SUM(ContractPrice) > 20000));
GO

CREATE PROCEDURE CH16_Add_Customer
AS 
INSERT INTO Customers
                      (CustFirstName, CustLastName, CustStreetAddress, CustCity, CustState, CustZipCode, CustPhoneNumber)
VALUES     ('Kendra', 'Hernandez', '457 211th St NE', 'Bothell', 'WA', '98200', '555-3945');
GO

CREATE VIEW CH16_Add_Customer_Query
AS 
SELECT 'Kendra' As CustFirstName, 'Hernandez' As CustLastName, '457 211th St NE' As CustStreetAddress, 'Bothell' As CustCity, 'WA' As CustState, '98200' As CustZipCode, '555-3945' As CustPhoneNumber
FROM Customers
WHERE CustomerID = 10001;
GO

CREATE PROCEDURE CH16_Add_Engagement
AS 
INSERT INTO Engagements
                      (CustomerID, EntertainerID, StartDate, EndDate, StartTime, StopTime, ContractPrice, AgentID)
SELECT     Customers.CustomerID, Entertainers.EntertainerID, '8/15/2013' AS StartDate, '8/16/2013' AS EndDate, '19:00:00' AS StartTime, '23:00:00' AS StopTime, 
                      ROUND(Entertainers.EntPricePerDay * 2 * 1.15, 0) AS ContractPrice, Agents.AgentID
FROM         Customers CROSS JOIN
                      Entertainers CROSS JOIN
                      Agents
WHERE     (Customers.CustFirstName = 'Matt') AND (Customers.CustLastName = 'Berg') AND (Entertainers.EntStageName = 'Jazz Persuasion') AND 
                      (Agents.AgtFirstName = 'Karen') AND (Agents.AgtLastName = 'Smith');
GO

CREATE VIEW CH16_Add_Engagement_Query
AS 
SELECT     Customers.CustomerID, Entertainers.EntertainerID, '8/15/2013' AS StartDate, '8/16/2013' AS EndDate, '19:00:00' AS StartTime, '23:00:00' AS StopTime, 
                      ROUND(Entertainers.EntPricePerDay * 2 * 1.15, 0) AS ContractPrice, Agents.AgentID
FROM         Customers CROSS JOIN
                      Entertainers CROSS JOIN
                      Agents
WHERE     (Customers.CustFirstName = 'Matt') AND (Customers.CustLastName = 'Berg') AND (Entertainers.EntStageName = 'Jazz Persuasion') AND 
                      (Agents.AgtFirstName = 'Karen') AND (Agents.AgtLastName = 'Smith');
GO

CREATE PROCEDURE CH16_Add_Style
AS 
INSERT INTO Musical_Styles
                      (StyleName)
VALUES     ('New Age');
GO

CREATE VIEW CH16_Add_Style_Query
AS
SELECT 'New Age' As StyeName
FROM Musical_Styles
WHERE StyleID = 1;
GO

CREATE PROCEDURE CH16_Archive_Engagements
AS 
INSERT INTO Engagements_Archive 
         (EngagementNumber, StartDate, EndDate, StartTime, StopTime, ContractPrice, 
          CustomerID, AgentID, EntertainerID) 
SELECT Engagements.EngagementNumber, Engagements.StartDate, Engagements.EndDate, 
Engagements.StartTime, Engagements.StopTime, Engagements.ContractPrice, Engagements.CustomerID, 
Engagements.AgentID, Engagements.EntertainerID
FROM Engagements
WHERE Engagements.EndDate < '01/01/2013';
GO

CREATE VIEW CH16_Archive_Engagements_Query
AS 
SELECT Engagements.EngagementNumber, Engagements.StartDate, Engagements.EndDate, 
Engagements.StartTime, Engagements.StopTime, Engagements.ContractPrice, Engagements.CustomerID, 
Engagements.AgentID, Engagements.EntertainerID
FROM Engagements
WHERE Engagements.EndDate < '01/01/2013';
GO

CREATE PROCEDURE CH16_Copy_Agent_To_Customer
AS 
INSERT INTO Customers
                      (CustFirstName, CustLastName, CustStreetAddress, CustCity, CustState, CustZipCode, CustPhoneNumber)
SELECT     AgtFirstName, AgtLastName, AgtStreetAddress, AgtCity, AgtState, AgtZipCode, AgtPhoneNumber
FROM         Agents
WHERE     (AgtFirstName = 'Marianne') AND (AgtLastName = 'Wier');
GO

CREATE VIEW CH16_Copy_Agent_To_Customer_Query
AS 
SELECT     AgtFirstName, AgtLastName, AgtStreetAddress, AgtCity, AgtState, AgtZipCode, AgtPhoneNumber
FROM         Agents
WHERE     (AgtFirstName = 'Marianne') AND (AgtLastName = 'Wier');
GO

CREATE PROCEDURE CH16_Duplicate_Engagement
AS 
INSERT INTO Engagements
                      (StartDate, EndDate, StartTime, StopTime, ContractPrice, CustomerID, AgentID, EntertainerID)
SELECT     '8/1/2013' AS StartDate, '8/4/2013' AS EndDate, Engagements.StartTime, Engagements.StopTime, Engagements.ContractPrice, 
                      Engagements.CustomerID, Engagements.AgentID, Engagements.EntertainerID
FROM         Customers INNER JOIN
                      Engagements ON Customers.CustomerID = Engagements.CustomerID
WHERE     (Customers.CustFirstName = 'Doris') AND (Customers.CustLastName = 'Hartwig') AND (Engagements.StartDate = '12/1/2012');
GO

CREATE VIEW CH16_Duplicate_Engagement_Query
AS 
SELECT     '8/1/2013' AS StartDate, '8/4/2013' AS EndDate, Engagements.StartTime, Engagements.StopTime, Engagements.ContractPrice, 
                      Engagements.CustomerID, Engagements.AgentID, Engagements.EntertainerID
FROM         Customers INNER JOIN
                      Engagements ON Customers.CustomerID = Engagements.CustomerID
WHERE     (Customers.CustFirstName = 'Doris') AND (Customers.CustLastName = 'Hartwig') AND (Engagements.StartDate = '12/1/2012');
GO

CREATE PROCEDURE CH17_Delete_Customers_Never_Booked
AS 
DELETE FROM Customers
WHERE     (CustomerID NOT IN
                          (SELECT     CustomerID
                            FROM          Engagements));
GO

CREATE VIEW CH17_Delete_Customers_Never_Booked_Query
AS 
SELECT * 
FROM Customers
WHERE     (CustomerID NOT IN
                          (SELECT     CustomerID
                            FROM          Engagements));
GO

CREATE PROCEDURE CH17_Delete_Entertainers_Not_Booked1
AS 
DELETE FROM Entertainer_Members
WHERE     (EntertainerID NOT IN
                          (SELECT     EntertainerID
                            FROM          Engagements));
GO

CREATE VIEW CH17_Delete_Entertainers_Not_Booked1_Query
AS 
SELECT * 
FROM Entertainer_Members
WHERE     (EntertainerID NOT IN
                          (SELECT     EntertainerID
                            FROM          Engagements));
GO

CREATE PROCEDURE CH17_Delete_Entertainers_Not_Booked2
AS 
DELETE FROM Entertainers
WHERE     (EntertainerID NOT IN
                          (SELECT     EntertainerID
                            FROM          Engagements));
GO

CREATE VIEW CH17_Delete_Entertainers_Not_Booked2_Query
AS 
SELECT * 
FROM Entertainers
WHERE     (EntertainerID NOT IN
                          (SELECT     EntertainerID
                            FROM          Engagements));
GO

CREATE PROCEDURE CH17_Delete_Members_Not_In_Group
AS 
DELETE FROM Members
WHERE     (MemberID NOT IN
                          (SELECT     MemberID
                            FROM          Entertainer_Members));
GO

CREATE VIEW CH17_Delete_Members_Not_In_Group_Query
AS 
SELECT * 
FROM Members
WHERE     (MemberID NOT IN
                          (SELECT     MemberID
                            FROM          Entertainer_Members));
GO

CREATE PROCEDURE CH17_Delete_Styles_No_Entertainer
AS
DELETE FROM Musical_Styles
WHERE     (StyleID NOT IN
                          (SELECT     StyleID
                            FROM          Entertainer_Styles))
      AND (StyleID NOT IN
                          (SELECT     StyleID
                            FROM          Musical_Preferences));
GO

CREATE VIEW CH17_Delete_Styles_No_Entertainer_Query
AS 
SELECT * 
FROM Musical_Styles
WHERE     (StyleID NOT IN
                          (SELECT     StyleID
                            FROM          Entertainer_Styles))
      AND (StyleID NOT IN
                          (SELECT     StyleID
                            FROM          Musical_Preferences));
GO

CREATE PROCEDURE CH17_Delete_Styles_No_Entertainer_Wrong
AS
DELETE FROM Musical_Styles
WHERE     (StyleID NOT IN
                          (SELECT     StyleID
                            FROM          Entertainer_Styles));
GO

CREATE VIEW CH17_Delete_Styles_No_Entertainer_Wrong_Query
AS 
SELECT * 
FROM Musical_Styles
WHERE     (StyleID NOT IN
                          (SELECT     StyleID
                            FROM          Entertainer_Styles));
GO

CREATE PROCEDURE CH17_Remove_Archived_Engagements
AS 
DELETE FROM Engagements
WHERE     (EngagementNumber IN
                          (SELECT     EngagementNumber
                            FROM          Engagements_Archive));
GO

CREATE VIEW CH17_Remove_Archived_Engagements_Query
AS 
SELECT * 
FROM Engagements
WHERE     (EngagementNumber IN
                          (SELECT     EngagementNumber
                            FROM          Engagements_Archive));
GO

USE EntertainmentAgencyExample;
GO

CREATE VIEW CH04_Agent_Phone_List
AS
SELECT TOP (100) PERCENT  AgtLastName, AgtFirstName, AgtPhoneNumber
FROM         Agents
ORDER BY AgtLastName, AgtFirstName;
GO

CREATE VIEW CH04_Engagement_Dates
AS
SELECT DISTINCT StartDate
FROM Engagements ;
GO

CREATE VIEW CH04_Engagement_Information
AS
SELECT Engagements.*
FROM Engagements ;
GO

CREATE VIEW CH04_Entertainer_Locations
AS
SELECT TOP (100) PERCENT EntCity, EntStageName
FROM         Entertainers
ORDER BY EntCity, EntStageName;
GO

CREATE VIEW CH04_Scheduled_Engagements
AS
SELECT  TOP (100) PERCENT StartDate, EngagementNumber
FROM         Engagements
ORDER BY StartDate DESC, EngagementNumber;
GO

CREATE VIEW CH05_Customers_By_City
AS
SELECT TOP (100) PERCENT CustCity AS City, CustLastName + ', ' + CustFirstName AS Customer
FROM         Customers
ORDER BY City, Customer;
GO

CREATE VIEW CH05_Engagement_Lengths
AS
SELECT     EngagementNumber, CAST(DateDiff(d, StartDate, EndDate) + 1 AS varchar) + ' day(s)' AS DueToRun
FROM         Engagements;
GO

CREATE VIEW CH05_Entertainer_Web_Sites
AS
SELECT EntStageName AS Entertainer, 'Web site: ' + EntWebPage AS Drop_By
FROM Entertainers ;
GO

CREATE VIEW CH05_First_Performance_Review
AS
SELECT TOP (100) PERCENT AgtLastName + ', ' + AgtFirstName AS Agent, DateHired, DateAdd(d, 180, DateHired) AS FirstReview
FROM         Agents
ORDER BY Agent;
GO

CREATE VIEW CH05_Net_Amount_Per_Contract
AS
SELECT EngagementNumber, ContractPrice, ContractPrice * 0.12 AS OurFee, ContractPrice - (ContractPrice * 0.12) AS NetAmount
FROM Engagements ;
GO

CREATE VIEW CH06_Eastside_Entertainers
AS
SELECT  TOP (100) PERCENT EntStageName, EntPhoneNumber, EntCity
FROM         Entertainers
WHERE      EntCity IN ('Bellevue', 'Redmond', 'Woodinville')
ORDER BY EntStageName;
GO

CREATE VIEW CH06_FourDay_Engagements
AS
SELECT EngagementNumber, StartDate, EndDate
FROM Engagements
WHERE DateDiff(d, StartDate, EndDate)=3 ;

GO

CREATE VIEW CH06_October_2012_Engagements
AS
SELECT EngagementNumber, ContractPrice, StartDate, EndDate
FROM Engagements
WHERE StartDate <= '10/31/2012' AND EndDate >= '10/1/2012' ;
GO

CREATE VIEW CH06_October_Dates_Between_Noon_and_Five
AS
SELECT     EngagementNumber, StartDate, StartTime
FROM         Engagements
WHERE     (StartDate <= '10/31/2012') AND (EndDate >= '10/1/2012') 
AND (StartTime BETWEEN '12:00:00 PM' AND '5:00:00 PM');
GO

CREATE VIEW CH06_Single_Day_Engagements
AS
SELECT EngagementNumber, StartDate, EndDate
FROM Engagements
WHERE StartDate = EndDate ;
GO

CREATE VIEW CH08_Agents_Booked_Dates
AS
SELECT  TOP (100) PERCENT Agents.AgtFirstName + ' ' + Agents.AgtLastName AS AgtFullName, Engagements.StartDate
FROM         Agents 
INNER JOIN   Engagements 
ON Agents.AgentID = Engagements.AgentID
ORDER BY Engagements.StartDate;
GO

CREATE VIEW CH08_Agents_Entertainers_Same_Postal
AS
SELECT (Agents.AgtFirstName + ' ' + Agents.AgtLastName) AS AgtFullName, Entertainers.EntStageName, Agents.AgtZipCode
FROM         Agents 
INNER JOIN   Entertainers 
ON (Agents.AgtZipCode = Entertainers.EntZipCode) ;
GO

CREATE VIEW CH08_Customers_Booked_Entertainers
AS
SELECT DISTINCT (Customers.CustFirstName + ' ' + Customers.CustLastName) AS CustFullName, Entertainers.EntStageName
FROM (Customers 
INNER JOIN Engagements 
ON (Customers.CustomerID = Engagements.CustomerID)) 
INNER JOIN Entertainers 
ON (Entertainers.EntertainerID = Engagements.EntertainerID) ;
GO

CREATE VIEW CH08_Entertainers_And_Contracts
AS
SELECT Entertainers.EntStageName, Engagements.StartDate, Engagements.EndDate, Engagements.ContractPrice
FROM         Entertainers 
INNER JOIN   Engagements 
ON (Entertainers.EntertainerID = Engagements.EntertainerID) ;
GO

CREATE VIEW CH08_Entertainers_Berg_AND_Hallmark
AS
SELECT     EntBerg.EntStageName
FROM 
        (SELECT DISTINCT Entertainers.EntertainerID, Entertainers.EntStageName
             FROM          (Entertainers 
             INNER JOIN     Engagements 
             ON Entertainers.EntertainerID = Engagements.EntertainerID) 
             INNER JOIN     Customers 
             ON Customers.CustomerID = Engagements.CustomerID
             WHERE      Customers.CustLastName = 'Berg') AS EntBerg 
         INNER JOIN
        (SELECT DISTINCT Entertainers.EntertainerID, Entertainers.EntStageName
             FROM          (Entertainers 
             INNER JOIN     Engagements 
             ON Entertainers.EntertainerID = Engagements.EntertainerID) 
             INNER JOIN     Customers 
             ON Customers.CustomerID = Engagements.CustomerID
             WHERE      Customers.CustLastName = 'Hallmark') AS EntHallmark 
         ON EntBerg.EntertainerID = EntHallmark.EntertainerID;
GO

CREATE VIEW CH08_Entertainers_For_Berg_Or_Hallmark
AS
SELECT DISTINCT Entertainers.EntStageName
FROM (Entertainers 
INNER JOIN Engagements 
ON (Entertainers.EntertainerID = Engagements.EntertainerID)) 
INNER JOIN Customers 
ON (Customers.CustomerID = Engagements.CustomerID)
WHERE Customers.CustLastName = 'Berg' 
OR Customers.CustLastName = 'Hallmark' ;
GO

CREATE VIEW CH09_Agents_No_Contracts
AS
SELECT Agents.AgentID, Agents.AgtFirstName, Agents.AgtLastName
FROM Agents LEFT JOIN Engagements 
ON (Agents.AgentID = Engagements.AgentID)
WHERE Engagements.EngagementNumber IS NULL ;
GO

CREATE VIEW CH09_All_Entertainers_And_Any_Engagements
AS
SELECT Entertainers.EntertainerID, Entertainers.EntStageName, Engagements.EngagementNumber, Engagements.StartDate, Engagements.CustomerID
FROM Entertainers LEFT JOIN Engagements 
ON (Entertainers.EntertainerID = Engagements.EntertainerID) ;
GO

CREATE VIEW CH09_All_Styles_And_Any_Customers
AS
SELECT Musical_Styles.StyleID, Musical_Styles.StyleName, Customers.CustomerID, Customers.CustFirstName, Customers.CustLastName
FROM Musical_Styles LEFT JOIN (Musical_Preferences
INNER JOIN Customers
ON Customers.CustomerID = Musical_Preferences.CustomerID)
ON Musical_Styles.StyleID = Musical_Preferences.StyleID;
GO

CREATE VIEW CH09_Customers_No_Bookings
AS
SELECT Customers.CustomerID, Customers.CustFirstName, Customers.CustLastName
FROM Customers LEFT JOIN Engagements 
ON (Customers.CustomerID = Engagements.CustomerID)
WHERE Engagements.EngagementNumber IS NULL ;
GO

CREATE VIEW CH09_Entertainers_Never_Booked
AS
SELECT Entertainers.EntertainerID, Entertainers.EntStageName
FROM Entertainers LEFT JOIN Engagements 
ON (Entertainers.EntertainerID = Engagements.EntertainerID)
WHERE Engagements.EngagementNumber Is Null ;
GO

CREATE VIEW CH10_Agents_UNION_Entertainers
AS
SELECT     Agents.AgtLastName + ', ' + Agents.AgtFirstName AS Name, 'Agent' AS Type
FROM         Agents
UNION
SELECT     Entertainers.EntStageName, 'Entertainer' AS Type
FROM         Entertainers;
GO

CREATE VIEW CH10_Customers_Entertainers_Contemporary
AS
SELECT     Customers.CustFirstName + ' ' + Customers.CustLastName AS Name, 'Customer' AS Type
FROM         Musical_Styles 
INNER JOIN   (Customers 
INNER JOIN    Musical_Preferences 
ON (Customers.CustomerID = Musical_Preferences.CustomerID)) 
ON (Musical_Styles.StyleID = Musical_Preferences.StyleID)
WHERE     Musical_Styles.StyleName = 'Contemporary'
UNION
SELECT     Entertainers.EntStageName, 'Entertainer' AS Type
FROM         Musical_Styles 
INNER JOIN   (Entertainers 
INNER JOIN    Entertainer_Styles 
ON (Entertainers.EntertainerID = Entertainer_Styles.EntertainerID)) 
ON (Musical_Styles.StyleID = Entertainer_Styles.StyleID)
WHERE     Musical_Styles.StyleName = 'Contemporary';
GO

CREATE VIEW CH10_Customers_UNION_Entertainers
AS
SELECT     Customers.CustLastName + ', ' + Customers.CustFirstName AS Name, 'Customer' AS Type
FROM         Customers
UNION
SELECT     Entertainers.EntStageName AS Name, 'Entertainer' AS Type
FROM         Entertainers;
GO

CREATE VIEW CH11_Customers_Last_Booking
AS
SELECT Customers.CustFirstName, Customers.CustLastName, (Select max(StartDate) FROM Engagements WHERE Engagements.CustomerID = Customers.CustomerID) AS LastBooking
FROM Customers ;
GO

CREATE VIEW CH11_Customers_Who_Like_Country
AS
SELECT     CustomerID, CustFirstName, CustLastName
FROM         Customers
WHERE     (CustomerID IN
          (SELECT     Engagements.CustomerID
           FROM     ((Musical_Styles 
           INNER JOIN Entertainer_Styles 
           ON Musical_Styles.StyleID = Entertainer_Styles.StyleID) 
           INNER JOIN Entertainers 
           ON Entertainers.EntertainerID = Entertainer_Styles.EntertainerID) 
           INNER JOIN Engagements 
           ON Entertainers.EntertainerID = Engagements.EntertainerID
           WHERE      Musical_Styles.StyleName = 'Country' OR
                      Musical_Styles.StyleName = 'Country Rock'));
GO

CREATE VIEW CH11_Entertainer_Engagement_Count
AS
SELECT Entertainers.EntStageName, (SELECT count(*) FROM Engagements WHERE Engagements.EntertainerID = Entertainers.EntertainerID) AS EngageCount
FROM Entertainers ;
GO

CREATE VIEW CH11_Entertainers_Berg_EXISTS
AS 
SELECT     Entertainers.EntertainerID, Entertainers.EntStageName
FROM         Entertainers
WHERE     EXISTS 
          (SELECT * 
           FROM        Customers 
           INNER JOIN  Engagements 
           ON Customers.CustomerID = Engagements.CustomerID 
           WHERE Customers.CustLastName='Berg'
              AND Engagements.EntertainerID = Entertainers.EntertainerID);
GO

CREATE VIEW CH11_Entertainers_Berg_IN
AS 
SELECT     Entertainers.EntertainerID, Entertainers.EntStageName
FROM         Entertainers
WHERE      EntertainerID IN 
           (SELECT    Engagements.EntertainerID 
            FROM       Customers 
            INNER JOIN Engagements 
            ON Customers.CustomerID = Engagements.CustomerID 
            WHERE Customers.CustLastName='Berg');
GO


CREATE VIEW CH11_Entertainers_Berg_OR_Hallmark_SOME
AS
SELECT     EntertainerID, EntStageName
FROM         Entertainers
WHERE     (EntertainerID = SOME
            (SELECT     Engagements.EntertainerID
             FROM          Customers 
             INNER JOIN    Engagements 
             ON Customers.CustomerID = Engagements.CustomerID
             WHERE      Customers.CustLastName = 'Berg' 
              OR       Customers.CustLastName = 'Hallmark'));
GO

CREATE VIEW CH12_Average_Agent_Salary
AS
SELECT avg(Salary) AS AverageAgentSalary
FROM Agents ;
GO

CREATE VIEW CH12_Contract_Price_GE_Average_Contract_Price
AS
SELECT     EngagementNumber
FROM         Engagements
WHERE     (ContractPrice >=
                          (SELECT     AVG(ContractPrice)
                            FROM          Engagements));
GO

CREATE VIEW CH12_Earliest_Contracts
AS
SELECT EngagementNumber, ContractPrice
FROM Engagements
WHERE StartDate =    
    (SELECT min(StartDate) FROM Engagements) ;
GO

CREATE VIEW CH12_Number_Of_Bellevue_Entertainers
AS
SELECT count(*) AS NumberOfEntertainers
FROM Entertainers
WHERE EntCity = 'Bellevue' ;
GO

CREATE VIEW CH12_Total_Booked_Value_For_October_2012
AS
SELECT sum(ContractPrice) AS TotalBookedValue
FROM Engagements
WHERE StartDate BETWEEN '10/1/2012' AND '10/31/2012' ;
GO

CREATE VIEW CH13_Agent_Sales_And_Commissions
AS
SELECT Agents.AgtFirstName, Agents.AgtLastName, sum(Engagements.ContractPrice) AS SumOfContractPrice, convert(money,sum(ContractPrice) * CommissionRate) AS Commission
FROM Agents 
INNER JOIN Engagements 
ON (Agents.AgentID = Engagements.AgentID)
GROUP BY Agents.AgtFirstName, Agents.AgtLastName, Agents.CommissionRate ;
GO

CREATE VIEW CH13_Aggregate_Contract_Info_All_Entertainers
AS
SELECT Entertainers.EntStageName, Count(Engagements.EntertainerID) AS NumContracts, 
Sum(Engagements.ContractPrice) AS TotPrice, Min(Engagements.ContractPrice) AS MinPrice, 
Max(Engagements.ContractPrice) AS MaxPrice, Avg(Engagements.ContractPrice) AS AvgPrice
FROM Entertainers 
LEFT JOIN Engagements 
ON Entertainers.EntertainerID=Engagements.EntertainerID
GROUP BY Entertainers.EntStageName;
GO

CREATE VIEW CH13_Aggregate_Contract_Info_By_Customer
AS
SELECT Customers.CustLastName, Customers.CustFirstName, count(*) AS NumContracts, 
sum(Engagements.ContractPrice) AS TotPrice, min(Engagements.ContractPrice) AS MinPrice, 
max(Engagements.ContractPrice) AS MaxPrice, avg(Engagements.ContractPrice) AS AvgPrice
FROM Customers 
INNER JOIN Engagements 
ON (Customers.CustomerID = Engagements.CustomerID)
GROUP BY Customers.CustLastName, Customers.CustFirstName ;
GO

CREATE VIEW CH13_Aggregate_Contract_Info_By_Entertainer
AS
SELECT Entertainers.EntStageName, count(*) AS NumContracts, sum(Engagements.ContractPrice) AS TotPrice, min(Engagements.ContractPrice) AS MinPrice, max(Engagements.ContractPrice) AS MaxPrice, avg(Engagements.ContractPrice) AS AvgPrice
FROM Entertainers 
INNER JOIN Engagements 
ON (Entertainers.EntertainerID = Engagements.EntertainerID)
GROUP BY Entertainers.EntStageName ;
GO

CREATE VIEW CH13_Biggest_Big_Contract
AS
SELECT     Customers.CustFirstName, Customers.CustLastName, Engagements.StartDate, Engagements.ContractPrice
FROM       Customers 
           INNER JOIN Engagements 
           ON Customers.CustomerID = Engagements.CustomerID
WHERE     (Engagements.ContractPrice > ALL
                 (SELECT     SUM(ContractPrice)
                   FROM          Engagements AS E2
                   WHERE      E2.CustomerID <> Customers.CustomerID
                   GROUP BY E2.CustomerID));
GO

CREATE VIEW CH13_Customers_Last_Booking
AS
SELECT Customers.CustLastName + ', ' + Customers.CustFirstName AS CustomerFullName, Customers.CustStreetAddress + ', ' + Customers.CustCity + ', ' + Customers.CustState + ' ' + Customers.CustZipCode AS CustomerFullAddress, max(Engagements.StartDate) AS LatestDate, sum(Engagements.ContractPrice) AS TotalContractPrice
FROM Customers 
INNER JOIN Engagements 
ON (Customers.CustomerID = Engagements.CustomerID)
GROUP BY Customers.CustLastName, Customers.CustFirstName, Customers.CustStreetAddress, Customers.CustCity, Customers.CustState, Customers.CustZipCode ;
GO

CREATE VIEW CH13_Entertainers_And_ContractPrices
AS
SELECT TOP (100) PERCENT Entertainers.EntStageName, Engagements.ContractPrice
FROM         Entertainers 
             INNER JOIN Engagements 
             ON Entertainers.EntertainerID = Engagements.EntertainerID
ORDER BY Entertainers.EntStageName;
GO

CREATE VIEW CH13_Member_Pay
AS
SELECT TOP (100) PERCENT Entertainers.EntertainerID, Members.MbrFirstName, Members.MbrLastName, 
                      CAST(SUM(Engagements.ContractPrice) /
                          (SELECT     COUNT(*)
                            FROM          Entertainer_Members AS EM2
                            WHERE      EM2.Status <> 3 AND EM2.EntertainerID = Entertainers.EntertainerID) AS Money) AS MemberPay
FROM         Members 
INNER JOIN   Entertainer_Members 
ON Members.MemberID = Entertainer_Members.MemberID 
INNER JOIN   Entertainers 
ON Entertainers.EntertainerID = Entertainer_Members.EntertainerID 
INNER JOIN   Engagements 
ON Entertainers.EntertainerID = Engagements.EntertainerID
WHERE     (Entertainer_Members.Status <> 3)
GROUP BY Entertainers.EntertainerID, Members.MbrFirstName, Members.MbrLastName
ORDER BY Members.MbrLastName;
GO

CREATE VIEW CH14_Agent_Sales_Big_Commissions
AS
SELECT Agents.AgtFirstName, Agents.AgtLastName, sum(Engagements.ContractPrice) AS SumOfContractPrice, convert(money,sum(ContractPrice) * CommissionRate) AS Commission
FROM Agents 
INNER JOIN Engagements 
ON (Agents.AgentID = Engagements.AgentID)
GROUP BY Agents.AgtFirstName, Agents.AgtLastName, Agents.CommissionRate
HAVING sum(ContractPrice * CommissionRate) > 1000 ;
GO

CREATE VIEW CH14_Agents_Book_Over_3000_12_2012
AS
SELECT Agents.AgtFirstName, Agents.AgtLastName, sum(Engagements.ContractPrice) AS TotalBooked
FROM Agents 
INNER JOIN Engagements 
ON (Agents.AgentID = Engagements.AgentID)
WHERE Engagements.StartDate Between '12/1/2012' And '12/31/2012'
GROUP BY Agents.AgtFirstName, Agents.AgtLastName
HAVING sum(Engagements.ContractPrice) > 3000 ;
GO

CREATE VIEW CH14_Entertainers_MoreThan_2_Overlap
AS
SELECT     EntertainerID, EntStageName
FROM         Entertainers
WHERE     (EntertainerID IN
             (SELECT     E1.EntertainerID
              FROM          Engagements AS E1 
              INNER JOIN Engagements AS E2 
              ON E1.EntertainerID = E2.EntertainerID
              WHERE      E1.EngagementNumber <> E2.EngagementNumber                AND E1.StartDate <= E2.EndDate 
               AND E1.EndDate >= E2.StartDate
              GROUP BY E1.EntertainerID
              HAVING      COUNT(*) > 2));
GO

CREATE VIEW CH14_Jazz_Entertainers_More_Than_3
AS 
SELECT Entertainers.EntertainerID, Entertainers.EntStageName, Count(Entertainer_Members.EntertainerID) AS CountOfEntertainerID
FROM ((Entertainers INNER JOIN Entertainer_Members 
ON Entertainers.EntertainerID=Entertainer_Members.EntertainerID) 
INNER JOIN Entertainer_Styles 
ON Entertainers.EntertainerID=Entertainer_Styles.EntertainerID) 
INNER JOIN Musical_Styles 
ON Musical_Styles.StyleID=Entertainer_Styles.StyleID
WHERE Musical_Styles.StyleName='Jazz'
GROUP BY Entertainers.EntertainerID, Entertainers.EntStageName
HAVING Count(Entertainer_Members.EntertainerID)>3;
GO

CREATE VIEW CH18_Agents_Not_Book_Country_CountryRock
AS 
SELECT Agents.AgentID, Agents.AgtFirstName, Agents.AgtLastName
FROM Agents
WHERE Agents.AgentID NOT IN 
(SELECT Engagements.AgentID 
FROM ((Engagements
INNER JOIN Entertainers 
ON Engagements.EntertainerID = Entertainers.EntertainerID) 
INNER JOIN Entertainer_Styles 
ON Entertainers.EntertainerID = Entertainer_Styles.EntertainerID) 
INNER JOIN Musical_Styles 
ON Entertainer_Styles.StyleID = Musical_Styles.StyleID
WHERE Musical_Styles.StyleName IN ('Country', 'Country Rock'));
GO

CREATE VIEW CH18_Customers_No_Bookings_NOT_IN
AS 
SELECT Customers.CustomerID, Customers.CustFirstName, Customers.CustLastName
FROM Customers
WHERE Customers.CustomerID NOT IN
(SELECT Engagements.CustomerID FROM Engagements);
GO

CREATE VIEW CH18_Customers_Not_Booked_Topazz_Or_ModernDance
AS 
SELECT Customers.CustomerID, Customers.CustFirstName, Customers.CustLastName
FROM Customers
WHERE Customers.CustomerID NOT IN
(SELECT CustomerID 
FROM Engagements
INNER JOIN Entertainers 
ON Engagements.EntertainerID = Entertainers.EntertainerID 
WHERE Entertainers.EntStageName = 'Topazz')
AND CustomerID NOT IN
(SELECT CustomerID 
FROM Engagements
INNER JOIN Entertainers 
ON Engagements.EntertainerID = Entertainers.EntertainerID 
WHERE Entertainers.EntStageName = 'Modern Dance');
GO

CREATE VIEW CH18_Customers_Peacock_Coie_Jazz_EXISTS
AS 
SELECT Customers.CustomerID, Customers.CustFirstName, Customers.CustLastName
FROM Customers
WHERE EXISTS  
(SELECT Engagements.CustomerID 
FROM Engagements
INNER JOIN Entertainers 
ON Engagements.EntertainerID=Entertainers.EntertainerID 
WHERE Entertainers.EntStageName='Carol Peacock Trio'
AND Engagements.CustomerID = Customers.CustomerID)
AND EXISTS 
(SELECT Engagements.CustomerID 
FROM Engagements
INNER JOIN Entertainers 
ON Engagements.EntertainerID=Entertainers.EntertainerID 
WHERE Entertainers.EntStageName='Caroline Coie Cuartet'
AND Engagements.CustomerID = Customers.CustomerID)
AND EXISTS 
(SELECT Engagements.CustomerID 
FROM Engagements
INNER JOIN Entertainers 
ON Engagements.EntertainerID=Entertainers.EntertainerID 
WHERE Entertainers.EntStageName='Jazz Persuasion'
AND Engagements.CustomerID = Customers.CustomerID);
GO

CREATE VIEW CH18_Customers_Peacock_Coie_Jazz_IN_RIGHT
AS 
SELECT Customers.CustomerID, Customers.CustFirstName, Customers.CustLastName
FROM Customers
WHERE Customers.CustomerID IN 
(SELECT Engagements.CustomerID 
FROM Engagements
INNER JOIN Entertainers 
ON Engagements.EntertainerID=Entertainers.EntertainerID 
WHERE Entertainers.EntStageName='Carol Peacock Trio')
AND Customers.CustomerID IN 
(SELECT Engagements.CustomerID 
FROM Engagements
INNER JOIN Entertainers 
ON Engagements.EntertainerID=Entertainers.EntertainerID 
WHERE Entertainers.EntStageName='Caroline Coie Cuartet')
AND Customers.CustomerID IN 
(SELECT Engagements.CustomerID 
FROM Engagements
INNER JOIN Entertainers 
ON Engagements.EntertainerID=Entertainers.EntertainerID 
WHERE Entertainers.EntStageName='Jazz Persuasion');
GO

CREATE VIEW CH18_Customers_Peacock_Coie_Jazz_IN_WRONG
AS 
SELECT Customers.CustomerID, Customers.CustFirstName, Customers.CustLastName
FROM Customers
WHERE Customers.CustomerID IN 
(SELECT Customers.CustomerID 
FROM (Customers
INNER JOIN Engagements 
ON Customers.CustomerID = Engagements.CustomerID) 
INNER JOIN Entertainers 
ON Engagements.EntertainerID = Entertainers.EntertainerID  
WHERE Entertainers.EntStageName IN 
('Carol Peacock Trio', 'Caroline Coie Cuartet', 'Jazz Persuasion'));
GO

CREATE VIEW CH18_Customers_Peacock_Coie_Jazz_INNERJOIN
AS 
SELECT DISTINCT CPT.CustomerID, CPT.CustFirstName, CPT.CustLastName
FROM ((SELECT Customers.CustomerID, Customers.CustFirstName, Customers.CustLastName FROM (Customers
INNER JOIN Engagements
ON Customers.CustomerID=Engagements.CustomerID)
INNER JOIN Entertainers
ON Engagements.EntertainerID=Entertainers.EntertainerID WHERE Entertainers.EntStageName='Carol Peacock Trio')  AS CPT
INNER JOIN (SELECT Customers.CustomerID FROM (Customers
INNER JOIN Engagements
ON Customers.CustomerID=Engagements.CustomerID)
INNER JOIN Entertainers
ON Engagements.EntertainerID=Entertainers.EntertainerID WHERE Entertainers.EntStageName='Caroline Coie Cuartet')  AS CCC
ON CPT.CustomerID=CCC.CustomerID)
INNER JOIN (SELECT Customers.CustomerID FROM (Customers
INNER JOIN Engagements
ON Customers.CustomerID=Engagements.CustomerID)
INNER JOIN Entertainers
ON Engagements.EntertainerID=Entertainers.EntertainerID WHERE Entertainers.EntStageName='Jazz Persuasion')  AS JP
ON CCC.CustomerID=JP.CustomerID;
GO

CREATE VIEW CH18_Entertainers_Berg_AND_Hallmark_EXISTS
AS 
SELECT Entertainers.EntertainerID, Entertainers.EntStageName
FROM Entertainers
WHERE EXISTS 
(SELECT * FROM Customers 
INNER JOIN Engagements 
ON Customers.CustomerID = Engagements.CustomerID 
WHERE Customers.CustLastName='Berg'
AND Engagements.EntertainerID = Entertainers.EntertainerID) 
AND EXISTS 
(SELECT * 
FROM Customers 
INNER JOIN Engagements 
ON Customers.CustomerID = Engagements.CustomerID 
WHERE Customers.CustLastName='Hallmark'
AND Engagements.EntertainerID = Entertainers.EntertainerID);
GO

CREATE VIEW CH18_Entertainers_Fully_Match_Customers_Style
AS 
SELECT Customers.CustomerID, Customers.CustFirstName, Customers.CustLastName, Entertainers.EntertainerID, Entertainers.EntStageName, Count(Musical_Preferences.StyleID) AS CountOfStyleID
FROM ((Customers
INNER JOIN Musical_Preferences
ON Customers.CustomerID=Musical_Preferences.CustomerID)
INNER JOIN Entertainer_Styles
ON Musical_Preferences.StyleID=Entertainer_Styles.StyleID)
INNER JOIN Entertainers
ON Entertainers.EntertainerID=Entertainer_Styles.EntertainerID
GROUP BY Customers.CustomerID, Customers.CustFirstName, Customers.CustLastName, Entertainers.EntertainerID, Entertainers.EntStageName
HAVING Count(Musical_Preferences.StyleID) =  (SELECT Count(*)  FROM Musical_Preferences  WHERE Musical_Preferences.CustomerID = Customers.CustomerID);
GO

CREATE VIEW CH18_Entertainers_Hartwig_McCrae_AND_Rosales_EXISTS
AS 
SELECT Entertainers.EntertainerID, Entertainers.EntStageName
FROM Entertainers
WHERE EXISTS 
(SELECT * FROM Customers 
INNER JOIN Engagements 
ON Customers.CustomerID = Engagements.CustomerID 
WHERE Customers.CustLastName='Hartwig'
AND Engagements.EntertainerID = Entertainers.EntertainerID) 
AND EXISTS 
(SELECT * 
FROM Customers 
INNER JOIN Engagements 
ON Customers.CustomerID = Engagements.CustomerID 
WHERE Customers.CustLastName='McCrae'
AND Engagements.EntertainerID = Entertainers.EntertainerID)
AND EXISTS 
(SELECT * 
FROM Customers 
INNER JOIN Engagements 
ON Customers.CustomerID = Engagements.CustomerID 
WHERE Customers.CustLastName='Rosales'
AND Engagements.EntertainerID = Entertainers.EntertainerID);
GO

CREATE VIEW CH18_Entertainers_Jazz_RhythmBlues_Salsa_HAVING
AS 
SELECT Entertainers.EntertainerID, Entertainers.EntStageName
FROM (Entertainers
INNER JOIN Entertainer_Styles
ON Entertainers.EntertainerID=Entertainer_Styles.EntertainerID)
INNER JOIN Musical_Styles
ON Entertainer_Styles.StyleID=Musical_Styles.StyleID
WHERE Musical_Styles.StyleName In ('Jazz','Rhythm and Blues','Salsa')
GROUP BY Entertainers.EntertainerID, Entertainers.EntStageName
HAVING Count(*)=3;
GO

CREATE VIEW CH18_Entertainers_Jazz_RhythmBlues_Salsa_IN
AS 
SELECT Entertainers.EntertainerID, Entertainers.EntStageName
FROM Entertainers
WHERE Entertainers.EntertainerID IN 
(SELECT Entertainer_Styles.EntertainerID 
FROM Entertainer_Styles
INNER JOIN Musical_Styles
ON Entertainer_Styles.StyleID = Musical_Styles.StyleID
WHERE Musical_Styles.StyleName = 'Jazz')
AND Entertainers.EntertainerID IN  
(SELECT Entertainer_Styles.EntertainerID 
FROM Entertainer_Styles
INNER JOIN Musical_Styles
ON Entertainer_Styles.StyleID = Musical_Styles.StyleID
WHERE Musical_Styles.StyleName = 'Rhythm and Blues')
AND Entertainers.EntertainerID IN
(SELECT Entertainer_Styles.EntertainerID 
FROM Entertainer_Styles
INNER JOIN Musical_Styles
ON Entertainer_Styles.StyleID = Musical_Styles.StyleID
WHERE Musical_Styles.StyleName = 'Salsa');
GO

CREATE VIEW CH18_Entertainers_Jazz_RhythmBlues_Salsa_IN_WRONG
AS 
SELECT Entertainers.EntertainerID, Entertainers.EntStageName
FROM Entertainers
WHERE Entertainers.EntertainerID IN 
(SELECT Entertainer_Styles.EntertainerID 
FROM Entertainer_Styles
INNER JOIN Musical_Styles
ON Entertainer_Styles.StyleID = Musical_Styles.StyleID
WHERE Musical_Styles.StyleName IN ('Jazz', 'Rhythm and Blues', 'Salsa'));
GO

CREATE VIEW CH18_Entertainers_Never_Booked_NOT_IN
AS 
SELECT Entertainers.EntertainerID, Entertainers.EntStageName
FROM Entertainers
WHERE Entertainers.EntertainerID NOT IN
(SELECT Engagements.EntertainerID FROM Engagements);
GO

CREATE VIEW CH18_Entertainers_Not_Booked_90Days_Before_May12013
AS 
SELECT Entertainers.EntertainerID, Entertainers.EntStageName
FROM Entertainers
WHERE Entertainers.EntertainerID NOT IN
(SELECT Engagements.EntertainerID 
FROM Engagements 
WHERE Engagements.StartDate >DateAdd(d, -90, '2013-05-01'));
GO

CREATE VIEW CH19_Customer_Styles_Oldies
AS
SELECT        Customers.CustomerID, Customers.CustFirstName, Customers.CustLastName, 
                         (CASE StyleName 
                          WHEN '50''s Music' THEN 'Oldies' 
                          WHEN '60''s Music' THEN 'Oldies' 
                          WHEN '70''s Music' THEN 'Oldies' 
                          WHEN '80''s Music' THEN 'Oldies' ELSE StyleName
                          END) AS CustStyle
FROM            Customers INNER JOIN Musical_Preferences 
                          ON Customers.CustomerID = Musical_Preferences.CustomerID 
                          INNER JOIN Musical_Styles 
                          ON Musical_Preferences.StyleID = Musical_Styles.StyleID;
GO

CREATE VIEW CH19_Customers_Jazz_Not_Standards
AS
SELECT        CustomerID, CustFirstName, CustLastName
FROM            Customers
WHERE        (1 = (CASE WHEN CustomerID NOT IN
                             (SELECT        CustomerID
                               FROM            Musical_Preferences INNER JOIN Musical_Styles 
                                               ON Musical_Preferences.StyleID = Musical_Styles.StyleID
                               WHERE        Musical_Styles.StyleName = 'Jazz') 
                   THEN 0 
                   WHEN CustomerID IN
                             (SELECT        CustomerID
                               FROM            Musical_Preferences INNER JOIN Musical_Styles 
                                               ON Musical_Preferences.StyleID = Musical_Styles.StyleID
                               WHERE        Musical_Styles.StyleName = 'Standards') 
                   THEN 0 ELSE 1 END));
GO

CREATE VIEW CH19_Entertainers_Booked_Xmas_2012
AS
SELECT        EntertainerID, EntStageName, 
              (CASE WHEN EntertainerID IN
                             (SELECT        EntertainerID
                               FROM            Engagements
                               WHERE        CAST('2012-12-25' AS Date) BETWEEN StartDate AND EndDate) 
                    THEN 'Booked' ELSE 'Not Booked' END) AS BookedXmas2012
FROM            Entertainers;
GO

CREATE VIEW CH19_Entertainers_Jazz_Not_Contemporary
AS
SELECT        EntertainerID, EntStageName
FROM            Entertainers
WHERE        (1 = (CASE WHEN EntertainerID NOT IN
                             (SELECT        EntertainerID
                               FROM            Entertainer_Styles INNER JOIN
                                                         Musical_Styles ON Entertainer_Styles.StyleID = Musical_Styles.StyleID
                               WHERE        Musical_Styles.StyleName = 'Jazz') 
                   THEN 0 
                   WHEN EntertainerID IN
                             (SELECT        EntertainerID
                               FROM            Entertainer_Styles INNER JOIN
                                                         Musical_Styles ON Entertainer_Styles.StyleID = Musical_Styles.StyleID
                               WHERE        Musical_Styles.StyleName = 'Contemporary') 
                   THEN 0 ELSE 1 END));
GO

CREATE VIEW CH20_Agents_Entertainers_Unbooked_Feb12013
AS
SELECT TOP (100) PERCENT Agents.AgentID, Agents.AgtFirstName, Agents.AgtLastName, Agents.AgtStreetAddress, Agents.AgtCity, Agents.AgtState, Agents.AgtZipCode, 
            Entertainers.EntertainerID, Entertainers.EntStageName, Entertainers.EntPhoneNumber, Musical_Styles.StyleName
FROM Agents, (Entertainers INNER JOIN Entertainer_Styles 
                          ON Entertainers.EntertainerID = Entertainer_Styles.EntertainerID) 
                         INNER JOIN Musical_Styles 
                         ON Musical_Styles.StyleID = Entertainer_Styles.StyleID
WHERE Entertainers.EntertainerID Not In 
    (SELECT Engagements.EntertainerID 
     FROM Engagements 
     WHERE Engagements.StartDate >= CAST('2013-02-01' AS date))
ORDER BY Agents.AgentID, Entertainers.EntertainerID;
GO

CREATE VIEW CH20_All_December_Days_Any_Bookings
AS 
SELECT ztblDays.DateField, BD.EntertainerID, BD.EntStageName
FROM ztblDays LEFT JOIN 
(SELECT ztblDays.DateField, Entertainers.EntertainerID, Entertainers.EntStageName 
FROM ztblDays, Entertainers INNER JOIN Engagements
ON Entertainers.EntertainerID=Engagements.EntertainerID 
WHERE ztblDays.DateField>=Engagements.StartDate 
AND ztblDays.DateFIeld<=Engagements.EndDate 
AND ztblDays.DateField Between CAST('2012-12-01' AS date) AND CAST('2012-12-31' AS date))  AS BD
ON ztblDays.DateField=BD.DateField
WHERE ztblDays.DateField Between CAST('2012-12-01' AS date) And CAST('2012-12-31' AS date);
GO


CREATE VIEW CH20_All_Weeks_Jan2013_All_Engagements
AS 
SELECT ztblWeeks.WeekStart, ztblWeeks.WeekEnd, Entertainers.EntertainerID, Entertainers.EntStageName, 
  Customers.CustFirstName, Customers.CustLastName, Engagements.StartDate, Engagements.EndDate
FROM ztblWeeks, (Customers INNER JOIN Engagements
ON Customers.CustomerID=Engagements.CustomerID)
INNER JOIN Entertainers
ON Entertainers.EntertainerID=Engagements.EntertainerID
WHERE (ztblWeeks.WeekStart <= CAST('2013-01-31' AS date))
AND (ztblWeeks.WeekEnd >= CAST('2013-01-01' AS date))
AND (Engagements.StartDate <= ztblWeeks.WeekEnd)
AND (Engagements.EndDate >= ztblWeeks.WeekStart);
GO


CREATE VIEW CH20_Customer_Mailing_Skip_4
AS 
SELECT TOP 100 PERCENT * FROM 
(SELECT ' ' As CustFirstName, ' ' As CustLastName, ' ' As CustStreenAddress, ' ' As CustCity, ' ' As CustState, ' ' As CustZipCode 
FROM ztblSkipLabels
WHERE ztblSkipLabels.LabelCount <= 4
UNION ALL SELECT Customers.CustFirstName, Customers.CustLastName, Customers.CustStreetAddress, Customers.CustCity, Customers.CustState, Customers.CustZipCode
FROM Customers) AS CustLabels 
ORDER BY CustZipCode, CustLastName;
GO


CREATE VIEW CH20_Customer_Style_Preference_Rankings
AS 
SELECT TOP 100 PERCENT Musical_Styles.StyleID, Musical_Styles.StyleName, COUNT(RankedPreferences.FirstStyle) AS FirstPreference, 
  COUNT(RankedPreferences.SecondStyle) AS SecondPreference, COUNT(RankedPreferences.ThirdStyle) AS ThirdPreference
FROM Musical_Styles, (SELECT (CASE WHEN Musical_Preferences.PreferenceSeq = 1 
                              THEN Musical_Preferences.StyleID ELSE Null END) As FirstStyle, 
                              (CASE WHEN Musical_Preferences.PreferenceSeq = 2
                              THEN Musical_Preferences.StyleID ELSE Null END) As SecondStyle, 
                              (CASE WHEN Musical_Preferences.PreferenceSeq = 3 
                              THEN Musical_Preferences.StyleID ELSE Null END) As ThirdStyle
			FROM Musical_Preferences)  AS RankedPreferences
WHERE Musical_Styles.StyleID = RankedPreferences.FirstStyle 
OR Musical_Styles.StyleID = RankedPreferences.SecondStyle
OR Musical_Styles.StyleID = RankedPreferences.ThirdStyle
GROUP BY StyleID, StyleName
HAVING COUNT(FirstStyle) > 0 
OR     COUNT(SecondStyle) > 0 
OR     COUNT(ThirdStyle) > 0
ORDER BY FirstPreference DESC, SecondPreference DESC, ThirdPreference DESC, StyleID;
GO


CREATE VIEW CH20_Customers_Match_Entertainers_FirstSecond_PrefStrength
AS 
SELECT CustomerID, CustFirstName, CustLastName, EntertainerID, EntStageName, 
   FirstPreference, SecondPreference, ThirdPreference, FirstStrength, SecondStrength, ThirdStrength
FROM (SELECT 		Customers.CustomerID, Customers.CustFirstName, Customers.CustLastName, 
		MAX((CASE WHEN Musical_Preferences.PreferenceSeq = 1  
                     THEN Musical_Preferences.StyleID ELSE Null END)) AS FirstPreference,
		MAX((CASE WHEN Musical_Preferences.PreferenceSeq = 2  
                     THEN Musical_Preferences.StyleID ELSE Null END)) AS SecondPreference,
		MAX((CASE WHEN Musical_Preferences.PreferenceSeq = 3  
                     THEN Musical_Preferences.StyleID ELSE Null END)) AS ThirdPreference
	FROM Musical_Preferences
        INNER JOIN Customers
        ON Musical_Preferences.CustomerID = Customers.CustomerID 
GROUP BY Customers.CustomerID, Customers.CustFirstName, Customers.CustLastName)  AS RankedPreferences, 
(SELECT Entertainers.EntertainerID, Entertainers.EntStageName, 
		MAX((CASE WHEN Entertainer_Styles.StyleStrength = 1 
                     THEN Entertainer_Styles.StyleID ELSE Null END)) AS FirstStrength, 
		MAX((CASE WHEN Entertainer_Styles.StyleStrength = 2 
                     THEN Entertainer_Styles.StyleID ELSE Null END)) AS SecondStrength, 
		MAX((CASE WHEN Entertainer_Styles.StyleStrength = 3 
                     THEN Entertainer_Styles.StyleID ELSE Null END)) As ThirdStrength 
	FROM Entertainer_Styles
        INNER JOIN Entertainers 
        ON Entertainer_Styles.EntertainerID = Entertainers.EntertainerID 
GROUP BY Entertainers.EntertainerID, Entertainers.EntStageName)  AS RankedStrengths
WHERE ((FirstPreference = FirstStrength)
AND (SecondPreference = SecondStrength))
OR ((SecondPreference =FirstStrength)
AND (FirstPreference = SecondStrength));
GO


CREATE VIEW CH20_Entertainer_BookingAmount_ByMonth
AS 
SELECT Entertainers.EntStageName, SUM(Engagements.ContractPrice*ztblMonths.January) AS January, 
   SUM(Engagements.ContractPrice*ztblMonths.February) AS February, 
   SUM(Engagements.ContractPrice*ztblMonths.March) AS March, 
   SUM(Engagements.ContractPrice*ztblMonths.April) AS April, 
   SUM(Engagements.ContractPrice*ztblMonths.May) AS May, 
   SUM(Engagements.ContractPrice*ztblMonths.June) AS June, 
   SUM(Engagements.ContractPrice*ztblMonths.July) AS July, 
   SUM(Engagements.ContractPrice*ztblMonths.August) AS August, 
   SUM(Engagements.ContractPrice*ztblMonths.September) AS September, 
   SUM(Engagements.ContractPrice*ztblMonths.October) AS October, 
   SUM(Engagements.ContractPrice*ztblMonths.November) AS November, 
   SUM(Engagements.ContractPrice*ztblMonths.December) AS December
FROM ztblMonths, Entertainers
INNER JOIN Engagements
ON Entertainers.EntertainerID=Engagements.EntertainerID
WHERE Engagements.StartDate BETWEEN ztblMonths.MonthStart
AND ztblMonths.MonthEnd
GROUP BY Entertainers.EntStageName;
GO


CREATE VIEW CH20_Entertainer_Style_Strength_Rankings
AS 
SELECT TOP 100 PERCENT Musical_Styles.StyleID, Musical_Styles.StyleName, COUNT(RankedPreferences.FirstStyle) AS FirstStrength, 
   COUNT(RankedPreferences.SecondStyle) AS SecondStrength, COUNT(RankedPreferences.ThirdStyle) AS ThirdStrength
FROM Musical_Styles, 
(SELECT (CASE WHEN Entertainer_Styles.StyleStrength = 1 
              THEN Entertainer_Styles.StyleID ELSE Null END) As FirstStyle, 
        (CASE WHEN Entertainer_Styles.StyleStrength = 2 
              THEN Entertainer_Styles.StyleID ELSE Null END) As SecondStyle, 
        (CASE WHEN Entertainer_Styles.StyleStrength = 3 
              THEN Entertainer_Styles.StyleID ELSE Null END) As ThirdStyle
FROM Entertainer_Styles)  AS RankedPreferences
WHERE Musical_Styles.StyleID = RankedPreferences.FirstStyle
OR Musical_Styles.StyleID = RankedPreferences.SecondStyle
OR Musical_Styles.StyleID = RankedPreferences.ThirdStyle
GROUP BY StyleID, StyleName
HAVING COUNT(FirstStyle) > 0 
OR     COUNT(SecondStyle) > 0 
OR     COUNT(ThirdStyle) > 0
ORDER BY FirstStrength DESC, SecondStrength DESC, ThirdStrength DESC, StyleID;
GO
