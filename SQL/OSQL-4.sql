create database product_bd;

use product_bd;

-- ==============================
-- CREATE TABLES
-- ==============================

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category TEXT,
    price NUMERIC(10,2),
    stock_quantity INT,
    is_available BOOLEAN,
    added_on DATE
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    product_id INT,
    quantity INT,
    order_date DATE,
    customer_name VARCHAR(50),
    payment_method VARCHAR(50),
    CONSTRAINT fk_product
        FOREIGN KEY (product_id)
        REFERENCES products(product_id)
        ON DELETE CASCADE
);

-- ==============================
-- INSERT DATA INTO products
-- ==============================

INSERT INTO products (product_id, product_name, category, price, stock_quantity, is_available, added_on)
VALUES
(1, 'iPhone 14', 'Electronics', 70000.00, 10, TRUE, '2025-01-10'),
(2, 'Samsung TV', 'Electronics', 40000.00, 5, TRUE, '2025-02-05'),
(3, 'Nike Shoes', 'Fashion', 5000.00, 20, TRUE, '2025-01-15'),
(4, 'Yoga Mat', 'Fitness', 1000.00, 50, TRUE, '2025-03-01'),
(5, 'Dumbbells', 'Fitness', 2500.00, 15, TRUE, '2025-02-20'),
(6, 'Washing Machine', 'Electronics', 30000.00, 8, TRUE, '2025-01-25'),
(7, 'Wooden Chair', 'Furniture', 3500.00, 12, TRUE, '2025-02-18'),
(8, 'Book: SQL Basics', 'Books', 800.00, 30, TRUE, '2025-02-10');  -- never ordered

-- ==============================
-- INSERT DATA INTO orders
-- ==============================

INSERT INTO orders (order_id, product_id, quantity, order_date, customer_name, payment_method)
VALUES
(101, 1, 1, '2025-03-05', 'Amit Sharma', 'Credit Card'),
(102, 2, 2, '2025-03-06', 'Neha Verma', 'UPI'),
(103, 3, 1, '2025-03-07', 'Rahul Singh', 'Cash'),
(104, 4, 3, '2025-03-07', 'Amit Sharma', 'UPI'),
(105, 5, 2, '2025-03-08', 'Rohit Mehra', 'Debit Card'),
(106, 1, 1, '2025-03-09', 'Priya Nair', 'Credit Card'),
(107, 6, 1, '2025-03-10', 'Neha Verma', 'Net Banking'),
(108, 4, 1, '2025-03-11', 'Karan Kapoor', 'Cash'),
(109, 7, 4, '2025-03-11', 'Amit Sharma', 'UPI'),
(110, 5, 3, '2025-03-12', 'Rahul Singh', 'Credit Card');

select * from orders;
select * from products;

select o.order_id,o.customer_name, p.product_name,p.price 
from orders o inner join products p
on o.product_id = p.product_id;

select o.order_id,o.customer_name, p.product_name,p.price 
from  products p left join orders o
on o.product_id = p.product_id;

SELECT o.order_id, p.product_name, p.category
FROM orders o
JOIN products p ON o.product_id = p.product_id
WHERE p.category = 'Electronics';

SELECT o.order_id, p.product_name, p.price
FROM orders o
JOIN products p ON o.product_id = p.product_id
order by p.price desc;

SELECT  p.product_name, count(o.order_id) as total_orders 
FROM products p 
JOIN orders o ON o.product_id = p.product_id
group by p.product_name;

SELECT  p.product_name, sum(o.quantity * p.price) as revenue
FROM products p 
JOIN orders o ON o.product_id = p.product_id
group by p.product_name;

SELECT  p.product_name, sum(o.quantity * p.price) as revenue
FROM products p 
JOIN orders o ON o.product_id = p.product_id
group by p.product_name
having sum(o.quantity * p.price) > 2000;

SELECT  distinct o.customer_name
FROM orders o
JOIN products p ON o.product_id = p.product_id
where p.category = 'Fitness';

create table students (
 student_id int primary key,
 student_name varchar(100)
 );

insert into students (student_id,student_name) values
(1, 'Akarsh vyas'),
(2,'Simran'),
(3, 'Rohan');

select * from students;

CREATE TABLE courses (
   course_id INT PRIMARY KEY,
   course_name VARCHAR(100) NOT NULL
);   


insert into courses (course_id,course_name) values
(101, 'python'),
(102,'SQL'),
(103,'Power BI');

select * from courses;

create table student_courses (
   student_id int,
   course_id int,
   primary key (student_id, course_id),
   foreign key (student_id) references students(student_id),
   foreign key (course_id) references courses(course_id)
);

insert into student_courses (student_id,course_id) values
(1,101), -- AKARSH->PYTHON
(1,102), -- AKARSH -> SQL   
(2,101), -- SIMRAN -> PYTHON
(2,103), -- SIMRAN -> POWER BI
(3,102); -- rohan -> sql

SELECT 
    s.student_name, 
    c.course_name
FROM 
    student_courses sc
JOIN students s ON sc.student_id = s.student_id
JOIN courses c ON sc.course_id = c.course_id;

SELECT 
    c.course_name
FROM 
    student_courses sc
JOIN students s ON sc.student_id = s.student_id
JOIN courses c ON sc.course_id = c.course_id
WHERE 
    s.student_name = 'Simran';

SELECT * FROM student_courses;
 select * from products;
 
 use flipkart_db;
 create view fitness_items as
 select product_id,name,price,stock_quantity
 from products
 where category = 'Fitness';
 
 create view low_stock as
 select name,category,stock_quantity
 from products
 where stock_quantity <30;

-- Step 1: Use your database (or create one)
CREATE DATABASE IF NOT EXISTS my_store;
USE my_store;

-- Step 2: Create the products table
DROP TABLE IF EXISTS products;


CREATE TABLE products (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    sku_code CHAR(8) NOT NULL UNIQUE,
    price DECIMAL(10,2) NOT NULL,
    stock_quantity INT NOT NULL,
    category VARCHAR(100)
);

-- Step 3: Change delimiter for stored procedure
DELIMITER $$

-- Step 4: Create stored procedure
CREATE PROCEDURE add_product(
    IN p_name VARCHAR(100),
    IN p_sku CHAR(8),
    IN p_price DECIMAL(10,2),
    IN p_qty INT,
    IN p_category VARCHAR(100)
)
BEGIN
    INSERT INTO products(name, sku_code, price, stock_quantity, category)
    VALUES (p_name, p_sku, p_price, p_qty, p_category);

    SELECT 'Product added successfully!' AS message;
END$$

-- Step 5: Reset delimiter
DELIMITER ;

-- Step 6: Call the procedure
CALL add_product('bottle', 'bo123467', 234.00, 45, 'Fitness');

-- Step 7: Optional - View inserted row
SELECT * FROM products;


-- Step 5: Reset delimiter back to default
DELIMITER ;

-- Step 6: Call the procedure with sample data
CALL add_product('bottle', 'bo123467', 234.00, 45, 'Fitness');

-- Optional: View inserted product
SELECT * FROM products;



