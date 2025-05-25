-- Database Schema: Tables and Constraints
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Trainer Table
CREATE TABLE Trainer (
    Id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    FirstName VARCHAR(255) NOT NULL,
    LastName VARCHAR(255) NOT NULL,
    Specialization VARCHAR(255)
);

-- Member Table
CREATE TABLE Member (
    Id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    TrainerId UUID REFERENCES Trainer(Id),
    Username VARCHAR(255) UNIQUE NOT NULL,
    Password VARCHAR(255) NOT NULL,
    FirstName VARCHAR(255) NOT NULL,
    LastName VARCHAR(255) NOT NULL,
    RegistrationDate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Report Table
CREATE TABLE Report (
    Id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    Date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    DailyAttendance SMALLINT NOT NULL,
    Income DECIMAL(10,2) NOT NULL,
    MemberCount SMALLINT NOT NULL,
    IsGenerated BOOLEAN DEFAULT FALSE,
    TrainerCount SMALLINT NOT NULL
);

-- TrainerSchedule Table
CREATE TABLE TrainerSchedule (
    Id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    TrainerId UUID REFERENCES Trainer(Id) NOT NULL,
    StartTime TIMESTAMP NOT NULL,
    EndTime TIMESTAMP NOT NULL,
    Activity VARCHAR(255) NOT NULL,
    CONSTRAINT valid_times CHECK (EndTime > StartTime)
);

-- WorkoutPlan Table
CREATE TABLE WorkoutPlan (
    Id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    MemberId UUID REFERENCES Member(Id) NOT NULL,
    Content VARCHAR(255) NOT NULL,
    LastUpdated TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- DietPlan Table
CREATE TABLE DietPlan (
    Id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    MemberId UUID REFERENCES Member(Id) NOT NULL,
    Content VARCHAR(255) NOT NULL,
    LastUpdated TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Notification Table
CREATE TABLE Notification (
    Id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    MemberId UUID REFERENCES Member(Id) NOT NULL,
    Type VARCHAR(255) NOT NULL,
    Content VARCHAR(255) NOT NULL,
    SentDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- AttendanceTracker Table
CREATE TABLE AttendanceTracker (
    Id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    MemberId UUID REFERENCES Member(Id) NOT NULL,
    CheckInTime TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Method VARCHAR(255) NOT NULL
);

-- SubscriptionPlan Table
CREATE TABLE SubscriptionPlan (
    Id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    TrainerId UUID REFERENCES Trainer(Id),
    MemberId UUID REFERENCES Member(Id),
    Price DECIMAL(10,2) NOT NULL,
    StartDate TIMESTAMP NOT NULL,
    EndDate TIMESTAMP NOT NULL,
    IsExpired BOOLEAN DEFAULT FALSE,
    CONSTRAINT valid_subscription_period CHECK (EndDate > StartDate),
    CONSTRAINT one_owner CHECK (
        (TrainerId IS NOT NULL AND MemberId IS NULL) OR
        (MemberId IS NOT NULL AND TrainerId IS NULL)
    )
);

-- PaymentIntegration Table
CREATE TABLE PaymentIntegration (
    Id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    MemberId UUID REFERENCES Member(Id),
    TrainerId UUID REFERENCES Trainer(Id),
    Amount DECIMAL(10,2) NOT NULL,
    PaymentDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    IsSuccessful BOOLEAN DEFAULT FALSE,
    CONSTRAINT payment_recipient CHECK (
        (MemberId IS NOT NULL AND TrainerId IS NULL) OR
        (TrainerId IS NOT NULL AND MemberId IS NULL)
    )
);