CREATE DATABASE new_db;

USE new_db;
CREATE TABLE students (
student_id INT,
name char(50),
age INT,
grade CHAR(1)
);
INSERT INTO students (name,age,grade)
values ('Akarsh',23,'A'),
        ('Anjali',22,'B'),
        (3, 'Raj',23,'C');

select name from students where age = 23;
select * from students;

set sql_safe_updates = 0;

update students
set age = 24
where name = 'Akarsh';

update students
set student_id = 1
where name = 'Akarsh';

update students
set student_id = 2
where name = 'Anjali';

select * from students;

delete from students
where name = 'Raj';

create table numbers (
ID serial,
age smallint,
price numeric(4,2),
rating Real
);

insert into numbers (age,price,rating)
values (23,23.67,12.567);

select * from numbers;

create table strings (
code char(5),
email varchar(100),
bio text
);

insert into strings
values ('23vb4','akarshvyas@gmail.com','hello i am a developer ');

select * from strings;

create table random (
ID serial primary key,
name varchar(100) not null,
email varchar(255) not null,
created_at datetime default current_timestamp,
age int check (age >= 18)
);

insert ignore into random (name,email,age)
value ('Akarsh','akarshvyas100@gmail.com',23);

insert into random (name,email,age)
value ('Anjali','anjali@gmail.com',22);

select * from random;

alter table students
add column email varchar(100);

select * from students;

alter table students
drop column email;

alter table students
rename column name to full_name;

alter table students
alter column age type int;

alter table students
alter column age set default 18;

alter table students
alter column age drop default;

select * from students;
alter table students
add constraint age_check  check (age >= 0);

alter table students
rename to school_students;

select * from school_students;

