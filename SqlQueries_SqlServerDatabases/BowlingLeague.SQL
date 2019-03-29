CREATE DATABASE BowlingLeagueExample
GO

use BowlingLeagueExample
GO

CREATE TABLE Bowler_Scores (
	MatchID int NOT NULL ,
	GameNumber smallint NOT NULL ,
	BowlerID int NOT NULL ,
	RawScore smallint NULL ,
	HandiCapScore smallint NULL ,
	WonGame bit NOT NULL 
) 
GO

CREATE TABLE Bowlers (
	BowlerID int NOT NULL ,
	BowlerLastName nvarchar (50) NULL ,
	BowlerFirstName nvarchar (50) NULL ,
	BowlerMiddleInit nvarchar (1) NULL ,
	BowlerAddress nvarchar (50) NULL ,
	BowlerCity nvarchar (50) NULL ,
	BowlerState nvarchar (2) NULL ,
	BowlerZip nvarchar (10) NULL ,
	BowlerPhoneNumber nvarchar (14) NULL ,
	TeamID int NULL 
) 
GO

CREATE TABLE Match_Games (
	MatchID int NOT NULL ,
	GameNumber smallint NOT NULL ,
	WinningTeamID int NULL 
) 
GO

CREATE TABLE Teams (
	TeamID int NOT NULL ,
	TeamName nvarchar (50) NOT NULL ,
	CaptainID int NULL 
) 
GO

CREATE TABLE Tournaments (
	TourneyID int NOT NULL ,
	TourneyDate date NULL ,
	TourneyLocation nvarchar (50) NULL 
) 
GO

CREATE TABLE Tourney_Matches (
	MatchID int NOT NULL ,
	TourneyID int NULL ,
	Lanes nvarchar (5) NULL ,
	OddLaneTeamID int NULL ,
	EvenLaneTeamID int NULL 
) 
GO

