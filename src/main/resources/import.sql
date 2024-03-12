-- Create User table
CREATE TABLE clients (
  id SERIAL PRIMARY KEY,
  username VARCHAR(255),
    password VARCHAR(255)
    );

-- Set sequence for the client table
ALTER SEQUENCE client_id_seq START WITH 1 OWNED BY clients.id;
ALTER SEQUENCE client_id_seq INCREMENT BY 1;

-- Create DayOfWeek table
CREATE TABLE day_of_the_week
(
    id   INT PRIMARY KEY,
    day_name VARCHAR(255)
);

-- Create Exercise table
CREATE TABLE exercise
(
    id   INT PRIMARY KEY,
    name VARCHAR(255),
    description  TEXT,
    muscle_group VARCHAR(255)
);

-- Create UserExerciseTemplate table
CREATE TABLE user_exercise_template
(
    id INT PRIMARY KEY,
    user_id     INT,
    day_id      INT,
    FOREIGN KEY (user_id) REFERENCES clients (id),
    FOREIGN KEY (day_id) REFERENCES day_of_the_week (id)
);

-- Create UserExercise table
CREATE TABLE user_exercise
(
    id INT PRIMARY KEY,
    template_id     INT,
    exercise_id     INT,
    reps           INT,
    FOREIGN KEY (template_id) REFERENCES user_exercise_template (id),
    FOREIGN KEY (exercise_id) REFERENCES exercise (id)
);

-- Create UserExerciseWeight table
CREATE TABLE user_exercise_weight
(
    id INT PRIMARY KEY,
    user_exercise_id INT,
    week_number     INT,
    weight_used     DECIMAL(10, 2),
    FOREIGN KEY (user_exercise_id) REFERENCES user_exercise (id)
);



-- Insert dummy data into User table
INSERT INTO clients (id,username, password)
VALUES (1,'Alice', 'alice01'),
       (2,'Bob', 'bob1990'),
       (3,'Charlie', 'charlie123');

-- Insert dummy data into DayOfWeek table
INSERT INTO day_of_the_week (id, day_name)
VALUES (1, 'Monday'),
       (2, 'Tuesday'),
       (3, 'Wednesday'),
       (4, 'Thursday'),
       (5, 'Friday'),
       (6, 'Saturday'),
       (7, 'Sunday');

-- Insert dummy data into Exercise table
INSERT INTO exercise (id, name, description, muscle_group)
VALUES (1, 'Push-up', 'Bodyweight exercise targeting chest, shoulders, and triceps.', 'chest'),
       (2, 'Squats', 'Lower body exercise targeting quadriceps, hamstrings, and glutes.', 'glutes'),
       (3, 'Bench Press', 'Strength training exercise for chest, shoulders, and triceps.', 'chest'),
       (4, 'Deadlift', 'Compound exercise targeting multiple muscle groups including back, hamstrings, and glutes.',
        'lower back');

-- Insert dummy data into UserExerciseTemplate table
INSERT INTO user_exercise_template (id, user_id, day_id)
VALUES (1, 1, 1), -- Alice's Monday template
       (2, 1, 3), -- Alice's Wednesday template
       (3, 2, 2);
-- Bob's Tuesday template

-- Insert dummy data into UserExercise table
INSERT INTO user_exercise (id, template_id, exercise_id, reps)
VALUES (1, 1, 1, 15), -- Alice's Monday: 15 Push-ups
       (2, 1, 2, 12), -- Alice's Monday: 12 Squats
       (3, 2, 3, 10), -- Alice's Wednesday: 10 Bench Press
       (4, 3, 4, 8);
-- Bob's Tuesday: 8 Deadlifts

-- Insert dummy data into UserExerciseWeight table
INSERT INTO user_exercise_weight (id, user_exercise_id, week_number, weight_used)
VALUES (1, 1, 1, 0),  -- Alice's Monday Push-ups, Week 1, No weight used
       (2, 1, 2, 0),  -- Alice's Monday Push-ups, Week 2, No weight used
       (3, 2, 1, 20), -- Alice's Monday Squats, Week 1, 20 kg
       (4, 2, 2, 22), -- Alice's Monday Squats, Week 2, 22 kg
       (5, 3, 1, 30), -- Alice's Wednesday Bench Press, Week 1, 30 kg
       (6, 3, 2, 32), -- Alice's Wednesday Bench Press, Week 2, 32 kg
       (7, 4, 1, 40), -- Bob's Tuesday Deadlifts, Week 1, 40 kg
       (8, 4, 2, 42); -- Bob's Tuesday Deadlifts, Week 2, 42 kg


-- Set next value for sequence
SELECT setval('client_id_seq', (SELECT MAX(id) FROM clients));