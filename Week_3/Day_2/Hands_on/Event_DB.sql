-- =============================================
-- EVENT MANAGEMENT DATABASE
-- ANSI SQL using SQL Server
-- =============================================

-- 1. Create Database
CREATE DATABASE EventDb;
GO

-- Use the database
USE EventDb;
GO


-- =============================================
-- TABLE 1: UserInfo
-- Stores system users (Admin or Participant)
-- =============================================
CREATE TABLE UserInfo (
    EmailId VARCHAR(100) PRIMARY KEY,        -- Primary Key
    UserName VARCHAR(50) NOT NULL,           -- Required, max length 50
    Role VARCHAR(20) NOT NULL                -- Must be Admin or Participant
        CHECK (Role IN ('Admin','Participant')),
    Password VARCHAR(20) NOT NULL            -- Password length 6–20
        CHECK (LEN(Password) BETWEEN 6 AND 20)
);



-- =============================================
-- TABLE 2: EventDetails
-- Stores event information
-- =============================================
CREATE TABLE EventDetails (
    EventId INT PRIMARY KEY,                 -- Primary Key
    EventName VARCHAR(50) NOT NULL,          -- Event name
    EventCategory VARCHAR(50) NOT NULL,      -- Category of event
    EventDate DATETIME NOT NULL,             -- Event date
    Description VARCHAR(255) NULL,           -- Optional description
    Status VARCHAR(20)                       -- Event status
        CHECK (Status IN ('Active','In-Active'))
);



-- =============================================
-- TABLE 3: SpeakersDetails
-- Stores speakers participating in events
-- =============================================
CREATE TABLE SpeakersDetails (
    SpeakerId INT PRIMARY KEY,               -- Primary Key
    SpeakerName VARCHAR(50) NOT NULL         -- Speaker name
);



-- =============================================
-- TABLE 4: SessionInfo
-- Stores sessions belonging to events
-- =============================================
CREATE TABLE SessionInfo (
    SessionId INT PRIMARY KEY,               -- Primary Key
    EventId INT NOT NULL,                    -- FK to EventDetails
    SessionTitle VARCHAR(50) NOT NULL,       -- Title of session
    SpeakerId INT NOT NULL,                  -- FK to SpeakersDetails
    Description VARCHAR(255) NULL,           -- Optional description
    SessionStart DATETIME NOT NULL,          -- Start time
    SessionEnd DATETIME NOT NULL,            -- End time
    SessionUrl VARCHAR(255),                 -- Online session link

    -- Foreign Key Constraints
    FOREIGN KEY (EventId) REFERENCES EventDetails(EventId),
    FOREIGN KEY (SpeakerId) REFERENCES SpeakersDetails(SpeakerId)
);



-- =============================================
-- TABLE 5: ParticipantEventDetails
-- Tracks participants attending sessions
-- =============================================
CREATE TABLE ParticipantEventDetails (
    Id INT PRIMARY KEY,                      -- Primary Key
    ParticipantEmailId VARCHAR(100) NOT NULL,-- FK to UserInfo
    EventId INT NOT NULL,                    -- FK to EventDetails
    SessionId INT NOT NULL,                  -- FK to SessionInfo
    IsAttended BIT CHECK (IsAttended IN (0,1)), -- 0 = No, 1 = Yes

    -- Foreign Key Constraints
    FOREIGN KEY (ParticipantEmailId) REFERENCES UserInfo(EmailId),
    FOREIGN KEY (EventId) REFERENCES EventDetails(EventId),
    FOREIGN KEY (SessionId) REFERENCES SessionInfo(SessionId)
);