CREATE TABLE ztblBowlerRatings (
        BowlerRating nvarchar (15) NOT NULL , 
        BowlerLowAvg smallint NULL ,
        BowlerHighAvg smallint NULL 
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

ALTER TABLE Bowler_Scores ADD 
	CONSTRAINT BS_Match_ID_Default DEFAULT (0) FOR MatchID,
	CONSTRAINT BS_Game_Number_Default DEFAULT (0) FOR GameNumber,
	CONSTRAINT BS_Bowler_ID_Default DEFAULT (0) FOR BowlerID,
	CONSTRAINT BS_Raw_Score_Default DEFAULT (0) FOR RawScore,
	CONSTRAINT BS_HandiCap_Score_Default DEFAULT (0) FOR HandiCapScore,
	CONSTRAINT BS_Won_Game_Default DEFAULT (0) FOR WonGame,
	CONSTRAINT Bowler_Scores_PK PRIMARY KEY   
	(
		MatchID,
		GameNumber,
		BowlerID
	)   
GO

CREATE  INDEX BowlerID ON Bowler_Scores(BowlerID) 
GO

CREATE  INDEX MatchGamesBowlerScores ON Bowler_Scores(MatchID, GameNumber) 
GO

ALTER TABLE Bowlers ADD 
	CONSTRAINT Bowler_ID_Default DEFAULT (0) FOR BowlerID,
	CONSTRAINT Bowlers_PK PRIMARY KEY   
	(
		BowlerID
	)   
GO

CREATE  INDEX BowlerLastName ON Bowlers(BowlerLastName) 
GO

CREATE  INDEX BowlersTeamID ON Bowlers(TeamID) 
GO

ALTER TABLE Match_Games ADD 
	CONSTRAINT MG_Match_ID_Default DEFAULT (0) FOR MatchID,
	CONSTRAINT MG_Game_Number_Default DEFAULT (0) FOR GameNumber,
	CONSTRAINT MD_Winning_Team_Default DEFAULT (0) FOR WinningTeamID,
	CONSTRAINT Match_Games_PK PRIMARY KEY   
	(
		MatchID,
		GameNumber
	)   
GO

CREATE  INDEX Team1ID ON Match_Games(WinningTeamID) 
GO

CREATE  INDEX TourneyMatchesMatchGames ON Match_Games(MatchID) 
GO

ALTER TABLE Teams ADD 
        CONSTRAINT Team_ID_Default DEFAULT (0) FOR TeamID,
	CONSTRAINT Teams_PK PRIMARY KEY   
	(
		TeamID
	)   
GO

ALTER TABLE Tournaments ADD 
	CONSTRAINT Tourney_ID_Default DEFAULT (0) FOR TourneyID,
	CONSTRAINT Tournaments_PK PRIMARY KEY   
	(
		TourneyID
	)   
GO

ALTER TABLE Tourney_Matches ADD 
	CONSTRAINT TM_Match_ID_Default DEFAULT (0) FOR MatchID,
	CONSTRAINT TM_Tourney_ID_Default DEFAULT (0) FOR TourneyID,
	CONSTRAINT TM_Odd_Lane_Team_Default DEFAULT (0) FOR OddLaneTeamID,
	CONSTRAINT TM_Even_Lane_Team_Default DEFAULT (0) FOR EvenLaneTeamID,
	CONSTRAINT Tourney_Matches_PK PRIMARY KEY   
	(
		MatchID
	)   
GO

CREATE  INDEX TeamsTourney_Matches ON Tourney_Matches(EvenLaneTeamID) 
GO

CREATE  INDEX TeamsTourneyMatches ON Tourney_Matches(OddLaneTeamID) 
GO

CREATE  INDEX TournamentsTourneyMatches ON Tourney_Matches(TourneyID) 
GO

CREATE  INDEX TourneyID ON Tourney_Matches(TourneyID) 
GO

ALTER TABLE ztblBowlerRatings ADD 
        CONSTRAINT ztblBowlerRatings_PK PRIMARY KEY 
        ( 
                BowlerRating 
        ) 
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

ALTER TABLE Bowler_Scores ADD 
	CONSTRAINT Bowler_Scores_FK00 FOREIGN KEY 
	(
		BowlerID
	) REFERENCES Bowlers (
		BowlerID
	),
	CONSTRAINT Bowler_Scores_FK01 FOREIGN KEY 
	(
		MatchID,
		GameNumber
	) REFERENCES Match_Games (
		MatchID,
		GameNumber
	)
GO

ALTER TABLE Bowlers ADD 
	CONSTRAINT Bowlers_FK00 FOREIGN KEY 
	(
		TeamID
	) REFERENCES Teams (
		TeamID
	)
GO

ALTER TABLE Match_Games ADD 
	CONSTRAINT Match_Games_FK00 FOREIGN KEY 
	(
		MatchID
	) REFERENCES Tourney_Matches (
		MatchID
	)
GO

ALTER TABLE Tourney_Matches ADD 
	CONSTRAINT Tourney_Matches_FK00 FOREIGN KEY 
	(
		EvenLaneTeamID
	) REFERENCES Teams (
		TeamID
	),
	CONSTRAINT Tourney_Matches_FK01 FOREIGN KEY 
	(
		OddLaneTeamID
	) REFERENCES Teams (
		TeamID
	),
	CONSTRAINT Tourney_Matches_FK02 FOREIGN KEY 
	(
		TourneyID
	) REFERENCES Tournaments (
		TourneyID
	)
GO


CREATE DATABASE BowlingLeagueModify
GO

use BowlingLeagueModify
GO

CREATE TABLE Bowler_Scores (
	MatchID int NOT NULL ,
	GameNumber smallint NOT NULL ,
	BowlerID int NOT NULL ,
	RawScore smallint NULL ,
	HandiCapScore smallint NULL ,
	WonGame bit NOT NULL 
)
GO

CREATE TABLE Bowler_Scores_Archive (
	MatchID int NOT NULL ,
	GameNumber smallint NOT NULL ,
	BowlerID int NOT NULL ,
	RawScore smallint NULL ,
	HandiCapScore smallint NULL ,
	WonGame bit NOT NULL 
)
GO

CREATE TABLE Bowlers (
	BowlerID int IDENTITY (1, 1) NOT NULL ,
	BowlerLastName nvarchar (50) NULL ,
	BowlerFirstName nvarchar (50) NULL ,
	BowlerMiddleInit nvarchar (1) NULL ,
	BowlerAddress nvarchar (50) NULL ,
	BowlerCity nvarchar (50) NULL ,
	BowlerState nvarchar (2) NULL ,
	BowlerZip nvarchar (10) NULL ,
	BowlerPhoneNumber nvarchar (14) NULL ,
	TeamID int NULL ,
	BowlerTotalPins int NULL ,
	BowlerGamesBowled int NULL ,
	BowlerCurrentAverage smallint NULL ,
	BowlerCurrentHcp smallint NULL 
)
GO

CREATE TABLE Match_Games (
	MatchID int NOT NULL ,
	GameNumber smallint NOT NULL ,
	WinningTeamID smallint NULL 
)
GO

CREATE TABLE Match_Games_Archive (
	MatchID int NOT NULL ,
	GameNumber smallint NOT NULL ,
	WinningTeamID int NULL 
)
GO

CREATE TABLE Teams (
	TeamID int IDENTITY (1, 1) NOT NULL ,
	TeamName nvarchar (50) NOT NULL ,
	CaptainID int NULL 
)
GO

CREATE TABLE Tournaments (
	TourneyID int IDENTITY (1, 1) NOT NULL ,
	TourneyDate date NULL ,
	TourneyLocation nvarchar (50) NULL 
)
GO

CREATE TABLE Tournaments_Archive (
	TourneyID int NOT NULL ,
	TourneyDate date NULL ,
	TourneyLocation nvarchar (50) NULL 
)
GO

CREATE TABLE Tourney_Matches (
	MatchID int IDENTITY (1, 1) NOT NULL ,
	TourneyID int NULL ,
	Lanes nvarchar (5) NULL ,
	OddLaneTeamID int NULL ,
	EvenLaneTeamID int NULL 
)
GO

CREATE TABLE Tourney_Matches_Archive (
	MatchID int NOT NULL ,
	TourneyID int NULL ,
	Lanes nvarchar (5) NULL ,
	OddLaneTeamID int NULL ,
	EvenLaneTeamID int NULL 
)
GO

CREATE TABLE WAZips (
	ZIP nvarchar (5) NOT NULL ,
	City nvarchar (255) NULL ,
	State nvarchar (255) NULL 
)
GO

ALTER TABLE Bowler_Scores ADD 
	CONSTRAINT BS_Match_ID_Default DEFAULT (0) FOR MatchID,
	CONSTRAINT BS_Game_Number_Default DEFAULT (0) FOR GameNumber,
	CONSTRAINT BS_Bowler_ID_Default DEFAULT (0) FOR BowlerID,
	CONSTRAINT BS_Raw_Score_Default DEFAULT (0) FOR RawScore,
	CONSTRAINT BS_HandiCap_Score_Default DEFAULT (0) FOR HandiCapScore,
	CONSTRAINT BS_Won_Game_Default DEFAULT (0) FOR WonGame,
	CONSTRAINT Bowler_Scores_PK PRIMARY KEY   
	(
		MatchID,
		GameNumber,
		BowlerID
	)   
GO

CREATE  INDEX BowlersBowlerScores ON Bowler_Scores(BowlerID) 
GO

CREATE  INDEX MatchGamesBowlerScores ON Bowler_Scores(MatchID, GameNumber) 
GO

ALTER TABLE Bowler_Scores_Archive ADD 
	CONSTRAINT BSA_Match_ID_Default DEFAULT (0) FOR MatchID,
	CONSTRAINT BSA_Game_Number_Default DEFAULT (0) FOR GameNumber,
	CONSTRAINT BSA_BowlerID_Default DEFAULT (0) FOR BowlerID,
	CONSTRAINT BSA_Raw_Score_Default DEFAULT (0) FOR RawScore,
	CONSTRAINT BSA_Handicap_Score_Default DEFAULT (0) FOR HandiCapScore,
	CONSTRAINT BSA_Won_Game_Default DEFAULT (0) FOR WonGame,
	CONSTRAINT Bowler_Scores_Archive_PK PRIMARY KEY  NONCLUSTERED 
	(
		MatchID,
		GameNumber,
		BowlerID
	)  
GO

 CREATE  INDEX BowlerID ON Bowler_Scores_Archive(BowlerID)
GO

 CREATE  INDEX Match_Games_ArchiveBowler_Scores_Archive ON Bowler_Scores_Archive(MatchID, GameNumber)
GO

ALTER TABLE Bowlers ADD 
	CONSTRAINT Bowler_Total_Pins_Default DEFAULT (0) FOR BowlerTotalPins,
	CONSTRAINT Bowler_Games_Bowled_Default DEFAULT (0) FOR BowlerGamesBowled,
	CONSTRAINT Bowler_Current_Average_Default DEFAULT (0) FOR BowlerCurrentAverage,
	CONSTRAINT Bowler_Current_Hcp_Default DEFAULT (0) FOR BowlerCurrentHcp,
	CONSTRAINT Bowlers_PK PRIMARY KEY  
	(
		BowlerID
	)  
GO

CREATE  INDEX BowlerLastName ON Bowlers(BowlerLastName) 
GO

CREATE  INDEX BowlersTeamID ON Bowlers(TeamID) 
GO

ALTER TABLE Match_Games ADD 
	CONSTRAINT MG_Match_ID_Default DEFAULT (0) FOR MatchID,
	CONSTRAINT MG_Game_Number_Default DEFAULT (0) FOR GameNumber,
	CONSTRAINT MD_Winning_Team_Default DEFAULT (0) FOR WinningTeamID,
	CONSTRAINT Match_Games_PK PRIMARY KEY   
	(
		MatchID,
		GameNumber
	)   
GO

CREATE  INDEX Team1ID ON Match_Games(WinningTeamID) 
GO

CREATE  INDEX TourneyMatchesMatchGames ON Match_Games(MatchID) 
GO

ALTER TABLE Match_Games_Archive ADD 
	CONSTRAINT MGA_Match_ID_Default DEFAULT (0) FOR MatchID,
	CONSTRAINT MGA_Game_Number_Default DEFAULT (0) FOR GameNumber,
	CONSTRAINT MGA_Winning_Team_ID_Default DEFAULT (0) FOR WinningTeamID,
	CONSTRAINT Match_Games_Archive_PK PRIMARY KEY  NONCLUSTERED 
	(
		MatchID,
		GameNumber
	)  
GO

 CREATE  INDEX Team1ID ON Match_Games_Archive(WinningTeamID)
GO

 CREATE  INDEX Tourney_Matches_ArchiveMatch_Games_Archive ON Match_Games_Archive(MatchID)
GO

ALTER TABLE Teams ADD 
	CONSTRAINT Teams_PK PRIMARY KEY   
	(
		TeamID
	)   
GO

ALTER TABLE Tournaments ADD 
	CONSTRAINT Tournaments_PK PRIMARY KEY   
	(
		TourneyID
	)   
GO

ALTER TABLE Tournaments_Archive ADD 
	CONSTRAINT TA_Tourney_ID_Default DEFAULT (0) FOR TourneyID,
	CONSTRAINT Tournaments_Archive_PK PRIMARY KEY  NONCLUSTERED 
	(
		TourneyID
	)  
GO

ALTER TABLE Tourney_Matches ADD 
	CONSTRAINT TM_Tourney_ID_Default DEFAULT (0) FOR TourneyID,
	CONSTRAINT TM_Odd_Lane_Team_Default DEFAULT (0) FOR OddLaneTeamID,
	CONSTRAINT TM_Even_Lane_Team_Default DEFAULT (0) FOR EvenLaneTeamID,
	CONSTRAINT Tourney_Matches_PK PRIMARY KEY   
	(
		MatchID
	)   
GO

CREATE  INDEX TeamsTourney_Matches_Even ON Tourney_Matches(EvenLaneTeamID) 
GO

CREATE  INDEX TeamsTourneyMatches_Odd ON Tourney_Matches(OddLaneTeamID) 
GO

CREATE  INDEX TourneyID ON Tourney_Matches(TourneyID) 
GO

ALTER TABLE Tourney_Matches_Archive ADD 
	CONSTRAINT TMA_Match_ID_Default DEFAULT (0) FOR MatchID,
	CONSTRAINT TMA_Tourney_ID_Default DEFAULT (0) FOR TourneyID,
	CONSTRAINT TMA_Odd_Lane_Team_Default DEFAULT (0) FOR OddLaneTeamID,
	CONSTRAINT TMA_Even_Lane_Team_Default DEFAULT (0) FOR EvenLaneTeamID,
	CONSTRAINT Tourney_Matches_Archive_PK PRIMARY KEY   
	(
		MatchID
	)  
GO

 CREATE  INDEX Team1ID ON Tourney_Matches_Archive(OddLaneTeamID)
GO

 CREATE  INDEX Team2ID ON Tourney_Matches_Archive(EvenLaneTeamID)
GO

CREATE  INDEX TourneyID ON Tourney_Matches_Archive(TourneyID)
GO

ALTER TABLE WAZips ADD 
	CONSTRAINT WAZips_PK PRIMARY KEY   
	(
		ZIP
	)  
GO

ALTER TABLE Bowler_Scores ADD 
	CONSTRAINT Bowler_Scores_FK00 FOREIGN KEY 
	(
		BowlerID
	) REFERENCES Bowlers (
		BowlerID
	),
	CONSTRAINT Bowler_Scores_FK01 FOREIGN KEY 
	(
		MatchID,
		GameNumber
	) REFERENCES Match_Games (
		MatchID,
		GameNumber
	)
GO

ALTER TABLE Bowler_Scores_Archive ADD 
	CONSTRAINT Bowler_Scores_Archive_FK00 FOREIGN KEY 
	(
		MatchID,
		GameNumber
	) REFERENCES Match_Games_Archive (
		MatchID,
		GameNumber
	)
GO

ALTER TABLE Bowlers ADD 
	CONSTRAINT Bowlers_FK00 FOREIGN KEY 
	(
		TeamID
	) REFERENCES Teams (
		TeamID
	)
GO

ALTER TABLE Match_Games ADD 
	CONSTRAINT Match_Games_FK00 FOREIGN KEY 
	(
		MatchID
	) REFERENCES Tourney_Matches (
		MatchID
	)
GO

ALTER TABLE Match_Games_Archive ADD 
	CONSTRAINT Match_Games_Archive_FK00 FOREIGN KEY 
	(
		MatchID
	) REFERENCES Tourney_Matches_Archive (
		MatchID
	)
GO

ALTER TABLE Tourney_Matches ADD 
	CONSTRAINT Tourney_Matches_FK00 FOREIGN KEY 
	(
		EvenLaneTeamID
	) REFERENCES Teams (
		TeamID
	),
	CONSTRAINT Tourney_Matches_FK01 FOREIGN KEY 
	(
		OddLaneTeamID
	) REFERENCES Teams (
		TeamID
	),
	CONSTRAINT Tourney_Matches_FK02 FOREIGN KEY 
	(
		TourneyID
	) REFERENCES Tournaments (
		TourneyID
	)
GO

ALTER TABLE Tourney_Matches_Archive ADD 
	CONSTRAINT Tourney_Matches_Archive_FK00 FOREIGN KEY 
	(
		TourneyID
	) REFERENCES Tournaments_Archive (
		TourneyID
	)
GO


Use BowlingLeagueExample;
INSERT INTO Tournaments
  (TourneyID, TourneyDate, TourneyLocation)
  VALUES (1, '2012-09-04', 'Red Rooster Lanes');
INSERT INTO Tournaments
  (TourneyID, TourneyDate, TourneyLocation)
  VALUES (2, '2012-09-11', 'Thunderbird Lanes');
INSERT INTO Tournaments
  (TourneyID, TourneyDate, TourneyLocation)
  VALUES (3, '2012-09-18', 'Bolero Lanes');
INSERT INTO Tournaments
  (TourneyID, TourneyDate, TourneyLocation)
  VALUES (4, '2012-09-25', 'Imperial Lanes');
INSERT INTO Tournaments
  (TourneyID, TourneyDate, TourneyLocation)
  VALUES (5, '2012-10-02', 'Sports World Lanes');
INSERT INTO Tournaments
  (TourneyID, TourneyDate, TourneyLocation)
  VALUES (6, '2012-10-09', 'Totem Lanes');
INSERT INTO Tournaments
  (TourneyID, TourneyDate, TourneyLocation)
  VALUES (7, '2012-10-16', 'Acapulco Lanes');
INSERT INTO Tournaments
  (TourneyID, TourneyDate, TourneyLocation)
  VALUES (8, '2012-10-23', 'Red Rooster Lanes');
INSERT INTO Tournaments
  (TourneyID, TourneyDate, TourneyLocation)
  VALUES (9, '2012-10-30', 'Thunderbird Lanes');
INSERT INTO Tournaments
  (TourneyID, TourneyDate, TourneyLocation)
  VALUES (10, '2012-11-06', 'Bolero Lanes');
INSERT INTO Tournaments
  (TourneyID, TourneyDate, TourneyLocation)
  VALUES (11, '2012-11-13', 'Imperial Lanes');
INSERT INTO Tournaments
  (TourneyID, TourneyDate, TourneyLocation)
  VALUES (12, '2012-11-20', 'Sports World Lanes');
INSERT INTO Tournaments
  (TourneyID, TourneyDate, TourneyLocation)
  VALUES (13, '2012-11-27', 'Totem Lanes');
INSERT INTO Tournaments
  (TourneyID, TourneyDate, TourneyLocation)
  VALUES (14, '2012-12-04', 'Acapulco Lanes');
INSERT INTO Tournaments
  (TourneyID, TourneyDate, TourneyLocation)
  VALUES (15, '2013-07-12', 'Red Rooster Lanes');
INSERT INTO Tournaments
  (TourneyID, TourneyDate, TourneyLocation)
  VALUES (16, '2013-07-19', 'Thunderbird Lanes');
INSERT INTO Tournaments
  (TourneyID, TourneyDate, TourneyLocation)
  VALUES (17, '2013-07-26', 'Bolero Lanes');
INSERT INTO Tournaments
  (TourneyID, TourneyDate, TourneyLocation)
  VALUES (18, '2013-08-02', 'Sports World Lanes');
INSERT INTO Tournaments
  (TourneyID, TourneyDate, TourneyLocation)
  VALUES (19, '2013-08-09', 'Imperial Lanes');
INSERT INTO Tournaments
  (TourneyID, TourneyDate, TourneyLocation)
  VALUES (20, '2013-08-16', 'Totem Lanes');
INSERT INTO Bowlers
  (BowlerID, BowlerLastName, BowlerFirstName, BowlerMiddleInit, 
   BowlerAddress, BowlerCity, BowlerState, BowlerZip, 
   BowlerPhoneNumber, TeamID)
  VALUES (1, 'Fournier', 'Barbara', NULL, '67 Willow Drive', 
   'Bothell', 'WA', '98123', '(206) 555-9876', NULL);
INSERT INTO Bowlers
  (BowlerID, BowlerLastName, BowlerFirstName, BowlerMiddleInit, 
   BowlerAddress, BowlerCity, BowlerState, BowlerZip, 
   BowlerPhoneNumber, TeamID)
  VALUES (2, 'Fournier', 'David', NULL, '67 Willow Drive', 
   'Bothell', 'WA', '98123', '(206) 555-9876', NULL);
INSERT INTO Bowlers
  (BowlerID, BowlerLastName, BowlerFirstName, BowlerMiddleInit, 
   BowlerAddress, BowlerCity, BowlerState, BowlerZip, 
   BowlerPhoneNumber, TeamID)
  VALUES (3, 'Kennedy', 'John', 'A', '2957 W 33rd', 
   'Ballard', 'WA', '98099', '(206) 555-7854', NULL);
INSERT INTO Bowlers
  (BowlerID, BowlerLastName, BowlerFirstName, BowlerMiddleInit, 
   BowlerAddress, BowlerCity, BowlerState, BowlerZip, 
   BowlerPhoneNumber, TeamID)
  VALUES (4, 'Sheskey', 'Sara', 'J', '17950 N 59th', 
   'Seattle', 'WA', '98011', '(206) 555-9893', NULL);
INSERT INTO Bowlers
  (BowlerID, BowlerLastName, BowlerFirstName, BowlerMiddleInit, 
   BowlerAddress, BowlerCity, BowlerState, BowlerZip, 
   BowlerPhoneNumber, TeamID)
  VALUES (5, 'Patterson', 'Ann', 'K', '16 Maple Lane', 
   'Auburn', 'WA', '98002', '(206) 555-3487', NULL);
INSERT INTO Bowlers
  (BowlerID, BowlerLastName, BowlerFirstName, BowlerMiddleInit, 
   BowlerAddress, BowlerCity, BowlerState, BowlerZip, 
   BowlerPhoneNumber, TeamID)
  VALUES (6, 'Patterson', 'Neil', NULL, '16 Maple Lane', 
   'Auburn', 'WA', '98002', '(206) 555-3487', NULL);
INSERT INTO Bowlers
  (BowlerID, BowlerLastName, BowlerFirstName, BowlerMiddleInit, 
   BowlerAddress, BowlerCity, BowlerState, BowlerZip, 
   BowlerPhoneNumber, TeamID)
  VALUES (7, 'Viescas', 'David', 'A', '16679 NE 42nd Court', 
   'Redmond', 'WA', '98052', '(206) 882-8878', NULL);
INSERT INTO Bowlers
  (BowlerID, BowlerLastName, BowlerFirstName, BowlerMiddleInit, 
   BowlerAddress, BowlerCity, BowlerState, BowlerZip, 
   BowlerPhoneNumber, TeamID)
  VALUES (8, 'Viescas', 'Stephanie', NULL, '16679 NE 42nd Court', 
   'Redmond', 'WA', '98052', '(206) 882-8878', NULL);
INSERT INTO Bowlers
  (BowlerID, BowlerLastName, BowlerFirstName, BowlerMiddleInit, 
   BowlerAddress, BowlerCity, BowlerState, BowlerZip, 
   BowlerPhoneNumber, TeamID)
  VALUES (9, 'Black', 'Alastair', NULL, '4726 - 11th Ave. N.E.', 
   'Seattle', 'WA', '98105', '(206) 555-1189', NULL);
INSERT INTO Bowlers
  (BowlerID, BowlerLastName, BowlerFirstName, BowlerMiddleInit, 
   BowlerAddress, BowlerCity, BowlerState, BowlerZip, 
   BowlerPhoneNumber, TeamID)
  VALUES (10, 'Cunningham', 'David', NULL, '4110 Old Redmond Rd.', 
   'Redmond', 'WA', '98052', '(206) 555-8122', NULL);
INSERT INTO Bowlers
  (BowlerID, BowlerLastName, BowlerFirstName, BowlerMiddleInit, 
   BowlerAddress, BowlerCity, BowlerState, BowlerZip, 
   BowlerPhoneNumber, TeamID)
  VALUES (11, 'Kennedy', 'Angel', NULL, '2957 W 33rd', 
   'Ballard', 'WA', '98099', '(206) 555-7854', NULL);
INSERT INTO Bowlers
  (BowlerID, BowlerLastName, BowlerFirstName, BowlerMiddleInit, 
   BowlerAddress, BowlerCity, BowlerState, BowlerZip, 
   BowlerPhoneNumber, TeamID)
  VALUES (12, 'Viescas', 'Carol', 'M', '16345 NE 32nd Street', 
   'Bellevue', 'WA', '98004', '(206) 555-7295', NULL);
INSERT INTO Bowlers
  (BowlerID, BowlerLastName, BowlerFirstName, BowlerMiddleInit, 
   BowlerAddress, BowlerCity, BowlerState, BowlerZip, 
   BowlerPhoneNumber, TeamID)
  VALUES (13, 'Hallmark', 'Elizabeth', NULL, 'Route 2, Box 203B', 
   'Woodinville', 'WA', '98072', '(206) 555-8990', 
   NULL);
INSERT INTO Bowlers
  (BowlerID, BowlerLastName, BowlerFirstName, BowlerMiddleInit, 
   BowlerAddress, BowlerCity, BowlerState, BowlerZip, 
   BowlerPhoneNumber, TeamID)
  VALUES (14, 'Hallmark', 'Gary', NULL, 'Route 2, Box 203B', 
   'Woodinville', 'WA', '98072', '(206) 555-8990', 
   NULL);
INSERT INTO Bowlers
  (BowlerID, BowlerLastName, BowlerFirstName, BowlerMiddleInit, 
   BowlerAddress, BowlerCity, BowlerState, BowlerZip, 
   BowlerPhoneNumber, TeamID)
  VALUES (15, 'Patterson', 'Kathryn', NULL, '16 Maple Lane', 
   'Auburn', 'WA', '98002', '(206) 555-3487', NULL);
INSERT INTO Bowlers
  (BowlerID, BowlerLastName, BowlerFirstName, BowlerMiddleInit, 
   BowlerAddress, BowlerCity, BowlerState, BowlerZip, 
   BowlerPhoneNumber, TeamID)
  VALUES (16, 'Sheskey', 'Richard', NULL, '17950 N 59th', 
   'Seattle', 'WA', '98011', '(206) 555-9893', NULL);
INSERT INTO Bowlers
  (BowlerID, BowlerLastName, BowlerFirstName, BowlerMiddleInit, 
   BowlerAddress, BowlerCity, BowlerState, BowlerZip, 
   BowlerPhoneNumber, TeamID)
  VALUES (17, 'Hernandez', 'Kendra', NULL, '47 Harvard Drive', 
   'Kirkland', 'WA', '98033', '(206) 889-9191', NULL);
INSERT INTO Bowlers
  (BowlerID, BowlerLastName, BowlerFirstName, BowlerMiddleInit, 
   BowlerAddress, BowlerCity, BowlerState, BowlerZip, 
   BowlerPhoneNumber, TeamID)
  VALUES (18, 'Hernandez', 'Michael', NULL, '47 Harvard Drive', 
   'Kirkland', 'WA', '98033', '(206) 889-9191', NULL);
INSERT INTO Bowlers
  (BowlerID, BowlerLastName, BowlerFirstName, BowlerMiddleInit, 
   BowlerAddress, BowlerCity, BowlerState, BowlerZip, 
   BowlerPhoneNumber, TeamID)
  VALUES (19, 'Viescas', 'John', 'L', '218 Main Street', 
   'Redmond', 'WA', '98052', '(206) 881-5596', NULL);
INSERT INTO Bowlers
  (BowlerID, BowlerLastName, BowlerFirstName, BowlerMiddleInit, 
   BowlerAddress, BowlerCity, BowlerState, BowlerZip, 
   BowlerPhoneNumber, TeamID)
  VALUES (20, 'Viescas', 'Suzanne', 'L', '218 Main Street', 
   'Redmond', 'WA', '98052', '(206) 881-5596', NULL);
INSERT INTO Bowlers
  (BowlerID, BowlerLastName, BowlerFirstName, BowlerMiddleInit, 
   BowlerAddress, BowlerCity, BowlerState, BowlerZip, 
   BowlerPhoneNumber, TeamID)
  VALUES (21, 'Ehrlich', 'Zachary', NULL, '507 - 20th Ave. E.', 
   'Seattle', 'WA', '98122', '(206) 555-9857', NULL);
INSERT INTO Bowlers
  (BowlerID, BowlerLastName, BowlerFirstName, BowlerMiddleInit, 
   BowlerAddress, BowlerCity, BowlerState, BowlerZip, 
   BowlerPhoneNumber, TeamID)
  VALUES (22, 'Hallmark', 'Alaina', NULL, 'Route 2, Box 203B', 
   'Woodinville', 'WA', '98072', '(206) 555-8990', 
   NULL);
INSERT INTO Bowlers
  (BowlerID, BowlerLastName, BowlerFirstName, BowlerMiddleInit, 
   BowlerAddress, BowlerCity, BowlerState, BowlerZip, 
   BowlerPhoneNumber, TeamID)
  VALUES (23, 'Viescas', 'Caleb', NULL, '16679 NE 42nd Court', 
   'Redmond', 'WA', '98052', '(206) 882-8878', NULL);
INSERT INTO Bowlers
  (BowlerID, BowlerLastName, BowlerFirstName, BowlerMiddleInit, 
   BowlerAddress, BowlerCity, BowlerState, BowlerZip, 
   BowlerPhoneNumber, TeamID)
  VALUES (24, 'Thompson', 'Sarah', 'L', '122 Spring Valley Drive', 
   'Duvall', 'WA', '98019', '(206) 555-8989', NULL);
INSERT INTO Bowlers
  (BowlerID, BowlerLastName, BowlerFirstName, BowlerMiddleInit, 
   BowlerAddress, BowlerCity, BowlerState, BowlerZip, 
   BowlerPhoneNumber, TeamID)
  VALUES (25, 'Patterson', 'Megan', NULL, '16 Maple Lane', 
   'Auburn', 'WA', '98002', '(206) 555-3487', NULL);
INSERT INTO Bowlers
  (BowlerID, BowlerLastName, BowlerFirstName, BowlerMiddleInit, 
   BowlerAddress, BowlerCity, BowlerState, BowlerZip, 
   BowlerPhoneNumber, TeamID)
  VALUES (26, 'Thompson', 'Mary', 'K', '122 Spring Valley Drive', 
   'Duvall', 'WA', '98019', '(206) 555-8989', NULL);
INSERT INTO Bowlers
  (BowlerID, BowlerLastName, BowlerFirstName, BowlerMiddleInit, 
   BowlerAddress, BowlerCity, BowlerState, BowlerZip, 
   BowlerPhoneNumber, TeamID)
  VALUES (27, 'Thompson', 'William', 'G', '122 Spring Valley Drive', 
   'Duvall', 'WA', '98019', '(206) 555-8989', NULL);
INSERT INTO Bowlers
  (BowlerID, BowlerLastName, BowlerFirstName, BowlerMiddleInit, 
   BowlerAddress, BowlerCity, BowlerState, BowlerZip, 
   BowlerPhoneNumber, TeamID)
  VALUES (28, 'Viescas', 'Michael', 'L', '218 Main Street', 
   'Redmond', 'WA', '98052', '(206) 881-5596', NULL);
INSERT INTO Bowlers
  (BowlerID, BowlerLastName, BowlerFirstName, BowlerMiddleInit, 
   BowlerAddress, BowlerCity, BowlerState, BowlerZip, 
   BowlerPhoneNumber, TeamID)
  VALUES (29, 'Hallmark', 'Bailey', NULL, 'Route 2, Box 203B', 
   'Woodinville', 'WA', '98072', '(206) 555-8990', 
   NULL);
INSERT INTO Bowlers
  (BowlerID, BowlerLastName, BowlerFirstName, BowlerMiddleInit, 
   BowlerAddress, BowlerCity, BowlerState, BowlerZip, 
   BowlerPhoneNumber, TeamID)
  VALUES (30, 'Patterson', 'Rachel', NULL, '16 Maple Lane', 
   'Auburn', 'WA', '98002', '(206) 555-3487', NULL);
INSERT INTO Bowlers
  (BowlerID, BowlerLastName, BowlerFirstName, BowlerMiddleInit, 
   BowlerAddress, BowlerCity, BowlerState, BowlerZip, 
   BowlerPhoneNumber, TeamID)
  VALUES (31, 'Pundt', 'Steve', NULL, '722 Moss Bay Blvd.', 
   'Kirkland', 'WA', '98033', '(206) 555-3412', NULL);
INSERT INTO Bowlers
  (BowlerID, BowlerLastName, BowlerFirstName, BowlerMiddleInit, 
   BowlerAddress, BowlerCity, BowlerState, BowlerZip, 
   BowlerPhoneNumber, TeamID)
  VALUES (32, 'Rosales', 'Joe', NULL, '908 W. Capital Way', 
   'Tacoma', 'WA', '98401', '(206) 555-9482', NULL);
INSERT INTO Teams
  (TeamID, TeamName, CaptainID)
  VALUES (1, 'Marlins', 2);
INSERT INTO Teams
  (TeamID, TeamName, CaptainID)
  VALUES (2, 'Sharks', 5);
INSERT INTO Teams
  (TeamID, TeamName, CaptainID)
  VALUES (3, 'Terrapins', 12);
INSERT INTO Teams
  (TeamID, TeamName, CaptainID)
  VALUES (4, 'Barracudas', 16);
INSERT INTO Teams
  (TeamID, TeamName, CaptainID)
  VALUES (5, 'Dolphins', 20);
INSERT INTO Teams
  (TeamID, TeamName, CaptainID)
  VALUES (6, 'Orcas', 24);
INSERT INTO Teams
  (TeamID, TeamName, CaptainID)
  VALUES (7, 'Manatees', 28);
INSERT INTO Teams
  (TeamID, TeamName, CaptainID)
  VALUES (8, 'Swordfish', 32);
INSERT INTO Teams
  (TeamID, TeamName, CaptainID)
  VALUES (9, 'Huckleberrys', 7);
INSERT INTO Teams
  (TeamID, TeamName, CaptainID)
  VALUES (10, 'MintJuleps', 22);
UPDATE Bowlers 
SET TeamID = 1
WHERE BowlerID IN (1, 2, 3, 4);
UPDATE Bowlers 
SET TeamID = 2
WHERE BowlerID IN (5, 6, 7, 8);
UPDATE Bowlers 
SET TeamID = 3
WHERE BowlerID IN (9, 10, 11, 12);
UPDATE Bowlers 
SET TeamID = 4
WHERE BowlerID IN (13, 14, 15, 16);
UPDATE Bowlers 
SET TeamID = 5
WHERE BowlerID IN (17, 18, 19, 20);
UPDATE Bowlers 
SET TeamID = 6
WHERE BowlerID IN (21, 22, 23, 24);
UPDATE Bowlers 
SET TeamID = 7
WHERE BowlerID IN (25, 26, 27, 28);
UPDATE Bowlers 
SET TeamID = 8
WHERE BowlerID IN (29, 30, 31, 32);
INSERT INTO Tourney_Matches
  (MatchID, TourneyID, Lanes, OddLaneTeamID, EvenLaneTeamID)
  VALUES (1, 1, '01-02', 1, 2);
INSERT INTO Tourney_Matches
  (MatchID, TourneyID, Lanes, OddLaneTeamID, EvenLaneTeamID)
  VALUES (2, 1, '03-04', 3, 4);
INSERT INTO Tourney_Matches
  (MatchID, TourneyID, Lanes, OddLaneTeamID, EvenLaneTeamID)
  VALUES (3, 1, '05-06', 5, 6);
INSERT INTO Tourney_Matches
  (MatchID, TourneyID, Lanes, OddLaneTeamID, EvenLaneTeamID)
  VALUES (4, 1, '07-08', 7, 8);
INSERT INTO Tourney_Matches
  (MatchID, TourneyID, Lanes, OddLaneTeamID, EvenLaneTeamID)
  VALUES (5, 2, '21-22', 3, 1);
INSERT INTO Tourney_Matches
  (MatchID, TourneyID, Lanes, OddLaneTeamID, EvenLaneTeamID)
  VALUES (6, 2, '23-24', 4, 2);
INSERT INTO Tourney_Matches
  (MatchID, TourneyID, Lanes, OddLaneTeamID, EvenLaneTeamID)
  VALUES (7, 2, '25-26', 5, 7);
INSERT INTO Tourney_Matches
  (MatchID, TourneyID, Lanes, OddLaneTeamID, EvenLaneTeamID)
  VALUES (8, 2, '27-28', 8, 6);
INSERT INTO Tourney_Matches
  (MatchID, TourneyID, Lanes, OddLaneTeamID, EvenLaneTeamID)
  VALUES (9, 3, '15-16', 2, 3);
INSERT INTO Tourney_Matches
  (MatchID, TourneyID, Lanes, OddLaneTeamID, EvenLaneTeamID)
  VALUES (10, 3, '17-18', 1, 4);
INSERT INTO Tourney_Matches
  (MatchID, TourneyID, Lanes, OddLaneTeamID, EvenLaneTeamID)
  VALUES (11, 3, '19-20', 7, 6);
INSERT INTO Tourney_Matches
  (MatchID, TourneyID, Lanes, OddLaneTeamID, EvenLaneTeamID)
  VALUES (12, 3, '21-22', 5, 8);
INSERT INTO Tourney_Matches
  (MatchID, TourneyID, Lanes, OddLaneTeamID, EvenLaneTeamID)
  VALUES (13, 4, '09-10', 1, 5);
INSERT INTO Tourney_Matches
  (MatchID, TourneyID, Lanes, OddLaneTeamID, EvenLaneTeamID)
  VALUES (14, 4, '11-12', 2, 6);
INSERT INTO Tourney_Matches
  (MatchID, TourneyID, Lanes, OddLaneTeamID, EvenLaneTeamID)
  VALUES (15, 4, '13-14', 3, 7);
INSERT INTO Tourney_Matches
  (MatchID, TourneyID, Lanes, OddLaneTeamID, EvenLaneTeamID)
  VALUES (16, 4, '15-16', 4, 8);
INSERT INTO Tourney_Matches
  (MatchID, TourneyID, Lanes, OddLaneTeamID, EvenLaneTeamID)
  VALUES (17, 5, '11-12', 6, 1);
INSERT INTO Tourney_Matches
  (MatchID, TourneyID, Lanes, OddLaneTeamID, EvenLaneTeamID)
  VALUES (18, 5, '13-14', 5, 2);
INSERT INTO Tourney_Matches
  (MatchID, TourneyID, Lanes, OddLaneTeamID, EvenLaneTeamID)
  VALUES (19, 5, '15-16', 8, 3);
INSERT INTO Tourney_Matches
  (MatchID, TourneyID, Lanes, OddLaneTeamID, EvenLaneTeamID)
  VALUES (20, 5, '17-18', 7, 4);
INSERT INTO Tourney_Matches
  (MatchID, TourneyID, Lanes, OddLaneTeamID, EvenLaneTeamID)
  VALUES (21, 6, '05-06', 1, 7);
INSERT INTO Tourney_Matches
  (MatchID, TourneyID, Lanes, OddLaneTeamID, EvenLaneTeamID)
  VALUES (22, 6, '07-08', 3, 5);
INSERT INTO Tourney_Matches
  (MatchID, TourneyID, Lanes, OddLaneTeamID, EvenLaneTeamID)
  VALUES (23, 6, '09-10', 2, 8);
INSERT INTO Tourney_Matches
  (MatchID, TourneyID, Lanes, OddLaneTeamID, EvenLaneTeamID)
  VALUES (24, 6, '11-12', 4, 6);
INSERT INTO Tourney_Matches
  (MatchID, TourneyID, Lanes, OddLaneTeamID, EvenLaneTeamID)
  VALUES (25, 7, '13-14', 8, 1);
INSERT INTO Tourney_Matches
  (MatchID, TourneyID, Lanes, OddLaneTeamID, EvenLaneTeamID)
  VALUES (26, 7, '15-16', 7, 2);
INSERT INTO Tourney_Matches
  (MatchID, TourneyID, Lanes, OddLaneTeamID, EvenLaneTeamID)
  VALUES (27, 7, '17-18', 6, 3);
INSERT INTO Tourney_Matches
  (MatchID, TourneyID, Lanes, OddLaneTeamID, EvenLaneTeamID)
  VALUES (28, 7, '19-20', 5, 4);
INSERT INTO Tourney_Matches
  (MatchID, TourneyID, Lanes, OddLaneTeamID, EvenLaneTeamID)
  VALUES (29, 8, '21-22', 1, 3);
INSERT INTO Tourney_Matches
  (MatchID, TourneyID, Lanes, OddLaneTeamID, EvenLaneTeamID)
  VALUES (30, 8, '23-24', 2, 4);
INSERT INTO Tourney_Matches
  (MatchID, TourneyID, Lanes, OddLaneTeamID, EvenLaneTeamID)
  VALUES (31, 8, '25-26', 7, 5);
INSERT INTO Tourney_Matches
  (MatchID, TourneyID, Lanes, OddLaneTeamID, EvenLaneTeamID)
  VALUES (32, 8, '27-28', 6, 8);
INSERT INTO Tourney_Matches
  (MatchID, TourneyID, Lanes, OddLaneTeamID, EvenLaneTeamID)
  VALUES (33, 9, '15-16', 3, 2);
INSERT INTO Tourney_Matches
  (MatchID, TourneyID, Lanes, OddLaneTeamID, EvenLaneTeamID)
  VALUES (34, 9, '17-18', 4, 1);
INSERT INTO Tourney_Matches
  (MatchID, TourneyID, Lanes, OddLaneTeamID, EvenLaneTeamID)
  VALUES (35, 9, '19-20', 6, 7);
INSERT INTO Tourney_Matches
  (MatchID, TourneyID, Lanes, OddLaneTeamID, EvenLaneTeamID)
  VALUES (36, 9, '21-22', 8, 5);
INSERT INTO Tourney_Matches
  (MatchID, TourneyID, Lanes, OddLaneTeamID, EvenLaneTeamID)
  VALUES (37, 10, '09-10', 5, 1);
INSERT INTO Tourney_Matches
  (MatchID, TourneyID, Lanes, OddLaneTeamID, EvenLaneTeamID)
  VALUES (38, 10, '11-12', 6, 2);
INSERT INTO Tourney_Matches
  (MatchID, TourneyID, Lanes, OddLaneTeamID, EvenLaneTeamID)
  VALUES (39, 10, '13-14', 7, 3);
INSERT INTO Tourney_Matches
  (MatchID, TourneyID, Lanes, OddLaneTeamID, EvenLaneTeamID)
  VALUES (40, 10, '15-16', 8, 4);
INSERT INTO Tourney_Matches
  (MatchID, TourneyID, Lanes, OddLaneTeamID, EvenLaneTeamID)
  VALUES (41, 11, '11-12', 1, 6);
INSERT INTO Tourney_Matches
  (MatchID, TourneyID, Lanes, OddLaneTeamID, EvenLaneTeamID)
  VALUES (42, 11, '13-14', 2, 5);
INSERT INTO Tourney_Matches
  (MatchID, TourneyID, Lanes, OddLaneTeamID, EvenLaneTeamID)
  VALUES (43, 11, '15-16', 3, 8);
INSERT INTO Tourney_Matches
  (MatchID, TourneyID, Lanes, OddLaneTeamID, EvenLaneTeamID)
  VALUES (44, 11, '17-18', 4, 7);
INSERT INTO Tourney_Matches
  (MatchID, TourneyID, Lanes, OddLaneTeamID, EvenLaneTeamID)
  VALUES (45, 12, '05-06', 7, 1);
INSERT INTO Tourney_Matches
  (MatchID, TourneyID, Lanes, OddLaneTeamID, EvenLaneTeamID)
  VALUES (46, 12, '07-08', 5, 3);
INSERT INTO Tourney_Matches
  (MatchID, TourneyID, Lanes, OddLaneTeamID, EvenLaneTeamID)
  VALUES (47, 12, '09-10', 8, 2);
INSERT INTO Tourney_Matches
  (MatchID, TourneyID, Lanes, OddLaneTeamID, EvenLaneTeamID)
  VALUES (48, 12, '11-12', 6, 4);
INSERT INTO Tourney_Matches
  (MatchID, TourneyID, Lanes, OddLaneTeamID, EvenLaneTeamID)
  VALUES (49, 13, '13-14', 1, 8);
INSERT INTO Tourney_Matches
  (MatchID, TourneyID, Lanes, OddLaneTeamID, EvenLaneTeamID)
  VALUES (50, 13, '15-16', 2, 7);
INSERT INTO Tourney_Matches
  (MatchID, TourneyID, Lanes, OddLaneTeamID, EvenLaneTeamID)
  VALUES (51, 13, '17-18', 3, 6);
INSERT INTO Tourney_Matches
  (MatchID, TourneyID, Lanes, OddLaneTeamID, EvenLaneTeamID)
  VALUES (52, 13, '19-20', 4, 5);
INSERT INTO Tourney_Matches
  (MatchID, TourneyID, Lanes, OddLaneTeamID, EvenLaneTeamID)
  VALUES (53, 14, '01-02', 2, 1);
INSERT INTO Tourney_Matches
  (MatchID, TourneyID, Lanes, OddLaneTeamID, EvenLaneTeamID)
  VALUES (54, 14, '03-04', 4, 3);
INSERT INTO Tourney_Matches
  (MatchID, TourneyID, Lanes, OddLaneTeamID, EvenLaneTeamID)
  VALUES (55, 14, '05-06', 6, 5);
INSERT INTO Tourney_Matches
  (MatchID, TourneyID, Lanes, OddLaneTeamID, EvenLaneTeamID)
  VALUES (56, 14, '07-08', 8, 7);
INSERT INTO Tourney_Matches
  (MatchID, TourneyID, Lanes, OddLaneTeamID, EvenLaneTeamID)
  VALUES (57, 11, '19-20', 10, 9);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (1, 1, 1);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (1, 2, 2);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (1, 3, 1);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (2, 1, 3);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (2, 2, 4);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (2, 3, 3);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (3, 1, 5);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (3, 2, 6);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (3, 3, 5);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (4, 1, 7);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (4, 2, 8);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (4, 3, 7);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (5, 1, 3);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (5, 2, 1);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (5, 3, 3);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (6, 1, 4);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (6, 2, 2);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (6, 3, 4);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (7, 1, 5);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (7, 2, 7);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (7, 3, 5);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (8, 1, 8);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (8, 2, 6);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (8, 3, 8);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (9, 1, 2);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (9, 2, 3);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (9, 3, 2);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (10, 1, 1);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (10, 2, 4);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (10, 3, 1);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (11, 1, 7);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (11, 2, 6);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (11, 3, 7);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (12, 1, 5);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (12, 2, 8);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (12, 3, 5);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (13, 1, 1);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (13, 2, 5);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (13, 3, 1);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (14, 1, 2);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (14, 2, 6);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (14, 3, 2);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (15, 1, 3);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (15, 2, 7);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (15, 3, 3);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (16, 1, 4);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (16, 2, 8);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (16, 3, 4);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (17, 1, 6);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (17, 2, 1);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (17, 3, 6);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (18, 1, 5);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (18, 2, 2);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (18, 3, 5);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (19, 1, 8);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (19, 2, 3);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (19, 3, 8);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (20, 1, 7);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (20, 2, 4);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (20, 3, 7);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (21, 1, 1);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (21, 2, 7);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (21, 3, 1);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (22, 1, 3);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (22, 2, 5);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (22, 3, 3);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (23, 1, 2);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (23, 2, 8);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (23, 3, 2);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (24, 1, 4);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (24, 2, 6);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (24, 3, 4);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (25, 1, 8);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (25, 2, 1);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (25, 3, 8);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (26, 1, 7);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (26, 2, 2);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (26, 3, 7);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (27, 1, 6);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (27, 2, 3);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (27, 3, 6);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (28, 1, 5);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (28, 2, 4);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (28, 3, 5);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (29, 1, 1);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (29, 2, 3);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (29, 3, 1);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (30, 1, 2);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (30, 2, 4);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (30, 3, 2);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (31, 1, 7);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (31, 2, 5);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (31, 3, 7);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (32, 1, 6);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (32, 2, 8);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (32, 3, 6);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (33, 1, 3);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (33, 2, 2);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (33, 3, 3);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (34, 1, 4);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (34, 2, 1);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (34, 3, 4);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (35, 1, 6);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (35, 2, 7);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (35, 3, 6);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (36, 1, 8);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (36, 2, 5);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (36, 3, 8);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (37, 1, 5);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (37, 2, 1);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (37, 3, 5);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (38, 1, 6);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (38, 2, 2);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (38, 3, 6);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (39, 1, 7);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (39, 2, 3);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (39, 3, 7);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (40, 1, 8);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (40, 2, 4);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (40, 3, 8);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (41, 1, 1);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (41, 2, 6);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (41, 3, 1);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (42, 1, 2);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (42, 2, 5);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (42, 3, 2);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (43, 1, 3);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (43, 2, 8);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (43, 3, 3);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (44, 1, 4);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (44, 2, 7);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (44, 3, 4);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (45, 1, 7);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (45, 2, 1);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (45, 3, 7);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (46, 1, 5);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (46, 2, 3);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (46, 3, 5);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (47, 1, 8);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (47, 2, 2);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (47, 3, 8);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (48, 1, 6);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (48, 2, 4);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (48, 3, 6);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (49, 1, 1);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (49, 2, 8);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (49, 3, 1);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (50, 1, 2);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (50, 2, 7);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (50, 3, 2);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (51, 1, 3);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (51, 2, 6);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (51, 3, 3);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (52, 1, 4);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (52, 2, 5);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (52, 3, 4);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (53, 1, 2);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (53, 2, 1);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (53, 3, 2);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (54, 1, 4);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (54, 2, 3);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (54, 3, 4);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (55, 1, 6);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (55, 2, 5);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (55, 3, 6);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (56, 1, 8);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (56, 2, 7);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (56, 3, 8);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (1, 1, 1, 146, 192, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (1, 1, 2, 166, 205, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (1, 1, 3, 140, 171, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (1, 1, 4, 146, 198, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (1, 1, 5, 157, 203, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (1, 1, 6, 160, 198, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (1, 1, 7, 170, 199, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (1, 1, 8, 150, 202, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (1, 2, 1, 146, 192, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (1, 2, 2, 135, 174, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (1, 2, 3, 156, 187, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (1, 2, 4, 143, 195, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (1, 2, 5, 149, 195, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (1, 2, 6, 152, 190, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (1, 2, 7, 158, 187, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (1, 2, 8, 136, 188, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (1, 3, 1, 153, 199, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (1, 3, 2, 177, 216, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (1, 3, 3, 191, 222, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (1, 3, 4, 148, 200, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (1, 3, 5, 139, 185, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (1, 3, 6, 142, 180, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (1, 3, 7, 192, 221, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (1, 3, 8, 148, 200, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (2, 1, 9, 146, 191, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (2, 1, 10, 154, 190, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (2, 1, 11, 168, 201, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (2, 1, 12, 136, 188, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (2, 1, 13, 143, 186, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (2, 1, 14, 142, 181, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (2, 1, 15, 137, 171, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (2, 1, 16, 143, 195, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (2, 2, 9, 138, 183, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (2, 2, 10, 171, 207, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (2, 2, 11, 180, 213, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (2, 2, 12, 145, 197, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (2, 2, 13, 155, 198, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (2, 2, 14, 166, 205, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (2, 2, 15, 155, 189, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (2, 2, 16, 139, 191, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (2, 3, 9, 161, 206, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (2, 3, 10, 172, 208, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (2, 3, 11, 186, 219, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (2, 3, 12, 136, 188, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (2, 3, 13, 162, 205, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (2, 3, 14, 137, 176, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (2, 3, 15, 163, 197, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (2, 3, 16, 143, 195, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (3, 1, 17, 159, 205, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (3, 1, 18, 176, 215, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (3, 1, 19, 147, 176, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (3, 1, 20, 143, 194, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (3, 1, 21, 154, 201, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (3, 1, 22, 173, 211, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (3, 1, 23, 146, 178, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (3, 1, 24, 164, 192, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (3, 2, 17, 165, 211, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (3, 2, 18, 164, 203, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (3, 2, 19, 168, 197, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (3, 2, 20, 137, 188, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (3, 2, 21, 157, 204, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (3, 2, 22, 157, 195, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (3, 2, 23, 182, 214, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (3, 2, 24, 160, 188, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (3, 3, 17, 149, 195, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (3, 3, 18, 160, 199, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (3, 3, 19, 185, 214, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (3, 3, 20, 141, 192, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (3, 3, 21, 137, 184, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (3, 3, 22, 180, 218, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (3, 3, 23, 187, 219, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (3, 3, 24, 163, 191, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (4, 1, 25, 157, 202, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (4, 1, 26, 143, 182, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (4, 1, 27, 140, 170, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (4, 1, 28, 143, 194, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (4, 1, 29, 138, 183, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (4, 1, 30, 176, 215, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (4, 1, 31, 151, 184, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (4, 1, 32, 148, 200, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (4, 2, 25, 138, 183, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (4, 2, 26, 147, 186, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (4, 2, 27, 172, 202, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (4, 2, 28, 147, 198, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (4, 2, 29, 143, 188, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (4, 2, 30, 167, 206, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (4, 2, 31, 146, 179, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (4, 2, 32, 141, 193, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (4, 3, 25, 155, 200, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (4, 3, 26, 148, 187, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (4, 3, 27, 167, 197, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (4, 3, 28, 140, 191, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (4, 3, 29, 163, 208, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (4, 3, 30, 143, 182, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (4, 3, 31, 182, 215, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (4, 3, 32, 148, 200, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (5, 1, 1, 145, 192, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (5, 1, 2, 148, 185, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (5, 1, 3, 181, 215, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (5, 1, 4, 139, 188, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (5, 1, 9, 147, 194, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (5, 1, 10, 147, 178, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (5, 1, 11, 158, 178, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (5, 1, 12, 147, 202, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (5, 2, 1, 137, 184, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (5, 2, 2, 140, 177, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (5, 2, 3, 158, 192, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (5, 2, 4, 139, 188, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (5, 2, 9, 146, 193, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (5, 2, 10, 167, 198, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (5, 2, 11, 144, 164, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (5, 2, 12, 143, 198, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (5, 3, 1, 152, 199, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (5, 3, 2, 144, 181, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (5, 3, 3, 175, 209, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (5, 3, 4, 138, 187, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (5, 3, 9, 148, 195, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (5, 3, 10, 178, 209, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (5, 3, 11, 158, 178, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (5, 3, 12, 137, 192, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (6, 1, 5, 164, 211, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (6, 1, 6, 179, 223, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (6, 1, 7, 181, 205, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (6, 1, 8, 146, 196, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (6, 1, 13, 164, 206, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (6, 1, 14, 164, 211, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (6, 1, 15, 180, 223, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (6, 1, 16, 149, 201, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (6, 2, 5, 138, 185, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (6, 2, 6, 164, 208, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (6, 2, 7, 183, 207, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (6, 2, 8, 149, 199, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (6, 2, 13, 165, 207, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (6, 2, 14, 156, 203, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (6, 2, 15, 177, 220, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (6, 2, 16, 149, 201, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (6, 3, 5, 165, 212, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (6, 3, 6, 136, 180, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (6, 3, 7, 178, 202, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (6, 3, 8, 138, 188, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (6, 3, 13, 151, 193, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (6, 3, 14, 147, 194, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (6, 3, 15, 158, 201, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (6, 3, 16, 136, 188, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (7, 1, 17, 139, 177, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (7, 1, 18, 142, 172, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (7, 1, 19, 189, 219, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (7, 1, 20, 138, 192, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (7, 1, 25, 143, 188, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (7, 1, 26, 180, 229, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (7, 1, 27, 167, 203, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (7, 1, 28, 148, 199, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (7, 2, 17, 157, 195, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (7, 2, 18, 143, 173, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (7, 2, 19, 176, 206, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (7, 2, 20, 141, 195, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (7, 2, 25, 139, 184, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (7, 2, 26, 175, 224, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (7, 2, 27, 178, 214, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (7, 2, 28, 147, 198, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (7, 3, 17, 155, 193, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (7, 3, 18, 136, 166, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (7, 3, 19, 155, 185, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (7, 3, 20, 139, 193, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (7, 3, 25, 143, 188, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (7, 3, 26, 151, 200, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (7, 3, 27, 137, 173, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (7, 3, 28, 150, 201, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (8, 1, 21, 145, 191, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (8, 1, 22, 146, 173, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (8, 1, 23, 157, 182, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (8, 1, 24, 168, 196, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (8, 1, 29, 140, 187, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (8, 1, 30, 179, 213, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (8, 1, 31, 161, 197, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (8, 1, 32, 138, 187, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (8, 2, 21, 148, 194, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (8, 2, 22, 136, 163, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (8, 2, 23, 193, 218, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (8, 2, 24, 178, 206, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (8, 2, 29, 156, 203, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (8, 2, 30, 149, 183, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (8, 2, 31, 185, 221, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (8, 2, 32, 136, 185, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (8, 3, 21, 136, 182, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (8, 3, 22, 143, 170, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (8, 3, 23, 189, 214, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (8, 3, 24, 168, 197, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (8, 3, 29, 135, 182, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (8, 3, 30, 166, 200, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (8, 3, 31, 140, 176, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (8, 3, 32, 144, 193, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (9, 1, 5, 137, 180, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (9, 1, 6, 178, 218, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (9, 1, 7, 140, 161, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (9, 1, 8, 139, 189, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (9, 1, 9, 164, 211, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (9, 1, 10, 136, 168, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (9, 1, 11, 182, 213, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (9, 1, 12, 145, 198, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (9, 2, 5, 149, 192, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (9, 2, 6, 147, 187, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (9, 2, 7, 145, 166, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (9, 2, 8, 141, 191, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (9, 2, 9, 158, 205, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (9, 2, 10, 167, 199, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (9, 2, 11, 176, 207, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (9, 2, 12, 139, 192, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (9, 3, 5, 162, 205, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (9, 3, 6, 141, 181, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (9, 3, 7, 144, 165, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (9, 3, 8, 149, 199, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (9, 3, 9, 144, 191, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (9, 3, 10, 158, 190, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (9, 3, 11, 158, 189, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (9, 3, 12, 135, 188, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (10, 1, 1, 140, 189, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (10, 1, 2, 141, 184, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (10, 1, 3, 189, 219, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (10, 1, 4, 143, 195, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (10, 1, 13, 150, 189, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (10, 1, 14, 150, 193, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (10, 1, 15, 181, 215, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (10, 1, 16, 145, 196, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (10, 2, 1, 137, 186, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (10, 2, 2, 163, 206, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (10, 2, 3, 135, 165, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (10, 2, 4, 147, 199, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (10, 2, 13, 153, 192, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (10, 2, 14, 154, 197, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (10, 2, 15, 169, 203, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (10, 2, 16, 138, 189, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (10, 3, 1, 161, 210, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (10, 3, 2, 167, 210, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (10, 3, 3, 175, 205, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (10, 3, 4, 140, 192, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (10, 3, 13, 143, 182, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (10, 3, 14, 157, 200, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (10, 3, 15, 153, 187, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (10, 3, 16, 142, 193, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (11, 1, 21, 146, 195, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (11, 1, 22, 174, 214, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (11, 1, 23, 164, 186, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (11, 1, 24, 169, 196, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (11, 1, 25, 158, 207, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (11, 1, 26, 159, 198, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (11, 1, 27, 195, 231, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (11, 1, 28, 138, 187, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (11, 2, 21, 154, 203, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (11, 2, 22, 140, 180, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (11, 2, 23, 140, 162, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (11, 2, 24, 175, 202, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (11, 2, 25, 158, 207, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (11, 2, 26, 171, 210, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (11, 2, 27, 160, 196, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (11, 2, 28, 142, 191, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (11, 3, 21, 159, 208, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (11, 3, 22, 165, 205, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (11, 3, 23, 147, 169, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (11, 3, 24, 167, 194, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (11, 3, 25, 161, 210, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (11, 3, 26, 161, 200, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (11, 3, 27, 158, 194, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (11, 3, 28, 135, 184, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (12, 1, 17, 139, 180, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (12, 1, 18, 145, 186, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (12, 1, 19, 154, 181, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (12, 1, 20, 149, 203, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (12, 1, 29, 137, 186, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (12, 1, 30, 135, 168, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (12, 1, 31, 139, 174, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (12, 1, 32, 140, 192, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (12, 2, 17, 151, 192, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (12, 2, 18, 167, 208, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (12, 2, 19, 183, 210, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (12, 2, 20, 146, 200, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (12, 2, 29, 148, 197, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (12, 2, 30, 171, 204, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (12, 2, 31, 145, 180, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (12, 2, 32, 145, 197, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (12, 3, 17, 155, 196, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (12, 3, 18, 143, 184, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (12, 3, 19, 141, 168, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (12, 3, 20, 149, 203, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (12, 3, 29, 156, 205, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (12, 3, 30, 158, 191, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (12, 3, 31, 184, 219, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (12, 3, 32, 146, 198, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (13, 1, 1, 159, 208, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (13, 1, 2, 163, 205, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (13, 1, 3, 182, 212, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (13, 1, 4, 138, 189, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (13, 1, 17, 150, 193, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (13, 1, 18, 136, 178, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (13, 1, 19, 179, 210, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (13, 1, 20, 146, 197, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (13, 2, 1, 140, 189, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (13, 2, 2, 176, 218, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (13, 2, 3, 178, 208, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (13, 2, 4, 139, 190, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (13, 2, 17, 153, 196, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (13, 2, 18, 174, 216, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (13, 2, 19, 140, 171, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (13, 2, 20, 141, 192, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (13, 3, 1, 158, 207, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (13, 3, 2, 141, 183, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (13, 3, 3, 150, 180, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (13, 3, 4, 140, 191, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (13, 3, 17, 151, 194, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (13, 3, 18, 146, 188, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (13, 3, 19, 173, 204, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (13, 3, 20, 148, 199, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (14, 1, 5, 163, 207, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (14, 1, 6, 136, 177, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (14, 1, 7, 177, 208, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (14, 1, 8, 147, 197, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (14, 1, 21, 146, 193, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (14, 1, 22, 170, 209, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (14, 1, 23, 149, 179, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (14, 1, 24, 176, 202, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (14, 2, 5, 150, 194, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (14, 2, 6, 172, 213, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (14, 2, 7, 135, 166, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (14, 2, 8, 136, 186, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (14, 2, 21, 160, 207, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (14, 2, 22, 140, 179, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (14, 2, 23, 164, 194, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (14, 2, 24, 172, 198, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (14, 3, 5, 142, 186, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (14, 3, 6, 142, 183, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (14, 3, 7, 179, 210, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (14, 3, 8, 148, 198, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (14, 3, 21, 153, 200, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (14, 3, 22, 178, 217, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (14, 3, 23, 180, 210, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (14, 3, 24, 175, 201, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (15, 1, 9, 142, 187, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (15, 1, 10, 155, 190, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (15, 1, 11, 150, 179, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (15, 1, 12, 140, 194, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (15, 1, 25, 163, 208, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (15, 1, 26, 153, 190, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (15, 1, 27, 153, 185, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (15, 1, 28, 143, 194, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (15, 2, 9, 162, 207, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (15, 2, 10, 151, 186, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (15, 2, 11, 146, 175, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (15, 2, 12, 150, 204, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (15, 2, 25, 147, 192, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (15, 2, 26, 156, 193, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (15, 2, 27, 182, 214, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (15, 2, 28, 140, 191, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (15, 3, 9, 163, 208, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (15, 3, 10, 158, 193, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (15, 3, 11, 141, 170, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (15, 3, 12, 140, 194, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (15, 3, 25, 139, 184, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (15, 3, 26, 166, 203, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (15, 3, 27, 193, 225, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (15, 3, 28, 140, 191, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (16, 1, 13, 157, 198, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (16, 1, 14, 162, 204, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (16, 1, 15, 165, 197, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (16, 1, 16, 139, 190, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (16, 1, 29, 164, 213, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (16, 1, 30, 153, 189, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (16, 1, 31, 174, 211, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (16, 1, 32, 140, 191, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (16, 2, 13, 162, 203, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (16, 2, 14, 164, 206, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (16, 2, 15, 135, 167, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (16, 2, 16, 137, 188, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (16, 2, 29, 138, 187, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (16, 2, 30, 167, 203, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (16, 2, 31, 184, 221, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (16, 2, 32, 144, 195, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (16, 3, 13, 139, 180, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (16, 3, 14, 153, 195, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (16, 3, 15, 183, 215, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (16, 3, 16, 147, 198, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (16, 3, 29, 163, 212, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (16, 3, 30, 147, 183, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (16, 3, 31, 149, 186, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (16, 3, 32, 140, 191, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (17, 1, 1, 139, 186, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (17, 1, 2, 175, 216, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (17, 1, 3, 136, 165, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (17, 1, 4, 141, 193, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (17, 1, 21, 141, 186, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (17, 1, 22, 146, 184, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (17, 1, 23, 156, 187, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (17, 1, 24, 162, 187, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (17, 2, 1, 164, 211, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (17, 2, 2, 161, 202, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (17, 2, 3, 174, 203, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (17, 2, 4, 145, 197, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (17, 2, 21, 147, 192, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (17, 2, 22, 141, 179, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (17, 2, 23, 156, 187, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (17, 2, 24, 165, 190, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (17, 3, 1, 161, 208, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (17, 3, 2, 173, 214, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (17, 3, 3, 144, 173, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (17, 3, 4, 141, 193, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (17, 3, 21, 138, 183, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (17, 3, 22, 174, 212, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (17, 3, 23, 190, 221, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (17, 3, 24, 173, 198, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (18, 1, 5, 143, 187, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (18, 1, 6, 145, 186, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (18, 1, 7, 169, 201, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (18, 1, 8, 146, 196, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (18, 1, 17, 149, 192, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (18, 1, 18, 165, 207, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (18, 1, 19, 138, 169, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (18, 1, 20, 148, 199, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (18, 2, 5, 155, 199, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (18, 2, 6, 178, 219, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (18, 2, 7, 175, 207, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (18, 2, 8, 146, 196, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (18, 2, 17, 156, 199, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (18, 2, 18, 173, 215, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (18, 2, 19, 155, 186, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (18, 2, 20, 148, 199, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (18, 3, 5, 136, 180, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (18, 3, 6, 140, 181, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (18, 3, 7, 187, 219, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (18, 3, 8, 142, 192, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (18, 3, 17, 141, 184, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (18, 3, 18, 173, 215, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (18, 3, 19, 190, 221, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (18, 3, 20, 143, 194, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (19, 1, 9, 142, 185, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (19, 1, 10, 169, 205, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (19, 1, 11, 162, 196, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (19, 1, 12, 140, 193, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (19, 1, 29, 144, 191, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (19, 1, 30, 162, 199, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (19, 1, 31, 175, 209, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (19, 1, 32, 143, 195, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (19, 2, 9, 164, 207, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (19, 2, 10, 161, 197, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (19, 2, 11, 137, 171, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (19, 2, 12, 148, 201, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (19, 2, 29, 135, 182, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (19, 2, 30, 177, 214, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (19, 2, 31, 174, 208, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (19, 2, 32, 149, 201, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (19, 3, 9, 162, 205, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (19, 3, 10, 158, 194, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (19, 3, 11, 149, 183, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (19, 3, 12, 142, 195, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (19, 3, 29, 137, 184, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (19, 3, 30, 151, 188, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (19, 3, 31, 186, 220, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (19, 3, 32, 137, 189, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (20, 1, 13, 161, 202, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (20, 1, 14, 175, 216, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (20, 1, 15, 176, 209, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (20, 1, 16, 143, 195, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (20, 1, 25, 144, 189, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (20, 1, 26, 141, 178, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (20, 1, 27, 139, 169, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (20, 1, 28, 150, 201, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (20, 2, 13, 148, 189, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (20, 2, 14, 164, 205, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (20, 2, 15, 144, 177, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (20, 2, 16, 137, 189, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (20, 2, 25, 144, 189, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (20, 2, 26, 158, 195, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (20, 2, 27, 147, 177, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (20, 2, 28, 138, 189, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (20, 3, 13, 162, 203, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (20, 3, 14, 172, 213, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (20, 3, 15, 140, 173, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (20, 3, 16, 138, 190, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (20, 3, 25, 137, 182, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (20, 3, 26, 143, 180, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (20, 3, 27, 172, 202, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (20, 3, 28, 149, 200, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (21, 1, 1, 141, 187, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (21, 1, 2, 141, 179, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (21, 1, 3, 191, 223, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (21, 1, 4, 145, 197, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (21, 1, 25, 142, 189, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (21, 1, 26, 151, 190, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (21, 1, 27, 150, 182, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (21, 1, 28, 148, 199, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (21, 2, 1, 141, 187, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (21, 2, 2, 164, 202, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (21, 2, 3, 189, 221, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (21, 2, 4, 142, 194, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (21, 2, 25, 147, 194, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (21, 2, 26, 138, 177, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (21, 2, 27, 176, 208, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (21, 2, 28, 137, 188, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (21, 3, 1, 139, 185, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (21, 3, 2, 159, 197, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (21, 3, 3, 174, 206, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (21, 3, 4, 137, 189, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (21, 3, 25, 136, 183, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (21, 3, 26, 178, 217, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (21, 3, 27, 191, 223, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (21, 3, 28, 147, 198, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (22, 1, 9, 142, 185, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (22, 1, 10, 165, 201, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (22, 1, 11, 144, 180, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (22, 1, 12, 139, 191, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (22, 1, 17, 139, 183, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (22, 1, 18, 168, 208, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (22, 1, 19, 165, 197, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (22, 1, 20, 144, 194, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (22, 2, 9, 143, 186, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (22, 2, 10, 167, 203, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (22, 2, 11, 188, 224, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (22, 2, 12, 145, 197, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (22, 2, 17, 144, 188, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (22, 2, 18, 159, 199, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (22, 2, 19, 166, 198, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (22, 2, 20, 143, 193, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (22, 3, 9, 153, 196, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (22, 3, 10, 146, 182, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (22, 3, 11, 182, 218, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (22, 3, 12, 147, 199, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (22, 3, 17, 162, 206, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (22, 3, 18, 179, 219, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (22, 3, 19, 179, 211, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (22, 3, 20, 144, 194, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (23, 1, 5, 136, 181, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (23, 1, 6, 175, 216, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (23, 1, 7, 164, 193, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (23, 1, 8, 136, 186, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (23, 1, 29, 159, 208, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (23, 1, 30, 151, 187, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (23, 1, 31, 177, 209, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (23, 1, 32, 142, 193, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (23, 2, 5, 145, 190, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (23, 2, 6, 175, 216, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (23, 2, 7, 182, 211, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (23, 2, 8, 142, 192, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (23, 2, 29, 136, 185, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (23, 2, 30, 149, 185, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (23, 2, 31, 149, 181, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (23, 2, 32, 136, 187, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (23, 3, 5, 154, 199, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (23, 3, 6, 177, 218, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (23, 3, 7, 150, 179, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (23, 3, 8, 142, 192, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (23, 3, 29, 135, 184, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (23, 3, 30, 153, 189, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (23, 3, 31, 141, 173, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (23, 3, 32, 140, 191, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (24, 1, 13, 149, 190, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (24, 1, 14, 138, 176, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (24, 1, 15, 154, 189, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (24, 1, 16, 139, 191, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (24, 1, 21, 159, 206, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (24, 1, 22, 147, 185, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (24, 1, 23, 193, 223, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (24, 1, 24, 171, 197, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (24, 2, 13, 151, 192, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (24, 2, 14, 179, 217, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (24, 2, 15, 157, 192, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (24, 2, 16, 148, 200, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (24, 2, 21, 157, 204, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (24, 2, 22, 172, 210, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (24, 2, 23, 175, 205, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (24, 2, 24, 169, 195, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (24, 3, 13, 149, 190, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (24, 3, 14, 163, 201, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (24, 3, 15, 148, 183, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (24, 3, 16, 139, 191, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (24, 3, 21, 138, 185, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (24, 3, 22, 170, 208, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (24, 3, 23, 168, 198, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (24, 3, 24, 174, 200, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (25, 1, 1, 149, 196, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (25, 1, 2, 157, 196, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (25, 1, 3, 152, 181, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (25, 1, 4, 141, 193, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (25, 1, 29, 164, 213, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (25, 1, 30, 173, 210, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (25, 1, 31, 187, 220, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (25, 1, 32, 145, 197, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (25, 2, 1, 159, 206, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (25, 2, 2, 171, 210, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (25, 2, 3, 179, 208, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (25, 2, 4, 135, 187, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (25, 2, 29, 164, 213, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (25, 2, 30, 156, 193, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (25, 2, 31, 159, 192, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (25, 2, 32, 137, 189, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (25, 3, 1, 138, 185, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (25, 3, 2, 157, 196, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (25, 3, 3, 148, 177, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (25, 3, 4, 137, 189, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (25, 3, 29, 147, 196, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (25, 3, 30, 159, 196, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (25, 3, 31, 147, 180, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (25, 3, 32, 148, 200, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (26, 1, 5, 142, 188, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (26, 1, 6, 166, 204, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (26, 1, 7, 190, 220, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (26, 1, 8, 142, 193, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (26, 1, 25, 164, 212, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (26, 1, 26, 174, 213, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (26, 1, 27, 162, 194, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (26, 1, 28, 145, 196, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (26, 2, 5, 139, 185, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (26, 2, 6, 163, 201, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (26, 2, 7, 173, 203, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (26, 2, 8, 135, 186, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (26, 2, 25, 139, 187, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (26, 2, 26, 170, 209, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (26, 2, 27, 180, 212, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (26, 2, 28, 136, 187, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (26, 3, 5, 160, 206, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (26, 3, 6, 168, 206, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (26, 3, 7, 174, 204, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (26, 3, 8, 137, 188, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (26, 3, 25, 152, 200, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (26, 3, 26, 139, 178, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (26, 3, 27, 141, 173, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (26, 3, 28, 138, 189, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (27, 1, 9, 148, 192, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (27, 1, 10, 174, 210, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (27, 1, 11, 138, 172, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (27, 1, 12, 148, 200, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (27, 1, 21, 155, 201, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (27, 1, 22, 156, 194, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (27, 1, 23, 147, 175, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (27, 1, 24, 166, 192, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (27, 2, 9, 150, 194, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (27, 2, 10, 169, 205, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (27, 2, 11, 141, 175, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (27, 2, 12, 147, 199, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (27, 2, 21, 146, 192, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (27, 2, 22, 174, 212, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (27, 2, 23, 179, 207, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (27, 2, 24, 160, 186, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (27, 3, 9, 152, 196, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (27, 3, 10, 175, 211, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (27, 3, 11, 191, 225, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (27, 3, 12, 148, 200, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (27, 3, 21, 144, 190, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (27, 3, 22, 147, 185, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (27, 3, 23, 147, 175, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (27, 3, 24, 171, 197, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (28, 1, 13, 140, 181, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (28, 1, 14, 155, 193, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (28, 1, 15, 170, 206, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (28, 1, 16, 138, 190, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (28, 1, 17, 165, 209, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (28, 1, 18, 172, 210, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (28, 1, 19, 185, 216, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (28, 1, 20, 140, 190, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (28, 2, 13, 149, 190, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (28, 2, 14, 162, 200, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (28, 2, 15, 140, 176, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (28, 2, 16, 135, 187, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (28, 2, 17, 153, 197, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (28, 2, 18, 180, 218, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (28, 2, 19, 181, 212, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (28, 2, 20, 142, 192, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (28, 3, 13, 142, 183, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (28, 3, 14, 135, 173, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (28, 3, 15, 138, 174, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (28, 3, 16, 148, 200, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (28, 3, 17, 152, 196, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (28, 3, 18, 140, 178, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (28, 3, 19, 167, 198, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (28, 3, 20, 149, 199, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (29, 1, 1, 161, 208, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (29, 1, 2, 143, 181, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (29, 1, 3, 182, 212, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (29, 1, 4, 138, 191, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (29, 1, 9, 158, 202, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (29, 1, 10, 161, 195, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (29, 1, 11, 150, 185, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (29, 1, 12, 145, 196, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (29, 2, 1, 141, 188, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (29, 2, 2, 171, 209, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (29, 2, 3, 145, 175, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (29, 2, 4, 144, 197, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (29, 2, 9, 141, 185, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (29, 2, 10, 160, 194, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (29, 2, 11, 173, 208, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (29, 2, 12, 150, 201, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (29, 3, 1, 156, 203, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (29, 3, 2, 159, 197, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (29, 3, 3, 169, 199, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (29, 3, 4, 146, 199, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (29, 3, 9, 144, 188, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (29, 3, 10, 164, 198, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (29, 3, 11, 166, 201, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (29, 3, 12, 136, 187, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (30, 1, 5, 153, 199, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (30, 1, 6, 152, 189, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (30, 1, 7, 172, 200, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (30, 1, 8, 136, 187, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (30, 1, 13, 136, 179, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (30, 1, 14, 165, 204, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (30, 1, 15, 137, 175, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (30, 1, 16, 148, 200, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (30, 2, 5, 149, 195, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (30, 2, 6, 159, 196, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (30, 2, 7, 153, 181, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (30, 2, 8, 149, 200, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (30, 2, 13, 158, 201, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (30, 2, 14, 148, 187, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (30, 2, 15, 188, 226, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (30, 2, 16, 145, 197, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (30, 3, 5, 147, 193, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (30, 3, 6, 151, 188, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (30, 3, 7, 193, 221, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (30, 3, 8, 143, 194, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (30, 3, 13, 155, 198, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (30, 3, 14, 177, 216, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (30, 3, 15, 145, 183, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (30, 3, 16, 141, 193, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (31, 1, 17, 139, 182, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (31, 1, 18, 144, 181, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (31, 1, 19, 179, 209, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (31, 1, 20, 147, 197, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (31, 1, 25, 157, 204, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (31, 1, 26, 170, 209, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (31, 1, 27, 168, 200, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (31, 1, 28, 143, 194, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (31, 2, 17, 155, 198, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (31, 2, 18, 148, 185, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (31, 2, 19, 167, 197, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (31, 2, 20, 141, 191, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (31, 2, 25, 159, 206, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (31, 2, 26, 165, 204, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (31, 2, 27, 192, 224, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (31, 2, 28, 142, 193, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (31, 3, 17, 136, 179, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (31, 3, 18, 171, 208, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (31, 3, 19, 157, 187, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (31, 3, 20, 137, 187, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (31, 3, 25, 164, 211, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (31, 3, 26, 165, 204, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (31, 3, 27, 183, 215, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (31, 3, 28, 146, 197, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (32, 1, 21, 136, 182, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (32, 1, 22, 143, 180, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (32, 1, 23, 158, 188, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (32, 1, 24, 174, 201, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (32, 1, 29, 151, 198, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (32, 1, 30, 167, 204, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (32, 1, 31, 184, 216, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (32, 1, 32, 143, 195, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (32, 2, 21, 158, 204, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (32, 2, 22, 166, 203, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (32, 2, 23, 188, 218, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (32, 2, 24, 167, 194, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (32, 2, 29, 150, 197, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (32, 2, 30, 166, 203, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (32, 2, 31, 161, 193, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (32, 2, 32, 137, 189, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (32, 3, 21, 159, 205, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (32, 3, 22, 145, 182, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (32, 3, 23, 181, 211, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (32, 3, 24, 168, 195, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (32, 3, 29, 143, 190, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (32, 3, 30, 161, 198, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (32, 3, 31, 152, 184, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (32, 3, 32, 139, 191, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (33, 1, 5, 141, 187, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (33, 1, 6, 143, 181, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (33, 1, 7, 166, 194, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (33, 1, 8, 145, 196, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (33, 1, 9, 152, 196, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (33, 1, 10, 141, 175, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (33, 1, 11, 169, 204, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (33, 1, 12, 147, 198, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (33, 2, 5, 164, 210, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (33, 2, 6, 147, 185, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (33, 2, 7, 160, 188, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (33, 2, 8, 147, 198, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (33, 2, 9, 159, 203, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (33, 2, 10, 140, 174, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (33, 2, 11, 180, 215, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (33, 2, 12, 138, 189, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (33, 3, 5, 140, 186, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (33, 3, 6, 171, 209, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (33, 3, 7, 168, 196, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (33, 3, 8, 140, 191, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (33, 3, 9, 136, 180, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (33, 3, 10, 155, 189, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (33, 3, 11, 194, 229, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (33, 3, 12, 150, 201, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (34, 1, 1, 140, 187, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (34, 1, 2, 160, 198, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (34, 1, 3, 152, 183, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (34, 1, 4, 142, 195, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (34, 1, 13, 146, 189, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (34, 1, 14, 161, 199, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (34, 1, 15, 170, 208, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (34, 1, 16, 144, 196, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (34, 2, 1, 140, 187, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (34, 2, 2, 170, 208, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (34, 2, 3, 158, 189, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (34, 2, 4, 137, 190, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (34, 2, 13, 154, 197, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (34, 2, 14, 170, 208, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (34, 2, 15, 145, 183, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (34, 2, 16, 141, 193, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (34, 3, 1, 149, 196, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (34, 3, 2, 146, 184, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (34, 3, 3, 141, 172, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (34, 3, 4, 149, 202, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (34, 3, 13, 156, 199, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (34, 3, 14, 148, 186, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (34, 3, 15, 176, 214, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (34, 3, 16, 149, 201, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (35, 1, 21, 137, 183, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (35, 1, 22, 157, 195, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (35, 1, 23, 168, 197, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (35, 1, 24, 163, 190, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (35, 1, 25, 141, 187, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (35, 1, 26, 158, 196, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (35, 1, 27, 150, 180, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (35, 1, 28, 147, 198, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (35, 2, 21, 153, 199, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (35, 2, 22, 155, 193, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (35, 2, 23, 142, 171, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (35, 2, 24, 171, 198, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (35, 2, 25, 163, 209, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (35, 2, 26, 157, 195, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (35, 2, 27, 180, 210, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (35, 2, 28, 139, 190, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (35, 3, 21, 159, 205, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (35, 3, 22, 164, 202, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (35, 3, 23, 160, 189, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (35, 3, 24, 162, 189, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (35, 3, 25, 136, 182, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (35, 3, 26, 141, 179, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (35, 3, 27, 151, 181, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (35, 3, 28, 144, 195, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (36, 1, 17, 157, 201, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (36, 1, 18, 157, 195, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (36, 1, 19, 149, 179, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (36, 1, 20, 148, 198, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (36, 1, 29, 162, 209, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (36, 1, 30, 139, 175, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (36, 1, 31, 138, 170, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (36, 1, 32, 142, 194, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (36, 2, 17, 159, 203, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (36, 2, 18, 179, 217, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (36, 2, 19, 192, 222, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (36, 2, 20, 140, 190, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (36, 2, 29, 153, 200, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (36, 2, 30, 158, 194, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (36, 2, 31, 163, 195, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (36, 2, 32, 142, 194, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (36, 3, 17, 148, 192, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (36, 3, 18, 174, 212, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (36, 3, 19, 146, 176, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (36, 3, 20, 139, 189, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (36, 3, 29, 161, 208, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (36, 3, 30, 173, 209, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (36, 3, 31, 156, 188, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (36, 3, 32, 143, 195, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (37, 1, 1, 143, 190, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (37, 1, 2, 139, 177, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (37, 1, 3, 178, 210, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (37, 1, 4, 141, 194, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (37, 1, 17, 164, 208, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (37, 1, 18, 138, 174, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (37, 1, 19, 155, 185, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (37, 1, 20, 149, 200, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (37, 2, 1, 156, 203, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (37, 2, 2, 143, 181, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (37, 2, 3, 159, 191, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (37, 2, 4, 144, 197, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (37, 2, 17, 161, 205, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (37, 2, 18, 142, 178, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (37, 2, 19, 193, 223, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (37, 2, 20, 141, 192, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (37, 3, 1, 151, 198, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (37, 3, 2, 165, 203, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (37, 3, 3, 156, 188, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (37, 3, 4, 148, 201, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (37, 3, 17, 156, 200, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (37, 3, 18, 155, 191, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (37, 3, 19, 192, 222, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (37, 3, 20, 137, 188, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (38, 1, 5, 156, 202, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (38, 1, 6, 155, 193, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (38, 1, 7, 155, 183, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (38, 1, 8, 138, 189, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (38, 1, 21, 157, 203, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (38, 1, 22, 136, 174, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (38, 1, 23, 167, 197, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (38, 1, 24, 173, 201, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (38, 2, 5, 148, 194, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (38, 2, 6, 165, 203, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (38, 2, 7, 167, 195, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (38, 2, 8, 138, 189, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (38, 2, 21, 144, 190, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (38, 2, 22, 161, 199, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (38, 2, 23, 149, 179, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (38, 2, 24, 176, 204, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (38, 3, 5, 153, 199, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (38, 3, 6, 165, 203, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (38, 3, 7, 165, 193, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (38, 3, 8, 145, 196, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (38, 3, 21, 144, 190, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (38, 3, 22, 151, 189, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (38, 3, 23, 183, 213, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (38, 3, 24, 171, 199, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (39, 1, 9, 139, 183, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (39, 1, 10, 146, 182, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (39, 1, 11, 156, 189, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (39, 1, 12, 145, 196, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (39, 1, 25, 154, 200, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (39, 1, 26, 158, 196, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (39, 1, 27, 160, 191, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (39, 1, 28, 148, 199, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (39, 2, 9, 137, 181, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (39, 2, 10, 146, 182, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (39, 2, 11, 145, 178, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (39, 2, 12, 136, 187, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (39, 2, 25, 135, 181, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (39, 2, 26, 158, 196, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (39, 2, 27, 144, 175, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (39, 2, 28, 144, 195, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (39, 3, 9, 150, 194, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (39, 3, 10, 145, 181, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (39, 3, 11, 181, 214, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (39, 3, 12, 147, 198, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (39, 3, 25, 141, 187, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (39, 3, 26, 136, 174, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (39, 3, 27, 175, 206, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (39, 3, 28, 139, 190, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (40, 1, 13, 161, 204, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (40, 1, 14, 161, 199, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (40, 1, 15, 173, 210, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (40, 1, 16, 146, 198, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (40, 1, 29, 141, 187, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (40, 1, 30, 172, 209, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (40, 1, 31, 144, 177, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (40, 1, 32, 142, 194, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (40, 2, 13, 155, 198, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (40, 2, 14, 165, 203, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (40, 2, 15, 143, 180, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (40, 2, 16, 137, 189, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (40, 2, 29, 161, 207, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (40, 2, 30, 140, 177, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (40, 2, 31, 167, 200, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (40, 2, 32, 146, 198, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (40, 3, 13, 140, 183, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (40, 3, 14, 157, 195, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (40, 3, 15, 191, 228, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (40, 3, 16, 139, 191, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (40, 3, 29, 158, 204, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (40, 3, 30, 137, 174, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (40, 3, 31, 192, 225, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (40, 3, 32, 136, 188, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (41, 1, 1, 143, 190, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (41, 1, 2, 156, 195, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (41, 1, 3, 162, 194, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (41, 1, 4, 145, 197, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (41, 1, 21, 151, 197, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (41, 1, 22, 149, 188, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (41, 1, 23, 178, 208, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (41, 1, 24, 164, 191, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (41, 2, 1, 156, 203, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (41, 2, 2, 176, 215, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (41, 2, 3, 188, 220, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (41, 2, 4, 137, 189, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (41, 2, 21, 141, 187, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (41, 2, 22, 170, 209, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (41, 2, 23, 145, 175, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (41, 2, 24, 171, 198, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (41, 3, 1, 142, 189, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (41, 3, 2, 178, 217, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (41, 3, 3, 149, 181, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (41, 3, 4, 149, 201, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (41, 3, 21, 145, 191, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (41, 3, 22, 141, 180, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (41, 3, 23, 143, 173, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (41, 3, 24, 159, 186, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (42, 1, 5, 147, 193, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (42, 1, 6, 163, 201, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (42, 1, 7, 190, 219, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (42, 1, 8, 137, 188, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (42, 1, 17, 158, 201, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (42, 1, 18, 166, 204, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (42, 1, 19, 142, 171, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (42, 1, 20, 138, 189, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (42, 2, 5, 147, 193, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (42, 2, 6, 144, 182, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (42, 2, 7, 171, 200, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (42, 2, 8, 150, 201, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (42, 2, 17, 135, 178, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (42, 2, 18, 169, 207, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (42, 2, 19, 191, 220, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (42, 2, 20, 137, 188, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (42, 3, 5, 145, 191, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (42, 3, 6, 148, 186, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (42, 3, 7, 142, 171, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (42, 3, 8, 140, 191, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (42, 3, 17, 153, 196, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (42, 3, 18, 154, 192, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (42, 3, 19, 177, 206, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (42, 3, 20, 145, 196, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (43, 1, 9, 156, 201, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (43, 1, 10, 180, 217, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (43, 1, 11, 175, 208, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (43, 1, 12, 149, 200, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (43, 1, 29, 157, 203, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (43, 1, 30, 137, 175, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (43, 1, 31, 136, 169, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (43, 1, 32, 140, 192, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (43, 2, 9, 148, 193, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (43, 2, 10, 158, 195, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (43, 2, 11, 151, 184, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (43, 2, 12, 135, 186, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (43, 2, 29, 135, 181, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (43, 2, 30, 163, 201, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (43, 2, 31, 163, 196, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (43, 2, 32, 147, 199, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (43, 3, 9, 159, 204, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (43, 3, 10, 172, 209, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (43, 3, 11, 162, 195, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (43, 3, 12, 140, 191, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (43, 3, 29, 151, 197, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (43, 3, 30, 162, 200, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (43, 3, 31, 148, 181, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (43, 3, 32, 146, 198, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (44, 1, 13, 157, 200, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (44, 1, 14, 171, 209, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (44, 1, 15, 148, 184, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (44, 1, 16, 136, 188, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (44, 1, 25, 143, 189, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (44, 1, 26, 175, 214, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (44, 1, 27, 141, 173, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (44, 1, 28, 136, 187, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (44, 2, 13, 153, 196, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (44, 2, 14, 153, 191, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (44, 2, 15, 153, 189, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (44, 2, 16, 142, 194, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (44, 2, 25, 153, 199, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (44, 2, 26, 142, 181, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (44, 2, 27, 178, 210, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (44, 2, 28, 139, 190, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (44, 3, 13, 157, 200, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (44, 3, 14, 144, 182, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (44, 3, 15, 166, 202, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (44, 3, 16, 140, 192, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (44, 3, 25, 140, 186, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (44, 3, 26, 148, 187, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (44, 3, 27, 192, 224, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (44, 3, 28, 150, 201, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (45, 1, 1, 164, 211, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (45, 1, 2, 143, 181, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (45, 1, 3, 172, 204, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (45, 1, 4, 136, 188, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (45, 1, 25, 159, 206, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (45, 1, 26, 141, 180, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (45, 1, 27, 167, 198, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (45, 1, 28, 150, 201, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (45, 2, 1, 153, 200, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (45, 2, 2, 171, 209, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (45, 2, 3, 164, 196, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (45, 2, 4, 144, 196, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (45, 2, 25, 163, 210, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (45, 2, 26, 162, 201, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (45, 2, 27, 183, 214, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (45, 2, 28, 141, 192, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (45, 3, 1, 163, 210, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (45, 3, 2, 151, 189, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (45, 3, 3, 160, 192, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (45, 3, 4, 139, 191, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (45, 3, 25, 146, 193, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (45, 3, 26, 164, 203, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (45, 3, 27, 182, 213, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (45, 3, 28, 142, 193, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (46, 1, 9, 162, 207, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (46, 1, 10, 176, 212, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (46, 1, 11, 185, 218, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (46, 1, 12, 136, 187, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (46, 1, 17, 146, 189, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (46, 1, 18, 155, 192, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (46, 1, 19, 158, 187, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (46, 1, 20, 147, 198, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (46, 2, 9, 151, 196, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (46, 2, 10, 138, 174, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (46, 2, 11, 162, 195, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (46, 2, 12, 138, 189, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (46, 2, 17, 137, 180, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (46, 2, 18, 145, 182, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (46, 2, 19, 174, 203, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (46, 2, 20, 144, 195, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (46, 3, 9, 146, 191, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (46, 3, 10, 136, 172, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (46, 3, 11, 148, 181, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (46, 3, 12, 137, 188, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (46, 3, 17, 137, 180, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (46, 3, 18, 138, 175, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (46, 3, 19, 178, 207, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (46, 3, 20, 146, 197, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (47, 1, 5, 136, 182, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (47, 1, 6, 174, 212, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (47, 1, 7, 166, 195, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (47, 1, 8, 136, 187, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (47, 1, 29, 161, 207, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (47, 1, 30, 152, 190, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (47, 1, 31, 138, 172, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (47, 1, 32, 137, 189, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (47, 2, 5, 164, 210, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (47, 2, 6, 136, 174, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (47, 2, 7, 170, 199, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (47, 2, 8, 144, 195, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (47, 2, 29, 154, 200, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (47, 2, 30, 147, 185, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (47, 2, 31, 188, 222, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (47, 2, 32, 142, 194, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (47, 3, 5, 151, 197, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (47, 3, 6, 137, 175, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (47, 3, 7, 150, 179, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (47, 3, 8, 142, 193, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (47, 3, 29, 150, 196, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (47, 3, 30, 151, 189, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (47, 3, 31, 186, 220, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (47, 3, 32, 136, 188, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (48, 1, 13, 150, 193, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (48, 1, 14, 167, 205, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (48, 1, 15, 190, 227, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (48, 1, 16, 148, 200, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (48, 1, 21, 154, 200, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (48, 1, 22, 172, 211, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (48, 1, 23, 140, 171, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (48, 1, 24, 175, 203, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (48, 2, 13, 147, 190, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (48, 2, 14, 140, 178, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (48, 2, 15, 178, 215, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (48, 2, 16, 146, 198, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (48, 2, 21, 136, 182, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (48, 2, 22, 161, 200, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (48, 2, 23, 152, 183, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (48, 2, 24, 160, 188, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (48, 3, 13, 149, 192, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (48, 3, 14, 151, 189, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (48, 3, 15, 191, 228, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (48, 3, 16, 141, 193, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (48, 3, 21, 140, 186, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (48, 3, 22, 176, 215, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (48, 3, 23, 148, 179, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (48, 3, 24, 174, 202, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (49, 1, 1, 142, 188, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (49, 1, 2, 142, 180, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (49, 1, 3, 162, 194, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (49, 1, 4, 140, 192, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (49, 1, 29, 156, 201, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (49, 1, 30, 145, 184, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (49, 1, 31, 184, 217, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (49, 1, 32, 142, 194, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (49, 2, 1, 145, 191, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (49, 2, 2, 167, 205, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (49, 2, 3, 152, 184, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (49, 2, 4, 143, 195, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (49, 2, 29, 142, 187, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (49, 2, 30, 144, 183, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (49, 2, 31, 162, 195, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (49, 2, 32, 138, 190, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (49, 3, 1, 140, 186, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (49, 3, 2, 153, 191, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (49, 3, 3, 189, 221, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (49, 3, 4, 148, 200, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (49, 3, 29, 160, 205, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (49, 3, 30, 170, 209, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (49, 3, 31, 190, 223, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (49, 3, 32, 140, 192, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (50, 1, 5, 159, 205, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (50, 1, 6, 174, 213, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (50, 1, 7, 189, 218, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (50, 1, 8, 149, 201, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (50, 1, 25, 158, 204, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (50, 1, 26, 177, 216, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (50, 1, 27, 189, 219, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (50, 1, 28, 141, 192, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (50, 2, 5, 155, 201, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (50, 2, 6, 153, 192, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (50, 2, 7, 195, 224, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (50, 2, 8, 149, 201, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (50, 2, 25, 161, 207, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (50, 2, 26, 175, 214, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (50, 2, 27, 148, 178, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (50, 2, 28, 137, 188, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (50, 3, 5, 139, 185, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (50, 3, 6, 177, 216, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (50, 3, 7, 189, 218, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (50, 3, 8, 135, 187, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (50, 3, 25, 164, 210, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (50, 3, 26, 143, 182, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (50, 3, 27, 189, 219, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (50, 3, 28, 146, 197, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (51, 1, 9, 160, 205, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (51, 1, 10, 150, 187, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (51, 1, 11, 169, 202, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (51, 1, 12, 144, 196, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (51, 1, 21, 144, 191, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (51, 1, 22, 173, 211, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (51, 1, 23, 155, 187, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (51, 1, 24, 166, 194, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (51, 2, 9, 152, 197, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (51, 2, 10, 176, 213, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (51, 2, 11, 175, 208, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (51, 2, 12, 150, 202, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (51, 2, 21, 147, 194, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (51, 2, 22, 135, 173, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (51, 2, 23, 177, 209, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (51, 2, 24, 178, 206, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (51, 3, 9, 149, 194, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (51, 3, 10, 142, 179, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (51, 3, 11, 152, 185, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (51, 3, 12, 140, 192, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (51, 3, 21, 142, 189, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (51, 3, 22, 163, 201, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (51, 3, 23, 179, 211, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (51, 3, 24, 171, 199, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (52, 1, 13, 142, 185, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (52, 1, 14, 171, 209, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (52, 1, 15, 183, 217, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (52, 1, 16, 145, 197, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (52, 1, 17, 149, 193, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (52, 1, 18, 156, 194, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (52, 1, 19, 175, 204, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (52, 1, 20, 142, 193, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (52, 2, 13, 157, 200, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (52, 2, 14, 136, 174, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (52, 2, 15, 148, 182, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (52, 2, 16, 141, 193, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (52, 2, 17, 138, 182, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (52, 2, 18, 155, 193, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (52, 2, 19, 156, 185, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (52, 2, 20, 147, 198, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (52, 3, 13, 160, 203, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (52, 3, 14, 136, 174, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (52, 3, 15, 165, 199, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (52, 3, 16, 148, 200, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (52, 3, 17, 142, 186, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (52, 3, 18, 138, 176, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (52, 3, 19, 184, 213, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (52, 3, 20, 145, 196, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (53, 1, 1, 139, 186, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (53, 1, 2, 145, 183, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (53, 1, 3, 191, 223, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (53, 1, 4, 146, 198, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (53, 1, 5, 150, 196, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (53, 1, 6, 170, 208, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (53, 1, 7, 156, 184, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (53, 1, 8, 141, 192, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (53, 2, 1, 155, 202, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (53, 2, 2, 146, 184, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (53, 2, 3, 155, 187, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (53, 2, 4, 143, 195, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (53, 2, 5, 137, 183, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (53, 2, 6, 179, 217, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (53, 2, 7, 142, 170, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (53, 2, 8, 137, 188, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (53, 3, 1, 158, 205, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (53, 3, 2, 138, 176, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (53, 3, 3, 175, 207, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (53, 3, 4, 140, 192, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (53, 3, 5, 163, 209, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (53, 3, 6, 155, 193, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (53, 3, 7, 137, 165, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (53, 3, 8, 147, 198, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (54, 1, 9, 145, 189, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (54, 1, 10, 175, 212, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (54, 1, 11, 136, 169, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (54, 1, 12, 138, 189, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (54, 1, 13, 141, 184, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (54, 1, 14, 157, 196, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (54, 1, 15, 174, 208, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (54, 1, 16, 149, 201, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (54, 2, 9, 142, 186, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (54, 2, 10, 170, 207, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (54, 2, 11, 171, 204, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (54, 2, 12, 146, 197, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (54, 2, 13, 163, 206, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (54, 2, 14, 170, 209, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (54, 2, 15, 166, 200, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (54, 2, 16, 139, 191, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (54, 3, 9, 158, 202, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (54, 3, 10, 173, 210, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (54, 3, 11, 182, 215, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (54, 3, 12, 139, 190, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (54, 3, 13, 147, 190, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (54, 3, 14, 150, 189, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (54, 3, 15, 147, 181, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (54, 3, 16, 141, 193, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (55, 1, 17, 137, 182, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (55, 1, 18, 153, 192, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (55, 1, 19, 147, 175, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (55, 1, 20, 138, 189, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (55, 1, 21, 155, 202, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (55, 1, 22, 169, 207, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (55, 1, 23, 161, 193, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (55, 1, 24, 170, 199, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (55, 2, 17, 136, 181, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (55, 2, 18, 155, 194, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (55, 2, 19, 150, 178, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (55, 2, 20, 144, 195, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (55, 2, 21, 148, 195, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (55, 2, 22, 170, 208, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (55, 2, 23, 170, 202, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (55, 2, 24, 172, 201, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (55, 3, 17, 149, 194, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (55, 3, 18, 162, 201, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (55, 3, 19, 183, 211, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (55, 3, 20, 138, 189, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (55, 3, 21, 138, 185, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (55, 3, 22, 136, 174, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (55, 3, 23, 155, 187, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (55, 3, 24, 169, 198, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (56, 1, 25, 142, 187, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (56, 1, 26, 177, 216, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (56, 1, 27, 143, 173, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (56, 1, 28, 142, 193, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (56, 1, 29, 138, 183, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (56, 1, 30, 135, 174, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (56, 1, 31, 175, 207, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (56, 1, 32, 143, 195, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (56, 2, 25, 164, 209, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (56, 2, 26, 151, 190, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (56, 2, 27, 143, 173, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (56, 2, 28, 135, 186, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (56, 2, 29, 149, 194, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (56, 2, 30, 155, 194, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (56, 2, 31, 141, 173, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (56, 2, 32, 141, 193, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (56, 3, 25, 163, 208, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (56, 3, 26, 136, 175, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (56, 3, 27, 182, 212, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (56, 3, 28, 139, 190, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (56, 3, 29, 156, 201, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (56, 3, 30, 165, 204, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (56, 3, 31, 138, 170, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (56, 3, 32, 148, 200, 1);
INSERT INTO ztblBowlerRatings
  (BowlerRating, BowlerLowAvg, BowlerHighAvg)
  VALUES ('League Player', 146, 160);
INSERT INTO ztblBowlerRatings
  (BowlerRating, BowlerLowAvg, BowlerHighAvg)
  VALUES ('Mediocre', 121, 145);
INSERT INTO ztblBowlerRatings
  (BowlerRating, BowlerLowAvg, BowlerHighAvg)
  VALUES ('Novice', 0, 120);
INSERT INTO ztblBowlerRatings
  (BowlerRating, BowlerLowAvg, BowlerHighAvg)
  VALUES ('Pro', 186, 300);
INSERT INTO ztblBowlerRatings
  (BowlerRating, BowlerLowAvg, BowlerHighAvg)
  VALUES ('Team winner', 161, 185);
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


Use BowlingLeagueModify;
SET IDENTITY_INSERT Tournaments ON
GO
INSERT INTO Tournaments
  (TourneyID, TourneyDate, TourneyLocation)
  VALUES (1, '2012-09-04', 'Red Rooster Lanes');
INSERT INTO Tournaments
  (TourneyID, TourneyDate, TourneyLocation)
  VALUES (2, '2012-09-11', 'Thunderbird Lanes');
INSERT INTO Tournaments
  (TourneyID, TourneyDate, TourneyLocation)
  VALUES (3, '2012-09-18', 'Bolero Lanes');
INSERT INTO Tournaments
  (TourneyID, TourneyDate, TourneyLocation)
  VALUES (4, '2012-09-25', 'Imperial Lanes');
INSERT INTO Tournaments
  (TourneyID, TourneyDate, TourneyLocation)
  VALUES (5, '2012-10-02', 'Sports World Lanes');
INSERT INTO Tournaments
  (TourneyID, TourneyDate, TourneyLocation)
  VALUES (6, '2012-10-09', 'Totem Lanes');
INSERT INTO Tournaments
  (TourneyID, TourneyDate, TourneyLocation)
  VALUES (7, '2012-10-16', 'Acapulco Lanes');
INSERT INTO Tournaments
  (TourneyID, TourneyDate, TourneyLocation)
  VALUES (8, '2012-10-23', 'Red Rooster Lanes');
INSERT INTO Tournaments
  (TourneyID, TourneyDate, TourneyLocation)
  VALUES (9, '2012-10-30', 'Thunderbird Lanes');
INSERT INTO Tournaments
  (TourneyID, TourneyDate, TourneyLocation)
  VALUES (10, '2012-11-06', 'Bolero Lanes');
INSERT INTO Tournaments
  (TourneyID, TourneyDate, TourneyLocation)
  VALUES (11, '2012-11-13', 'Imperial Lanes');
INSERT INTO Tournaments
  (TourneyID, TourneyDate, TourneyLocation)
  VALUES (12, '2012-11-20', 'Sports World Lanes');
INSERT INTO Tournaments
  (TourneyID, TourneyDate, TourneyLocation)
  VALUES (13, '2012-11-27', 'Totem Lanes');
INSERT INTO Tournaments
  (TourneyID, TourneyDate, TourneyLocation)
  VALUES (14, '2012-12-04', 'Acapulco Lanes');
INSERT INTO Tournaments
  (TourneyID, TourneyDate, TourneyLocation)
  VALUES (15, '2013-07-12', 'Red Rooster Lanes');
INSERT INTO Tournaments
  (TourneyID, TourneyDate, TourneyLocation)
  VALUES (16, '2013-07-19', 'Thunderbird Lanes');
INSERT INTO Tournaments
  (TourneyID, TourneyDate, TourneyLocation)
  VALUES (17, '2013-07-26', 'Bolero Lanes');
INSERT INTO Tournaments
  (TourneyID, TourneyDate, TourneyLocation)
  VALUES (18, '2013-08-02', 'Sports World Lanes');
INSERT INTO Tournaments
  (TourneyID, TourneyDate, TourneyLocation)
  VALUES (19, '2013-08-09', 'Imperial Lanes');
INSERT INTO Tournaments
  (TourneyID, TourneyDate, TourneyLocation)
  VALUES (20, '2013-08-16', 'Totem Lanes');
SET IDENTITY_INSERT Tournaments OFF
GO
SET IDENTITY_INSERT Bowlers ON
GO
INSERT INTO Bowlers
  (BowlerID, BowlerLastName, BowlerFirstName, BowlerMiddleInit, 
   BowlerAddress, BowlerCity, BowlerState, BowlerZip, 
   BowlerPhoneNumber, TeamID, BowlerTotalPins, BowlerGamesBowled, 
   BowlerCurrentAverage, BowlerCurrentHcp)
  VALUES (1, 'Fournier', 'Barbara', NULL, '67 Willow Drive', 
   'Bothell', 'WA', '98014', '(206) 555-9876', NULL, 
   5790, 39, 148, 47);
INSERT INTO Bowlers
  (BowlerID, BowlerLastName, BowlerFirstName, BowlerMiddleInit, 
   BowlerAddress, BowlerCity, BowlerState, BowlerZip, 
   BowlerPhoneNumber, TeamID, BowlerTotalPins, BowlerGamesBowled, 
   BowlerCurrentAverage, BowlerCurrentHcp)
  VALUES (2, 'Fournier', 'David', NULL, '67 Willow Drive', 
   'Bothell', 'WA', '98014', '(206) 555-9876', NULL, 
   6152, 39, 158, 38);
INSERT INTO Bowlers
  (BowlerID, BowlerLastName, BowlerFirstName, BowlerMiddleInit, 
   BowlerAddress, BowlerCity, BowlerState, BowlerZip, 
   BowlerPhoneNumber, TeamID, BowlerTotalPins, BowlerGamesBowled, 
   BowlerCurrentAverage, BowlerCurrentHcp)
  VALUES (3, 'Kennedy', 'John', 'A', '2957 W 33rd', 
   'Ballard', 'WA', '98154', '(206) 555-7854', NULL, 
   6435, 39, 165, 32);
INSERT INTO Bowlers
  (BowlerID, BowlerLastName, BowlerFirstName, BowlerMiddleInit, 
   BowlerAddress, BowlerCity, BowlerState, BowlerZip, 
   BowlerPhoneNumber, TeamID, BowlerTotalPins, BowlerGamesBowled, 
   BowlerCurrentAverage, BowlerCurrentHcp)
  VALUES (4, 'Sheskey', 'Sara', 'J', '17950 N 59th', 
   'Seattle', 'WA', '98011', '(206) 555-9893', NULL, 
   5534, 39, 142, 52);
INSERT INTO Bowlers
  (BowlerID, BowlerLastName, BowlerFirstName, BowlerMiddleInit, 
   BowlerAddress, BowlerCity, BowlerState, BowlerZip, 
   BowlerPhoneNumber, TeamID, BowlerTotalPins, BowlerGamesBowled, 
   BowlerCurrentAverage, BowlerCurrentHcp)
  VALUES (5, 'Patterson', 'Ann', 'K', '16 Maple Lane', 
   'Auburn', 'WA', '98002', '(206) 555-3487', NULL, 
   5819, 39, 149, 46);
INSERT INTO Bowlers
  (BowlerID, BowlerLastName, BowlerFirstName, BowlerMiddleInit, 
   BowlerAddress, BowlerCity, BowlerState, BowlerZip, 
   BowlerPhoneNumber, TeamID, BowlerTotalPins, BowlerGamesBowled, 
   BowlerCurrentAverage, BowlerCurrentHcp)
  VALUES (6, 'Patterson', 'Neil', NULL, '16 Maple Lane', 
   'Auburn', 'WA', '98002', '(206) 555-3487', NULL, 
   6150, 39, 158, 38);
INSERT INTO Bowlers
  (BowlerID, BowlerLastName, BowlerFirstName, BowlerMiddleInit, 
   BowlerAddress, BowlerCity, BowlerState, BowlerZip, 
   BowlerPhoneNumber, TeamID, BowlerTotalPins, BowlerGamesBowled, 
   BowlerCurrentAverage, BowlerCurrentHcp)
  VALUES (7, 'Viescas', 'David', 'A', '16679 NE 42nd Court', 
   'Redmond', 'WA', '98052', '(206) 882-8878', NULL, 
   6607, 39, 169, 28);
INSERT INTO Bowlers
  (BowlerID, BowlerLastName, BowlerFirstName, BowlerMiddleInit, 
   BowlerAddress, BowlerCity, BowlerState, BowlerZip, 
   BowlerPhoneNumber, TeamID, BowlerTotalPins, BowlerGamesBowled, 
   BowlerCurrentAverage, BowlerCurrentHcp)
  VALUES (8, 'Viescas', 'Stephanie', NULL, '16679 NE 42nd Court', 
   'Redmond', 'WA', '98052', '(206) 882-8878', NULL, 
   5558, 39, 143, 51);
INSERT INTO Bowlers
  (BowlerID, BowlerLastName, BowlerFirstName, BowlerMiddleInit, 
   BowlerAddress, BowlerCity, BowlerState, BowlerZip, 
   BowlerPhoneNumber, TeamID, BowlerTotalPins, BowlerGamesBowled, 
   BowlerCurrentAverage, BowlerCurrentHcp)
  VALUES (9, 'Black', 'Alastair', NULL, '4726 - 11th Ave. N.E.', 
   'Seattle', 'WA', '98105', '(206) 555-1189', NULL, 
   5874, 39, 151, 44);
INSERT INTO Bowlers
  (BowlerID, BowlerLastName, BowlerFirstName, BowlerMiddleInit, 
   BowlerAddress, BowlerCity, BowlerState, BowlerZip, 
   BowlerPhoneNumber, TeamID, BowlerTotalPins, BowlerGamesBowled, 
   BowlerCurrentAverage, BowlerCurrentHcp)
  VALUES (10, 'Cunningham', 'David', NULL, '4110 Old Redmond Rd.', 
   'Redmond', 'WA', '98052', '(206) 555-8122', NULL, 
   6184, 39, 159, 37);
INSERT INTO Bowlers
  (BowlerID, BowlerLastName, BowlerFirstName, BowlerMiddleInit, 
   BowlerAddress, BowlerCity, BowlerState, BowlerZip, 
   BowlerPhoneNumber, TeamID, BowlerTotalPins, BowlerGamesBowled, 
   BowlerCurrentAverage, BowlerCurrentHcp)
  VALUES (11, 'Kennedy', 'Angel', NULL, '2957 W 33rd', 
   'Ballard', 'WA', '98154', '(206) 555-7854', NULL, 
   6372, 39, 163, 33);
INSERT INTO Bowlers
  (BowlerID, BowlerLastName, BowlerFirstName, BowlerMiddleInit, 
   BowlerAddress, BowlerCity, BowlerState, BowlerZip, 
   BowlerPhoneNumber, TeamID, BowlerTotalPins, BowlerGamesBowled, 
   BowlerCurrentAverage, BowlerCurrentHcp)
  VALUES (12, 'Viescas', 'Carol', 'M', '16345 NE 32nd Street', 
   'Bellevue', 'WA', '98004', '(206) 555-7295', NULL, 
   5560, 39, 143, 51);
INSERT INTO Bowlers
  (BowlerID, BowlerLastName, BowlerFirstName, BowlerMiddleInit, 
   BowlerAddress, BowlerCity, BowlerState, BowlerZip, 
   BowlerPhoneNumber, TeamID, BowlerTotalPins, BowlerGamesBowled, 
   BowlerCurrentAverage, BowlerCurrentHcp)
  VALUES (13, 'Hallmark', 'Elizabeth', NULL, 'Route 2, Box 203B', 
   'Woodinville', 'WA', '98072', '(206) 555-8990', 
   NULL, 5928, 39, 152, 43);
INSERT INTO Bowlers
  (BowlerID, BowlerLastName, BowlerFirstName, BowlerMiddleInit, 
   BowlerAddress, BowlerCity, BowlerState, BowlerZip, 
   BowlerPhoneNumber, TeamID, BowlerTotalPins, BowlerGamesBowled, 
   BowlerCurrentAverage, BowlerCurrentHcp)
  VALUES (14, 'Hallmark', 'Gary', NULL, 'Route 2, Box 203B', 
   'Woodinville', 'WA', '98072', '(206) 555-8990', 
   NULL, 6116, 39, 157, 39);
INSERT INTO Bowlers
  (BowlerID, BowlerLastName, BowlerFirstName, BowlerMiddleInit, 
   BowlerAddress, BowlerCity, BowlerState, BowlerZip, 
   BowlerPhoneNumber, TeamID, BowlerTotalPins, BowlerGamesBowled, 
   BowlerCurrentAverage, BowlerCurrentHcp)
  VALUES (15, 'Patterson', 'Kathryn', NULL, '16 Maple Lane', 
   'Auburn', 'WA', '98002', '(206) 555-3487', NULL, 
   6313, 39, 162, 34);
INSERT INTO Bowlers
  (BowlerID, BowlerLastName, BowlerFirstName, BowlerMiddleInit, 
   BowlerAddress, BowlerCity, BowlerState, BowlerZip, 
   BowlerPhoneNumber, TeamID, BowlerTotalPins, BowlerGamesBowled, 
   BowlerCurrentAverage, BowlerCurrentHcp)
  VALUES (16, 'Sheskey', 'Richard', NULL, '17950 N 59th', 
   'Seattle', 'WA', '98011', '(206) 555-9893', NULL, 
   5549, 39, 142, 52);
INSERT INTO Bowlers
  (BowlerID, BowlerLastName, BowlerFirstName, BowlerMiddleInit, 
   BowlerAddress, BowlerCity, BowlerState, BowlerZip, 
   BowlerPhoneNumber, TeamID, BowlerTotalPins, BowlerGamesBowled, 
   BowlerCurrentAverage, BowlerCurrentHcp)
  VALUES (17, 'Hernandez', 'Kendra', NULL, '47 Harvard Drive', 
   'Kirkland', 'WA', '98033', '(206) 889-9191', NULL, 
   5854, 39, 150, 45);
INSERT INTO Bowlers
  (BowlerID, BowlerLastName, BowlerFirstName, BowlerMiddleInit, 
   BowlerAddress, BowlerCity, BowlerState, BowlerZip, 
   BowlerPhoneNumber, TeamID, BowlerTotalPins, BowlerGamesBowled, 
   BowlerCurrentAverage, BowlerCurrentHcp)
  VALUES (18, 'Hernandez', 'Michael', NULL, '47 Harvard Drive', 
   'Kirkland', 'WA', '98033', '(206) 889-9191', NULL, 
   6125, 39, 157, 39);
INSERT INTO Bowlers
  (BowlerID, BowlerLastName, BowlerFirstName, BowlerMiddleInit, 
   BowlerAddress, BowlerCity, BowlerState, BowlerZip, 
   BowlerPhoneNumber, TeamID, BowlerTotalPins, BowlerGamesBowled, 
   BowlerCurrentAverage, BowlerCurrentHcp)
  VALUES (19, 'Viescas', 'John', 'L', '218 Main Street', 
   'Redmond', 'WA', '98052', '(206) 881-5596', NULL, 
   6581, 39, 169, 28);
INSERT INTO Bowlers
  (BowlerID, BowlerLastName, BowlerFirstName, BowlerMiddleInit, 
   BowlerAddress, BowlerCity, BowlerState, BowlerZip, 
   BowlerPhoneNumber, TeamID, BowlerTotalPins, BowlerGamesBowled, 
   BowlerCurrentAverage, BowlerCurrentHcp)
  VALUES (20, 'Viescas', 'Suzanne', 'L', '218 Main Street', 
   'Redmond', 'WA', '98052', '(206) 881-5596', NULL, 
   5589, 39, 143, 51);
INSERT INTO Bowlers
  (BowlerID, BowlerLastName, BowlerFirstName, BowlerMiddleInit, 
   BowlerAddress, BowlerCity, BowlerState, BowlerZip, 
   BowlerPhoneNumber, TeamID, BowlerTotalPins, BowlerGamesBowled, 
   BowlerCurrentAverage, BowlerCurrentHcp)
  VALUES (21, 'Ehrlich', 'Zachary', NULL, '507 - 20th Ave. E.', 
   'Seattle', 'WA', '98122', '(206) 555-9857', NULL, 
   5767, 39, 148, 47);
INSERT INTO Bowlers
  (BowlerID, BowlerLastName, BowlerFirstName, BowlerMiddleInit, 
   BowlerAddress, BowlerCity, BowlerState, BowlerZip, 
   BowlerPhoneNumber, TeamID, BowlerTotalPins, BowlerGamesBowled, 
   BowlerCurrentAverage, BowlerCurrentHcp)
  VALUES (22, 'Hallmark', 'Alaina', NULL, 'Route 2, Box 203B', 
   'Woodinville', 'WA', '98072', '(206) 555-8990', 
   NULL, 6147, 39, 158, 38);
INSERT INTO Bowlers
  (BowlerID, BowlerLastName, BowlerFirstName, BowlerMiddleInit, 
   BowlerAddress, BowlerCity, BowlerState, BowlerZip, 
   BowlerPhoneNumber, TeamID, BowlerTotalPins, BowlerGamesBowled, 
   BowlerCurrentAverage, BowlerCurrentHcp)
  VALUES (23, 'Viescas', 'Caleb', NULL, '16679 NE 42nd Court', 
   'Redmond', 'WA', '98052', '(206) 882-8878', NULL, 
   6422, 39, 165, 32);
INSERT INTO Bowlers
  (BowlerID, BowlerLastName, BowlerFirstName, BowlerMiddleInit, 
   BowlerAddress, BowlerCity, BowlerState, BowlerZip, 
   BowlerPhoneNumber, TeamID, BowlerTotalPins, BowlerGamesBowled, 
   BowlerCurrentAverage, BowlerCurrentHcp)
  VALUES (24, 'Thompson', 'Sarah', 'L', '122 Spring Valley Drive', 
   'Duvall', 'WA', '98019', '(206) 555-8989', NULL, 
   6589, 39, 169, 28);
INSERT INTO Bowlers
  (BowlerID, BowlerLastName, BowlerFirstName, BowlerMiddleInit, 
   BowlerAddress, BowlerCity, BowlerState, BowlerZip, 
   BowlerPhoneNumber, TeamID, BowlerTotalPins, BowlerGamesBowled, 
   BowlerCurrentAverage, BowlerCurrentHcp)
  VALUES (25, 'Patterson', 'Megan', NULL, '16 Maple Lane', 
   'Auburn', 'WA', '98002', '(206) 555-3487', NULL, 
   5843, 39, 150, 45);
INSERT INTO Bowlers
  (BowlerID, BowlerLastName, BowlerFirstName, BowlerMiddleInit, 
   BowlerAddress, BowlerCity, BowlerState, BowlerZip, 
   BowlerPhoneNumber, TeamID, BowlerTotalPins, BowlerGamesBowled, 
   BowlerCurrentAverage, BowlerCurrentHcp)
  VALUES (26, 'Thompson', 'Mary', 'K', '122 Spring Valley Drive', 
   'Duvall', 'WA', '98019', '(206) 555-8989', NULL, 
   6137, 39, 157, 39);
INSERT INTO Bowlers
  (BowlerID, BowlerLastName, BowlerFirstName, BowlerMiddleInit, 
   BowlerAddress, BowlerCity, BowlerState, BowlerZip, 
   BowlerPhoneNumber, TeamID, BowlerTotalPins, BowlerGamesBowled, 
   BowlerCurrentAverage, BowlerCurrentHcp)
  VALUES (27, 'Thompson', 'William', 'G', '122 Spring Valley Drive', 
   'Duvall', 'WA', '98019', '(206) 555-8989', NULL, 
   6532, 39, 167, 30);
INSERT INTO Bowlers
  (BowlerID, BowlerLastName, BowlerFirstName, BowlerMiddleInit, 
   BowlerAddress, BowlerCity, BowlerState, BowlerZip, 
   BowlerPhoneNumber, TeamID, BowlerTotalPins, BowlerGamesBowled, 
   BowlerCurrentAverage, BowlerCurrentHcp)
  VALUES (28, 'Viescas', 'Michael', 'L', '218 Main Street', 
   'Redmond', 'WA', '98052', '(206) 881-5596', NULL, 
   5575, 39, 143, 51);
INSERT INTO Bowlers
  (BowlerID, BowlerLastName, BowlerFirstName, BowlerMiddleInit, 
   BowlerAddress, BowlerCity, BowlerState, BowlerZip, 
   BowlerPhoneNumber, TeamID, BowlerTotalPins, BowlerGamesBowled, 
   BowlerCurrentAverage, BowlerCurrentHcp)
  VALUES (29, 'Hallmark', 'Bailey', NULL, 'Route 2, Box 203B', 
   'Woodinville', 'WA', '98072', '(206) 555-8990', 
   NULL, 5848, 39, 150, 45);
INSERT INTO Bowlers
  (BowlerID, BowlerLastName, BowlerFirstName, BowlerMiddleInit, 
   BowlerAddress, BowlerCity, BowlerState, BowlerZip, 
   BowlerPhoneNumber, TeamID, BowlerTotalPins, BowlerGamesBowled, 
   BowlerCurrentAverage, BowlerCurrentHcp)
  VALUES (30, 'Patterson', 'Rachel', NULL, '16 Maple Lane', 
   'Auburn', 'WA', '98002', '(206) 555-3487', NULL, 
   6126, 39, 157, 39);
INSERT INTO Bowlers
  (BowlerID, BowlerLastName, BowlerFirstName, BowlerMiddleInit, 
   BowlerAddress, BowlerCity, BowlerState, BowlerZip, 
   BowlerPhoneNumber, TeamID, BowlerTotalPins, BowlerGamesBowled, 
   BowlerCurrentAverage, BowlerCurrentHcp)
  VALUES (31, 'Pundt', 'Steve', NULL, '722 Moss Bay Blvd.', 
   'Kirkland', 'WA', '98033', '(206) 555-3412', NULL, 
   6387, 39, 164, 32);
INSERT INTO Bowlers
  (BowlerID, BowlerLastName, BowlerFirstName, BowlerMiddleInit, 
   BowlerAddress, BowlerCity, BowlerState, BowlerZip, 
   BowlerPhoneNumber, TeamID, BowlerTotalPins, BowlerGamesBowled, 
   BowlerCurrentAverage, BowlerCurrentHcp)
  VALUES (32, 'Rosales', 'Joe', NULL, '908 W. Capital Way', 
   'Tacoma', 'WA', '98404', '(206) 555-9482', NULL, 
   5525, 39, 142, 52);
INSERT INTO Bowlers
  (BowlerID, BowlerLastName, BowlerFirstName, BowlerMiddleInit, 
   BowlerAddress, BowlerCity, BowlerState, BowlerZip, 
   BowlerPhoneNumber, TeamID, BowlerTotalPins, BowlerGamesBowled, 
   BowlerCurrentAverage, BowlerCurrentHcp)
  VALUES (33, 'Patterson', 'Kerry', NULL, '16 Maple Lane', 
   'Auburn', 'WA', '98002', '(206) 555-3487', NULL, 
   0, 0, 0, 0);
INSERT INTO Bowlers
  (BowlerID, BowlerLastName, BowlerFirstName, BowlerMiddleInit, 
   BowlerAddress, BowlerCity, BowlerState, BowlerZip, 
   BowlerPhoneNumber, TeamID, BowlerTotalPins, BowlerGamesBowled, 
   BowlerCurrentAverage, BowlerCurrentHcp)
  VALUES (34, 'Patterson', 'Maria', NULL, '16 Maple Lane', 
   'Auburn', 'WA', '98002', '(206) 555-3487', NULL, 
   0, 0, 0, 0);
SET IDENTITY_INSERT Bowlers OFF
GO
SET IDENTITY_INSERT Teams ON
GO
INSERT INTO Teams
  (TeamID, TeamName, CaptainID)
  VALUES (1, 'Marlins', 2);
INSERT INTO Teams
  (TeamID, TeamName, CaptainID)
  VALUES (2, 'Sharks', 5);
INSERT INTO Teams
  (TeamID, TeamName, CaptainID)
  VALUES (3, 'Terrapins', 12);
INSERT INTO Teams
  (TeamID, TeamName, CaptainID)
  VALUES (4, 'Barracudas', 16);
INSERT INTO Teams
  (TeamID, TeamName, CaptainID)
  VALUES (5, 'Dolphins', 20);
INSERT INTO Teams
  (TeamID, TeamName, CaptainID)
  VALUES (6, 'Orcas', 24);
INSERT INTO Teams
  (TeamID, TeamName, CaptainID)
  VALUES (7, 'Manatees', 28);
INSERT INTO Teams
  (TeamID, TeamName, CaptainID)
  VALUES (8, 'Swordfish', 32);
INSERT INTO Teams
  (TeamID, TeamName, CaptainID)
  VALUES (9, 'Huckleberrys', 7);
INSERT INTO Teams
  (TeamID, TeamName, CaptainID)
  VALUES (10, 'Never Show Ups', 22);
SET IDENTITY_INSERT Teams OFF
GO
UPDATE Bowlers 
SET TeamID = 1
WHERE BowlerID IN (1, 2, 3, 4);
UPDATE Bowlers 
SET TeamID = 2
WHERE BowlerID IN (5, 6, 7, 8);
UPDATE Bowlers 
SET TeamID = 3
WHERE BowlerID IN (9, 10, 11, 12);
UPDATE Bowlers 
SET TeamID = 4
WHERE BowlerID IN (13, 14, 15, 16);
UPDATE Bowlers 
SET TeamID = 5
WHERE BowlerID IN (17, 18, 19, 20);
UPDATE Bowlers 
SET TeamID = 6
WHERE BowlerID IN (21, 22, 23, 24);
UPDATE Bowlers 
SET TeamID = 7
WHERE BowlerID IN (25, 26, 27, 28, 33, 34);
UPDATE Bowlers 
SET TeamID = 8
WHERE BowlerID IN (29, 30, 31, 32);
SET IDENTITY_INSERT Tourney_Matches ON
GO
INSERT INTO Tourney_Matches
  (MatchID, TourneyID, Lanes, OddLaneTeamID, EvenLaneTeamID)
  VALUES (1, 1, '01-02', 1, 2);
INSERT INTO Tourney_Matches
  (MatchID, TourneyID, Lanes, OddLaneTeamID, EvenLaneTeamID)
  VALUES (2, 1, '03-04', 3, 4);
INSERT INTO Tourney_Matches
  (MatchID, TourneyID, Lanes, OddLaneTeamID, EvenLaneTeamID)
  VALUES (3, 1, '05-06', 5, 6);
INSERT INTO Tourney_Matches
  (MatchID, TourneyID, Lanes, OddLaneTeamID, EvenLaneTeamID)
  VALUES (4, 1, '07-08', 7, 8);
INSERT INTO Tourney_Matches
  (MatchID, TourneyID, Lanes, OddLaneTeamID, EvenLaneTeamID)
  VALUES (5, 2, '21-22', 3, 1);
INSERT INTO Tourney_Matches
  (MatchID, TourneyID, Lanes, OddLaneTeamID, EvenLaneTeamID)
  VALUES (6, 2, '23-24', 4, 2);
INSERT INTO Tourney_Matches
  (MatchID, TourneyID, Lanes, OddLaneTeamID, EvenLaneTeamID)
  VALUES (7, 2, '25-26', 5, 7);
INSERT INTO Tourney_Matches
  (MatchID, TourneyID, Lanes, OddLaneTeamID, EvenLaneTeamID)
  VALUES (8, 2, '27-28', 8, 6);
INSERT INTO Tourney_Matches
  (MatchID, TourneyID, Lanes, OddLaneTeamID, EvenLaneTeamID)
  VALUES (9, 3, '15-16', 2, 3);
INSERT INTO Tourney_Matches
  (MatchID, TourneyID, Lanes, OddLaneTeamID, EvenLaneTeamID)
  VALUES (10, 3, '17-18', 1, 4);
INSERT INTO Tourney_Matches
  (MatchID, TourneyID, Lanes, OddLaneTeamID, EvenLaneTeamID)
  VALUES (11, 3, '19-20', 7, 6);
INSERT INTO Tourney_Matches
  (MatchID, TourneyID, Lanes, OddLaneTeamID, EvenLaneTeamID)
  VALUES (12, 3, '21-22', 5, 8);
INSERT INTO Tourney_Matches
  (MatchID, TourneyID, Lanes, OddLaneTeamID, EvenLaneTeamID)
  VALUES (13, 4, '09-10', 1, 5);
INSERT INTO Tourney_Matches
  (MatchID, TourneyID, Lanes, OddLaneTeamID, EvenLaneTeamID)
  VALUES (14, 4, '11-12', 2, 6);
INSERT INTO Tourney_Matches
  (MatchID, TourneyID, Lanes, OddLaneTeamID, EvenLaneTeamID)
  VALUES (15, 4, '13-14', 3, 7);
INSERT INTO Tourney_Matches
  (MatchID, TourneyID, Lanes, OddLaneTeamID, EvenLaneTeamID)
  VALUES (16, 4, '15-16', 4, 8);
INSERT INTO Tourney_Matches
  (MatchID, TourneyID, Lanes, OddLaneTeamID, EvenLaneTeamID)
  VALUES (17, 5, '11-12', 6, 1);
INSERT INTO Tourney_Matches
  (MatchID, TourneyID, Lanes, OddLaneTeamID, EvenLaneTeamID)
  VALUES (18, 5, '13-14', 5, 2);
INSERT INTO Tourney_Matches
  (MatchID, TourneyID, Lanes, OddLaneTeamID, EvenLaneTeamID)
  VALUES (19, 5, '15-16', 8, 3);
INSERT INTO Tourney_Matches
  (MatchID, TourneyID, Lanes, OddLaneTeamID, EvenLaneTeamID)
  VALUES (20, 5, '17-18', 7, 4);
INSERT INTO Tourney_Matches
  (MatchID, TourneyID, Lanes, OddLaneTeamID, EvenLaneTeamID)
  VALUES (21, 6, '05-06', 1, 7);
INSERT INTO Tourney_Matches
  (MatchID, TourneyID, Lanes, OddLaneTeamID, EvenLaneTeamID)
  VALUES (22, 6, '07-08', 3, 5);
INSERT INTO Tourney_Matches
  (MatchID, TourneyID, Lanes, OddLaneTeamID, EvenLaneTeamID)
  VALUES (23, 6, '09-10', 2, 8);
INSERT INTO Tourney_Matches
  (MatchID, TourneyID, Lanes, OddLaneTeamID, EvenLaneTeamID)
  VALUES (24, 6, '11-12', 4, 6);
INSERT INTO Tourney_Matches
  (MatchID, TourneyID, Lanes, OddLaneTeamID, EvenLaneTeamID)
  VALUES (25, 7, '13-14', 8, 1);
INSERT INTO Tourney_Matches
  (MatchID, TourneyID, Lanes, OddLaneTeamID, EvenLaneTeamID)
  VALUES (26, 7, '15-16', 7, 2);
INSERT INTO Tourney_Matches
  (MatchID, TourneyID, Lanes, OddLaneTeamID, EvenLaneTeamID)
  VALUES (27, 7, '17-18', 6, 3);
INSERT INTO Tourney_Matches
  (MatchID, TourneyID, Lanes, OddLaneTeamID, EvenLaneTeamID)
  VALUES (28, 7, '19-20', 5, 4);
INSERT INTO Tourney_Matches
  (MatchID, TourneyID, Lanes, OddLaneTeamID, EvenLaneTeamID)
  VALUES (29, 8, '21-22', 1, 3);
INSERT INTO Tourney_Matches
  (MatchID, TourneyID, Lanes, OddLaneTeamID, EvenLaneTeamID)
  VALUES (30, 8, '23-24', 2, 4);
INSERT INTO Tourney_Matches
  (MatchID, TourneyID, Lanes, OddLaneTeamID, EvenLaneTeamID)
  VALUES (31, 8, '25-26', 7, 5);
INSERT INTO Tourney_Matches
  (MatchID, TourneyID, Lanes, OddLaneTeamID, EvenLaneTeamID)
  VALUES (32, 8, '27-28', 6, 8);
INSERT INTO Tourney_Matches
  (MatchID, TourneyID, Lanes, OddLaneTeamID, EvenLaneTeamID)
  VALUES (33, 9, '15-16', 3, 2);
INSERT INTO Tourney_Matches
  (MatchID, TourneyID, Lanes, OddLaneTeamID, EvenLaneTeamID)
  VALUES (34, 9, '17-18', 4, 1);
INSERT INTO Tourney_Matches
  (MatchID, TourneyID, Lanes, OddLaneTeamID, EvenLaneTeamID)
  VALUES (35, 9, '19-20', 6, 7);
INSERT INTO Tourney_Matches
  (MatchID, TourneyID, Lanes, OddLaneTeamID, EvenLaneTeamID)
  VALUES (36, 9, '21-22', 8, 5);
INSERT INTO Tourney_Matches
  (MatchID, TourneyID, Lanes, OddLaneTeamID, EvenLaneTeamID)
  VALUES (37, 10, '09-10', 5, 1);
INSERT INTO Tourney_Matches
  (MatchID, TourneyID, Lanes, OddLaneTeamID, EvenLaneTeamID)
  VALUES (38, 10, '11-12', 6, 2);
INSERT INTO Tourney_Matches
  (MatchID, TourneyID, Lanes, OddLaneTeamID, EvenLaneTeamID)
  VALUES (39, 10, '13-14', 7, 3);
INSERT INTO Tourney_Matches
  (MatchID, TourneyID, Lanes, OddLaneTeamID, EvenLaneTeamID)
  VALUES (40, 10, '15-16', 8, 4);
INSERT INTO Tourney_Matches
  (MatchID, TourneyID, Lanes, OddLaneTeamID, EvenLaneTeamID)
  VALUES (41, 11, '11-12', 1, 6);
INSERT INTO Tourney_Matches
  (MatchID, TourneyID, Lanes, OddLaneTeamID, EvenLaneTeamID)
  VALUES (42, 11, '13-14', 2, 5);
INSERT INTO Tourney_Matches
  (MatchID, TourneyID, Lanes, OddLaneTeamID, EvenLaneTeamID)
  VALUES (43, 11, '15-16', 3, 8);
INSERT INTO Tourney_Matches
  (MatchID, TourneyID, Lanes, OddLaneTeamID, EvenLaneTeamID)
  VALUES (44, 11, '17-18', 4, 7);
INSERT INTO Tourney_Matches
  (MatchID, TourneyID, Lanes, OddLaneTeamID, EvenLaneTeamID)
  VALUES (45, 12, '05-06', 7, 1);
INSERT INTO Tourney_Matches
  (MatchID, TourneyID, Lanes, OddLaneTeamID, EvenLaneTeamID)
  VALUES (46, 12, '07-08', 5, 3);
INSERT INTO Tourney_Matches
  (MatchID, TourneyID, Lanes, OddLaneTeamID, EvenLaneTeamID)
  VALUES (47, 12, '09-10', 8, 2);
INSERT INTO Tourney_Matches
  (MatchID, TourneyID, Lanes, OddLaneTeamID, EvenLaneTeamID)
  VALUES (48, 12, '11-12', 6, 4);
INSERT INTO Tourney_Matches
  (MatchID, TourneyID, Lanes, OddLaneTeamID, EvenLaneTeamID)
  VALUES (49, 13, '13-14', 1, 8);
INSERT INTO Tourney_Matches
  (MatchID, TourneyID, Lanes, OddLaneTeamID, EvenLaneTeamID)
  VALUES (50, 13, '15-16', 2, 7);
INSERT INTO Tourney_Matches
  (MatchID, TourneyID, Lanes, OddLaneTeamID, EvenLaneTeamID)
  VALUES (51, 13, '17-18', 3, 6);
INSERT INTO Tourney_Matches
  (MatchID, TourneyID, Lanes, OddLaneTeamID, EvenLaneTeamID)
  VALUES (52, 13, '19-20', 4, 5);
INSERT INTO Tourney_Matches
  (MatchID, TourneyID, Lanes, OddLaneTeamID, EvenLaneTeamID)
  VALUES (53, 14, '01-02', 2, 1);
INSERT INTO Tourney_Matches
  (MatchID, TourneyID, Lanes, OddLaneTeamID, EvenLaneTeamID)
  VALUES (54, 14, '03-04', 4, 3);
INSERT INTO Tourney_Matches
  (MatchID, TourneyID, Lanes, OddLaneTeamID, EvenLaneTeamID)
  VALUES (55, 14, '05-06', 6, 5);
INSERT INTO Tourney_Matches
  (MatchID, TourneyID, Lanes, OddLaneTeamID, EvenLaneTeamID)
  VALUES (56, 14, '07-08', 8, 7);
INSERT INTO Tourney_Matches
  (MatchID, TourneyID, Lanes, OddLaneTeamID, EvenLaneTeamID)
  VALUES (57, 11, '19-20', 10, 9);
SET IDENTITY_INSERT Tourney_Matches OFF
GO
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (1, 1, 1);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (1, 2, 2);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (1, 3, 1);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (2, 1, 3);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (2, 2, 4);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (2, 3, 3);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (3, 1, 5);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (3, 2, 6);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (3, 3, 5);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (4, 1, 7);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (4, 2, 8);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (4, 3, 7);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (5, 1, 3);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (5, 2, 1);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (5, 3, 3);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (6, 1, 4);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (6, 2, 2);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (6, 3, 4);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (7, 1, 5);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (7, 2, 7);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (7, 3, 5);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (8, 1, 8);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (8, 2, 6);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (8, 3, 8);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (9, 1, 2);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (9, 2, 3);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (9, 3, 2);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (10, 1, 1);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (10, 2, 4);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (10, 3, 1);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (11, 1, 7);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (11, 2, 6);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (11, 3, 7);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (12, 1, 5);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (12, 2, 8);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (12, 3, 5);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (13, 1, 1);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (13, 2, 5);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (13, 3, 1);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (14, 1, 2);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (14, 2, 6);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (14, 3, 2);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (15, 1, 3);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (15, 2, 7);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (15, 3, 3);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (16, 1, 4);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (16, 2, 8);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (16, 3, 4);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (17, 1, 6);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (17, 2, 1);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (17, 3, 6);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (18, 1, 5);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (18, 2, 2);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (18, 3, 5);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (19, 1, 8);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (19, 2, 3);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (19, 3, 8);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (20, 1, 7);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (20, 2, 4);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (20, 3, 7);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (21, 1, 1);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (21, 2, 7);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (21, 3, 1);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (22, 1, 3);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (22, 2, 5);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (22, 3, 3);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (23, 1, 2);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (23, 2, 8);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (23, 3, 2);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (24, 1, 4);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (24, 2, 6);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (24, 3, 4);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (25, 1, 8);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (25, 2, 1);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (25, 3, 8);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (26, 1, 7);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (26, 2, 2);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (26, 3, 7);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (27, 1, 6);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (27, 2, 3);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (27, 3, 6);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (28, 1, 5);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (28, 2, 4);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (28, 3, 5);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (29, 1, 1);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (29, 2, 3);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (29, 3, 1);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (30, 1, 2);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (30, 2, 4);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (30, 3, 2);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (31, 1, 7);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (31, 2, 5);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (31, 3, 7);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (32, 1, 6);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (32, 2, 8);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (32, 3, 6);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (33, 1, 3);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (33, 2, 2);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (33, 3, 3);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (34, 1, 4);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (34, 2, 1);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (34, 3, 4);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (35, 1, 6);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (35, 2, 7);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (35, 3, 6);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (36, 1, 8);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (36, 2, 5);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (36, 3, 8);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (37, 1, 5);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (37, 2, 1);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (37, 3, 5);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (38, 1, 6);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (38, 2, 2);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (38, 3, 6);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (39, 1, 7);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (39, 2, 3);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (39, 3, 7);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (40, 1, 8);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (40, 2, 4);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (40, 3, 8);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (41, 1, 1);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (41, 2, 6);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (41, 3, 1);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (42, 1, 2);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (42, 2, 5);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (42, 3, 2);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (43, 1, 3);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (43, 2, 8);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (43, 3, 3);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (44, 1, 4);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (44, 2, 7);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (44, 3, 4);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (45, 1, 7);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (45, 2, 1);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (45, 3, 7);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (46, 1, 5);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (46, 2, 3);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (46, 3, 5);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (47, 1, 8);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (47, 2, 2);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (47, 3, 8);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (48, 1, 6);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (48, 2, 4);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (48, 3, 6);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (49, 1, 1);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (49, 2, 8);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (49, 3, 1);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (50, 1, 2);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (50, 2, 7);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (50, 3, 2);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (51, 1, 3);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (51, 2, 6);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (51, 3, 3);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (52, 1, 4);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (52, 2, 5);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (52, 3, 4);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (53, 1, 2);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (53, 2, 1);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (53, 3, 2);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (54, 1, 4);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (54, 2, 3);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (54, 3, 4);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (55, 1, 6);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (55, 2, 5);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (55, 3, 6);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (56, 1, 8);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (56, 2, 7);
INSERT INTO Match_Games
  (MatchID, GameNumber, WinningTeamID)
  VALUES (56, 3, 8);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (1, 1, 1, 146, 192, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (1, 1, 2, 166, 205, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (1, 1, 3, 140, 171, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (1, 1, 4, 146, 198, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (1, 1, 5, 157, 203, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (1, 1, 6, 160, 198, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (1, 1, 7, 170, 199, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (1, 1, 8, 150, 202, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (1, 2, 1, 146, 192, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (1, 2, 2, 135, 174, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (1, 2, 3, 156, 187, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (1, 2, 4, 143, 195, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (1, 2, 5, 149, 195, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (1, 2, 6, 152, 190, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (1, 2, 7, 158, 187, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (1, 2, 8, 136, 188, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (1, 3, 1, 153, 199, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (1, 3, 2, 177, 216, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (1, 3, 3, 191, 222, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (1, 3, 4, 148, 200, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (1, 3, 5, 139, 185, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (1, 3, 6, 142, 180, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (1, 3, 7, 192, 221, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (1, 3, 8, 148, 200, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (2, 1, 9, 146, 191, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (2, 1, 10, 154, 190, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (2, 1, 11, 168, 201, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (2, 1, 12, 136, 188, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (2, 1, 13, 143, 186, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (2, 1, 14, 142, 181, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (2, 1, 15, 137, 171, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (2, 1, 16, 143, 195, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (2, 2, 9, 138, 183, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (2, 2, 10, 171, 207, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (2, 2, 11, 180, 213, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (2, 2, 12, 145, 197, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (2, 2, 13, 155, 198, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (2, 2, 14, 166, 205, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (2, 2, 15, 155, 189, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (2, 2, 16, 139, 191, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (2, 3, 9, 161, 206, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (2, 3, 10, 172, 208, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (2, 3, 11, 186, 219, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (2, 3, 12, 136, 188, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (2, 3, 13, 162, 205, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (2, 3, 14, 137, 176, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (2, 3, 15, 163, 197, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (2, 3, 16, 143, 195, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (3, 1, 17, 159, 205, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (3, 1, 18, 176, 215, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (3, 1, 19, 147, 176, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (3, 1, 20, 143, 194, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (3, 1, 21, 154, 201, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (3, 1, 22, 173, 211, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (3, 1, 23, 146, 178, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (3, 1, 24, 164, 192, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (3, 2, 17, 165, 211, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (3, 2, 18, 164, 203, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (3, 2, 19, 168, 197, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (3, 2, 20, 137, 188, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (3, 2, 21, 157, 204, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (3, 2, 22, 157, 195, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (3, 2, 23, 182, 214, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (3, 2, 24, 160, 188, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (3, 3, 17, 149, 195, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (3, 3, 18, 160, 199, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (3, 3, 19, 185, 214, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (3, 3, 20, 141, 192, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (3, 3, 21, 137, 184, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (3, 3, 22, 180, 218, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (3, 3, 23, 187, 219, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (3, 3, 24, 163, 191, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (4, 1, 25, 157, 202, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (4, 1, 26, 143, 182, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (4, 1, 27, 140, 170, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (4, 1, 28, 143, 194, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (4, 1, 29, 138, 183, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (4, 1, 30, 176, 215, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (4, 1, 31, 151, 184, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (4, 1, 32, 148, 200, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (4, 2, 25, 138, 183, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (4, 2, 26, 147, 186, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (4, 2, 27, 172, 202, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (4, 2, 28, 147, 198, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (4, 2, 29, 143, 188, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (4, 2, 30, 167, 206, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (4, 2, 31, 146, 179, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (4, 2, 32, 141, 193, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (4, 3, 25, 155, 200, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (4, 3, 26, 148, 187, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (4, 3, 27, 167, 197, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (4, 3, 28, 140, 191, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (4, 3, 29, 163, 208, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (4, 3, 30, 143, 182, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (4, 3, 31, 182, 215, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (4, 3, 32, 148, 200, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (5, 1, 1, 145, 192, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (5, 1, 2, 148, 185, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (5, 1, 3, 181, 215, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (5, 1, 4, 139, 188, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (5, 1, 9, 147, 194, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (5, 1, 10, 147, 178, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (5, 1, 11, 158, 178, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (5, 1, 12, 147, 202, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (5, 2, 1, 137, 184, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (5, 2, 2, 140, 177, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (5, 2, 3, 158, 192, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (5, 2, 4, 139, 188, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (5, 2, 9, 146, 193, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (5, 2, 10, 167, 198, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (5, 2, 11, 144, 164, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (5, 2, 12, 143, 198, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (5, 3, 1, 152, 199, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (5, 3, 2, 144, 181, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (5, 3, 3, 175, 209, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (5, 3, 4, 138, 187, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (5, 3, 9, 148, 195, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (5, 3, 10, 178, 209, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (5, 3, 11, 158, 178, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (5, 3, 12, 137, 192, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (6, 1, 5, 164, 211, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (6, 1, 6, 179, 223, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (6, 1, 7, 181, 205, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (6, 1, 8, 146, 196, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (6, 1, 13, 164, 206, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (6, 1, 14, 164, 211, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (6, 1, 15, 180, 223, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (6, 1, 16, 149, 201, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (6, 2, 5, 138, 185, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (6, 2, 6, 164, 208, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (6, 2, 7, 183, 207, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (6, 2, 8, 149, 199, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (6, 2, 13, 165, 207, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (6, 2, 14, 156, 203, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (6, 2, 15, 177, 220, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (6, 2, 16, 149, 201, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (6, 3, 5, 165, 212, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (6, 3, 6, 136, 180, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (6, 3, 7, 178, 202, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (6, 3, 8, 138, 188, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (6, 3, 13, 151, 193, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (6, 3, 14, 147, 194, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (6, 3, 15, 158, 201, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (6, 3, 16, 136, 188, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (7, 1, 17, 139, 177, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (7, 1, 18, 142, 172, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (7, 1, 19, 189, 219, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (7, 1, 20, 138, 192, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (7, 1, 25, 143, 188, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (7, 1, 26, 180, 229, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (7, 1, 27, 167, 203, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (7, 1, 28, 148, 199, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (7, 2, 17, 157, 195, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (7, 2, 18, 143, 173, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (7, 2, 19, 176, 206, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (7, 2, 20, 141, 195, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (7, 2, 25, 139, 184, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (7, 2, 26, 175, 224, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (7, 2, 27, 178, 214, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (7, 2, 28, 147, 198, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (7, 3, 17, 155, 193, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (7, 3, 18, 136, 166, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (7, 3, 19, 155, 185, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (7, 3, 20, 139, 193, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (7, 3, 25, 143, 188, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (7, 3, 26, 151, 200, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (7, 3, 27, 137, 173, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (7, 3, 28, 150, 201, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (8, 1, 21, 145, 191, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (8, 1, 22, 146, 173, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (8, 1, 23, 157, 182, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (8, 1, 24, 168, 196, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (8, 1, 29, 140, 187, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (8, 1, 30, 179, 213, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (8, 1, 31, 161, 197, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (8, 1, 32, 138, 187, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (8, 2, 21, 148, 194, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (8, 2, 22, 136, 163, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (8, 2, 23, 193, 218, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (8, 2, 24, 178, 206, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (8, 2, 29, 156, 203, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (8, 2, 30, 149, 183, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (8, 2, 31, 185, 221, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (8, 2, 32, 136, 185, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (8, 3, 21, 136, 182, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (8, 3, 22, 143, 170, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (8, 3, 23, 189, 214, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (8, 3, 24, 168, 197, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (8, 3, 29, 135, 182, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (8, 3, 30, 166, 200, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (8, 3, 31, 140, 176, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (8, 3, 32, 144, 193, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (9, 1, 5, 137, 180, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (9, 1, 6, 178, 218, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (9, 1, 7, 140, 161, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (9, 1, 8, 139, 189, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (9, 1, 9, 164, 211, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (9, 1, 10, 136, 168, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (9, 1, 11, 182, 213, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (9, 1, 12, 145, 198, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (9, 2, 5, 149, 192, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (9, 2, 6, 147, 187, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (9, 2, 7, 145, 166, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (9, 2, 8, 141, 191, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (9, 2, 9, 158, 205, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (9, 2, 10, 167, 199, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (9, 2, 11, 176, 207, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (9, 2, 12, 139, 192, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (9, 3, 5, 162, 205, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (9, 3, 6, 141, 181, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (9, 3, 7, 144, 165, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (9, 3, 8, 149, 199, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (9, 3, 9, 144, 191, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (9, 3, 10, 158, 190, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (9, 3, 11, 158, 189, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (9, 3, 12, 135, 188, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (10, 1, 1, 140, 189, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (10, 1, 2, 141, 184, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (10, 1, 3, 189, 219, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (10, 1, 4, 143, 195, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (10, 1, 13, 150, 189, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (10, 1, 14, 150, 193, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (10, 1, 15, 181, 215, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (10, 1, 16, 145, 196, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (10, 2, 1, 137, 186, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (10, 2, 2, 163, 206, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (10, 2, 3, 135, 165, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (10, 2, 4, 147, 199, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (10, 2, 13, 153, 192, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (10, 2, 14, 154, 197, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (10, 2, 15, 169, 203, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (10, 2, 16, 138, 189, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (10, 3, 1, 161, 210, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (10, 3, 2, 167, 210, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (10, 3, 3, 175, 205, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (10, 3, 4, 140, 192, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (10, 3, 13, 143, 182, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (10, 3, 14, 157, 200, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (10, 3, 15, 153, 187, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (10, 3, 16, 142, 193, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (11, 1, 21, 146, 195, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (11, 1, 22, 174, 214, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (11, 1, 23, 164, 186, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (11, 1, 24, 169, 196, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (11, 1, 25, 158, 207, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (11, 1, 26, 159, 198, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (11, 1, 27, 195, 231, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (11, 1, 28, 138, 187, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (11, 2, 21, 154, 203, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (11, 2, 22, 140, 180, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (11, 2, 23, 140, 162, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (11, 2, 24, 175, 202, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (11, 2, 25, 158, 207, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (11, 2, 26, 171, 210, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (11, 2, 27, 160, 196, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (11, 2, 28, 142, 191, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (11, 3, 21, 159, 208, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (11, 3, 22, 165, 205, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (11, 3, 23, 147, 169, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (11, 3, 24, 167, 194, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (11, 3, 25, 161, 210, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (11, 3, 26, 161, 200, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (11, 3, 27, 158, 194, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (11, 3, 28, 135, 184, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (12, 1, 17, 139, 180, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (12, 1, 18, 145, 186, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (12, 1, 19, 154, 181, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (12, 1, 20, 149, 203, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (12, 1, 29, 137, 186, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (12, 1, 30, 135, 168, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (12, 1, 31, 139, 174, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (12, 1, 32, 140, 192, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (12, 2, 17, 151, 192, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (12, 2, 18, 167, 208, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (12, 2, 19, 183, 210, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (12, 2, 20, 146, 200, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (12, 2, 29, 148, 197, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (12, 2, 30, 171, 204, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (12, 2, 31, 145, 180, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (12, 2, 32, 145, 197, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (12, 3, 17, 155, 196, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (12, 3, 18, 143, 184, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (12, 3, 19, 141, 168, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (12, 3, 20, 149, 203, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (12, 3, 29, 156, 205, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (12, 3, 30, 158, 191, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (12, 3, 31, 184, 219, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (12, 3, 32, 146, 198, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (13, 1, 1, 159, 208, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (13, 1, 2, 163, 205, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (13, 1, 3, 182, 212, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (13, 1, 4, 138, 189, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (13, 1, 17, 150, 193, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (13, 1, 18, 136, 178, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (13, 1, 19, 179, 210, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (13, 1, 20, 146, 197, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (13, 2, 1, 140, 189, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (13, 2, 2, 176, 218, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (13, 2, 3, 178, 208, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (13, 2, 4, 139, 190, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (13, 2, 17, 153, 196, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (13, 2, 18, 174, 216, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (13, 2, 19, 140, 171, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (13, 2, 20, 141, 192, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (13, 3, 1, 158, 207, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (13, 3, 2, 141, 183, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (13, 3, 3, 150, 180, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (13, 3, 4, 140, 191, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (13, 3, 17, 151, 194, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (13, 3, 18, 146, 188, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (13, 3, 19, 173, 204, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (13, 3, 20, 148, 199, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (14, 1, 5, 163, 207, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (14, 1, 6, 136, 177, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (14, 1, 7, 177, 208, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (14, 1, 8, 147, 197, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (14, 1, 21, 146, 193, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (14, 1, 22, 170, 209, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (14, 1, 23, 149, 179, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (14, 1, 24, 176, 202, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (14, 2, 5, 150, 194, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (14, 2, 6, 172, 213, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (14, 2, 7, 135, 166, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (14, 2, 8, 136, 186, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (14, 2, 21, 160, 207, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (14, 2, 22, 140, 179, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (14, 2, 23, 164, 194, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (14, 2, 24, 172, 198, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (14, 3, 5, 142, 186, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (14, 3, 6, 142, 183, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (14, 3, 7, 179, 210, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (14, 3, 8, 148, 198, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (14, 3, 21, 153, 200, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (14, 3, 22, 178, 217, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (14, 3, 23, 180, 210, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (14, 3, 24, 175, 201, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (15, 1, 9, 142, 187, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (15, 1, 10, 155, 190, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (15, 1, 11, 150, 179, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (15, 1, 12, 140, 194, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (15, 1, 25, 163, 208, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (15, 1, 26, 153, 190, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (15, 1, 27, 153, 185, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (15, 1, 28, 143, 194, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (15, 2, 9, 162, 207, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (15, 2, 10, 151, 186, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (15, 2, 11, 146, 175, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (15, 2, 12, 150, 204, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (15, 2, 25, 147, 192, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (15, 2, 26, 156, 193, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (15, 2, 27, 182, 214, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (15, 2, 28, 140, 191, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (15, 3, 9, 163, 208, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (15, 3, 10, 158, 193, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (15, 3, 11, 141, 170, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (15, 3, 12, 140, 194, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (15, 3, 25, 139, 184, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (15, 3, 26, 166, 203, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (15, 3, 27, 193, 225, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (15, 3, 28, 140, 191, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (16, 1, 13, 157, 198, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (16, 1, 14, 162, 204, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (16, 1, 15, 165, 197, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (16, 1, 16, 139, 190, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (16, 1, 29, 164, 213, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (16, 1, 30, 153, 189, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (16, 1, 31, 174, 211, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (16, 1, 32, 140, 191, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (16, 2, 13, 162, 203, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (16, 2, 14, 164, 206, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (16, 2, 15, 135, 167, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (16, 2, 16, 137, 188, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (16, 2, 29, 138, 187, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (16, 2, 30, 167, 203, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (16, 2, 31, 184, 221, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (16, 2, 32, 144, 195, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (16, 3, 13, 139, 180, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (16, 3, 14, 153, 195, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (16, 3, 15, 183, 215, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (16, 3, 16, 147, 198, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (16, 3, 29, 163, 212, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (16, 3, 30, 147, 183, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (16, 3, 31, 149, 186, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (16, 3, 32, 140, 191, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (17, 1, 1, 139, 186, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (17, 1, 2, 175, 216, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (17, 1, 3, 136, 165, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (17, 1, 4, 141, 193, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (17, 1, 21, 141, 186, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (17, 1, 22, 146, 184, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (17, 1, 23, 156, 187, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (17, 1, 24, 162, 187, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (17, 2, 1, 164, 211, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (17, 2, 2, 161, 202, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (17, 2, 3, 174, 203, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (17, 2, 4, 145, 197, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (17, 2, 21, 147, 192, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (17, 2, 22, 141, 179, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (17, 2, 23, 156, 187, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (17, 2, 24, 165, 190, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (17, 3, 1, 161, 208, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (17, 3, 2, 173, 214, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (17, 3, 3, 144, 173, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (17, 3, 4, 141, 193, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (17, 3, 21, 138, 183, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (17, 3, 22, 174, 212, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (17, 3, 23, 190, 221, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (17, 3, 24, 173, 198, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (18, 1, 5, 143, 187, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (18, 1, 6, 145, 186, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (18, 1, 7, 169, 201, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (18, 1, 8, 146, 196, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (18, 1, 17, 149, 192, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (18, 1, 18, 165, 207, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (18, 1, 19, 138, 169, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (18, 1, 20, 148, 199, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (18, 2, 5, 155, 199, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (18, 2, 6, 178, 219, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (18, 2, 7, 175, 207, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (18, 2, 8, 146, 196, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (18, 2, 17, 156, 199, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (18, 2, 18, 173, 215, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (18, 2, 19, 155, 186, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (18, 2, 20, 148, 199, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (18, 3, 5, 136, 180, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (18, 3, 6, 140, 181, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (18, 3, 7, 187, 219, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (18, 3, 8, 142, 192, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (18, 3, 17, 141, 184, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (18, 3, 18, 173, 215, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (18, 3, 19, 190, 221, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (18, 3, 20, 143, 194, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (19, 1, 9, 142, 185, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (19, 1, 10, 169, 205, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (19, 1, 11, 162, 196, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (19, 1, 12, 140, 193, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (19, 1, 29, 144, 191, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (19, 1, 30, 162, 199, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (19, 1, 31, 175, 209, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (19, 1, 32, 143, 195, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (19, 2, 9, 164, 207, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (19, 2, 10, 161, 197, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (19, 2, 11, 137, 171, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (19, 2, 12, 148, 201, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (19, 2, 29, 135, 182, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (19, 2, 30, 177, 214, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (19, 2, 31, 174, 208, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (19, 2, 32, 149, 201, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (19, 3, 9, 162, 205, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (19, 3, 10, 158, 194, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (19, 3, 11, 149, 183, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (19, 3, 12, 142, 195, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (19, 3, 29, 137, 184, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (19, 3, 30, 151, 188, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (19, 3, 31, 186, 220, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (19, 3, 32, 137, 189, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (20, 1, 13, 161, 202, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (20, 1, 14, 175, 216, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (20, 1, 15, 176, 209, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (20, 1, 16, 143, 195, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (20, 1, 25, 144, 189, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (20, 1, 26, 141, 178, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (20, 1, 27, 139, 169, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (20, 1, 28, 150, 201, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (20, 2, 13, 148, 189, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (20, 2, 14, 164, 205, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (20, 2, 15, 144, 177, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (20, 2, 16, 137, 189, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (20, 2, 25, 144, 189, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (20, 2, 26, 158, 195, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (20, 2, 27, 147, 177, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (20, 2, 28, 138, 189, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (20, 3, 13, 162, 203, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (20, 3, 14, 172, 213, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (20, 3, 15, 140, 173, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (20, 3, 16, 138, 190, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (20, 3, 25, 137, 182, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (20, 3, 26, 143, 180, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (20, 3, 27, 172, 202, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (20, 3, 28, 149, 200, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (21, 1, 1, 141, 187, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (21, 1, 2, 141, 179, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (21, 1, 3, 191, 223, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (21, 1, 4, 145, 197, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (21, 1, 25, 142, 189, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (21, 1, 26, 151, 190, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (21, 1, 27, 150, 182, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (21, 1, 28, 148, 199, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (21, 2, 1, 141, 187, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (21, 2, 2, 164, 202, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (21, 2, 3, 189, 221, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (21, 2, 4, 142, 194, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (21, 2, 25, 147, 194, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (21, 2, 26, 138, 177, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (21, 2, 27, 176, 208, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (21, 2, 28, 137, 188, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (21, 3, 1, 139, 185, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (21, 3, 2, 159, 197, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (21, 3, 3, 174, 206, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (21, 3, 4, 137, 189, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (21, 3, 25, 136, 183, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (21, 3, 26, 178, 217, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (21, 3, 27, 191, 223, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (21, 3, 28, 147, 198, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (22, 1, 9, 142, 185, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (22, 1, 10, 165, 201, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (22, 1, 11, 144, 180, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (22, 1, 12, 139, 191, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (22, 1, 17, 139, 183, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (22, 1, 18, 168, 208, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (22, 1, 19, 165, 197, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (22, 1, 20, 144, 194, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (22, 2, 9, 143, 186, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (22, 2, 10, 167, 203, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (22, 2, 11, 188, 224, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (22, 2, 12, 145, 197, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (22, 2, 17, 144, 188, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (22, 2, 18, 159, 199, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (22, 2, 19, 166, 198, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (22, 2, 20, 143, 193, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (22, 3, 9, 153, 196, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (22, 3, 10, 146, 182, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (22, 3, 11, 182, 218, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (22, 3, 12, 147, 199, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (22, 3, 17, 162, 206, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (22, 3, 18, 179, 219, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (22, 3, 19, 179, 211, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (22, 3, 20, 144, 194, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (23, 1, 5, 136, 181, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (23, 1, 6, 175, 216, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (23, 1, 7, 164, 193, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (23, 1, 8, 136, 186, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (23, 1, 29, 159, 208, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (23, 1, 30, 151, 187, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (23, 1, 31, 177, 209, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (23, 1, 32, 142, 193, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (23, 2, 5, 145, 190, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (23, 2, 6, 175, 216, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (23, 2, 7, 182, 211, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (23, 2, 8, 142, 192, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (23, 2, 29, 136, 185, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (23, 2, 30, 149, 185, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (23, 2, 31, 149, 181, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (23, 2, 32, 136, 187, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (23, 3, 5, 154, 199, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (23, 3, 6, 177, 218, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (23, 3, 7, 150, 179, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (23, 3, 8, 142, 192, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (23, 3, 29, 135, 184, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (23, 3, 30, 153, 189, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (23, 3, 31, 141, 173, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (23, 3, 32, 140, 191, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (24, 1, 13, 149, 190, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (24, 1, 14, 138, 176, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (24, 1, 15, 154, 189, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (24, 1, 16, 139, 191, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (24, 1, 21, 159, 206, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (24, 1, 22, 147, 185, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (24, 1, 23, 193, 223, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (24, 1, 24, 171, 197, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (24, 2, 13, 151, 192, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (24, 2, 14, 179, 217, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (24, 2, 15, 157, 192, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (24, 2, 16, 148, 200, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (24, 2, 21, 157, 204, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (24, 2, 22, 172, 210, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (24, 2, 23, 175, 205, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (24, 2, 24, 169, 195, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (24, 3, 13, 149, 190, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (24, 3, 14, 163, 201, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (24, 3, 15, 148, 183, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (24, 3, 16, 139, 191, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (24, 3, 21, 138, 185, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (24, 3, 22, 170, 208, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (24, 3, 23, 168, 198, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (24, 3, 24, 174, 200, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (25, 1, 1, 149, 196, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (25, 1, 2, 157, 196, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (25, 1, 3, 152, 181, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (25, 1, 4, 141, 193, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (25, 1, 29, 164, 213, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (25, 1, 30, 173, 210, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (25, 1, 31, 187, 220, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (25, 1, 32, 145, 197, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (25, 2, 1, 159, 206, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (25, 2, 2, 171, 210, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (25, 2, 3, 179, 208, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (25, 2, 4, 135, 187, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (25, 2, 29, 164, 213, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (25, 2, 30, 156, 193, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (25, 2, 31, 159, 192, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (25, 2, 32, 137, 189, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (25, 3, 1, 138, 185, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (25, 3, 2, 157, 196, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (25, 3, 3, 148, 177, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (25, 3, 4, 137, 189, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (25, 3, 29, 147, 196, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (25, 3, 30, 159, 196, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (25, 3, 31, 147, 180, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (25, 3, 32, 148, 200, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (26, 1, 5, 142, 188, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (26, 1, 6, 166, 204, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (26, 1, 7, 190, 220, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (26, 1, 8, 142, 193, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (26, 1, 25, 164, 212, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (26, 1, 26, 174, 213, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (26, 1, 27, 162, 194, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (26, 1, 28, 145, 196, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (26, 2, 5, 139, 185, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (26, 2, 6, 163, 201, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (26, 2, 7, 173, 203, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (26, 2, 8, 135, 186, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (26, 2, 25, 139, 187, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (26, 2, 26, 170, 209, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (26, 2, 27, 180, 212, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (26, 2, 28, 136, 187, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (26, 3, 5, 160, 206, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (26, 3, 6, 168, 206, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (26, 3, 7, 174, 204, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (26, 3, 8, 137, 188, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (26, 3, 25, 152, 200, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (26, 3, 26, 139, 178, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (26, 3, 27, 141, 173, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (26, 3, 28, 138, 189, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (27, 1, 9, 148, 192, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (27, 1, 10, 174, 210, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (27, 1, 11, 138, 172, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (27, 1, 12, 148, 200, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (27, 1, 21, 155, 201, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (27, 1, 22, 156, 194, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (27, 1, 23, 147, 175, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (27, 1, 24, 166, 192, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (27, 2, 9, 150, 194, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (27, 2, 10, 169, 205, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (27, 2, 11, 141, 175, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (27, 2, 12, 147, 199, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (27, 2, 21, 146, 192, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (27, 2, 22, 174, 212, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (27, 2, 23, 179, 207, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (27, 2, 24, 160, 186, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (27, 3, 9, 152, 196, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (27, 3, 10, 175, 211, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (27, 3, 11, 191, 225, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (27, 3, 12, 148, 200, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (27, 3, 21, 144, 190, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (27, 3, 22, 147, 185, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (27, 3, 23, 147, 175, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (27, 3, 24, 171, 197, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (28, 1, 13, 140, 181, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (28, 1, 14, 155, 193, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (28, 1, 15, 170, 206, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (28, 1, 16, 138, 190, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (28, 1, 17, 165, 209, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (28, 1, 18, 172, 210, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (28, 1, 19, 185, 216, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (28, 1, 20, 140, 190, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (28, 2, 13, 149, 190, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (28, 2, 14, 162, 200, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (28, 2, 15, 140, 176, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (28, 2, 16, 135, 187, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (28, 2, 17, 153, 197, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (28, 2, 18, 180, 218, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (28, 2, 19, 181, 212, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (28, 2, 20, 142, 192, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (28, 3, 13, 142, 183, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (28, 3, 14, 135, 173, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (28, 3, 15, 138, 174, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (28, 3, 16, 148, 200, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (28, 3, 17, 152, 196, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (28, 3, 18, 140, 178, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (28, 3, 19, 167, 198, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (28, 3, 20, 149, 199, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (29, 1, 1, 161, 208, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (29, 1, 2, 143, 181, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (29, 1, 3, 182, 212, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (29, 1, 4, 138, 191, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (29, 1, 9, 158, 202, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (29, 1, 10, 161, 195, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (29, 1, 11, 150, 185, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (29, 1, 12, 145, 196, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (29, 2, 1, 141, 188, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (29, 2, 2, 171, 209, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (29, 2, 3, 145, 175, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (29, 2, 4, 144, 197, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (29, 2, 9, 141, 185, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (29, 2, 10, 160, 194, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (29, 2, 11, 173, 208, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (29, 2, 12, 150, 201, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (29, 3, 1, 156, 203, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (29, 3, 2, 159, 197, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (29, 3, 3, 169, 199, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (29, 3, 4, 146, 199, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (29, 3, 9, 144, 188, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (29, 3, 10, 164, 198, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (29, 3, 11, 166, 201, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (29, 3, 12, 136, 187, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (30, 1, 5, 153, 199, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (30, 1, 6, 152, 189, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (30, 1, 7, 172, 200, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (30, 1, 8, 136, 187, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (30, 1, 13, 136, 179, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (30, 1, 14, 165, 204, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (30, 1, 15, 137, 175, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (30, 1, 16, 148, 200, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (30, 2, 5, 149, 195, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (30, 2, 6, 159, 196, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (30, 2, 7, 153, 181, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (30, 2, 8, 149, 200, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (30, 2, 13, 158, 201, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (30, 2, 14, 148, 187, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (30, 2, 15, 188, 226, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (30, 2, 16, 145, 197, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (30, 3, 5, 147, 193, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (30, 3, 6, 151, 188, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (30, 3, 7, 193, 221, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (30, 3, 8, 143, 194, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (30, 3, 13, 155, 198, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (30, 3, 14, 177, 216, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (30, 3, 15, 145, 183, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (30, 3, 16, 141, 193, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (31, 1, 17, 139, 182, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (31, 1, 18, 144, 181, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (31, 1, 19, 179, 209, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (31, 1, 20, 147, 197, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (31, 1, 25, 157, 204, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (31, 1, 26, 170, 209, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (31, 1, 27, 168, 200, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (31, 1, 28, 143, 194, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (31, 2, 17, 155, 198, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (31, 2, 18, 148, 185, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (31, 2, 19, 167, 197, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (31, 2, 20, 141, 191, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (31, 2, 25, 159, 206, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (31, 2, 26, 165, 204, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (31, 2, 27, 192, 224, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (31, 2, 28, 142, 193, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (31, 3, 17, 136, 179, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (31, 3, 18, 171, 208, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (31, 3, 19, 157, 187, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (31, 3, 20, 137, 187, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (31, 3, 25, 164, 211, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (31, 3, 26, 165, 204, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (31, 3, 27, 183, 215, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (31, 3, 28, 146, 197, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (32, 1, 21, 136, 182, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (32, 1, 22, 143, 180, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (32, 1, 23, 158, 188, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (32, 1, 24, 174, 201, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (32, 1, 29, 151, 198, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (32, 1, 30, 167, 204, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (32, 1, 31, 184, 216, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (32, 1, 32, 143, 195, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (32, 2, 21, 158, 204, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (32, 2, 22, 166, 203, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (32, 2, 23, 188, 218, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (32, 2, 24, 167, 194, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (32, 2, 29, 150, 197, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (32, 2, 30, 166, 203, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (32, 2, 31, 161, 193, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (32, 2, 32, 137, 189, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (32, 3, 21, 159, 205, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (32, 3, 22, 145, 182, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (32, 3, 23, 181, 211, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (32, 3, 24, 168, 195, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (32, 3, 29, 143, 190, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (32, 3, 30, 161, 198, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (32, 3, 31, 152, 184, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (32, 3, 32, 139, 191, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (33, 1, 5, 141, 187, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (33, 1, 6, 143, 181, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (33, 1, 7, 166, 194, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (33, 1, 8, 145, 196, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (33, 1, 9, 152, 196, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (33, 1, 10, 141, 175, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (33, 1, 11, 169, 204, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (33, 1, 12, 147, 198, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (33, 2, 5, 164, 210, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (33, 2, 6, 147, 185, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (33, 2, 7, 160, 188, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (33, 2, 8, 147, 198, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (33, 2, 9, 159, 203, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (33, 2, 10, 140, 174, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (33, 2, 11, 180, 215, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (33, 2, 12, 138, 189, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (33, 3, 5, 140, 186, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (33, 3, 6, 171, 209, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (33, 3, 7, 168, 196, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (33, 3, 8, 140, 191, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (33, 3, 9, 136, 180, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (33, 3, 10, 155, 189, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (33, 3, 11, 194, 229, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (33, 3, 12, 150, 201, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (34, 1, 1, 140, 187, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (34, 1, 2, 160, 198, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (34, 1, 3, 152, 183, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (34, 1, 4, 142, 195, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (34, 1, 13, 146, 189, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (34, 1, 14, 161, 199, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (34, 1, 15, 170, 208, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (34, 1, 16, 144, 196, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (34, 2, 1, 140, 187, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (34, 2, 2, 170, 208, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (34, 2, 3, 158, 189, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (34, 2, 4, 137, 190, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (34, 2, 13, 154, 197, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (34, 2, 14, 170, 208, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (34, 2, 15, 145, 183, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (34, 2, 16, 141, 193, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (34, 3, 1, 149, 196, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (34, 3, 2, 146, 184, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (34, 3, 3, 141, 172, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (34, 3, 4, 149, 202, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (34, 3, 13, 156, 199, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (34, 3, 14, 148, 186, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (34, 3, 15, 176, 214, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (34, 3, 16, 149, 201, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (35, 1, 21, 137, 183, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (35, 1, 22, 157, 195, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (35, 1, 23, 168, 197, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (35, 1, 24, 163, 190, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (35, 1, 25, 141, 187, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (35, 1, 26, 158, 196, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (35, 1, 27, 150, 180, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (35, 1, 28, 147, 198, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (35, 2, 21, 153, 199, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (35, 2, 22, 155, 193, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (35, 2, 23, 142, 171, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (35, 2, 24, 171, 198, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (35, 2, 25, 163, 209, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (35, 2, 26, 157, 195, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (35, 2, 27, 180, 210, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (35, 2, 28, 139, 190, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (35, 3, 21, 159, 205, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (35, 3, 22, 164, 202, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (35, 3, 23, 160, 189, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (35, 3, 24, 162, 189, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (35, 3, 25, 136, 182, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (35, 3, 26, 141, 179, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (35, 3, 27, 151, 181, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (35, 3, 28, 144, 195, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (36, 1, 17, 157, 201, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (36, 1, 18, 157, 195, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (36, 1, 19, 149, 179, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (36, 1, 20, 148, 198, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (36, 1, 29, 162, 209, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (36, 1, 30, 139, 175, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (36, 1, 31, 138, 170, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (36, 1, 32, 142, 194, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (36, 2, 17, 159, 203, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (36, 2, 18, 179, 217, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (36, 2, 19, 192, 222, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (36, 2, 20, 140, 190, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (36, 2, 29, 153, 200, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (36, 2, 30, 158, 194, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (36, 2, 31, 163, 195, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (36, 2, 32, 142, 194, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (36, 3, 17, 148, 192, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (36, 3, 18, 174, 212, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (36, 3, 19, 146, 176, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (36, 3, 20, 139, 189, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (36, 3, 29, 161, 208, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (36, 3, 30, 173, 209, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (36, 3, 31, 156, 188, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (36, 3, 32, 143, 195, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (37, 1, 1, 143, 190, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (37, 1, 2, 139, 177, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (37, 1, 3, 178, 210, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (37, 1, 4, 141, 194, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (37, 1, 17, 164, 208, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (37, 1, 18, 138, 174, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (37, 1, 19, 155, 185, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (37, 1, 20, 149, 200, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (37, 2, 1, 156, 203, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (37, 2, 2, 143, 181, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (37, 2, 3, 159, 191, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (37, 2, 4, 144, 197, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (37, 2, 17, 161, 205, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (37, 2, 18, 142, 178, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (37, 2, 19, 193, 223, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (37, 2, 20, 141, 192, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (37, 3, 1, 151, 198, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (37, 3, 2, 165, 203, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (37, 3, 3, 156, 188, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (37, 3, 4, 148, 201, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (37, 3, 17, 156, 200, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (37, 3, 18, 155, 191, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (37, 3, 19, 192, 222, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (37, 3, 20, 137, 188, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (38, 1, 5, 156, 202, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (38, 1, 6, 155, 193, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (38, 1, 7, 155, 183, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (38, 1, 8, 138, 189, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (38, 1, 21, 157, 203, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (38, 1, 22, 136, 174, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (38, 1, 23, 167, 197, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (38, 1, 24, 173, 201, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (38, 2, 5, 148, 194, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (38, 2, 6, 165, 203, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (38, 2, 7, 167, 195, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (38, 2, 8, 138, 189, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (38, 2, 21, 144, 190, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (38, 2, 22, 161, 199, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (38, 2, 23, 149, 179, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (38, 2, 24, 176, 204, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (38, 3, 5, 153, 199, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (38, 3, 6, 165, 203, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (38, 3, 7, 165, 193, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (38, 3, 8, 145, 196, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (38, 3, 21, 144, 190, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (38, 3, 22, 151, 189, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (38, 3, 23, 183, 213, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (38, 3, 24, 171, 199, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (39, 1, 9, 139, 183, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (39, 1, 10, 146, 182, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (39, 1, 11, 156, 189, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (39, 1, 12, 145, 196, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (39, 1, 25, 154, 200, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (39, 1, 26, 158, 196, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (39, 1, 27, 160, 191, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (39, 1, 28, 148, 199, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (39, 2, 9, 137, 181, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (39, 2, 10, 146, 182, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (39, 2, 11, 145, 178, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (39, 2, 12, 136, 187, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (39, 2, 25, 135, 181, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (39, 2, 26, 158, 196, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (39, 2, 27, 144, 175, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (39, 2, 28, 144, 195, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (39, 3, 9, 150, 194, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (39, 3, 10, 145, 181, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (39, 3, 11, 181, 214, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (39, 3, 12, 147, 198, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (39, 3, 25, 141, 187, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (39, 3, 26, 136, 174, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (39, 3, 27, 175, 206, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (39, 3, 28, 139, 190, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (40, 1, 13, 161, 204, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (40, 1, 14, 161, 199, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (40, 1, 15, 173, 210, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (40, 1, 16, 146, 198, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (40, 1, 29, 141, 187, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (40, 1, 30, 172, 209, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (40, 1, 31, 144, 177, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (40, 1, 32, 142, 194, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (40, 2, 13, 155, 198, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (40, 2, 14, 165, 203, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (40, 2, 15, 143, 180, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (40, 2, 16, 137, 189, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (40, 2, 29, 161, 207, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (40, 2, 30, 140, 177, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (40, 2, 31, 167, 200, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (40, 2, 32, 146, 198, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (40, 3, 13, 140, 183, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (40, 3, 14, 157, 195, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (40, 3, 15, 191, 228, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (40, 3, 16, 139, 191, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (40, 3, 29, 158, 204, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (40, 3, 30, 137, 174, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (40, 3, 31, 192, 225, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (40, 3, 32, 136, 188, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (41, 1, 1, 143, 190, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (41, 1, 2, 156, 195, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (41, 1, 3, 162, 194, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (41, 1, 4, 145, 197, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (41, 1, 21, 151, 197, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (41, 1, 22, 149, 188, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (41, 1, 23, 178, 208, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (41, 1, 24, 164, 191, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (41, 2, 1, 156, 203, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (41, 2, 2, 176, 215, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (41, 2, 3, 188, 220, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (41, 2, 4, 137, 189, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (41, 2, 21, 141, 187, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (41, 2, 22, 170, 209, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (41, 2, 23, 145, 175, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (41, 2, 24, 171, 198, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (41, 3, 1, 142, 189, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (41, 3, 2, 178, 217, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (41, 3, 3, 149, 181, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (41, 3, 4, 149, 201, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (41, 3, 21, 145, 191, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (41, 3, 22, 141, 180, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (41, 3, 23, 143, 173, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (41, 3, 24, 159, 186, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (42, 1, 5, 147, 193, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (42, 1, 6, 163, 201, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (42, 1, 7, 190, 219, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (42, 1, 8, 137, 188, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (42, 1, 17, 158, 201, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (42, 1, 18, 166, 204, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (42, 1, 19, 142, 171, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (42, 1, 20, 138, 189, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (42, 2, 5, 147, 193, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (42, 2, 6, 144, 182, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (42, 2, 7, 171, 200, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (42, 2, 8, 150, 201, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (42, 2, 17, 135, 178, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (42, 2, 18, 169, 207, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (42, 2, 19, 191, 220, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (42, 2, 20, 137, 188, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (42, 3, 5, 145, 191, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (42, 3, 6, 148, 186, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (42, 3, 7, 142, 171, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (42, 3, 8, 140, 191, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (42, 3, 17, 153, 196, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (42, 3, 18, 154, 192, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (42, 3, 19, 177, 206, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (42, 3, 20, 145, 196, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (43, 1, 9, 156, 201, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (43, 1, 10, 180, 217, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (43, 1, 11, 175, 208, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (43, 1, 12, 149, 200, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (43, 1, 29, 157, 203, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (43, 1, 30, 137, 175, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (43, 1, 31, 136, 169, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (43, 1, 32, 140, 192, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (43, 2, 9, 148, 193, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (43, 2, 10, 158, 195, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (43, 2, 11, 151, 184, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (43, 2, 12, 135, 186, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (43, 2, 29, 135, 181, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (43, 2, 30, 163, 201, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (43, 2, 31, 163, 196, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (43, 2, 32, 147, 199, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (43, 3, 9, 159, 204, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (43, 3, 10, 172, 209, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (43, 3, 11, 162, 195, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (43, 3, 12, 140, 191, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (43, 3, 29, 151, 197, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (43, 3, 30, 162, 200, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (43, 3, 31, 148, 181, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (43, 3, 32, 146, 198, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (44, 1, 13, 157, 200, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (44, 1, 14, 171, 209, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (44, 1, 15, 148, 184, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (44, 1, 16, 136, 188, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (44, 1, 25, 143, 189, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (44, 1, 26, 175, 214, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (44, 1, 27, 141, 173, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (44, 1, 28, 136, 187, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (44, 2, 13, 153, 196, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (44, 2, 14, 153, 191, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (44, 2, 15, 153, 189, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (44, 2, 16, 142, 194, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (44, 2, 25, 153, 199, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (44, 2, 26, 142, 181, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (44, 2, 27, 178, 210, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (44, 2, 28, 139, 190, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (44, 3, 13, 157, 200, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (44, 3, 14, 144, 182, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (44, 3, 15, 166, 202, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (44, 3, 16, 140, 192, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (44, 3, 25, 140, 186, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (44, 3, 26, 148, 187, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (44, 3, 27, 192, 224, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (44, 3, 28, 150, 201, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (45, 1, 1, 164, 211, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (45, 1, 2, 143, 181, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (45, 1, 3, 172, 204, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (45, 1, 4, 136, 188, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (45, 1, 25, 159, 206, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (45, 1, 26, 141, 180, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (45, 1, 27, 167, 198, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (45, 1, 28, 150, 201, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (45, 2, 1, 153, 200, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (45, 2, 2, 171, 209, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (45, 2, 3, 164, 196, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (45, 2, 4, 144, 196, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (45, 2, 25, 163, 210, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (45, 2, 26, 162, 201, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (45, 2, 27, 183, 214, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (45, 2, 28, 141, 192, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (45, 3, 1, 163, 210, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (45, 3, 2, 151, 189, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (45, 3, 3, 160, 192, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (45, 3, 4, 139, 191, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (45, 3, 25, 146, 193, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (45, 3, 26, 164, 203, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (45, 3, 27, 182, 213, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (45, 3, 28, 142, 193, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (46, 1, 9, 162, 207, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (46, 1, 10, 176, 212, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (46, 1, 11, 185, 218, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (46, 1, 12, 136, 187, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (46, 1, 17, 146, 189, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (46, 1, 18, 155, 192, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (46, 1, 19, 158, 187, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (46, 1, 20, 147, 198, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (46, 2, 9, 151, 196, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (46, 2, 10, 138, 174, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (46, 2, 11, 162, 195, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (46, 2, 12, 138, 189, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (46, 2, 17, 137, 180, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (46, 2, 18, 145, 182, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (46, 2, 19, 174, 203, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (46, 2, 20, 144, 195, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (46, 3, 9, 146, 191, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (46, 3, 10, 136, 172, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (46, 3, 11, 148, 181, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (46, 3, 12, 137, 188, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (46, 3, 17, 137, 180, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (46, 3, 18, 138, 175, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (46, 3, 19, 178, 207, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (46, 3, 20, 146, 197, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (47, 1, 5, 136, 182, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (47, 1, 6, 174, 212, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (47, 1, 7, 166, 195, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (47, 1, 8, 136, 187, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (47, 1, 29, 161, 207, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (47, 1, 30, 152, 190, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (47, 1, 31, 138, 172, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (47, 1, 32, 137, 189, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (47, 2, 5, 164, 210, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (47, 2, 6, 136, 174, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (47, 2, 7, 170, 199, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (47, 2, 8, 144, 195, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (47, 2, 29, 154, 200, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (47, 2, 30, 147, 185, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (47, 2, 31, 188, 222, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (47, 2, 32, 142, 194, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (47, 3, 5, 151, 197, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (47, 3, 6, 137, 175, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (47, 3, 7, 150, 179, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (47, 3, 8, 142, 193, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (47, 3, 29, 150, 196, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (47, 3, 30, 151, 189, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (47, 3, 31, 186, 220, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (47, 3, 32, 136, 188, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (48, 1, 13, 150, 193, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (48, 1, 14, 167, 205, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (48, 1, 15, 190, 227, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (48, 1, 16, 148, 200, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (48, 1, 21, 154, 200, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (48, 1, 22, 172, 211, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (48, 1, 23, 140, 171, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (48, 1, 24, 175, 203, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (48, 2, 13, 147, 190, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (48, 2, 14, 140, 178, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (48, 2, 15, 178, 215, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (48, 2, 16, 146, 198, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (48, 2, 21, 136, 182, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (48, 2, 22, 161, 200, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (48, 2, 23, 152, 183, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (48, 2, 24, 160, 188, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (48, 3, 13, 149, 192, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (48, 3, 14, 151, 189, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (48, 3, 15, 191, 228, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (48, 3, 16, 141, 193, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (48, 3, 21, 140, 186, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (48, 3, 22, 176, 215, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (48, 3, 23, 148, 179, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (48, 3, 24, 174, 202, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (49, 1, 1, 142, 188, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (49, 1, 2, 142, 180, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (49, 1, 3, 162, 194, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (49, 1, 4, 140, 192, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (49, 1, 29, 156, 201, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (49, 1, 30, 145, 184, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (49, 1, 31, 184, 217, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (49, 1, 32, 142, 194, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (49, 2, 1, 145, 191, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (49, 2, 2, 167, 205, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (49, 2, 3, 152, 184, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (49, 2, 4, 143, 195, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (49, 2, 29, 142, 187, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (49, 2, 30, 144, 183, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (49, 2, 31, 162, 195, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (49, 2, 32, 138, 190, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (49, 3, 1, 140, 186, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (49, 3, 2, 153, 191, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (49, 3, 3, 189, 221, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (49, 3, 4, 148, 200, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (49, 3, 29, 160, 205, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (49, 3, 30, 170, 209, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (49, 3, 31, 190, 223, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (49, 3, 32, 140, 192, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (50, 1, 5, 159, 205, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (50, 1, 6, 174, 213, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (50, 1, 7, 189, 218, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (50, 1, 8, 149, 201, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (50, 1, 25, 158, 204, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (50, 1, 26, 177, 216, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (50, 1, 27, 189, 219, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (50, 1, 28, 141, 192, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (50, 2, 5, 155, 201, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (50, 2, 6, 153, 192, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (50, 2, 7, 195, 224, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (50, 2, 8, 149, 201, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (50, 2, 25, 161, 207, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (50, 2, 26, 175, 214, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (50, 2, 27, 148, 178, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (50, 2, 28, 137, 188, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (50, 3, 5, 139, 185, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (50, 3, 6, 177, 216, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (50, 3, 7, 189, 218, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (50, 3, 8, 135, 187, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (50, 3, 25, 164, 210, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (50, 3, 26, 143, 182, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (50, 3, 27, 189, 219, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (50, 3, 28, 146, 197, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (51, 1, 9, 160, 205, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (51, 1, 10, 150, 187, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (51, 1, 11, 169, 202, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (51, 1, 12, 144, 196, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (51, 1, 21, 144, 191, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (51, 1, 22, 173, 211, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (51, 1, 23, 155, 187, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (51, 1, 24, 166, 194, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (51, 2, 9, 152, 197, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (51, 2, 10, 176, 213, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (51, 2, 11, 175, 208, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (51, 2, 12, 150, 202, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (51, 2, 21, 147, 194, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (51, 2, 22, 135, 173, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (51, 2, 23, 177, 209, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (51, 2, 24, 178, 206, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (51, 3, 9, 149, 194, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (51, 3, 10, 142, 179, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (51, 3, 11, 152, 185, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (51, 3, 12, 140, 192, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (51, 3, 21, 142, 189, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (51, 3, 22, 163, 201, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (51, 3, 23, 179, 211, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (51, 3, 24, 171, 199, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (52, 1, 13, 142, 185, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (52, 1, 14, 171, 209, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (52, 1, 15, 183, 217, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (52, 1, 16, 145, 197, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (52, 1, 17, 149, 193, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (52, 1, 18, 156, 194, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (52, 1, 19, 175, 204, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (52, 1, 20, 142, 193, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (52, 2, 13, 157, 200, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (52, 2, 14, 136, 174, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (52, 2, 15, 148, 182, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (52, 2, 16, 141, 193, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (52, 2, 17, 138, 182, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (52, 2, 18, 155, 193, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (52, 2, 19, 156, 185, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (52, 2, 20, 147, 198, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (52, 3, 13, 160, 203, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (52, 3, 14, 136, 174, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (52, 3, 15, 165, 199, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (52, 3, 16, 148, 200, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (52, 3, 17, 142, 186, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (52, 3, 18, 138, 176, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (52, 3, 19, 184, 213, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (52, 3, 20, 145, 196, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (53, 1, 1, 139, 186, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (53, 1, 2, 145, 183, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (53, 1, 3, 191, 223, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (53, 1, 4, 146, 198, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (53, 1, 5, 150, 196, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (53, 1, 6, 170, 208, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (53, 1, 7, 156, 184, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (53, 1, 8, 141, 192, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (53, 2, 1, 155, 202, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (53, 2, 2, 146, 184, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (53, 2, 3, 155, 187, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (53, 2, 4, 143, 195, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (53, 2, 5, 137, 183, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (53, 2, 6, 179, 217, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (53, 2, 7, 142, 170, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (53, 2, 8, 137, 188, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (53, 3, 1, 158, 205, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (53, 3, 2, 138, 176, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (53, 3, 3, 175, 207, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (53, 3, 4, 140, 192, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (53, 3, 5, 163, 209, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (53, 3, 6, 155, 193, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (53, 3, 7, 137, 165, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (53, 3, 8, 147, 198, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (54, 1, 9, 145, 189, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (54, 1, 10, 175, 212, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (54, 1, 11, 136, 169, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (54, 1, 12, 138, 189, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (54, 1, 13, 141, 184, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (54, 1, 14, 157, 196, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (54, 1, 15, 174, 208, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (54, 1, 16, 149, 201, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (54, 2, 9, 142, 186, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (54, 2, 10, 170, 207, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (54, 2, 11, 171, 204, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (54, 2, 12, 146, 197, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (54, 2, 13, 163, 206, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (54, 2, 14, 170, 209, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (54, 2, 15, 166, 200, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (54, 2, 16, 139, 191, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (54, 3, 9, 158, 202, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (54, 3, 10, 173, 210, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (54, 3, 11, 182, 215, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (54, 3, 12, 139, 190, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (54, 3, 13, 147, 190, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (54, 3, 14, 150, 189, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (54, 3, 15, 147, 181, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (54, 3, 16, 141, 193, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (55, 1, 17, 137, 182, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (55, 1, 18, 153, 192, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (55, 1, 19, 147, 175, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (55, 1, 20, 138, 189, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (55, 1, 21, 155, 202, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (55, 1, 22, 169, 207, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (55, 1, 23, 161, 193, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (55, 1, 24, 170, 199, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (55, 2, 17, 136, 181, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (55, 2, 18, 155, 194, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (55, 2, 19, 150, 178, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (55, 2, 20, 144, 195, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (55, 2, 21, 148, 195, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (55, 2, 22, 170, 208, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (55, 2, 23, 170, 202, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (55, 2, 24, 172, 201, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (55, 3, 17, 149, 194, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (55, 3, 18, 162, 201, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (55, 3, 19, 183, 211, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (55, 3, 20, 138, 189, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (55, 3, 21, 138, 185, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (55, 3, 22, 136, 174, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (55, 3, 23, 155, 187, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (55, 3, 24, 169, 198, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (56, 1, 25, 142, 187, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (56, 1, 26, 177, 216, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (56, 1, 27, 143, 173, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (56, 1, 28, 142, 193, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (56, 1, 29, 138, 183, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (56, 1, 30, 135, 174, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (56, 1, 31, 175, 207, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (56, 1, 32, 143, 195, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (56, 2, 25, 164, 209, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (56, 2, 26, 151, 190, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (56, 2, 27, 143, 173, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (56, 2, 28, 135, 186, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (56, 2, 29, 149, 194, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (56, 2, 30, 155, 194, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (56, 2, 31, 141, 173, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (56, 2, 32, 141, 193, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (56, 3, 25, 163, 208, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (56, 3, 26, 136, 175, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (56, 3, 27, 182, 212, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (56, 3, 28, 139, 190, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (56, 3, 29, 156, 201, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (56, 3, 30, 165, 204, 1);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (56, 3, 31, 138, 170, 0);
INSERT INTO Bowler_Scores
  (MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, 
   WonGame)
  VALUES (56, 3, 32, 148, 200, 1);
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98001', 'Auburn', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98002', 'Auburn', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98003', 'Federal Way', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98004', 'Bellevue', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98005', 'Bellevue', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98006', 'Bellevue', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98007', 'Bellevue', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98008', 'Bellevue', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98010', 'Black Diamond', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98011', 'Bothell', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98012', 'Bothell', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98014', 'Carnation', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98019', 'Duvall', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98020', 'Edmonds', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98021', 'Bothell', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98022', 'Enumclaw', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98023', 'Federal Way', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98024', 'Fall City', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98026', 'Edmonds', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98027', 'Issaquah', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98028', 'Kenmore', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98029', 'Issaquah', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98030', 'Kent', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98031', 'Kent', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98032', 'Kent', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98033', 'Kirkland', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98034', 'Kirkland', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98036', 'Lynnwood', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98037', 'Lynnwood', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98038', 'Maple Valley', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98039', 'Medina', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98040', 'Mercer Island', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98042', 'Kent', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98043', 'Mountlake Terrace', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98045', 'North Bend', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98047', 'Pacific', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98051', 'Ravensdale', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98052', 'Redmond', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98053', 'Redmond', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98055', 'Renton', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98056', 'Renton', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98058', 'Renton', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98059', 'Renton', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98065', 'Snoqualmie', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98070', 'Vashon', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98072', 'Woodinville', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98074', 'Sammamish', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98075', 'Sammamish', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98077', 'Woodinville', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98092', 'Auburn', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98101', 'Seattle', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98102', 'Seattle', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98103', 'Seattle', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98104', 'Seattle', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98105', 'Seattle', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98106', 'Seattle', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98107', 'Seattle', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98108', 'Seattle', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98109', 'Seattle', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98110', 'Bainbridge Island', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98112', 'Seattle', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98115', 'Seattle', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98116', 'Seattle', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98117', 'Seattle', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98118', 'Seattle', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98119', 'Seattle', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98121', 'Seattle', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98122', 'Seattle', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98125', 'Seattle', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98126', 'Seattle', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98131', 'Seattle', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98132', 'Seattle', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98133', 'Seattle', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98134', 'Seattle', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98136', 'Seattle', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98144', 'Seattle', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98146', 'Seattle', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98148', 'Seattle', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98154', 'Seattle', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98155', 'Seattle', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98158', 'Seattle', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98161', 'Seattle', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98164', 'Seattle', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98166', 'Seattle', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98168', 'Seattle', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98174', 'Seattle', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98177', 'Seattle', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98178', 'Seattle', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98188', 'Seattle', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98198', 'Seattle', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98199', 'Seattle', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98201', 'Everett', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98203', 'Everett', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98204', 'Everett', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98205', 'Everett', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98208', 'Everett', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98220', 'Acme', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98221', 'Anacortes', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98222', 'Blakely Island', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98223', 'Arlington', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98225', 'Bellingham', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98226', 'Bellingham', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98229', 'Bellingham', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98230', 'Blaine', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98232', 'Bow', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98233', 'Burlington', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98236', 'Clinton', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98237', 'Concrete', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98239', 'Coupeville', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98240', 'Custer', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98241', 'Darrington', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98244', 'Deming', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98245', 'Eastsound', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98247', 'Everson', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98248', 'Ferndale', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98249', 'Freeland', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98250', 'Friday Harbor', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98251', 'Gold Bar', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98252', 'Granite Falls', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98253', 'Greenbank', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98257', 'La Conner', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98258', 'Lake Stevens', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98260', 'Langley', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98261', 'Lopez Island', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98262', 'Lummi Island', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98264', 'Lynden', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98266', 'Maple Falls', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98267', 'Marblemount', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98270', 'Marysville', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98271', 'Marysville', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98272', 'Monroe', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98273', 'Mount Vernon', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98274', 'Mount Vernon', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98275', 'Mukilteo', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98277', 'Oak Harbor', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98279', 'Olga', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98281', 'Point Roberts', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98282', 'Camano Island', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98283', 'Rockport', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98284', 'Sedro Woolley', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98290', 'Snohomish', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98292', 'Stanwood', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98294', 'Sultan', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98295', 'Sumas', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98296', 'Snohomish', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98303', 'Anderson Island', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98304', 'Ashford', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98305', 'Beaver', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98310', 'Bremerton', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98311', 'Bremerton', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98312', 'Bremerton', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98315', 'Silverdale', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98320', 'Brinnon', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98321', 'Buckley', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98323', 'Carbonado', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98325', 'Chimacum', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98326', 'Clallam Bay', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98327', 'Dupont', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98328', 'Eatonville', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98329', 'Gig Harbor', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98330', 'Elbe', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98331', 'Forks', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98332', 'Gig Harbor', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98333', 'Fox Island', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98335', 'Gig Harbor', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98336', 'Glenoma', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98337', 'Bremerton', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98338', 'Graham', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98339', 'Port Hadlock', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98340', 'Hansville', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98342', 'Indianola', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98346', 'Kingston', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98349', 'Lakebay', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98351', 'Longbranch', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98354', 'Milton', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98355', 'Mineral', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98356', 'Morton', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98358', 'Nordland', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98359', 'Olalla', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98360', 'Orting', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98361', 'Packwood', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98362', 'Port Angeles', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98363', 'Port Angeles', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98365', 'Port Ludlow', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98366', 'Port Orchard', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98367', 'Port Orchard', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98368', 'Port Townsend', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98370', 'Poulsbo', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98371', 'Puyallup', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98372', 'Puyallup', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98373', 'Puyallup', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98374', 'Puyallup', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98375', 'Puyallup', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98376', 'Quilcene', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98377', 'Randle', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98380', 'Seabeck', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98381', 'Sekiu', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98382', 'Sequim', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98383', 'Silverdale', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98387', 'Spanaway', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98388', 'Steilacoom', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98390', 'Sumner', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98392', 'Suquamish', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98394', 'Vaughn', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98402', 'Tacoma', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98403', 'Tacoma', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98404', 'Tacoma', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98405', 'Tacoma', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98406', 'Tacoma', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98407', 'Tacoma', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98408', 'Tacoma', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98409', 'Tacoma', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98413', 'Tacoma', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98418', 'Tacoma', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98421', 'Tacoma', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98422', 'Tacoma', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98424', 'Tacoma', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98433', 'Tacoma', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98439', 'Lakewood', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98443', 'Tacoma', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98444', 'Tacoma', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98445', 'Tacoma', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98446', 'Tacoma', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98465', 'Tacoma', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98466', 'Tacoma', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98467', 'University Place', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98498', 'Lakewood', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98499', 'Lakewood', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98501', 'Olympia', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98502', 'Olympia', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98503', 'Lacey', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98506', 'Olympia', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98512', 'Olympia', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98513', 'Olympia', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98516', 'Olympia', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98520', 'Aberdeen', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98524', 'Allyn', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98526', 'Amanda Park', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98528', 'Belfair', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98531', 'Centralia', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98532', 'Chehalis', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98533', 'Cinebar', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98535', 'Copalis Beach', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98536', 'Copalis Crossing', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98537', 'Cosmopolis', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98538', 'Curtis', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98541', 'Elma', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98542', 'Ethel', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98546', 'Grapeview', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98547', 'Grayland', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98548', 'Hoodsport', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98550', 'Hoquiam', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98552', 'Humptulips', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98555', 'Lilliwaup', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98557', 'McCleary', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98560', 'Matlock', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98563', 'Montesano', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98564', 'Mossyrock', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98568', 'Oakville', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98569', 'Ocean Shores', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98570', 'Onalaska', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98572', 'Pe Ell', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98575', 'Quinault', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98576', 'Rainier', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98577', 'Raymond', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98579', 'Rochester', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98580', 'Roy', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98581', 'Ryderwood', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98582', 'Salkum', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98584', 'Shelton', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98585', 'Silver Creek', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98586', 'South Bend', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98588', 'Tahuya', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98589', 'Tenino', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98590', 'Tokeland', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98591', 'Toledo', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98592', 'Union', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98593', 'Vader', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98595', 'Westport', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98596', 'Winlock', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98597', 'Yelm', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98601', 'Amboy', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98602', 'Appleton', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98603', 'Ariel', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98604', 'Battle Ground', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98605', 'Bingen', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98606', 'Brush Prairie', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98607', 'Camas', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98609', 'Carrolls', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98610', 'Carson', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98611', 'Castle Rock', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98612', 'Cathlamet', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98613', 'Centerville', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98616', 'Cougar', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98619', 'Glenwood', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98620', 'Goldendale', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98621', 'Grays River', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98624', 'Ilwaco', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98625', 'Kalama', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98626', 'Kelso', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98628', 'Klickitat', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98629', 'La Center', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98631', 'Long Beach', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98632', 'Longview', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98635', 'Lyle', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98638', 'Naselle', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98640', 'Ocean Park', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98642', 'Ridgefield', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98643', 'Rosburg', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98645', 'Silverlake', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98647', 'Skamokawa', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98648', 'Stevenson', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98649', 'Toutle', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98650', 'Trout Lake', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98651', 'Underwood', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98660', 'Vancouver', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98661', 'Vancouver', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98662', 'Vancouver', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98663', 'Vancouver', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98664', 'Vancouver', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98665', 'Vancouver', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98670', 'Wahkiacus', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98671', 'Washougal', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98672', 'White Salmon', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98674', 'Woodland', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98675', 'Yacolt', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98682', 'Vancouver', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98683', 'Vancouver', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98684', 'Vancouver', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98685', 'Vancouver', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98686', 'Vancouver', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98801', 'Wenatchee', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98802', 'East Wenatchee', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98812', 'Brewster', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98813', 'Bridgeport', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98814', 'Carlton', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98815', 'Cashmere', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98816', 'Chelan', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98822', 'Entiat', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98823', 'Ephrata', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98826', 'Leavenworth', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98827', 'Loomis', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98828', 'Malaga', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98830', 'Mansfield', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98831', 'Manson', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98832', 'Marlin', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98833', 'Mazama', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98834', 'Methow', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98837', 'Moses Lake', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98840', 'Okanogan', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98841', 'Omak', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98843', 'Orondo', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98844', 'Oroville', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98845', 'Palisades', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98846', 'Pateros', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98847', 'Peshastin', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98848', 'Quincy', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98849', 'Riverside', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98850', 'Rock Island', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98851', 'Soap Lake', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98855', 'Tonasket', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98856', 'Twisp', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98857', 'Warden', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98858', 'Waterville', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98859', 'Wauconda', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98862', 'Winthrop', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98901', 'Yakima', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98902', 'Yakima', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98903', 'Yakima', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98908', 'Yakima', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98922', 'Cle Elum', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98923', 'Cowiche', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98926', 'Ellensburg', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98929', 'Goose Prairie', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98930', 'Grandview', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98932', 'Granger', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98933', 'Harrah', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98935', 'Mabton', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98936', 'Moxee', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98937', 'Naches', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98938', 'Outlook', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98942', 'Selah', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98944', 'Sunnyside', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98946', 'Thorp', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98947', 'Tieton', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98948', 'Toppenish', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98951', 'Wapato', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98952', 'White Swan', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('98953', 'Zillah', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('99001', 'Airway Heights', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('99003', 'Chattaroy', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('99004', 'Cheney', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('99005', 'Colbert', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('99006', 'Deer Park', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('99008', 'Edwall', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('99009', 'Elk', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('99011', 'Fairchild AFB', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('99012', 'Fairfield', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('99013', 'Ford', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('99015', 'Freeman', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('99016', 'Greenacres', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('99017', 'Lamont', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('99018', 'Latah', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('99019', 'Liberty Lake', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('99021', 'Mead', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('99022', 'Medical Lake', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('99023', 'Mica', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('99025', 'Newman Lake', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('99026', 'Nine Mile Falls', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('99027', 'Otis Orchards', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('99029', 'Reardan', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('99030', 'Rockford', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('99031', 'Spangle', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('99032', 'Sprague', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('99033', 'Tekoa', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('99034', 'Tumtum', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('99036', 'Valleyford', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('99037', 'Veradale', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('99040', 'Wellpinit', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('99101', 'Addy', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('99103', 'Almira', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('99105', 'Benge', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('99107', 'Boyds', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('99109', 'Chewelah', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('99110', 'Clayton', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('99111', 'Colfax', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('99113', 'Colton', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('99114', 'Colville', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('99115', 'Coulee City', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('99116', 'Coulee Dam', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('99117', 'Creston', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('99118', 'Curlew', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('99119', 'Cusick', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('99121', 'Danville', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('99122', 'Davenport', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('99123', 'Electric City', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('99125', 'Endicott', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('99126', 'Evans', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('99127', 'Saint John', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('99128', 'Farmington', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('99129', 'Fruitland', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('99130', 'Garfield', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('99131', 'Gifford', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('99133', 'Grand Coulee', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('99134', 'Harrington', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('99135', 'Hartline', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('99136', 'Hay', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('99137', 'Hunters', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('99138', 'Inchelium', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('99139', 'Ione', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('99140', 'Keller', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('99141', 'Kettle Falls', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('99143', 'Lacrosse', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('99144', 'Lamona', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('99147', 'Lincoln', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('99148', 'Loon Lake', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('99150', 'Malo', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('99153', 'Metaline Falls', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('99154', 'Mohler', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('99156', 'Newport', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('99157', 'Northport', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('99158', 'Oakesdale', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('99159', 'Odessa', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('99160', 'Orient', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('99161', 'Palouse', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('99163', 'Pullman', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('99166', 'Republic', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('99167', 'Rice', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('99169', 'Ritzville', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('99170', 'Rosalia', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('99171', 'Saint John', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('99173', 'Springdale', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('99176', 'Thornton', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('99179', 'Uniontown', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('99180', 'Usk', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('99181', 'Valley', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('99185', 'Wilbur', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('99201', 'Spokane', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('99202', 'Spokane', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('99203', 'Spokane', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('99204', 'Spokane', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('99205', 'Spokane', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('99206', 'Spokane', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('99207', 'Spokane', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('99208', 'Spokane', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('99212', 'Spokane', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('99216', 'Spokane', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('99217', 'Spokane', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('99218', 'Spokane', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('99223', 'Spokane', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('99224', 'Spokane', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('99301', 'Pasco', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('99320', 'Benton City', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('99321', 'Beverly', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('99322', 'Bickleton', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('99323', 'Burbank', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('99324', 'College Place', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('99326', 'Connell', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('99327', 'Cunningham', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('99328', 'Dayton', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('99330', 'Eltopia', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('99336', 'Kennewick', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('99337', 'Kennewick', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('99338', 'Kennewick', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('99341', 'Lind', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('99343', 'Mesa', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('99344', 'Othello', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('99347', 'Pomeroy', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('99348', 'Prescott', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('99349', 'Mattawa', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('99350', 'Prosser', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('99352', 'Richland', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('99353', 'West Richland', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('99354', 'Richland', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('99356', 'Roosevelt', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('99357', 'Royal City', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('99360', 'Touchet', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('99361', 'Waitsburg', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('99362', 'Walla Walla', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('99371', 'Washtucna', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('99401', 'Anatone', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('99402', 'Asotin', 'WA');
INSERT INTO WAZips
  (ZIP, City, State)
  VALUES ('99403', 'Clarkston', 'WA');

USE BowlingLeagueModify;
GO

CREATE PROCEDURE CH15_Calc_Bowler_Pins_Avg_Hcp
AS 
UPDATE    Bowlers
SET              BowlerTotalPins =
                          (SELECT     SUM(RawScore)
                            FROM          Bowler_Scores
                            WHERE      Bowler_Scores.BowlerID = Bowlers.BowlerID), BowlerGamesBowled =
                          (SELECT     COUNT(Bowler_Scores.RawScore)
                            FROM          Bowler_Scores
                            WHERE      Bowler_Scores.BowlerID = Bowlers.BowlerID), BowlerCurrentAverage =
                          IsNull((SELECT     Round(AVG(Bowler_Scores.RawScore), 0)
                            FROM          Bowler_Scores
                            WHERE      Bowler_Scores.BowlerID = Bowlers.BowlerID), 0), BowlerCurrentHcp =
                          IsNull((SELECT     Round(0.9 * (200 - Round(AVG(Bowler_Scores.RawScore), 0)), 0)
                            FROM          Bowler_Scores
                            WHERE      Bowler_Scores.BowlerID = Bowlers.BowlerID), 0);
GO

CREATE VIEW CH15_Calc_Bowler_Pins_Avg_Hcp_Query
AS 
SELECT Bowlers.BowlerTotalPins, 
                          (SELECT     SUM(RawScore)
                            FROM          Bowler_Scores
                            WHERE      Bowler_Scores.BowlerID = Bowlers.BowlerID) 
AS NewBowlerTotalPins, Bowlers.BowlerGamesBowled, 
                          (SELECT     COUNT(Bowler_Scores.RawScore)
                            FROM          Bowler_Scores
                            WHERE      Bowler_Scores.BowlerID = Bowlers.BowlerID) 
AS NewBowlerGamesBowled, Bowlers.BowlerCurrentAverage, 
                          IsNull((SELECT     Round(AVG(Bowler_Scores.RawScore), 0)
                            FROM          Bowler_Scores
                            WHERE      Bowler_Scores.BowlerID = Bowlers.BowlerID), 0) 
AS NewBowlerCurrentAverage, Bowlers.BowlerCurrentHcp, 
                          IsNull((SELECT     Round(0.9 * (200 - Round(AVG(Bowler_Scores.RawScore), 0)), 0)
                            FROM          Bowler_Scores
                            WHERE      Bowler_Scores.BowlerID = Bowlers.BowlerID), 0) 
AS NewBowlerCurrentHcp
FROM Bowlers;
GO

CREATE PROCEDURE CH15_Change_Huckleberry_Name
AS 
UPDATE    Teams
SET              TeamName = 'Manta Rays'
WHERE     (TeamName = 'Huckleberrys');
GO

CREATE VIEW CH15_Change_Huckleberry_Name_Query
AS 
SELECT Teams.TeamName, 'Manta Rays' AS NewTeamName
FROM Teams
WHERE Teams.TeamName = 'Huckleberrys';
GO

CREATE PROCEDURE CH15_Change_Tourney_Location
AS 
UPDATE    Tournaments
SET              TourneyLocation = 'Oasis Lanes'
WHERE     (TourneyLocation = 'Sports World Lanes');
GO

CREATE VIEW CH15_Change_Tourney_Location_Query
AS 
SELECT Tournaments.TourneyID, Tournaments.TourneyLocation, 'Oasis Lanes' AS NewTourneyLocation
FROM Tournaments
WHERE (Tournaments.TourneyLocation = 'Sports World Lanes');
GO

CREATE PROCEDURE CH15_Update_Bowler_City_State
AS 
UPDATE    Bowlers
SET              BowlerCity =
                          (SELECT     City
                            FROM          WAZips
                            WHERE      Bowlers.BowlerZip = WAZips.ZIP), BowlerState =
                          (SELECT     State
                            FROM          WAZips
                            WHERE      Bowlers.BowlerZip = WAZips.ZIP)
WHERE     (BowlerCity <>
                          (SELECT     City
                            FROM          WAZips
                            WHERE      Bowlers.BowlerZip = WAZips.ZIP)) OR
                      (BowlerState <>
                          (SELECT     State
                            FROM          WAZips
                            WHERE      Bowlers.BowlerZip = WAZips.ZIP));
GO

CREATE VIEW CH15_Update_Bowler_City_State_Query
AS 
SELECT Bowlers.BowlerCity, 
                          (SELECT     City
                            FROM          WAZips
                            WHERE      Bowlers.BowlerZip = WAZips.ZIP) AS NewBowlerCity, Bowlers.BowlerState, 
                          (SELECT     State
                            FROM          WAZips
                            WHERE      Bowlers.BowlerZip = WAZips.ZIP) AS NewBowlerState
FROM Bowlers
WHERE     (BowlerCity <>
                          (SELECT     City
                            FROM          WAZips
                            WHERE      Bowlers.BowlerZip = WAZips.ZIP)) OR
                      (BowlerState <>
                          (SELECT     State
                            FROM          WAZips
                            WHERE      Bowlers.BowlerZip = WAZips.ZIP));
GO

CREATE PROCEDURE CH16_Add_Bowler
AS 
INSERT INTO Bowlers
                      (BowlerLastName, BowlerFirstName, BowlerAddress, BowlerCity, BowlerState, BowlerZip, BowlerPhoneNumber, TeamID, BowlerTotalPins, 
                      BowlerGamesBowled, BowlerCurrentAverage, BowlerCurrentHcp)
SELECT     BowlerLastName, 'Matthew' AS BowlerFirstName, BowlerAddress, BowlerCity, BowlerState, BowlerZip, BowlerPhoneNumber, TeamID, 0 AS BowlerTotalPins, 0 AS BowlerGamesBowled, 0 AS BolwerCurrentAverage, 0 AS BowlerCurrentHcp
FROM         Bowlers
WHERE     (BowlerLastName = 'Patterson') AND (BowlerFirstName = 'Neil');
GO

CREATE VIEW CH16_Add_Bowler_Query
AS 
SELECT Bowlers.BowlerLastName, 'Matthew' AS BowlerFirstName, Bowlers.BowlerAddress, Bowlers.BowlerCity, Bowlers.BowlerState, Bowlers.BowlerZip, Bowlers.BowlerPhoneNumber, Bowlers.TeamID, 0 AS BowlerTotalPins, 0 AS BowlerGamesBowled, 0 AS BowlerCurrentAverage, 0 AS BowlerCurrentHcp
FROM Bowlers
WHERE (((Bowlers.BowlerLastName)='Patterson') AND ((Bowlers.BowlerFirstName)='Neil'));
GO

CREATE PROCEDURE CH16_Add_Team
AS 
INSERT INTO Teams
                      (TeamName, CaptainID)
VALUES     ('Aardvarks', NULL);
GO

CREATE VIEW CH16_Add_Team_Query
AS
SELECT 'Aardvarks' As TeamName, Null As CaptainID
FROM Teams
WHERE TeamID = 1;
GO

CREATE PROCEDURE CH16_Archive_2012_Tournaments_1
AS 
INSERT INTO Tournaments_Archive
SELECT     TourneyID, TourneyDate, TourneyLocation
FROM         Tournaments
WHERE     (TourneyDate BETWEEN '1/1/2012' AND '12/31/2012');
GO

CREATE VIEW CH16_Archive_2012_Tournaments_1_Query
AS 
SELECT     TourneyID, TourneyDate, TourneyLocation
FROM         Tournaments
WHERE     (TourneyDate BETWEEN '1/1/2012' AND '12/31/2012');
GO

CREATE PROCEDURE CH16_Archive_2012_Tournaments_2
AS 
INSERT INTO Tourney_Matches_Archive
SELECT     MatchID, TourneyID, Lanes, OddLaneTeamID, EvenLaneTeamID
FROM         Tourney_Matches
WHERE     (TourneyID IN
                          (SELECT     TourneyID
                            FROM          Tournaments
                            WHERE      TourneyDate BETWEEN '1/1/2012' AND '12/31/2012'));
GO

CREATE VIEW CH16_Archive_2012_Tournaments_2_Query
AS 
SELECT     MatchID, TourneyID, Lanes, OddLaneTeamID, EvenLaneTeamID
FROM         Tourney_Matches
WHERE     (TourneyID IN
                          (SELECT     TourneyID
                            FROM          Tournaments
                            WHERE      TourneyDate BETWEEN '1/1/2012' AND '12/31/2012'));
GO

CREATE PROCEDURE CH16_Archive_2012_Tournaments_3
AS 
INSERT INTO Match_Games_Archive
SELECT     MatchID, GameNumber, NULL AS WinTeam
FROM         Match_Games
WHERE     (MatchID IN
                          (SELECT     Tourney_Matches.MatchID
                            FROM          Tourney_Matches INNER JOIN
                                                   Tournaments ON Tournaments.TourneyID = Tourney_Matches.TourneyID
                            WHERE      Tournaments.TourneyDate BETWEEN '1/1/2012' AND '12/31/2012'));
GO

CREATE VIEW CH16_Archive_2012_Tournaments_3_Query
AS 
SELECT     MatchID, GameNumber, NULL AS WinTeam
FROM         Match_Games
WHERE     (MatchID IN
                          (SELECT     Tourney_Matches.MatchID
                            FROM          Tourney_Matches INNER JOIN
                                                   Tournaments ON Tournaments.TourneyID = Tourney_Matches.TourneyID
                            WHERE      Tournaments.TourneyDate BETWEEN '1/1/2012' AND '12/31/2012'));
GO

CREATE PROCEDURE CH16_Archive_2012_Tournaments_4
AS 
INSERT INTO Bowler_Scores_Archive
SELECT     MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, WonGame
FROM         Bowler_Scores
WHERE     (MatchID IN
                          (SELECT     Tourney_Matches.MatchID
                            FROM          Tourney_Matches INNER JOIN
                                                   Tournaments ON Tournaments.TourneyID = Tourney_Matches.TourneyID
                            WHERE      Tournaments.TourneyDate BETWEEN '1/1/2012' AND '12/31/2012'));
GO

CREATE VIEW CH16_Archive_2012_Tournaments_4_Query
AS 
SELECT     MatchID, GameNumber, BowlerID, RawScore, HandiCapScore, WonGame
FROM         Bowler_Scores
WHERE     (MatchID IN
                          (SELECT     Tourney_Matches.MatchID
                            FROM          Tourney_Matches INNER JOIN
                                                   Tournaments ON Tournaments.TourneyID = Tourney_Matches.TourneyID
                            WHERE      Tournaments.TourneyDate BETWEEN '1/1/2012' AND '12/31/2012'));
GO

CREATE PROCEDURE CH16_Copy_2012_Tournaments_1
AS 
INSERT INTO Tournaments
                      (TourneyID, TourneyDate, TourneyLocation)
SELECT     TourneyID + 25 AS Expr1, DateAdd(d, 728, TourneyDate) AS Expr2, TourneyLocation
FROM         Tournaments
WHERE     (TourneyDate BETWEEN '1/1/2012' AND '12/31/2012');
GO

CREATE VIEW CH16_Copy_2012_Tournaments_1_Query
AS 
SELECT     TourneyID + 25 AS Expr1, DateAdd(d, 728, TourneyDate) AS Expr2, TourneyLocation
FROM         Tournaments
WHERE     (TourneyDate BETWEEN '1/1/2012' AND '12/31/2012');
GO

CREATE PROCEDURE CH16_Copy_2012_Tournaments_2
AS 
INSERT INTO Tourney_Matches
                      (TourneyID, Lanes, OddLaneTeamID, EvenLaneTeamID)
SELECT     TourneyID + 25 AS NewTourneyID, Lanes, OddLaneTeamID, EvenLaneTeamID
FROM         Tourney_Matches;
GO

CREATE VIEW CH16_Copy_2012_Tournaments_2_Query
AS 
SELECT     MatchID, TourneyID + 25 AS NewTourneyID, Lanes, OddLaneTeamID, EvenLaneTeamID
FROM         Tourney_Matches;
GO

CREATE PROCEDURE CH17_Delete_Archived_2012_Tournaments_1
AS 
DELETE FROM Bowler_Scores
WHERE     (MatchID IN
                          (SELECT     Tourney_Matches_Archive.MatchID
                            FROM          Tourney_Matches_Archive));
GO

CREATE VIEW CH17_Delete_Archived_2012_Tournaments_1_Query
AS 
SELECT * FROM Bowler_Scores
WHERE     (MatchID IN
                          (SELECT     Tourney_Matches_Archive.MatchID
                            FROM          Tourney_Matches_Archive));
GO

CREATE PROCEDURE CH17_Delete_Archived_2012_Tournaments_1_WRONG
AS 
DELETE FROM Bowler_Scores
WHERE     (MatchID IN
                          (SELECT     Tourney_Matches.MatchID
                            FROM          Tourney_Matches INNER JOIN
                                                   Tournaments ON Tournaments.TourneyID = Tourney_Matches.TourneyID
                            WHERE      Tournaments.TourneyDate BETWEEN '1/1/2012' AND '12/31/2012'));
GO

CREATE VIEW CH17_Delete_Archived_2012_Tournaments_1_WRONG_Query
AS 
SELECT * FROM Bowler_Scores
WHERE     (MatchID IN
                          (SELECT     Tourney_Matches.MatchID
                            FROM          Tourney_Matches INNER JOIN
                                                   Tournaments ON Tournaments.TourneyID = Tourney_Matches.TourneyID
                            WHERE      Tournaments.TourneyDate BETWEEN '1/1/2012' AND '12/31/2012'));
GO

CREATE PROCEDURE CH17_Delete_Archived_2012_Tournaments_2
AS 
DELETE FROM Match_Games
WHERE     (MatchID IN
                          (SELECT     Tourney_Matches_Archive.MatchID
                            FROM          Tourney_Matches_Archive));
GO

CREATE VIEW CH17_Delete_Archived_2012_Tournaments_2_Query
AS 
SELECT * FROM Match_Games
WHERE     (MatchID IN
                          (SELECT     Tourney_Matches_Archive.MatchID
                            FROM          Tourney_Matches_Archive));
GO

CREATE PROCEDURE CH17_Delete_Archived_2012_Tournaments_3
AS 
DELETE FROM Tourney_Matches
WHERE     (MatchID IN
                          (SELECT     MatchID
                            FROM          Tourney_Matches_Archive));
GO

CREATE VIEW CH17_Delete_Archived_2012_Tournaments_3_Query
AS 
SELECT * FROM Tourney_Matches
WHERE     (MatchID IN
                          (SELECT     MatchID
                            FROM          Tourney_Matches_Archive));
GO

CREATE PROCEDURE CH17_Delete_Archived_2012_Tournaments_4
AS 
DELETE FROM Tournaments
WHERE     (TourneyID IN
                          (SELECT     Tournaments_Archive.TourneyID
                            FROM          Tournaments_Archive));
GO

CREATE VIEW CH17_Delete_Archived_2012_Tournaments_4_Query
AS 
SELECT * FROM Tournaments
WHERE     (TourneyID IN
                          (SELECT     Tournaments_Archive.TourneyID
                            FROM          Tournaments_Archive));
GO

CREATE PROCEDURE CH17_Delete_Bowlers_No_Games
AS 
DELETE FROM Bowlers
WHERE     (BowlerGamesBowled = 0);
GO

CREATE VIEW CH17_Delete_Bowlers_No_Games_Query
AS 
SELECT * FROM Bowlers
WHERE     (BowlerGamesBowled = 0);
GO

CREATE PROCEDURE CH17_Delete_Bowlers_No_Games_Safe
AS 
DELETE FROM dbo.Bowlers
WHERE     (BowlerID NOT IN
                          (SELECT     BowlerID
                            FROM          Bowler_Scores));
GO

CREATE VIEW CH17_Delete_Bowlers_No_Games_Safe_Query
AS 
SELECT * FROM dbo.Bowlers
WHERE     (BowlerID NOT IN
                          (SELECT     BowlerID
                            FROM          Bowler_Scores));
GO

CREATE PROCEDURE CH17_Delete_Matches_Not_Played
AS 
DELETE FROM Tourney_Matches
WHERE     (MatchID NOT IN
                          (SELECT     MatchID
                            FROM          Bowler_Scores));
GO

CREATE VIEW CH17_Delete_Matches_Not_Played_Query
AS 
SELECT * FROM Tourney_Matches
WHERE     (MatchID NOT IN
                          (SELECT     MatchID
                            FROM          Bowler_Scores));
GO

CREATE PROCEDURE CH17_Delete_Teams_No_Bowlers
AS 
DELETE FROM Teams
WHERE     (TeamID NOT IN
                          (SELECT     TeamID
                            FROM          Bowlers));
GO

CREATE VIEW CH17_Delete_Teams_No_Bowlers_Query
AS 
SELECT * FROM Teams
WHERE     (TeamID NOT IN
                          (SELECT     TeamID
                            FROM          Bowlers));
GO


Use BowlingLeagueExample;
GO

CREATE VIEW CH04_Bowler_Names_Addresses
AS
SELECT     TOP 100 PERCENT BowlerLastName, BowlerFirstName, BowlerAddress, BowlerCity, BowlerState, BowlerZip
FROM         Bowlers
ORDER BY BowlerLastName, BowlerFirstName;
GO

CREATE VIEW CH04_Bowler_Score_Information
AS
SELECT     Bowler_Scores.*
FROM         Bowler_Scores;
GO

CREATE VIEW CH04_Team_List
AS
SELECT     TOP 100 PERCENT TeamName
FROM         Teams
ORDER BY TeamName;
GO

CREATE VIEW CH04_Tourney_Dates
AS
SELECT     TOP 100 PERCENT TourneyDate, TourneyLocation
FROM         Tournaments
ORDER BY TourneyDate DESC, TourneyLocation;
GO

CREATE VIEW CH04_Tourney_Locations
AS
SELECT DISTINCT TourneyLocation
FROM         Tournaments;
GO

CREATE VIEW CH05_Handicap_vs_RawScore
AS
SELECT     TOP 100 PERCENT BowlerID, MatchID, GameNumber, HandiCapScore, RawScore, HandiCapScore - RawScore AS PointDifference
FROM         Bowler_Scores
ORDER BY BowlerID, MatchID, GameNumber;
GO

CREATE VIEW CH05_Names_Address_For_Mailing
AS
SELECT     TOP 100 PERCENT BowlerFirstName + ' ' + BowlerLastName AS FullName, BowlerAddress, 
                      BowlerCity + ', ' + BowlerState + '  ' + BowlerZip AS CityStateZip, BowlerZip
FROM         Bowlers
ORDER BY BowlerZip;
GO

CREATE VIEW CH05_Next_Years_Tourney_Dates
AS
SELECT     TOP 100 PERCENT TourneyLocation, TourneyDate, DateAdd(d, 364, TourneyDate) AS NextYearTourneyDate
FROM         Tournaments
ORDER BY TourneyLocation;
GO

CREATE VIEW CH05_Phone_List
AS
SELECT     TOP 100 PERCENT BowlerLastName + ', ' + BowlerFirstName AS Bowler, BowlerPhoneNumber AS Phone
FROM         Bowlers
ORDER BY Bowler;
GO

CREATE VIEW CH05_Team_Lineups
AS
SELECT     TOP 100 PERCENT TeamID, BowlerLastName + ', ' + BowlerFirstName AS Bowler
FROM         Bowlers
ORDER BY TeamID, Bowler;
GO

CREATE VIEW CH06_Eastside_Bowlers_On_Teams_5_Through_8
AS
SELECT     TOP 100 PERCENT BowlerFirstName, BowlerLastName, BowlerCity, TeamID
FROM         Bowlers
WHERE     (BowlerCity IN ('Bellevue', 'Bothell', 'Duvall', 'Redmond', 'Woodinville')) AND (TeamID BETWEEN 5 AND 8)
ORDER BY BowlerCity, BowlerLastName;
GO

CREATE VIEW CH06_Eastside_Tournaments
AS
SELECT     TOP 100 PERCENT TourneyLocation, TourneyDate
FROM         Tournaments
WHERE     (TourneyLocation IN ('Red Rooster Lanes', 'Thunderbird Lanes', 'Bolero Lanes'))
ORDER BY TourneyLocation, TourneyDate;
GO

CREATE VIEW CH06_Game3_Top_Ten_Matches
AS
SELECT     WinningTeamID, MatchID, GameNumber
FROM         Match_Games
WHERE     (MatchID <= 10) AND (GameNumber = 3);
GO

CREATE VIEW CH06_H_Bowlers_Teams_3_Through_5
AS
SELECT     BowlerFirstName, BowlerLastName, TeamID
FROM         Bowlers
WHERE     (BowlerLastName LIKE 'H%') AND (TeamID IN (3, 4, 5));
GO

CREATE VIEW CH06_September_2012_Tournament_Schedule
AS
SELECT     TourneyDate, TourneyLocation
FROM         Tournaments
WHERE     (TourneyDate BETWEEN '9/1/2012' AND '9/30/2012');
GO

CREATE VIEW CH08_Bowler_Game_Scores
AS
SELECT     Bowler_Scores.MatchID, Teams.TeamName, Bowlers.BowlerFirstName + ' ' + Bowlers.BowlerLastName AS BowlerFullName, 
                      Bowler_Scores.GameNumber, Bowler_Scores.RawScore
FROM         Teams INNER JOIN
                      Bowlers ON Teams.TeamID = Bowlers.TeamID INNER JOIN
                      Bowler_Scores ON Bowlers.BowlerID = Bowler_Scores.BowlerID;
GO

CREATE VIEW CH08_Bowlers_Same_ZipCode
AS
SELECT     Bowlers.BowlerLastName + ', ' + Bowlers.BowlerFirstName AS FirstBowler, Bowlers.BowlerZip, 
                      Bowlers2.BowlerLastName + ', ' + Bowlers2.BowlerFirstName AS SecondBowler
FROM         Bowlers INNER JOIN
                      Bowlers Bowlers2 
             ON Bowlers.BowlerID <> Bowlers2.BowlerID 
                AND Bowlers.BowlerZip = Bowlers2.BowlerZip;
GO

CREATE VIEW CH08_Good_Bowlers_TBird_And_Bolero
AS
SELECT     BowlerTbird.BowlerFullName
FROM         (SELECT DISTINCT Bowlers.BowlerID, (Bowlers.BowlerLastName + ', ' + Bowlers.BowlerFirstName) AS BowlerFullName
                       FROM          ((Bowlers INNER JOIN
                                              Bowler_Scores ON Bowlers.BowlerID = Bowler_Scores.BowlerID) INNER JOIN
                                              Tourney_Matches ON Tourney_Matches.MatchID = Bowler_Scores.MatchID) INNER JOIN
                                              Tournaments ON Tournaments.TourneyID = Tourney_Matches.TourneyID
                       WHERE      Tournaments.TourneyLocation = 'Thunderbird Lanes' AND Bowler_Scores.RawScore >= 170) BowlerTbird INNER JOIN
                          (SELECT DISTINCT Bowlers.BowlerID, (Bowlers.BowlerLastName + ', ' + Bowlers.BowlerFirstName) AS BowlerFullName
                            FROM          ((Bowlers INNER JOIN
                                                   Bowler_Scores ON Bowlers.BowlerID = Bowler_Scores.BowlerID) INNER JOIN
                                                   Tourney_Matches ON Tourney_Matches.MatchID = Bowler_Scores.MatchID) INNER JOIN
                                                   Tournaments ON Tournaments.TourneyID = Tourney_Matches.TourneyID
                            WHERE      Tournaments.TourneyLocation = 'Bolero Lanes' AND Bowler_Scores.RawScore >= 170) BowlerBolero ON 
                      BowlerTbird.BowlerID = BowlerBolero.BowlerID;
GO

CREATE VIEW CH08_Teams_And_Bowlers
AS
SELECT     Teams.TeamName, Bowlers.BowlerLastName + ', ' + Bowlers.BowlerFirstName AS BowlerFullName
FROM         Teams INNER JOIN
                      Bowlers ON Teams.TeamID = Bowlers.TeamID;
GO

CREATE VIEW CH08_Teams_And_Captains
AS
SELECT     Teams.TeamName, Bowlers.BowlerLastName + ', ' + Bowlers.BowlerFirstName AS CaptainName
FROM         Teams INNER JOIN
                      Bowlers ON Teams.CaptainID = Bowlers.BowlerID;
GO

CREATE VIEW CH08_Tournament_Match_Game_Results
AS
SELECT   Tournaments.TourneyID AS Tourney, Tournaments.TourneyLocation AS Location, Tourney_Matches.MatchID, Tourney_Matches.Lanes, OddTeam.TeamName AS OddLaneTeam, EvenTeam.TeamName AS EvenLaneTeam, Match_Games.GameNumber AS GameNo, Winner.TeamName AS Winner
FROM       ((((Tournaments INNER JOIN 
            Tourney_Matches ON Tournaments.TourneyID = Tourney_Matches.TourneyID) INNER JOIN 
            Teams AS OddTeam ON OddTeam.TeamID = Tourney_Matches.OddLaneTeamID) INNER JOIN 
            Teams AS EvenTeam ON EvenTeam.TeamID = Tourney_Matches.EvenLaneTeamID) INNER JOIN 
            Match_Games ON Match_Games.MatchID = Tourney_Matches.MatchID) INNER JOIN 
            Teams AS Winner ON Winner.TeamID = Match_Games.WinningTeamID;
GO

CREATE VIEW CH09_All_Bowlers_And_Scores_Over_180
AS
SELECT     TOP 100 PERCENT Bowlers.BowlerLastName + ', ' + Bowlers.BowlerFirstName AS BowlerName, TI.TourneyDate, TI.TourneyLocation, 
                      TI.MatchID, TI.RawScore
FROM         Bowlers LEFT OUTER JOIN
                          (SELECT     Tournaments.TourneyDate, Tournaments.TourneyLocation, Bowler_Scores.MatchID, Bowler_Scores.BowlerID, 
                                                   Bowler_Scores.RawScore
                            FROM          (Bowler_Scores INNER JOIN
                                                   Tourney_Matches ON Bowler_Scores.MatchID = Tourney_Matches.MatchID) INNER JOIN
                                                   Tournaments ON Tournaments.TourneyID = Tourney_Matches.TourneyID
                            WHERE      Bowler_Scores.RawScore > 180) TI ON Bowlers.BowlerID = TI.BowlerID
ORDER BY Bowlers.BowlerLastName + ', ' + Bowlers.BowlerFirstName;
GO

CREATE VIEW CH09_All_Tourneys_Match_Results
AS
SELECT     TOP 100 PERCENT Tournaments.TourneyID, Tournaments.TourneyDate, Tournaments.TourneyLocation, TM.MatchID, TM.GameNumber, 
                      TM.Winner
FROM         Tournaments LEFT OUTER JOIN
                          (SELECT     Tourney_Matches.TourneyID, Tourney_Matches.MatchID, Match_Games.GameNumber, Teams.TeamName AS Winner
                            FROM          Tourney_Matches INNER JOIN
                                                   (Teams INNER JOIN
                                                   Match_Games ON Teams.TeamID = Match_Games.WinningTeamID) ON Tourney_Matches.MatchID = Match_Games.MatchID) TM ON 
                      Tournaments.TourneyID = TM.TourneyID
ORDER BY Tournaments.TourneyID;
GO

CREATE VIEW CH09_Matches_Not_Played_Yet
AS
SELECT     Tourney_Matches.MatchID, Tourney_Matches.TourneyID, Teams.TeamName AS OddLaneTeam, 
                      Teams_1.TeamName AS EvenLaneTeam
FROM         Teams Teams_1 INNER JOIN
                      Teams INNER JOIN
                      Tourney_Matches LEFT OUTER JOIN
                      Match_Games ON Tourney_Matches.MatchID = Match_Games.MatchID ON 
                      Teams.TeamID = Tourney_Matches.OddLaneTeamID ON Teams_1.TeamID = Tourney_Matches.EvenLaneTeamID
WHERE     (Match_Games.MatchID IS NULL);
GO

CREATE VIEW CH09_Tourney_Not_Yet_Played
AS
SELECT     Tournaments.TourneyID, Tournaments.TourneyDate, Tournaments.TourneyLocation
FROM         Tournaments LEFT OUTER JOIN
                      Tourney_Matches ON Tournaments.TourneyID = Tourney_Matches.TourneyID
WHERE     (Tourney_Matches.MatchID IS NULL);
GO

CREATE VIEW CH10_Bowling_Schedule
AS
SELECT     TOP 100 PERCENT Sched.*
FROM         (SELECT     Tournaments.TourneyLocation, Tournaments.TourneyDate, Tourney_Matches.MatchID, Teams.TeamName, 
                                              Bowlers.BowlerLastName + ', ' + Bowlers.BowlerFirstName AS Captain, 'Odd Lane' AS Lane
                       FROM          ((Tournaments INNER JOIN
                                              Tourney_Matches ON Tournaments.TourneyID = Tourney_Matches.TourneyID) INNER JOIN
                                              Teams ON Teams.TeamID = Tourney_Matches.OddLaneTeamID) INNER JOIN
                                              Bowlers ON Bowlers.BowlerID = Teams.CaptainID
                       UNION ALL
                       SELECT     Tournaments.TourneyLocation, Tournaments.TourneyDate, Tourney_Matches.MatchID, Teams.TeamName, 
                                             Bowlers.BowlerLastName + ', ' + Bowlers.BowlerFirstName AS Captain, 'Even Lane' AS Lane
                       FROM         ((Tournaments INNER JOIN
                                             Tourney_Matches ON Tournaments.TourneyID = Tourney_Matches.TourneyID) INNER JOIN
                                             Teams ON Teams.TeamID = Tourney_Matches.EvenLaneTeamID) INNER JOIN
                                             Bowlers ON Bowlers.BowlerID = Teams.CaptainID) Sched
ORDER BY 2, 3;
GO

CREATE VIEW CH10_Good_Bowlers_TBird_Bolero_UNION
AS
SELECT     Tournaments.TourneyLocation, Bowlers.BowlerLastName, Bowlers.BowlerFirstName, Bowler_Scores.RawScore
FROM         Bowlers INNER JOIN
                      ((Tournaments INNER JOIN
                      Tourney_Matches ON (Tournaments.TourneyID = Tourney_Matches.TourneyID)) INNER JOIN
                      Bowler_Scores ON (Tourney_Matches.MatchID = Bowler_Scores.MatchID)) ON (Bowlers.BowlerID = Bowler_Scores.BowlerID)
WHERE     Tournaments.TourneyLocation = 'Thunderbird Lanes' AND Bowler_Scores.RawScore > 165
UNION
SELECT     Tournaments.TourneyLocation, Bowlers.BowlerLastName, Bowlers.BowlerFirstName, Bowler_Scores.RawScore
FROM         Bowlers INNER JOIN
                      ((Tournaments INNER JOIN
                      Tourney_Matches ON (Tournaments.TourneyID = Tourney_Matches.TourneyID)) INNER JOIN
                      Bowler_Scores ON (Tourney_Matches.MatchID = Bowler_Scores.MatchID)) ON (Bowlers.BowlerID = Bowler_Scores.BowlerID)
WHERE     Tournaments.TourneyLocation = 'Bolero Lanes' AND Bowler_Scores.RawScore > 150;
GO

CREATE VIEW CH10_Good_Bowlers_TBird_Bolero_WHERE
AS
SELECT     Tournaments.TourneyLocation, Bowlers.BowlerLastName, Bowlers.BowlerFirstName, Bowler_Scores.RawScore
FROM         Tournaments INNER JOIN
                      Bowlers INNER JOIN
                      Tourney_Matches INNER JOIN
                      Bowler_Scores ON Tourney_Matches.MatchID = Bowler_Scores.MatchID ON Bowlers.BowlerID = Bowler_Scores.BowlerID ON 
                      Tournaments.TourneyID = Tourney_Matches.TourneyID
WHERE     (Tournaments.TourneyLocation = 'Thunderbird Lanes') AND (Bowler_Scores.RawScore > 165) OR
                      (Tournaments.TourneyLocation = 'Bolero Lanes') AND (Bowler_Scores.RawScore > 150);
GO

CREATE VIEW CH11_Bowler_High_Score
AS
SELECT     BowlerFirstName, BowlerLastName,
                          (SELECT     MAX(RawScore)
                            FROM          Bowler_Scores
                            WHERE      Bowler_Scores.BowlerID = Bowlers.BowlerID) AS HighScore
FROM         Bowlers;
GO

CREATE VIEW CH11_Bowlers_And_Count_Games
AS
SELECT     BowlerFirstName, BowlerLastName,
                          (SELECT     COUNT(*)
                            FROM          Bowler_Scores
                            WHERE      Bowler_Scores.BowlerID = Bowlers.BowlerID) AS Games
FROM         Bowlers;
GO

CREATE VIEW CH11_Bowlers_Low_Score
AS
SELECT DISTINCT Bowlers.BowlerID, Bowlers.BowlerFirstName, Bowlers.BowlerLastName, Bowler_Scores.RawScore
FROM         Bowlers INNER JOIN
                      Bowler_Scores ON Bowlers.BowlerID = Bowler_Scores.BowlerID
WHERE     (Bowler_Scores.RawScore < ALL
                          (SELECT     BS2.RawScore
                            FROM          Bowlers AS B2 INNER JOIN
                                                   Bowler_Scores AS BS2 ON B2.BowlerID = BS2.BowlerID
                            WHERE      B2.BowlerID <> Bowlers.BowlerID AND B2.TeamID = Bowlers.TeamID));
GO

CREATE VIEW CH11_Team_Captains_High_Score
AS
SELECT     Teams.TeamName, Bowlers.BowlerID, Bowlers.BowlerFirstName, Bowlers.BowlerLastName, 
                      Bowler_Scores.HandiCapScore
FROM         Bowlers INNER JOIN
                      Teams ON Bowlers.BowlerID = Teams.CaptainID INNER JOIN
                      Bowler_Scores ON Bowlers.BowlerID = Bowler_Scores.BowlerID
WHERE     (Bowler_Scores.HandiCapScore > ALL
                          (SELECT     BS2.HandiCapScore
                            FROM          Bowlers AS B2 INNER JOIN
                                                   Bowler_Scores AS BS2 ON B2.BowlerID = BS2.BowlerID
                            WHERE      B2.BowlerID <> Bowlers.BowlerID AND B2.TeamID = Bowlers.TeamID));
GO

CREATE VIEW CH12_Better_Than_Overall_Average
AS
SELECT     TOP 100 PERCENT BowlerLastName, BowlerFirstName
FROM         Bowlers
WHERE     ((SELECT     AVG(CAST(RawScore AS Float))
                         FROM         Bowler_Scores AS BS
                         WHERE     BS.BowlerID = Bowlers.BowlerID) >=
                          (SELECT     AVG(Cast(RawScore AS Float))
                            FROM          Bowler_Scores))
ORDER BY BowlerLastName, BowlerFirstName;
GO

CREATE VIEW CH12_Current_Highest_Handicap
AS
SELECT     MAX(Handicap) AS HighHandicap
FROM         (SELECT     ROUND((200 - ROUND
                                                  ((SELECT     AVG(Cast(RawScore AS Float))
                                                      FROM         Bowler_Scores
                                                      WHERE     Bowler_Scores.BowlerID = Bowlers.BowlerID), 0)) * 0.9, 0) AS Handicap
                       FROM          Bowlers) Q1;
GO

CREATE VIEW CH12_Last_Tourney_Date
AS
SELECT     MAX(TourneyDate) AS MostRecentDate
FROM         Tournaments;
GO

CREATE VIEW CH12_Number_Of_Tournaments_At_Red_Rooster_Lanes
AS
SELECT     COUNT(TourneyLocation) AS NumberOfTournaments
FROM         Tournaments
WHERE     (TourneyLocation = 'Red Rooster Lanes');
GO

CREATE VIEW CH12_Tourney_Locations_For_Earliest_Date
AS
SELECT     TourneyLocation
FROM         Tournaments
WHERE     (TourneyDate =
                          (SELECT     MIN(TourneyDate)
                            FROM          Tournaments));
GO

CREATE VIEW CH13_Bowler_Average_Handicap
AS
SELECT     Bowler_Scores.BowlerID, Bowlers.BowlerLastName, Bowlers.BowlerFirstName, SUM(Bowler_Scores.RawScore) AS TotalPins, 
                      COUNT(Bowler_Scores.RawScore) AS GamesBowled, ROUND(AVG(CAST(Bowler_Scores.RawScore AS FLOAT)), 0) AS CurAvg, 
                      ROUND(0.9 * (200 - ROUND(AVG(CAST(Bowler_Scores.RawScore AS FLOAT)), 0)), 0) AS CurHcp
FROM         Bowlers INNER JOIN
                      Bowler_Scores ON Bowlers.BowlerID = Bowler_Scores.BowlerID
GROUP BY Bowler_Scores.BowlerID, Bowlers.BowlerLastName, Bowlers.BowlerFirstName;
GO

CREATE VIEW CH13_Bowler_Averages
AS
SELECT     Bowlers.BowlerLastName + ', ' + Bowlers.BowlerFirstName AS BowlerFullName, AVG(CAST(Bowler_Scores.RawScore AS FLOAT)) 
                      AS AvgOfRawScore
FROM         Bowlers INNER JOIN
                      Bowler_Scores ON Bowlers.BowlerID = Bowler_Scores.BowlerID
GROUP BY Bowlers.BowlerLastName, Bowlers.BowlerFirstName;
GO

CREATE VIEW CH13_Bowler_High_Score_Group
AS
SELECT     Bowlers.BowlerFirstName, Bowlers.BowlerLastName, MAX(Bowler_Scores.RawScore) AS HighScore
FROM         Bowlers INNER JOIN
                      Bowler_Scores ON Bowlers.BowlerID = Bowler_Scores.BowlerID
GROUP BY Bowlers.BowlerFirstName, Bowlers.BowlerLastName;
GO

CREATE VIEW CH13_Bowler_High_Score_Subquery
AS
SELECT     BowlerFirstName, BowlerLastName,
                          (SELECT     MAX(RawScore)
                            FROM          Bowler_Scores
                            WHERE      Bowler_Scores.BowlerID = Bowlers.BowlerID) AS HighScore
FROM         Bowlers;
GO

CREATE VIEW CH13_Tournament_Match_Team_Results
AS
SELECT     Tournaments.TourneyID, Tournaments.TourneyLocation, Tourney_Matches.MatchID, Teams.TeamName, 
                      SUM(Bowler_Scores.HandiCapScore) AS TotHandiCapScore
FROM         Tournaments INNER JOIN
                      Tourney_Matches ON Tournaments.TourneyID = Tourney_Matches.TourneyID INNER JOIN
                      Match_Games ON Tourney_Matches.MatchID = Match_Games.MatchID INNER JOIN
                      Bowler_Scores ON Match_Games.GameNumber = Bowler_Scores.GameNumber AND 
                      Match_Games.MatchID = Bowler_Scores.MatchID INNER JOIN
                      Bowlers ON Bowlers.BowlerID = Bowler_Scores.BowlerID INNER JOIN
                      Teams ON Teams.TeamID = Bowlers.TeamID
GROUP BY Tournaments.TourneyID, Tournaments.TourneyLocation, Tourney_Matches.MatchID, Teams.TeamName;
GO

CREATE VIEW CH14_Better_Than_Overall_Average_Having
AS
SELECT     TOP 100 PERCENT Bowlers.BowlerLastName, Bowlers.BowlerFirstName
FROM         Bowlers INNER JOIN
                      Bowler_Scores ON Bowlers.BowlerID = Bowler_Scores.BowlerID
GROUP BY Bowlers.BowlerLastName, Bowlers.BowlerFirstName
HAVING      (AVG(CAST(Bowler_Scores.RawScore AS Float)) >=
                          (SELECT     AVG(CAST(RawScore AS FLOAT))
                            FROM          Bowler_Scores));
GO

CREATE VIEW CH14_Bowlers_Big_High_Score
AS
SELECT     Bowlers.BowlerFirstName, Bowlers.BowlerLastName, ROUND(AVG(CAST(Bowler_Scores.RawScore AS FLOAT)), 0) AS CurrentAverage, 
                      MAX(Bowler_Scores.RawScore) AS HighGame
FROM         Bowlers INNER JOIN
                      Bowler_Scores ON Bowlers.BowlerID = Bowler_Scores.BowlerID
GROUP BY Bowlers.BowlerFirstName, Bowlers.BowlerLastName
HAVING      (MAX(Bowler_Scores.RawScore) > ROUND(AVG(CAST(Bowler_Scores.RawScore AS FLOAT)), 0) + 20);
GO

CREATE VIEW CH14_Captains_Who_Are_Hotshots
AS
SELECT     Teams.TeamID, Bowlers.BowlerID, Bowlers.BowlerFirstName, Bowlers.BowlerLastName, MAX(Bowler_Scores.RawScore) 
                      AS MaxOfRawScore
FROM         Bowlers INNER JOIN
                      Bowler_Scores ON Bowlers.BowlerID = Bowler_Scores.BowlerID INNER JOIN
                      Teams ON Bowlers.BowlerID = Teams.CaptainID
GROUP BY Teams.TeamID, Bowlers.BowlerID, Bowlers.BowlerFirstName, Bowlers.BowlerLastName
HAVING      (MAX(Bowler_Scores.RawScore) >
                          (SELECT     MAX(RawScore)
                            FROM          (Teams AS T2 INNER JOIN
                                                   Bowlers AS B2 ON T2.TeamID = B2.TeamID) INNER JOIN
                                                   Bowler_Scores ON B2.BowlerID = Bowler_Scores.BowlerID
                            WHERE      T2.TeamID = Teams.TeamID AND B2.BowlerID <> Bowlers.BowlerID));
GO

CREATE VIEW CH14_Good_Bowlers
AS
SELECT     Bowlers.BowlerFirstName, Bowlers.BowlerLastName, AVG(CAST(Bowler_Scores.RawScore AS FLOAT)) AS AvgScore
FROM         Bowlers INNER JOIN
                      Bowler_Scores ON Bowlers.BowlerID = Bowler_Scores.BowlerID
GROUP BY Bowlers.BowlerFirstName, Bowlers.BowlerLastName
HAVING      (AVG(CAST(Bowler_Scores.RawScore AS FLOAT)) > 155);
GO

CREATE VIEW CH18_Bowlers_LTE_165_Thunderbird_Bolero
AS 
SELECT Bowlers.BowlerID, Bowlers.BowlerLastName, Bowlers.BowlerFirstName
FROM Bowlers
WHERE Bowlers.BowlerID NOT IN 
(SELECT Bowler_Scores.BowlerID 
FROM (Tournaments
INNER JOIN Tourney_Matches 
ON Tournaments.TourneyID = Tourney_Matches.TourneyID) 
INNER JOIN Bowler_Scores  
ON Tourney_Matches.MatchID = Bowler_Scores.MatchID
WHERE (Bowler_Scores.RawScore > 165)
AND (Tournaments.TourneyLocation IN ('Thunderbird Lanes', 'Bolero Lanes')));
GO


CREATE VIEW CH18_Bowlers_Won_LowScore_TBird_Totem_Bolero_RIGHT
AS 
SELECT Bowlers.BowlerID, Bowlers.BowlerFirstName, Bowlers.BowlerLastName, 
   Bowler_Scores.MatchID, Bowler_Scores.GameNumber, Bowler_Scores.HandiCapScore, 
   Tournaments.TourneyDate, Tournaments.TourneyLocation
FROM ((Bowlers
INNER JOIN Bowler_Scores
ON Bowlers.BowlerID=Bowler_Scores.BowlerID)
INNER JOIN Tourney_Matches
ON Bowler_Scores.MatchID=Tourney_Matches.MatchID)
INNER JOIN Tournaments
ON Tournaments.TourneyID=Tourney_Matches.TourneyID
WHERE (Bowler_Scores.HandiCapScore <= 190)
AND (Bowler_Scores.WonGame = 1)
AND (Tournaments.TourneyLocation IN ('Thunderbird Lanes', 'Totem Lanes', 'Bolero Lanes')) 
AND (Bowlers.BowlerID IN  (SELECT Bowler_Scores.BowlerID  FROM (Tournaments
INNER JOIN Tourney_Matches 
ON Tournaments.TourneyID = Tourney_Matches.TourneyID) 
INNER JOIN Bowler_Scores 
ON Tourney_Matches.MatchID = Bowler_Scores.MatchID WHERE Bowler_Scores.WonGame = 1 
AND Bowler_Scores.HandiCapScore <=190 
AND Tournaments.TourneyLocation = 'Thunderbird Lanes'))
AND (Bowlers.BowlerID IN  (SELECT Bowler_Scores.BowlerID  FROM (Tournaments
INNER JOIN Tourney_Matches 
ON Tournaments.TourneyID = Tourney_Matches.TourneyID) 
INNER JOIN Bowler_Scores 
ON Tourney_Matches.MatchID = Bowler_Scores.MatchID WHERE Bowler_Scores.WonGame = 1 
AND Bowler_Scores.HandiCapScore <=190 
AND Tournaments.TourneyLocation = 'Totem Lanes'))
AND (Bowlers.BowlerID IN (SELECT Bowler_Scores.BowlerID  FROM (Tournaments
INNER JOIN Tourney_Matches 
ON Tournaments.TourneyID = Tourney_Matches.TourneyID) 
INNER JOIN Bowler_Scores 
ON Tourney_Matches.MatchID = Bowler_Scores.MatchID WHERE Bowler_Scores.WonGame = 1 
AND Bowler_Scores.HandiCapScore <=190 
AND Tournaments.TourneyLocation = 'Bolero Lanes'));
GO


CREATE VIEW CH18_Bowlers_Won_LowScore_TBird_Totem_Bolero_WRONG
AS 
SELECT Bowlers.BowlerID, Bowlers.BowlerFirstName, Bowlers.BowlerLastName, 
   Bowler_Scores.MatchID, Bowler_Scores.GameNumber, Bowler_Scores.HandiCapScore, 
   Tournaments.TourneyDate, Tournaments.TourneyLocation
FROM ((Bowlers
INNER JOIN Bowler_Scores
ON Bowlers.BowlerID=Bowler_Scores.BowlerID)
INNER JOIN Tourney_Matches
ON Bowler_Scores.MatchID=Tourney_Matches.MatchID)
INNER JOIN Tournaments
ON Tournaments.TourneyID=Tourney_Matches.TourneyID
WHERE (Bowler_Scores.HandiCapScore<=190)
AND (Bowler_Scores.WonGame = 1)
AND (Tournaments.TourneyLocation In ('Thunderbird Lanes','Totem Lanes','Bolero Lanes'));
GO


CREATE VIEW CH18_Good_Bowlers_TBird_And_Bolero_EXISTS
AS 
SELECT Bowlers.BowlerID, Bowlers.BowlerLastName, Bowlers.BowlerFirstName
FROM Bowlers
WHERE EXISTS  
(SELECT *  
FROM (Tournaments
INNER JOIN Tourney_Matches 
ON Tournaments.TourneyID = Tourney_Matches.TourneyID) 
INNER JOIN Bowler_Scores  
ON Tourney_Matches.MatchID = Bowler_Scores.MatchID
WHERE (Bowler_Scores.BowlerID = Bowlers.BowlerID) 
AND (Bowler_Scores.RawScore >= 170)
AND (Tournaments.TourneyLocation = 'Thunderbird Lanes'))
AND EXISTS  
(SELECT *  
FROM (Tournaments
INNER JOIN Tourney_Matches 
ON Tournaments.TourneyID = Tourney_Matches.TourneyID) 
INNER JOIN Bowler_Scores  
ON Tourney_Matches.MatchID = Bowler_Scores.MatchID
WHERE (Bowler_Scores.BowlerID = Bowlers.BowlerID) 
AND (Bowler_Scores.RawScore >= 170)
AND (Tournaments.TourneyLocation = 'Bolero Lanes'));
GO


CREATE VIEW CH18_Mediocre_Bowlers
AS 
SELECT Bowlers.BowlerID, Bowlers.BowlerFirstName, Bowlers.BowlerLastName
FROM Bowlers
WHERE NOT EXISTS 
(SELECT * FROM Bowler_Scores 
WHERE Bowler_Scores.RawScore > 150 
AND Bowler_Scores.BowlerID = Bowlers.BowlerID);
GO


CREATE VIEW CH18_Tourney_Not_Yet_Played_NOT_IN
AS 
SELECT Tournaments.TourneyID, Tournaments.TourneyDate, Tournaments.TourneyLocation
FROM Tournaments
WHERE Tournaments.TourneyID NOT IN 
(SELECT Tourney_Matches.TourneyID 
FROM Tourney_Matches);
GO

CREATE VIEW CH19_All_Tournaments_Any_Matches
AS
SELECT  Tournaments.TourneyID, Tournaments.TourneyDate, Tournaments.TourneyLocation, 
        (CASE WHEN Tourney_Matches.MatchID IS NULL THEN 'Not Played Yet' 
        ELSE 'Match: ' + CAST(Tourney_Matches.MatchID AS nvarchar) 
              + '  Lanes: ' + Tourney_Matches.Lanes + '  Odd Lane Team: ' 
              + Teams.TeamName + '  Even Lane Team: ' + Teams_1.TeamName END) AS Match
FROM    ((Tourney_Matches INNER JOIN Teams 
        ON Tourney_Matches.OddLaneTeamID = Teams.TeamID) 
        INNER JOIN Teams AS Teams_1 
        ON Tourney_Matches.EvenLaneTeamID = Teams_1.TeamID) 
        RIGHT OUTER JOIN Tournaments 
        ON Tourney_Matches.TourneyID = Tournaments.TourneyID;
GO

CREATE VIEW CH19_All_Tourney_Matches
AS
SELECT TOP (100) PERCENT Tournaments.TourneyDate, Tournaments.TourneyLocation, 
                         Tourney_Matches.Lanes, Tourney_Matches.MatchID, Teams.TeamName AS OddLaneTeam, 
                         Teams_1.TeamName AS EvenLaneTeam, GameResults.GameNumber, 
                         (CASE WHEN GameResults.TeamName IS NULL 
                         THEN 'Match not played' ELSE GameResults.TeamName END) AS Winner
FROM   (((Tournaments INNER JOIN Tourney_Matches 
       ON Tournaments.TourneyID = Tourney_Matches.TourneyID) 
       INNER JOIN Teams 
       ON Tourney_Matches.OddLaneTeamID = Teams.TeamID) 
       INNER JOIN Teams AS Teams_1 
       ON Tourney_Matches.EvenLaneTeamID = Teams_1.TeamID) 
       LEFT OUTER JOIN
       (SELECT  Match_Games.MatchID, Match_Games.GameNumber, Teams_2.TeamName
        FROM    Match_Games INNER JOIN Teams AS Teams_2 
                ON Match_Games.WinningTeamID = Teams_2.TeamID) AS GameResults 
       ON Tourney_Matches.MatchID = GameResults.MatchID
ORDER BY Tournaments.TourneyDate, Tourney_Matches.MatchID, GameResults.GameNumber;
GO

CREATE VIEW CH19_Bowler_Averages_Avoid_0_Games

AS
SELECT  Bowlers.BowlerID, Bowlers.BowlerFirstName, Bowlers.BowlerLastName, 
          COUNT(Bowler_Scores.MatchID) AS GamesBowled, SUM(Bowler_Scores.RawScore) AS TotalPins, 
          (CASE COUNT(Bowler_Scores.MatchID) 
           WHEN 0 THEN 0 
           ELSE CAST((SUM(Bowler_Scores.RawScore)/COUNT(Bowler_Scores.MatchID)) AS SmallInt) END) AS BowlerAverage
FROM    Bowlers LEFT OUTER JOIN Bowler_Scores 
        ON Bowlers.BowlerID = Bowler_Scores.BowlerID
GROUP BY Bowlers.BowlerID, Bowlers.BowlerFirstName, Bowlers.BowlerLastName;
GO

CREATE VIEW CH19_Bowler_Ratings AS
SELECT   Bowlers.BowlerID, Bowlers.BowlerLastName, Bowlers.BowlerFirstName, CAST(AVG(Bowler_Scores.RawScore) AS Int) AS BowlerAverage, 
            (CASE WHEN CAST(AVG(Bowler_Scores.RawScore) AS Int) < 140 THEN 'Fair' 
                  WHEN CAST(AVG(Bowler_Scores.RawScore) AS Int) < 160 THEN 'Average' 
                  WHEN CAST(AVG(Bowler_Scores.RawScore) AS Int) < 185 THEN 'Good' 
                  ELSE 'Excellent' END) AS BowlerRating
FROM     Bowlers INNER JOIN Bowler_Scores 
         ON Bowlers.BowlerID = Bowler_Scores.BowlerID
GROUP BY Bowlers.BowlerID, Bowlers.BowlerLastName, Bowlers.BowlerFirstName;
GO

CREATE VIEW CH20_Bowler_Mailing_Skip_3
AS 
SELECT TOP 100 PERCENT * FROM
(SELECT ' ' As BowlerLastName, ' ' As BowlerFirstName, ' ' As BowlerAddress, ' ' As BowlerCity, ' ' As BowlerState, ' ' As BowlerZip
FROM ztblSkipLabels
WHERE ztblSkipLabels.LabelCount <= 3
UNION ALL SELECT BowlerLastName, BowlerFirstName, BowlerAddress, BowlerCity, BowlerState, BowlerZip
FROM Bowlers) AS Blist
ORDER BY BowlerZip, BowlerLastName;
GO

CREATE VIEW CH20_Bowler_Ratings
AS 
SELECT BScores.BowlerID, BScores.BowlerLastName, BScores.BowlerFirstName, BScores.BowlerAverage, ztblBowlerRatings.BowlerRating
FROM ztblBowlerRatings, (SELECT Bowlers.BowlerID, Bowlers.BowlerLastName, Bowlers.BowlerFirstName, CAST(AVG(Bowler_Scores.RawScore) AS Integer) AS BowlerAverage FROM Bowlers
INNER JOIN Bowler_Scores 
ON Bowlers.BowlerID=Bowler_Scores.BowlerID GROUP BY Bowlers.BowlerID, Bowlers.BowlerLastName, Bowlers.BowlerFirstName)  AS BScores
WHERE BScores.BowlerAverage BETWEEN ztblBowlerRatings.BowlerLowAvg
AND ztblBowlerRatings.BowlerHighAvg;
GO

CREATE VIEW CH20_Team_Pairings
AS 
SELECT TOP 100 PERCENT Teams.TeamID AS Team1ID, Teams.TeamName AS Team1Name, Teams_1.TeamID AS Team2ID, Teams_1.TeamName AS Team2Name
FROM Teams, Teams AS Teams_1
WHERE Teams_1.TeamID>Teams.TeamID
ORDER BY Teams.TeamID, Teams_1.TeamID;
GO

CREATE VIEW CH20_Tournament_Week_Schedule_2012
AS 
SELECT ztblWeeks.WeekStart, (SELECT Tournaments.TourneyLocation FROM Tournaments WHERE Tournaments.TourneyDate BETWEEN ztblWeeks.WeekStart
AND ztblWeeks.WeekEnd) AS BowlingAlley
FROM ztblWeeks
WHERE ztblWeeks.WeekStart <= '2012-12-31' And ztblWeeks.WeekEnd >= '2012-09-01';
GO



