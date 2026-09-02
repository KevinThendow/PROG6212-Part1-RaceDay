/*==========================================================
  RaceDay Database Design Summary

  Users:
  Stores both Organisers and Participants.

  Events:
  Stores events created by Organisers.

  Categories:
  Stores age or distance categories linked to Events.

  Routes:
  Stores route information linked to Events.

  Enrolments:
  Connects Participants to Events and Categories.

  Results:
  Stores finish time and finishing position for Enrolments.
==========================================================*/
/*==========================================================
  PROG6212 - Programming 2B
  PoE Part 1 - Section C
  RaceDay Event Management System Database
==========================================================*/

------------------------------------------------------------
-- 1. CREATE DATABASE
------------------------------------------------------------

IF DB_ID('RaceDayDB') IS NULL
BEGIN
    CREATE DATABASE RaceDayDB;
END
GO

USE RaceDayDB;
GO


------------------------------------------------------------
-- 2. REMOVE EXISTING TABLES
-- This allows the script to be executed again for testing.
------------------------------------------------------------

DROP TABLE IF EXISTS Results;
DROP TABLE IF EXISTS Enrolments;
DROP TABLE IF EXISTS Routes;
DROP TABLE IF EXISTS Categories;
DROP TABLE IF EXISTS Events;
DROP TABLE IF EXISTS Users;
GO


------------------------------------------------------------
-- 3. CREATE USERS TABLE
------------------------------------------------------------
/*==========================================================
  Database Constraints

  The RaceDay database uses constraints to protect data quality.

  - PRIMARY KEY ensures each record has a unique identifier.
  - FOREIGN KEY keeps relationships between tables valid.
  - NOT NULL ensures required information is provided.
  - UNIQUE prevents duplicate values such as email addresses.
  - DEFAULT supplies values automatically where appropriate.
  - CHECK restricts values to valid options such as:
      * User roles: Organiser or Participant
      * Event types: Run, Walk or Cycle
      * Enrolment status: Pending, Confirmed or Cancelled
==========================================================*/
CREATE TABLE Users
(
    UserID INT IDENTITY(1,1) PRIMARY KEY,

    FirstName NVARCHAR(50) NOT NULL,

    LastName NVARCHAR(50) NOT NULL,

    Email NVARCHAR(100) NOT NULL UNIQUE,

    PasswordHash NVARCHAR(255) NOT NULL,

    PhoneNumber NVARCHAR(20) NULL,

    DateOfBirth DATE NULL,

    Role NVARCHAR(20) NOT NULL,

    ProfileImageUrl NVARCHAR(500) NULL,

    CreatedAt DATETIME2 NOT NULL
        DEFAULT GETDATE(),

    CONSTRAINT CK_Users_Role
        CHECK (Role IN ('Organiser', 'Participant'))
);
GO


------------------------------------------------------------
-- 4. CREATE EVENTS TABLE
------------------------------------------------------------

CREATE TABLE Events
(
    EventID INT IDENTITY(1,1) PRIMARY KEY,

    OrganiserID INT NOT NULL,

    EventName NVARCHAR(100) NOT NULL,

    Description NVARCHAR(500) NULL,

    EventDate DATE NOT NULL,

    Location NVARCHAR(150) NOT NULL,

    Distance DECIMAL(6,2) NOT NULL,

    EventType NVARCHAR(20) NOT NULL,

    BannerImageUrl NVARCHAR(500) NULL,

    CreatedAt DATETIME2 NOT NULL
        DEFAULT GETDATE(),

    CONSTRAINT FK_Events_Users
        FOREIGN KEY (OrganiserID)
        REFERENCES Users(UserID),

    CONSTRAINT CK_Events_EventType
        CHECK (EventType IN ('Run', 'Walk', 'Cycle')),

    CONSTRAINT CK_Events_Distance
        CHECK (Distance > 0)
);
GO


------------------------------------------------------------
-- 5. CREATE CATEGORIES TABLE
------------------------------------------------------------

