create database after_joins_june;
use after_joins_june;

CREATE TABLE sales_data (
    year INT,
    country VARCHAR(50),
    product VARCHAR(50),
    profit INT
);

INSERT INTO sales_data (year, country, product, profit) VALUES
(2000, 'Finland', 'Computer', 1500),
(2000, 'Finland', 'Phone', 100),
(2001, 'Finland', 'Phone', 10),
(2000, 'India', 'Calculator', 75),
(2000, 'India', 'Calculator', 75),
(2000, 'India', 'Computer', 1200),
(2000, 'USA', 'Calculator', 75),
(2000, 'USA', 'Computer', 1500),
(2001, 'USA', 'Calculator', 50),
(2001, 'USA', 'Computer', 1500),
(2001, 'USA', 'Computer', 1200),
(2001, 'USA', 'TV', 150),
(2001, 'USA', 'TV', 100);

select * from sales_data;

-- creating the new table from the existing table
create table usa_sales  AS
select * from sales_data where country = "USA";

CREATE TABLE COUNTRY_PROFIT AS
SELECT COUNTRY,SUM(PROFIT) FROM SALES_DATA
GROUP BY COUNTRY;

SELECT * FROM sales_data;

CREATE TABLE INDIA_SALES(
YEAR INT,
PRODUCT VARCHAR(50),
PROFIT INT);

SELECT * FROM INDIA_SALES;

-- INSERTING THE DATA IN THE EXISTING TABLE FROM ANOTHER EXISTING TABLE

INSERT INTO INDIA_SALES

SELECT YEAR,PRODUCT,PROFIT
FROM SALES_DATA WHERE COUNTRY = "INDIA";

SELECT * FROM  INDIA_SALES;

-- CONSTRAINTS: USED TO SPECIFY RULES FOR THE COLUMNS IN THE TABLE.
-- NOT NULL, UNIQUE, PRIMARY KEY (NOT NULL AND UNIQUE),
--  FOREIGN KEY (NOT NULL BUT CAN REPEAT), DEFAULT, CHECK, INDEX, ENUM,SET
-- AUTO_INCREMENT

CREATE TABLE COLLEGE(
S_NO INT auto_increment primary key,
name varchar(20) not null,
roll_no int unique not null,
salary int default 3000,
age int check  (age>=18),
gender  enum ("male","female"), -- allow only one value from enum
prog_lang set ("python","sql","java") -- can allow combination as well
);

select * from college;

insert into college
(name,roll_no,salary,age,gender,prog_lang)
values
("Ram",10,300,23,"MALE","Python");

select * from college;
insert into college
(name,roll_no,age,gender,prog_lang)
values
("Rama",13,20,"Male","Python");

-- ADDING THE CONSTRAINT IN THE EXISTING TABLE
ALTER TABLE COLLEGE ADD COLUMN CITY VARCHAR(20) NOT NULL;


insert into college
(name,roll_no,age,gender,prog_lang)
values
("Rama",14,20,"Male","Python");


SELECT * FROM COLLEGE;

ALTER TABLE COLLEGE MODIFY COLUMN CITY VARCHAR(20) NOT NULL default "bhopal";

/*
ALTER TABLE COLLEGE
ADD constraint PK_NAME_CITY
primary key (NAME,CITY);
*/

-- CASCADING:  USED TO MAKE THE RELATIONSHIP BTW TWO OR MORE THAN TWO TABLES.
-- on update cascade, on delete cascade
use after_joins_june;

create table department(
dept_id int primary key,
dept_name varchar(20));

select * from department;

insert into department
values
(1,"maths"),
(2,"physics"),
(3,"chemistry");

create table teachers(
teacher_id int primary key,
name varchar(20),
dept_id int,
foreign key (dept_id) 
references department(dept_id)
on update cascade
on delete cascade
);

select * from teachers;

insert into teachers
values
(10,"ram",2),
(11,"ramaa",2),
(12,"shayam",1),
(13,"shayama",3);

select * from department;

update department
set dept_id = 10
where dept_id = 1;

select * from teachers;


delete from department
where dept_id = 2;

select * from department;
select * from teachers;

insert into teachers
values
(15,"ram",20); -- giving error cz dept_id = 20 doest not exist in department table

/*
views: virtual table based on the result-set of a sql statement.
-- VIEW CONTAINS ROWS AND COLUMNS, JUST LIKE A REAL TABLE. tHE FIELD IN A VIEW ARE FIELD FROM ONE OR MORE
THAN ONE TABLE IN THE DATABASE.
-- IT ALLOWS US TO ENCAPSULATE OR HIDE COMPLEXITIES OR ALLOW LIMITED READ ACCESS TO PART OF THE DATA.

-- IT DOESNT STORE DATA DIRECTLY IN THE VIEW ONLY CAN DISPLAY DATA FROM THE ACTUAL TABLES

SYNTAX:
CREATE VIEW VIEW_NAME AS
	SELECT  COL1,COL2..... FROM TABLE_NAME...
*/

SELECT * FROM SALES_DATA;

create view profit_5 as
SELECT * FROM SALES_DATA
WHERE COUNTRY LIKE "f%d" and profit>50;

select * from profit_50;

update sales_data
set profit = 1000 where profit = 1500;

select * from sales_data;
select * from profit_50;
set sql_safe_updates=0;

update profit_50
set product = "laptop"
where product = "phone";

select * from profit_50;
select * from sales_data;

DROP VIEW PROFIT_50;

SELECT * FROM SALES_DATA;

-- CASE STATEMENTS:
/* ALLOWS US TO PERFORM CONDITIOAL LOGIC WITHIN OUR QUERY,
-- THEY ARE HELPFUL WHEN WE NEED TO PERFORM DIFFERENT ACTIONS OR CALCULATIONS BASED
ON CERTAIN CONDITIONS.

1. SIMPLE CASE STATEMENTS : ON A SET OF SINGLE CONDITIONS ONLY
2. SEARCHED CASE STATEMENTS : ON A SET OF MULTIPLE CONDITIONS OR COMBO OF CONDITIONS
*/

CREATE table DETAILS(
ID INT,
NAME VARCHAR(20),
GENDER VARCHAR(20),
MARRIED VARCHAR(20),
SALARY INT);

INSERT INTO DETAILS
VALUES
(1,"RAM","M","yes",10000),
(2,"sita","f","yes",2000),
(3,"rohit","m","no",20000),
(4,"Mohit","m","Yes",20000),
(5,"rita","f","no",30000);

select * from details;


select 
case 
	when salary<11000 then "low salary"
	when salary<22000 then "mid salary"
	else "high salary"
end as sal_category
from details;

select *,
case 
	when GENDER ="M" THEN "Mr."
	when gender="f" and married="yes" then "Mrs."
	else "Miss"
end as prefix
from details;

select * from details;

alter table details
add column prefix varchar(20);

select * from details;

update details
set prefix = 
case 
	when GENDER ="M" THEN "Mr."
	when gender="f" and married="yes" then "Mrs."
	else "Miss"
end;

select * from details;


/*
subqueries: allows us to nest one query(inner query) inside another query
(outer query).
 
the result of the inner query is used by the outer query to perform further
operations
*/

select * from sales_data 
where profit>(select avg(profit) from sales_data where country = "usa");


select avg(profit) from sales_data;


