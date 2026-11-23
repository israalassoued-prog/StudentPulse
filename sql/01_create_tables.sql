
-- Create the students table
CREATE TABLE students (
    student_id VARCHAR(10) PRIMARY KEY,
    university VARCHAR(100) NOT NULL,
    field_of_study VARCHAR(100),
    academic_year VARCHAR(20),
    age INTEGER CHECK (age BETWEEN 18 AND 26)
);

-- Create the events table
CREATE TABLE events (
    event_id VARCHAR(10) PRIMARY KEY,
    event_name VARCHAR(150) NOT NULL,
    category VARCHAR(100),
    event_date TIMESTAMP,
    capacity INTEGER CHECK (capacity > 0),
    location VARCHAR(100)
);

-- Create the registrations table
CREATE TABLE registrations (
    registration_id INTEGER PRIMARY KEY,
    student_id VARCHAR(10) NOT NULL,
    event_id VARCHAR(10) NOT NULL,
    registration_date TIMESTAMP,
    attendance_status VARCHAR(20)
        CHECK (attendance_status IN ('Attended', 'Absent')),
    satisfaction_score INTEGER
        CHECK (satisfaction_score BETWEEN 1 AND 5),
    registration_channel VARCHAR(50),

    CONSTRAINT fk_student
        FOREIGN KEY (student_id)
        REFERENCES students(student_id),

    CONSTRAINT fk_event
        FOREIGN KEY (event_id)
        REFERENCES events(event_id),

    CONSTRAINT unique_student_event
        UNIQUE (student_id, event_id)
);