CREATE TABLE Categories
(
    CategoryID INT IDENTITY(1,1) PRIMARY KEY,

    EventID INT NOT NULL,

    CategoryName NVARCHAR(100) NOT NULL,

    CategoryType NVARCHAR(20) NOT NULL,

    MinAge INT NULL,

    MaxAge INT NULL,

    Distance DECIMAL(6,2) NULL,

    CONSTRAINT FK_Categories_Events
        FOREIGN KEY (EventID)
        REFERENCES Events(EventID),

    CONSTRAINT CK_Categories_Type
        CHECK (CategoryType IN ('Age', 'Distance')),

    CONSTRAINT CK_Categories_MinAge
        CHECK (MinAge IS NULL OR MinAge >= 0),

    CONSTRAINT CK_Categories_MaxAge
        CHECK (MaxAge IS NULL OR MaxAge >= 0)
);
GO


------------------------------------------------------------
-- 6. CREATE ROUTES TABLE
------------------------------------------------------------

CREATE TABLE Routes
(
    RouteID INT IDENTITY(1,1) PRIMARY KEY,

    EventID INT NOT NULL,

    RouteName NVARCHAR(100) NOT NULL,

    StartLocation NVARCHAR(150) NOT NULL,

    EndLocation NVARCHAR(150) NOT NULL,

    RouteDescription NVARCHAR(500) NULL,

    RouteMapUrl NVARCHAR(500) NULL,

    CONSTRAINT FK_Routes_Events
        FOREIGN KEY (EventID)
        REFERENCES Events(EventID)
);
GO


------------------------------------------------------------
-- 7. CREATE ENROLMENTS TABLE
------------------------------------------------------------

CREATE TABLE Enrolments
(
    EnrolmentID INT IDENTITY(1,1) PRIMARY KEY,

    ParticipantID INT NOT NULL,

    EventID INT NOT NULL,

    CategoryID INT NOT NULL,

    EnrolmentDate DATETIME2 NOT NULL
        DEFAULT GETDATE(),

    Status NVARCHAR(20) NOT NULL
        DEFAULT 'Pending',

    CONSTRAINT FK_Enrolments_Users
        FOREIGN KEY (ParticipantID)
        REFERENCES Users(UserID),

    CONSTRAINT FK_Enrolments_Events
        FOREIGN KEY (EventID)
        REFERENCES Events(EventID),

    CONSTRAINT FK_Enrolments_Categories
        FOREIGN KEY (CategoryID)
        REFERENCES Categories(CategoryID),

    CONSTRAINT CK_Enrolments_Status
        CHECK (Status IN
        ('Pending', 'Confirmed', 'Cancelled')),

    CONSTRAINT UQ_Enrolment_Participant_Event
        UNIQUE (ParticipantID, EventID)
);
GO


------------------------------------------------------------
-- 8. CREATE RESULTS TABLE
------------------------------------------------------------

CREATE TABLE Results
(
    ResultID INT IDENTITY(1,1) PRIMARY KEY,

    EnrolmentID INT NOT NULL UNIQUE,

    FinishTime TIME NULL,

    FinishingPosition INT NULL,

    RecordedAt DATETIME2 NOT NULL
        DEFAULT GETDATE(),

    CONSTRAINT FK_Results_Enrolments
        FOREIGN KEY (EnrolmentID)
        REFERENCES Enrolments(EnrolmentID),

    CONSTRAINT CK_Results_Position
        CHECK
        (
            FinishingPosition IS NULL
            OR FinishingPosition > 0
        )
);
GO


------------------------------------------------------------
-- 9. INSERT USERS
-- 2 Organisers and 2 Participants
------------------------------------------------------------

INSERT INTO Users
(
    FirstName,
    LastName,
    Email,
    PasswordHash,
    PhoneNumber,
    DateOfBirth,
    Role
)
VALUES
(
    'Thabo',
    'Mokoena',
    'thabo.mokoena@raceday.co.za',
    '8C6976E5B5410415BDE908BD4DEE15DF',
    '0712345678',
    '1988-04-15',
    'Organiser'
),
(
    'Naledi',
    'Nkosi',
    'naledi.nkosi@raceday.co.za',
    '2BB80D537B1DA3E38BD30361AA855686',
    '0723456789',
    '1990-09-21',
    'Organiser'
),
(
    'Lerato',
    'Khumalo',
    'lerato.khumalo@email.com',
    'A665A45920422F9D417E4867EFDC4FB8',
    '0734567890',
    '2001-06-10',
    'Participant'
),
(
    'Sipho',
    'Ndlovu',
    'sipho.ndlovu@email.com',
    'B3A8E0E1F9AB1BFE3A36F231F20F4B6A',
    '0745678901',
    '1997-11-08',
    'Participant'
);
GO


