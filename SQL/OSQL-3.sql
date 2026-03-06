-- 1. Create and select the database
CREATE DATABASE IF NOT EXISTS SCHOOL_DB;
USE SCHOOL_DB;

-- 2. Create the 'students' table
CREATE TABLE IF NOT EXISTS students (
  student_id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) NOT NULL
);

-- 3. Insert data into 'students'
INSERT INTO students (name)
VALUES
('Akarsh Vyas'),
('Simran Mehta'),
('Rohan Gupta');

-- 4. Create the 'student_profiles' table with matching data type for student_id
CREATE TABLE IF NOT EXISTS student_profiles (
  student_id BIGINT UNSIGNED PRIMARY KEY,
  address TEXT,
  age INT,
  phone VARCHAR(15)
);

-- 5. Insert data into 'student_profiles'
INSERT INTO student_profiles (student_id, address, age, phone)
VALUES
(1, 'Delhi, India', 22, '9999999999'),
(2, 'Mumbai, India', 21, '8888888888'),
(3, 'Bangalore, India', 23, '7777777777');

desc students;
desc student_profiles;

alter table student_profiles modify student_id int;


-- 6. Add the foreign key constraint (will now succeed)
ALTER TABLE student_profiles
ADD CONSTRAINT fk_student_id
FOREIGN KEY (student_id)
REFERENCES students(student_id);

-- 7. View data in both tables
SELECT * FROM students;
SELECT * FROM student_profiles;

SELECT 
   s.student_id,
   s.name,
   sp.address,
   sp.age,
   sp.phone
FROM students s
JOIN student_profiles sp
ON s.student_id = sp.student_id;

create table students (
student_id serial primary key,
name varchar(100) not null
);

CREATE TABLE marks (
  marks_id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  student_id BIGINT UNSIGNED,
  subject VARCHAR(50),
  marks INT,
  FOREIGN KEY (student_id) REFERENCES students(student_id)
);

insert into students (name)
values ('Akarsh vyas'),('Simran Mehta'),('Rohan Gupta');

select * from students;

-- Insert marks data
INSERT INTO marks (student_id, subject, marks)
VALUES
(1, 'English', 85),
(1, 'Math', 89),
(1, 'Science', 92),

(2, 'English', 80),
(2, 'Math', 75),
(2, 'Science', 78),

(3, 'English', 72),
(3, 'Math', 70),
(3, 'Science', 74);

-- View data
SELECT * FROM students;
SELECT * FROM marks;

select  * from students s join marks m on s.student_id = m.student_id;
select s.name,m.subject,m.marks from students s join marks m on s.student_id = m.student_id;

select s.name,m.subject,m.marks from students s join marks m on s.student_id = m.student_id where name = 'Simran mehta';

insert into students (name)
values ('Harsh Patel');

INSERT INTO marks (student_id, subject, marks)
VALUES (4, 'English',34);

select s.name,m.subject,m.marks
 from students s  left join marks m
 on s.student_id = m.student_id;
 
 select s.name,m.subject,m.marks
 from students s  right join marks m
 on s.student_id = m.student_id;
 
 insert into students (name)
values ('sarthak sharma');
 
 SELECT s.student_id, s.name, m.subject, m.marks
FROM students s
LEFT JOIN marks m ON s.student_id = m.student_id

UNION

SELECT s.student_id, s.name, m.subject, m.marks
FROM students s
RIGHT JOIN marks m ON s.student_id = m.student_id;

