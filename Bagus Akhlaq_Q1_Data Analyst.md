<link href="https://fonts.googleapis.com/css?family=Inter" rel='stylesheet'>
<style>
    body {
        font-family:'Inter'
    }
    h1, h2, h3, h4, h5, h6 {
        font-weight: bold;
    }
    blockquote {
        background-color: rgba(220, 220, 220, 0.25);
        font-weight: 500;
    }
    p, li {
        font-weight: 400;
    }
    #port-img {
        display: block;
        margin-left: auto;
        margin-right: auto;
        width: 100%;
        max-width: 275px;
        height: auto;
    }
    #lands-img {
        display: block;
        margin-left: auto;
        margin-right: auto;
        width: 100%;
        max-width: 545px;
        height: auto;
    }
    #lands2-img {
        display: block;
        margin-left: auto;
        margin-right: auto;
        width: 100%;
        max-width: 850px;
        height: auto;
    }
    /* X-Small devices (portrait phones, less than 576px) */
    /* @media only screen and (min-width: 300px) {
		h1, h2, h3, h4, h5, p, li {font-size: 1.2vw;}
		th {font-size: 3.4vw;} 
		td {font-size: 1.4vw;} 
		pre, label {font-size: 3vw;}
		blockquote {font-size: 1.2vw;}
		.katex {font-size: 4vw;}
		input[type="checkbox" i] {width: 25px; height: 25px;}
	} */
	@media only screen and (max-width: 478px) { 
		h1, h2, h3, h4, h5, p, li {font-size: 1.2vw;}
		th {font-size: 3.4vw;} 
		td {font-size: 1.4vw;} 
		pre, label {font-size: 3vw;}
		blockquote {font-size: 1.2vw;}
		.katex {font-size: 4vw;}
		input[type="checkbox" i] {width: 25px; height: 25px;}
	}
    /* Small devices (landscape phones, less than 768px) */
    @media (max-width: 767px) { 
        th, td, pre {font-size: 2vw;} 
        }
    /* Medium devices (tablets, less than 992px) 
    @media (max-width: 991.98px) { 
        th, td, pre {font-size: 3vw;} 
        } */


</style>

# Data Analyst Coding Test Vidio.com
## By Bagus Akhlaq
---
# Question 1
There is a dataset which contains 2 tables. Student and Classroom. 
> *I use MySQL as the programming language to answer following questions*
<br>

## Set up database
```sql
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
```
## Part A
Question: 
>Find out what classroom that has no students on those table using SQL

```sql
SELECT
    c.classroom_id,
    COUNT(s.name_student) AS total_student
FROM student AS s
RIGHT JOIN classroom AS c
ON s.student_id = c.student_id
GROUP BY 1
ORDER BY 2 DESC;
```
Answer:
> There is no classroom without students, but there is student who has no classroom

## Part B
Question:
>Could you display what classroom_id that each student has ? use SQL

```sql
SELECT
	s.student_id,
    s.name_student,
    c.classroom_id
FROM student AS s
LEFT JOIN classroom AS c
ON s.student_id = c.student_id;
```
Answer:
> Only Chip who doesn't have classroom

## Part C
Question:
>Create a group for students that have age > 15 is called “high school” and age < 16 called “middle school”, and count how many students that belong to that group.

```sql
SELECT 
	CASE
		WHEN age > 15 THEN "High School"
        WHEN age < 16 THEN "Middle School"
	ELSE age END AS age_group,
    COUNT(student_id) AS total_student
FROM student
GROUP BY 1
ORDER BY 1;
```
Answer:
> There are only one student in High School age group, and the other three are in Middle School

## Part D
Question:
> Create SQL that give output that marqueez is the oldest student

```sql
/* 1st Method */
SELECT * FROM student ORDER BY age DESC LIMIT 1;

/* 2nd Method */
SELECT
	student_id,
    name_student,
    RANK() OVER (ORDER BY age DESC) AS age_rank
FROM student
LIMIT 1;
```

## Part E
Question:
>Find out the cumulative age from the students table for each student record, like the table below.

```sql
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
```

## Part F
Question:
>What insight that you could find from students & classroom tables ? No need to use SQL, just use human language to describe those tables. And also, what question could you create from those tables ?

Answer:
>Most students in the data are still in the middle school. The classroom table needs to be updated and restructured to ensure the data is complete to record all rows in the student table. \
>We can also dig deeper into the data to know what is the average age of overall students, how is the student distribution by age, and what is most likely classroom for Chip.