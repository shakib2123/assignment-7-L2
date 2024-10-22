-- Active: 1729271827172@@127.0.0.1@5432@university_db


-- Create a "students" table
CREATE TABLE students(
    student_id SERIAL PRIMARY KEY,
    student_name VARCHAR(50),
    age INTEGER,
    email VARCHAR(100),
    frontend_mark INTEGER,
    backend_mark INTEGER,
    status VARCHAR(10)
)

-- Insert data into the "students" table
INSERT INTO students(student_name,age,email,frontend_mark,backend_mark,status) 
VALUES
('Sameer', 21, 'sameer@example.com', 48, 60, NULL),
('Zoya', 23, 'zoya@example.com', 52, 58, NULL),
('Nabil', 22, 'nabil@example.com', 37, 46, NULL),
('Rafi', 24, 'rafi@example.com', 41, 40, NULL),
('Sophia', 22, 'sophia@example.com', 50, 52, NULL),
('Hasan', 23, 'hasan@gmail.com', 43, 39, NULL);



-- Create a "courses" table
CREATE TABLE courses(
    course_id SERIAL PRIMARY KEY,
    course_name VARCHAR(50),
    credits INTEGER
);


-- Insert data into the "courses" table
INSERT INTO courses(course_name,credits)
VALUES
('Next.js', 3),
('React.js', 4),
('Databases', 3),
('Prisma', 3);



-- Create an "enrollment" table
CREATE TABLE enrollment(
    enrollment_id SERIAL PRIMARY KEY,
    student_id INTEGER REFERENCES students(student_id),
    course_id INTEGER REFERENCES courses(course_id)
);

-- Insert data into the "enrollment" table
INSERT INTO enrollment(student_id,course_id)
VALUES 
(1,1),
(1,2),
(2,1),
(3,2);



-- Query 1: Insert a new student record into the "students" table
INSERT INTO students(student_name,age,email,frontend_mark,backend_mark,status) 
VALUES
('Shakib', 17, 'shakib@gmail.com', 55, 60, NULL);

-- Query 2: Retrieve the names of all students who are enrolled in the course titled 'Next.js'.
SELECT students.student_name FROM students
JOIN enrollment ON students.student_id = enrollment.student_id
JOIN courses ON enrollment.course_id = courses.course_id
WHERE courses.course_name = 'Next.js';


-- Query 3: Update the status of the student with the highest total (frontend_mark + backend_mark) to 'Awarded'.
UPDATE students
SET status = 'Awarded'
WHERE (frontend_mark + backend_mark) = (SELECT MAX(frontend_mark + backend_mark) FROM students);

-- Query 4: Delete all courses that have no students enrolled.
DELETE FROM courses
WHERE course_id NOT IN (SELECT course_id FROM enrollment);


-- Query 5: Retrieve the names of students using a limit of 2, starting from the 3rd student.
SELECT student_name FROM students
LIMIT 2 OFFSET 2;

-- Query 6: Retrieve the course names and the number of students enrolled in each course.
SELECT courses.course_name, COUNT(enrollment.course_id) FROM courses
JOIN enrollment ON courses.course_id = enrollment.course_id
GROUP BY courses.course_name;


-- Query 7: Calculate and display the average age of all students.
SELECT AVG(age) as average_age FROM students;


-- Query 8: Retrieve the names of students whose email addresses contain 'example.com'.
SELECT student_name FROM students
WHERE email LIKE '%example.com%';