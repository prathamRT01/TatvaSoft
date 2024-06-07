CREATE DATABASE tatvasoft

CREATE TABLE [IF NOT EXISTS] employee


CREATE TABLE students (
    student_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    gender VARCHAR(10),
    email VARCHAR(100) UNIQUE NOT NULL
);

DROP TABLE IF EXISTS students

INSERT INTO students (first_name, last_name, gender, email) VALUES (
    'pratham', 'thakkar', 'Male', 'prathamthakkar@gmail.com');

INSERT INTO students (first_name, last_name, gender, email) VALUES 
	('Jane', 'Smith', 'Female', 'jane.smith@example.com'),
	('Alice', 'Johnson', 'Female', 'alice.johnson@example.com'),
	('Bob', 'Brown', 'Male', 'bob.brown@example.com'),
	('Charlie', 'Davis',  'Male', 'charlie.davis@example.com');
	
SELECT * FROM students


CREATE TABLE results (
    result_id SERIAL PRIMARY KEY,
    student_id INTEGER NOT NULL REFERENCES students(student_id),
    exam_name VARCHAR(100) NOT NULL,
    score NUMERIC(5, 2) NOT NULL
);


INSERT INTO results (student_id, exam_name, score) VALUES
(1, 'Mathematics', 85.50),
(2, 'Mathematics', 92.00),
(3, 'Mathematics', 76.75),
(4, 'Mathematics', 88.25),
(5, 'Mathematics', 91.00),
(1, 'Physics', 79.50),
(2, 'Physics', 85.75),
(3, 'Physics', 68.00),
(4, 'Physics', 94.50),
(5, 'Physics', 89.00),
(1, 'Chemistry', 87.25);

SELECT * FROM results


-- Update Statement
UPDATE results
SET score=90
WHERE result_id = 11;
	
-- Delete Statement
DELETE FROM results
WHERE result_id = 11;

--select statement
SELECT first_name,last_name,email FROM students;

--OrderBy 
SELECT first_name,last_name,email FROM students ORDER BY first_name ASC;

SELECT first_name,last_name,email FROM students ORDER BY last_name DESC;

--where clause
SELECT
	first_name,
	last_name,
	email
FROM
	students
WHERE
	first_name = 'pratham' AND last_name = 'thakkar';

SELECT
	first_name,
	last_name,
	email
FROM
	students
WHERE
	first_name IN ('pratham','Alice');

SELECT
	first_name,
	last_name,
	email
FROM
	students
WHERE
	first_name LIKE '%a%';

--join
SELECT * FROM students as s
INNER JOIN results as r
ON s.student_id = r.student_id

--GroupBy
SELECT
	s.student_id,
	s.first_name,
	s.last_name,
	s.gender,
	s.email,
	COUNT (r.result_id) AS "NoOfSubjects",
	AVG(r.score) AS "Average"
FROM students as s
INNER JOIN results as r
	ON s.student_id = r.student_id
GROUP BY s.student_id 
ORDER BY s.student_id;

--Having
SELECT
	s.student_id,
	s.first_name,
	s.last_name,
	s.gender,
	s.email,
	COUNT (r.result_id) AS "NoOfSubjects",
	AVG (r.score) AS "Average"
FROM students as s
INNER JOIN results as r
	ON s.student_id = r.student_id
GROUP BY s.student_id 
HAVING AVG (r.score) >= 82.5
ORDER BY s.student_id


--sub query
SELECT * from results
where student_id IN (select student_id from students where first_name='pratham')

SELECT
    student_id,
	first_name,
	last_name,
	email
FROM
	students
WHERE
	EXISTS (
		SELECT
			1
		FROM
			results
		WHERE
			results.student_id = students.student_id
	);



