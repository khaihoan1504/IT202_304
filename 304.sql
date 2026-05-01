CREATE DATABASE bamuoithangtu;
USE bamuoithangtu;

CREATE TABLE teachers (
    id INT PRIMARY KEY AUTO_INCREMENT,
    full_name VARCHAR(100) NOT NULL,
    salary DECIMAL(15, 2) CHECK (salary > 0)
);

CREATE TABLE courses (
    id INT PRIMARY KEY AUTO_INCREMENT,
    course_name VARCHAR(100) NOT NULL,
    teacher_id INT,
    credits INT CHECK (credits > 0),
    tuition_fee DECIMAL(15, 2),
    FOREIGN KEY (teacher_id) REFERENCES teachers(id) ON DELETE SET NULL
);

CREATE TABLE students (
    id INT PRIMARY KEY AUTO_INCREMENT,
    full_name VARCHAR(100) NOT NULL,
    date_of_birth DATE,
    gender ENUM('Male', 'Female', 'Other')
);

CREATE TABLE enrollments (
    id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT NOT NULL,
    course_id INT NOT NULL,
    enroll_date DATE DEFAULT (CURRENT_DATE),
    score DECIMAL(4, 2) CHECK (score >= 0 AND score <= 10),
    FOREIGN KEY (student_id) REFERENCES students(id) ON DELETE CASCADE,
    FOREIGN KEY (course_id) REFERENCES courses(id) ON DELETE CASCADE
);

INSERT INTO teachers (full_name, salary) VALUES 
('Nguyen Van A', 15000000),
('Tran Thi B', 18000000),
('Le Van C', 20000000);

INSERT INTO courses (course_name, teacher_id, credits, tuition_fee) VALUES 
('IT: Java Programming', 1, 3, 3000000),
('IT: Database SQL', 1, 3, 2500000),
('Soft Skills', 2, 2, 1500000),
('English Communication', 2, 4, 4000000),
('IT: Web Development', 3, 3, 3500000),
('Graphic Design', NULL, 3, 2800000);

INSERT INTO students (full_name, date_of_birth, gender) VALUES 
('Pham Hoan', '2006-05-20', 'Male'),
('Le Chi', '2006-02-15', 'Female'),
('Nguyen Dung', '2006-11-10', 'Male'),
('Hoang Long', '2005-08-22', 'Male'),
('Tran Vy', '2006-03-30', 'Female'),
('Do Nam', '2006-07-12', 'Male'),
('Bui Anh', '2006-01-05', 'Female'),
('Ly Duc', '2006-09-18', 'Male'),
('Vu Lan', '2006-12-25', 'Female'),
('Ngo Son', '2005-04-02', 'Male');

INSERT INTO enrollments (student_id, course_id, enroll_date, score) VALUES 
(1, 1, '2026-04-01', 8.5), (1, 2, '2026-04-01', 9.0),
(2, 1, '2026-04-02', 7.0), (2, 3, '2026-04-02', 8.0),
(3, 5, '2026-04-03', 6.5), (4, 5, '2026-04-03', 10.0),
(5, 4, '2026-04-04', 7.5), (6, 1, '2026-04-05', 8.0),
(7, 2, '2026-04-05', 9.5), (8, 6, '2026-04-06', 7.0),
(9, 3, '2026-04-07', 8.5), (10, 4, '2026-04-08', 6.0),
(1, 5, '2026-04-10', 9.0),
(3, 1, '2026-04-12', NULL),
(5, 2, '2026-04-12', NULL);

UPDATE teachers 
SET salary = salary * 1.1
WHERE id IN (
    SELECT DISTINCT teacher_id 
    FROM courses 
    WHERE course_name LIKE '%IT%'
);