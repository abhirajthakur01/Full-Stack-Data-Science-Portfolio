use sql_june_joins;

-- STATES
CREATE TABLE States (
    state_id INT PRIMARY KEY,
    state_name VARCHAR(100)
);

-- CITIES
CREATE TABLE Cities (
    city_id INT PRIMARY KEY,
    city_name VARCHAR(100),
    state_id INT,
    FOREIGN KEY (state_id) REFERENCES States(state_id)
);

-- STUDENTS
CREATE TABLE Students (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(100),
    age INT,
    gender VARCHAR(10),
    city_id INT,
    FOREIGN KEY (city_id) REFERENCES Cities(city_id)
);

-- COURSES
CREATE TABLE Courses (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(100),
    student_id INT,
    teacher_name VARCHAR(100),
    course_fee INT,
    FOREIGN KEY (student_id) REFERENCES Students(student_id)
);
-- STATES
INSERT INTO States VALUES 
(1, 'Maharashtra'), (2, 'Uttar Pradesh'), (3, 'Tamil Nadu'), (4, 'West Bengal');

-- CITIES
INSERT INTO Cities VALUES 
(1, 'Mumbai', 1), (2, 'Pune', 1), (3, 'Lucknow', 2), 
(4, 'Chennai', 3), (5, 'Kolkata', 4);

-- STUDENTS
INSERT INTO Students VALUES 
(101, 'Rahul Sharma', 20, 'Male', 1),
(102, 'Anjali Verma', 22, 'Female', 1),
(103, 'Vikas Yadav', 21, 'Male', 3),
(104, 'Sneha Iyer', 23, 'Female', 4),
(105, 'Rohit Das', 22, 'Male', 5),
(106, 'Priya Mehta', 21, 'Female', 1),
(107, 'Amit Dubey', 22, 'Male', 3),
(108, 'Sonal Kapoor', 23, 'Female', 3),
(109, 'Karan Singh', 20, 'Male', 2),
(110, 'Neha Patil', 22, 'Female', 2);

-- COURSES
INSERT INTO Courses VALUES 
(201, 'Data Science', 101, 'Dr. Mehta', 30000),
(202, 'Data Science', 102, 'Dr. Mehta', 30000),
(203, 'Python', 103, 'Mr. Khan', 15000),
(204, 'Python', 104, 'Mr. Khan', 15000),
(205, 'SQL', 105, 'Mrs. Singh', 10000),
(206, 'Java', 106, 'Mr. Roy', 20000),
(207, 'SQL', 107, 'Mrs. Singh', 10000),
(208, 'Python', 108, 'Mr. Khan', 15000),
(209, 'Java', 109, 'Mr. Roy', 20000),
(210, 'Data Science', 110, 'Dr. Mehta', 30000);

show tables;

select * from states;
select * from cities;
select * from students;
select * from courses;
-- state wise total cities
select states.state_name, count(cities.city_id)
from cities inner join states
on states.state_id = cities.state_id
group by states.state_name;

-- count of gender by gender and state wise

select states.state_name,students.gender,count(students.gender)
from states join cities on states.state_id = cities.state_id
inner join students on students.city_id = cities.city_id
group by states.state_name,students.gender;

SELECT STATES.STATE_NAME, COUNT(STUDENTS.STUDENT_ID)
FROM STATES JOIN CITIES ON STATES.STATE_ID = CITIES.STATE_ID
JOIN STUDENTS ON STUDENTS.CITY_ID = CITIES.CITY_ID
GROUP BY STATES.STATE_NAME;

-- 1.Count students per state.
SELECT States.state_name, COUNT(Students.student_id) AS total_students
FROM States 
JOIN Cities  ON States.state_id = Cities.state_id
JOIN Students  ON Cities.city_id = Students.city_id
GROUP BY States.state_name;

-- 2. List number of students in each city.
SELECT c.city_name, COUNT(s.student_id) AS student_count
FROM Cities c
JOIN Students s ON c.city_id = s.city_id
GROUP BY c.city_name;

-- 3.List number of students enrolled in each course.
SELECT COURSE_NAME,COUNT(STUDENT_ID)
FROM COURSES
GROUP BY COURSE_NAME;

-- 4.List total revenue generated per course.
SELECT COURSE_NAME,SUM(COURSE_FEE)
FROM COURSES GROUP BY COURSE_NAME;




