# DATABASE CREATION
CREATE DATABASE ALU_STUDENT_DB;

# CREATE TABLES

-- Create the students table
CREATE TABLE students (
    student_id INT PRIMARY KEY AUTO_INCREMENT,
    student_name VARCHAR(100),
    intake_year INT
);

-- Create the linux_grades table
CREATE TABLE linux_grades (
    course_id INT PRIMARY KEY AUTO_INCREMENT,
    course_name VARCHAR(100),
    student_id INT,
    grade_obtained DECIMAL(5,2),
    FOREIGN KEY (student_id) REFERENCES students(student_id)
);

-- Create the python_grades table
CREATE TABLE python_grades (
    course_id INT PRIMARY KEY AUTO_INCREMENT,
    course_name VARCHAR(100),
    student_id INT,
    grade_obtained DECIMAL(5,2),
    FOREIGN KEY (student_id) REFERENCES students(student_id)
);

# QUERIES IMPLEMENTATION

-- Insert sample data into the students table.
INSERT INTO students (student_id, student_name, intake_year) VALUES
(1, 'Alice', 2020),
(2, 'Bob', 2020),
(3, 'Charlie', 2021),
(4, 'David', 2021),
(5, 'Eva', 2022),
(6, 'Frank', 2022),
(7, 'Grace', 2020),
(8, 'Hannah', 2021),
(9, 'Ian', 2022),
(10, 'Jack', 2020),
(11, 'Kathy', 2021),
(12, 'Leo', 2022),
(13, 'Mona', 2020),
(14, 'Nina', 2021),
(15, 'Oscar', 2022);

-- Insert sample data into the linux_grades table.
INSERT INTO linux_grades (course_id, course_name, student_id, grade_obtained) VALUES
(1, 'Linux Basics', 1, 85.00),
(2, 'Linux Basics', 2, 78.50),
(3, 'Linux Basics', 3, 92.00),
(4, 'Linux Basics', 4, 45.00),
(5, 'Linux Basics', 5, 60.00),
(6, 'Linux Basics', 6, 88.00),
(7, 'Linux Basics', 7, 73.00),
(8, 'Linux Basics', 8, 95.00),
(9, 'Linux Basics', 9, 50.00),
(10, 'Linux Basics', 10, 80.00),
(11, 'Linux Basics', 11, 67.00),
(12, 'Linux Basics', 12, 90.00),
(13, 'Linux Basics', 13, 55.00),
(14, 'Linux Basics', 14, 72.00),
(15, 'Linux Basics', 15, 65.00);

-- Insert sample data into the python_grades table.
INSERT INTO python_grades (course_id, course_name, student_id, grade_obtained) VALUES
(1, 'Python Basics', 1, 95.00),
(2, 'Python Basics', 2, 85.00),
(3, 'Python Basics', 3, 75.00),
(4, 'Python Basics', 4, 60.00),
(5, 'Python Basics', 5, 70.00),
(6, 'Python Basics', 6, 80.00),
(7, 'Python Basics', 7, 90.00),
(8, 'Python Basics', 8, 88.00),
(9, 'Python Basics', 9, 82.00),
(10, 'Python Basics', 10, 78.00),
(11, 'Python Basics', 11, 92.00),
(12, 'Python Basics', 12, 85.00),
(13, 'Python Basics', 13, 76.00),
(14, 'Python Basics', 14, 89.00),
(15, 'Python Basics', 15, 91.00);

-- Find students who scored less than 50% in the Linux course
SELECT s.student_id, s.student_name, l.grade_obtained
FROM students s
JOIN linux_grades l ON s.student_id = l.student_id
WHERE l.grade_obtained < 50;

-- Find students who took only one course (either Linux or Python, not both)
SELECT s.student_id, s.student_name
FROM students s
LEFT JOIN linux_grades l ON s.student_id = l.student_id
LEFT JOIN python_grades p ON s.student_id = p.student_id
WHERE (l.student_id IS NOT NULL AND p.student_id IS NULL)
   OR (l.student_id IS NULL AND p.student_id IS NOT NULL);

-- Find students who took both courses.
SELECT s.student_id, s.student_name
FROM students s
JOIN linux_grades l ON s.student_id = l.student_id
JOIN python_grades p ON s.student_id = p.student_id;

-- Calculate the average grade per course (Linux and Python separately).
SELECT 'Linux' AS course_name, AVG(grade_obtained) AS average_grade
FROM linux_grades
UNION ALL
SELECT 'Python' AS course_name, AVG(grade_obtained) AS average_grade
FROM python_grades;

-- Identify the top-performing student across both courses (based on the average of their grades).
SELECT s.student_id, s.student_name, AVG(g.grade_obtained) AS average_grade
FROM students s
JOIN (
    SELECT student_id, grade_obtained FROM linux_grades
    UNION ALL
    SELECT student_id, grade_obtained FROM python_grades
) g ON s.student_id = g.student_id
GROUP BY s.student_id, s.student_name
ORDER BY average_grade DESC
LIMIT 1;