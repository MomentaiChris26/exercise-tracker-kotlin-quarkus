-- Create User table
CREATE TABLE IF NOT EXISTS "User" (
  UserID   INT PRIMARY KEY,
  Username VARCHAR(255),
    Password VARCHAR(255)
    );

-- Create DayOfWeek table
CREATE TABLE DayOfWeek
(
    DayID   INT PRIMARY KEY,
    DayName VARCHAR(255)
);

-- Create Exercise table
CREATE TABLE Exercise
(
    ExerciseID   INT PRIMARY KEY,
    ExerciseName VARCHAR(255),
    Description  TEXT,
    MuscleGroup VARCHAR(255)
);

-- Create UserExerciseTemplate table
CREATE TABLE UserExerciseTemplate
(
    TemplateID INT PRIMARY KEY,
    UserID     INT,
    DayID      INT,
    FOREIGN KEY (UserID) REFERENCES "User" (UserID),
    FOREIGN KEY (DayID) REFERENCES DayOfWeek (DayID)
);

-- Create UserExercise table
CREATE TABLE UserExercise
(
    UserExerciseID INT PRIMARY KEY,
    TemplateID     INT,
    ExerciseID     INT,
    Reps           INT,
    FOREIGN KEY (TemplateID) REFERENCES UserExerciseTemplate (TemplateID),
    FOREIGN KEY (ExerciseID) REFERENCES Exercise (ExerciseID)
);

-- Create UserExerciseWeight table
CREATE TABLE UserExerciseWeight
(
    WeightID       INT PRIMARY KEY,
    UserExerciseID INT,
    WeekNumber     INT,
    WeightUsed     DECIMAL(10, 2),
    FOREIGN KEY (UserExerciseID) REFERENCES UserExercise (UserExerciseID)
);


-- Insert dummy data into User table
INSERT INTO "User" (UserID, Username,password)
VALUES (1, 'Alice', 'alice01'),
       (2, 'Bob', 'bob1990'),
       (3, 'Charlie', 'charlie123');

-- Insert dummy data into DayOfWeek table
INSERT INTO DayOfWeek (DayID, DayName)
VALUES (1, 'Monday'),
       (2, 'Tuesday'),
       (3, 'Wednesday'),
       (4, 'Thursday'),
       (5, 'Friday'),
       (6, 'Saturday'),
       (7, 'Sunday');

-- Insert dummy data into Exercise table
INSERT INTO Exercise (ExerciseID, ExerciseName, Description,MuscleGroup)
VALUES (1, 'Push-up', 'Bodyweight exercise targeting chest, shoulders, and triceps.', 'chest'),
       (2, 'Squats', 'Lower body exercise targeting quadriceps, hamstrings, and glutes.', 'glutes'),
       (3, 'Bench Press', 'Strength training exercise for chest, shoulders, and triceps.', 'chest'),
       (4, 'Deadlift', 'Compound exercise targeting multiple muscle groups including back, hamstrings, and glutes.',
        'lower back');

-- Insert dummy data into UserExerciseTemplate table
INSERT INTO UserExerciseTemplate (TemplateID, UserID, DayID)
VALUES (1, 1, 1), -- Alice's Monday template
       (2, 1, 3), -- Alice's Wednesday template
       (3, 2, 2);
-- Bob's Tuesday template

-- Insert dummy data into UserExercise table
INSERT INTO UserExercise (UserExerciseID, TemplateID, ExerciseID, Reps)
VALUES (1, 1, 1, 15), -- Alice's Monday: 15 Push-ups
       (2, 1, 2, 12), -- Alice's Monday: 12 Squats
       (3, 2, 3, 10), -- Alice's Wednesday: 10 Bench Press
       (4, 3, 4, 8);
-- Bob's Tuesday: 8 Deadlifts

-- Insert dummy data into UserExerciseWeight table
INSERT INTO UserExerciseWeight (WeightID, UserExerciseID, WeekNumber, WeightUsed)
VALUES (1, 1, 1, 0),  -- Alice's Monday Push-ups, Week 1, No weight used
       (2, 1, 2, 0),  -- Alice's Monday Push-ups, Week 2, No weight used
       (3, 2, 1, 20), -- Alice's Monday Squats, Week 1, 20 kg
       (4, 2, 2, 22), -- Alice's Monday Squats, Week 2, 22 kg
       (5, 3, 1, 30), -- Alice's Wednesday Bench Press, Week 1, 30 kg
       (6, 3, 2, 32), -- Alice's Wednesday Bench Press, Week 2, 32 kg
       (7, 4, 1, 40), -- Bob's Tuesday Deadlifts, Week 1, 40 kg
       (8, 4, 2, 42); -- Bob's Tuesday Deadlifts, Week 2, 42 kg