SELECT course_name, SUM(course_fee) AS total_revenue
FROM Courses
GROUP BY course_name;

-- 5.Find average course fee per teacher.
SELECT teacher_name, AVG(course_fee)
FROM Courses
GROUP BY teacher_name;

-- 6. List courses with more than 2 students enrolled.
SELECT course_name, COUNT(*) AS total_students
FROM Courses
GROUP BY course_name
HAVING COUNT(*) > 2;

-- 7. Teachers whose total revenue generated is more than ₹40,000.
SELECT teacher_name, SUM(course_fee) AS total_revenue
FROM Courses
GROUP BY teacher_name
HAVING SUM(course_fee) > 40000;

-- 8. Cities with more than 2 students.
SELECT CITIES.CITY_NAME,COUNT(STUDENTS.student_id)
FROM CITIES JOIN STUDENTS ON CITIES.CITY_ID = STUDENTS.CITY_ID
GROUP BY CITIES.CITY_NAME
HAVING COUNT(STUDENTS.student_id)>2;




SELECT c.city_name, COUNT(s.student_id) AS student_count
FROM Cities c
JOIN Students s ON c.city_id = s.city_id
GROUP BY c.city_name
HAVING COUNT(s.student_id) > 2;

-- 9.States where average course fee is more than ₹20000.
SELECT st.state_name, AVG(co.course_fee) AS avg_fee
FROM States st
JOIN Cities ci ON st.state_id = ci.state_id
JOIN Students s ON ci.city_id = s.city_id
JOIN Courses co ON s.student_id = co.student_id
GROUP BY st.state_name
HAVING AVG(co.course_fee) > 20000;

-- 10.Find teachers who taught more than 2 different students.
SELECT distinct(TEACHER_NAME) FROM COURSES;

SELECT TEACHER_NAME,COUNT(DISTINCT STUDENT_ID) AS TOTAL_STUDENT
FROM COURSES
GROUP BY TEACHER_NAME
HAVING COUNT(DISTINCT STUDENT_ID)>2;






SELECT teacher_name, COUNT(DISTINCT student_id) AS students_taught
FROM Courses
GROUP BY teacher_name
HAVING COUNT(DISTINCT student_id) > 2;

-- 11. Show total number of male and female students per state.
SELECT st.state_name, s.gender, COUNT(*) AS total
FROM Students s
JOIN Cities c ON s.city_id = c.city_id
JOIN States st ON c.state_id = st.state_id
GROUP BY st.state_name, s.gender;

-- 12. Course-wise gender distribution.
SELECT c.course_name, s.gender, COUNT(*) AS total
FROM Courses c
JOIN Students s ON c.student_id = s.student_id
GROUP BY c.course_name, s.gender;

-- 13. Show top 3 cities with highest number of students.
SELECT c.city_name, COUNT(s.student_id) AS student_count
FROM Cities c
JOIN Students s ON c.city_id = s.city_id
GROUP BY c.city_name
ORDER BY student_count DESC
LIMIT 3;

-- 14.Total students and average age per city.
SELECT c.city_name, COUNT(s.student_id) AS total_students, AVG(s.age) AS avg_age
FROM Cities c
JOIN Students s ON c.city_id = s.city_id
GROUP BY c.city_name;

-- 15. Show state-wise total course fees collected.
SELECT st.state_name, SUM(co.course_fee) AS total_collected
FROM States st
JOIN Cities ci ON st.state_id = ci.state_id
JOIN Students s ON ci.city_id = s.city_id
JOIN Courses co ON s.student_id = co.student_id
GROUP BY st.state_name;


-- 16.Which course has the highest average fee?
SELECT course_name, AVG(course_fee) AS avg_fee
FROM Courses
GROUP BY course_name
ORDER BY avg_fee DESC
LIMIT 1;

-- 17. Which teacher teaches the most students?
SELECT teacher_name, COUNT(*) AS students
FROM Courses
GROUP BY teacher_name
ORDER BY students DESC
LIMIT 1;

-- 18.Which city contributes the most to revenue?
SELECT ci.city_name, SUM(co.course_fee) AS city_revenue
FROM Cities ci
JOIN Students s ON ci.city_id = s.city_id
JOIN Courses co ON s.student_id = co.student_id
GROUP BY ci.city_name
ORDER BY city_revenue DESC
LIMIT 1;

-- 19. Find cities where total revenue is below ₹40000.
-- 20. Find teachers whose average fee per student is above ₹25000.