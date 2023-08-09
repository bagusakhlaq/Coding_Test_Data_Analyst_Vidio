USE vidio_test;
CREATE TABLE student (
	student_id INT,
    name_student TEXT,
    age INT
    );
CREATE TABLE classroom (
	classroom_id INT,
    student_id INT
    );
INSERT INTO student 
	(student_id, name_student, age)
VALUES
	(1, "John", 15),
    (2, "Marqueez", 16),
    (3, "Cihp", 14),
    (4, "Marley", 14);
INSERT INTO classroom
	(classroom_id, student_id)
VALUES
	(123, 1),
    (234, 2),
    (123, 4);

#---Question 1
# Part A: Find out what classroom that has no students on those table using SQL
SELECT
    c.classroom_id,
    COUNT(s.name_student) AS total_student
FROM student AS s
RIGHT JOIN classroom AS c
ON s.student_id = c.student_id
GROUP BY 1
ORDER BY 2 DESC;

# ANSWER: There is no classroom without students, but there is student who has not classroom
-----------------------------------------------

#Part B: Could you display what classroom_id that each student has ? use SQL
SELECT
	s.student_id,
    s.name_student,
    c.classroom_id
FROM student AS s
LEFT JOIN classroom AS c
ON s.student_id = c.student_id;

# ANSWER: Only Chip who doesn't have classroom
-----------------------------------------------

/*
Part C: Create a group for students that have age > 15 is called “high school” 
and age < 16 called “middle school”, and count how many students that belong to that group.
*/
SELECT 
	CASE
		WHEN age > 15 THEN "High School"
        WHEN age < 16 THEN "Middle School"
	ELSE age END AS age_group,
    COUNT(student_id) AS total_student
FROM student
GROUP BY 1
ORDER BY 1;

# ANSWER: There are only one student in High School age group, and the other three are in Middle School
-----------------------------------------------

#Part D: Create SQL that give output that marqueez is the oldest student
# 1st Method
SELECT * FROM student ORDER BY age DESC LIMIT 1;

# 2nd Method
SELECT
	student_id,
    name_student,
    RANK() OVER (ORDER BY age DESC) AS age_rank
FROM student
LIMIT 1;

-----------------------------------------------

# Part E: Find out the cumulative age from the students table for each student record, like the table below.
SELECT
	student_id,
    name_student,
    age,
    SUM(age) OVER (
					ORDER BY student_id ASC
					ROWS BETWEEN 3 PRECEDING AND CURRENT ROW
                    ) AS cumulative_age
FROM student
ORDER BY 1;
-----------------------------------------------

# Part F: 