------------------------------------------------------------
-- 10. INSERT EVENTS
-- Minimum required: 3 Events
------------------------------------------------------------

INSERT INTO Events
(
    OrganiserID,
    EventName,
    Description,
    EventDate,
    Location,
    Distance,
    EventType
)
VALUES
(
    1,
    'Polokwane Spring 10K',
    'A community road running event in Polokwane.',
    '2026-10-10',
    'Polokwane, Limpopo',
    10.00,
    'Run'
),
(
    1,
    'Limpopo Family Fun Walk',
    'A family-friendly walking event suitable for all ages.',
    '2026-11-07',
    'Polokwane, Limpopo',
    5.00,
    'Walk'
),
(
    2,
    'Johannesburg City Cycle Challenge',
    'A road cycling event through Johannesburg.',
    '2026-12-05',
    'Johannesburg, Gauteng',
    40.00,
    'Cycle'
);
GO


------------------------------------------------------------
-- 11. INSERT CATEGORIES
------------------------------------------------------------

INSERT INTO Categories
(
    EventID,
    CategoryName,
    CategoryType,
    MinAge,
    MaxAge,
    Distance
)
VALUES

-- Event 1
(
    1,
    'Open 10km',
    'Distance',
    NULL,
    NULL,
    10.00
),

(
    1,
    'Under 20',
    'Age',
    16,
    19,
    10.00
),

-- Event 2
(
    2,
    'Family 5km',
    'Distance',
    NULL,
    NULL,
    5.00
),

(
    2,
    'Senior',
    'Age',
    60,
    NULL,
    5.00
),

-- Event 3
(
    3,
    '40km Open',
    'Distance',
    NULL,
    NULL,
    40.00
);
GO


------------------------------------------------------------
-- 12. INSERT ROUTES
------------------------------------------------------------

INSERT INTO Routes
(
    EventID,
    RouteName,
    StartLocation,
    EndLocation,
    RouteDescription
)
VALUES
(
    1,
    'Polokwane 10K Route',
    'Peter Mokaba Stadium',
    'Peter Mokaba Stadium',
    'A 10 kilometre road-running route through central Polokwane.'
),
(
    2,
    'Family Walk Route',
    'Polokwane City Park',
    'Polokwane City Park',
    'A five kilometre family walking route.'
),
(
    3,
    'Johannesburg Cycle Route',
    'Johannesburg Stadium',
    'Johannesburg Stadium',
    'A 40 kilometre urban cycling route through Johannesburg.'
);
GO


------------------------------------------------------------
-- 13. INSERT SAMPLE ENROLMENTS
------------------------------------------------------------

INSERT INTO Enrolments
(
    ParticipantID,
    EventID,
    CategoryID,
    Status
)
VALUES
(
    3,
    1,
    1,
    'Confirmed'
),
(
    4,
    1,
    1,
    'Confirmed'
),
(
    3,
    2,
    3,
    'Confirmed'
),
(
    4,
    3,
    5,
    'Pending'
);
GO


------------------------------------------------------------
-- 14. INSERT SAMPLE RESULTS
------------------------------------------------------------

INSERT INTO Results
(
    EnrolmentID,
    FinishTime,
    FinishingPosition
)
VALUES
(
    1,
    '00:52:35',
    47
),
(
    2,
    '00:48:20',
    31
);
GO


------------------------------------------------------------
-- 15. VERIFY DATABASE DATA
------------------------------------------------------------

SELECT * FROM Users;
SELECT * FROM Events;
SELECT * FROM Categories;
SELECT * FROM Routes;
SELECT * FROM Enrolments;
SELECT * FROM Results;
GO


------------------------------------------------------------
-- END OF RACEDAY DATABASE SCRIPT
------------------------------------------------------------
