
-- HAVING:
/* USED TO FILTER THE RESULTS OF A QUERY BASED ON CONDITIONS
APPLIED TO AGGREGATED VALUES. IT IS OFTEN USED IN COMBINATION
WITH THE GROUP BY CLAUSE TO SPECIFY CONDITIONS ON GROUP OF ROWS.

SELECT COL1,COL2,...
FROM TABLE_NAME
WHERE CONDITION
GROUP BY COL1,COL2....
HAVING CONDITION
ORDER BY COL1,COL2,...
 */

create DATABASE IndianBusiness;
USE IndianBusiness;
SHOW TABLES;

-- BASIC JOIN QUESTIONS
CREATE TABLE Citizens (
    CitizenID INT PRIMARY KEY,
    Name VARCHAR(50),
    CityID INT,
    Age INT
);
INSERT INTO Citizens 
(CitizenID, Name, CityID, Age) 
VALUES
(1, 'Rajesh Kumar', 1, 30),
(2, 'Neha Sharma', 2, 28),
(3, 'Amit Verma', 3, 35),
(4, 'Priya Iyer', 4, 32),
(5, 'Vikram Singh', 5, 40);


CREATE TABLE Cities (
    CityID INT PRIMARY KEY,
    CityName VARCHAR(50),
    State VARCHAR(50)
);
INSERT INTO Cities (CityID, CityName, State) VALUES
(1, 'Mumbai', 'Maharashtra'),
(2, 'Bangalore', 'Karnataka'),
(3, 'Delhi', 'Delhi'),
(4, 'Chennai', 'Tamil Nadu'),
(5, 'Kolkata', 'West Bengal');

CREATE TABLE Jobs (
    JobID INT PRIMARY KEY,
    JobTitle VARCHAR(50),
    Salary DECIMAL(10,2)
);
INSERT INTO Jobs (JobID, JobTitle, Salary) VALUES
(1, 'Software Engineer', 80000),
(2, 'Doctor', 120000),
(3, 'Teacher', 50000),
(4, 'Accountant', 70000),
(5, 'Lawyer', 90000);


CREATE TABLE CitizenJobs (
    CitizenID INT,
    JobID INT,
    PRIMARY KEY (CitizenID, JobID),
    FOREIGN KEY (CitizenID) REFERENCES Citizens(CitizenID),
    FOREIGN KEY (JobID) REFERENCES Jobs(JobID)
);
INSERT INTO CitizenJobs (CitizenID, JobID) VALUES
(1, 1),
(2, 3),
(3, 2),
(4, 4),
(5, 5),
(1, 2); 
select * from citizens;
select * from cities;
insert into citizens
(Citizenid,name,cityid,age)
values
(8,"RAM",3,20),
(9,"RAMA",3,21),
(10,"ROHIT",5,23);

-- 1.Retrieve citizens NAME,CITY and their STATE names.




SELECT Citizens.Name, Cities.CityName, Cities.State
FROM Citizens INNER JOIN Cities 
ON Citizens.CityID = Cities.CityID;

-- 2.Retrieve all citizens NAME, 
-- including those without a city.
SELECT Citizens.Name, Cities.CityName
FROM Citizens LEFT JOIN Cities 
ON Citizens.CityID = Cities.CityID;

-- count the no. of citizens in each city
select cities.cityname,count(Citizens.cityid)
from citizens inner join cities
on citizens.cityid = cities.cityid
group by cities.cityid;


-- COMPLETE DATA OF CITIZEND AND CITIES TABLE
SELECT CITIES.CITYID,CITIZENS.NAME,CITIES.STATE,
CITIZENS.CITIZENID,CITIZENS.NAME,CITIZENS.AGE
FROM CITIES LEFT JOIN CITIZENS
ON CITIZENS.CITYID=CITIES.CITYID
UNION
SELECT CITIZENS.CITYID,CITIZENS.NAME,CITIES.STATE,
CITIZENS.CITIZENID,CITIZENS.NAME,CITIZENS.AGE
FROM CITIES RIGHT JOIN CITIZENS
ON CITIZENS.CITYID=CITIES.CITYID;
-- 3. Retrieve citizens NAME 
-- with their job titles AND SALARY.
SELECT Citizens.Name, Jobs.JobTitle, Jobs.Salary
FROM Citizens INNER JOIN CitizenJobs 
ON Citizens.CitizenID = CitizenJobs.CitizenID
INNER JOIN Jobs 
ON CitizenJobs.JobID = Jobs.JobID;

-- 4.Retrieve all citizens name and cities,
-- even if they don't have matches.
SELECT CITIZENS.NAME,CITIES.CITYNAME
FROM CITIZENS LEFT JOIN CITIES
ON CITIZENS.CITYID = CITIES.CITYID
UNION
SELECT CITIZENS.NAME,CITIES.CITYNAME
FROM CITIZENS RIGHT JOIN CITIES
ON CITIZENS.CITYID = CITIES.CITYID;


SELECT Citizens.Name, Cities.CityName
FROM Citizens LEFT JOIN Cities 
ON Citizens.CityID = Cities.CityID
UNION
SELECT Citizens.Name, Cities.CityName
FROM Citizens RIGHT JOIN Cities
ON Citizens.CityID = Cities.CityID;

-- 5.Retrieve the city name along 
-- with the number of citizens living there.



SELECT Cities.CityName, COUNT(Citizens.Cityid) AS TotalCitizens
FROM Citizens
JOIN Cities ON Citizens.CityID = Cities.CityID
GROUP BY Cities.CityName;

-- 6. Retrieve cities where more than one citizen resides.
SELECT CITIES.CITYNAME,COUNT(CITIZENS.CITYID)
FROM CITIZENS INNER JOIN CITIES
ON CITIZENS.CITYID=CITIES.CITYID
GROUP BY CITIES.CITYID
HAVING COUNT(CITIZENS.CITYID)>1
;
;




SELECT Cities.CityName, COUNT(Citizens.CitizenID) AS TotalCitizens
FROM Citizens
JOIN Cities ON Citizens.CityID = Cities.CityID
GROUP BY Cities.CityName
HAVING COUNT(Citizens.CitizenID) > 1;
SELECT * FROM CITIZENJOBS;
SHOW TABLES;

SELECT JOBS.JOBID, JOBS.JOBTITLE,JOBS.SALARY,
CITIZENJOBS.CITIZENID 
FROM JOBS LEFT JOIN CITIZENJOBS 
ON CITIZENJOBS.JOBID=JOBS.JOBID
UNION
SELECT CITIZENJOBS.JOBID, JOBS.JOBTITLE,JOBS.SALARY,
CITIZENJOBS.CITIZENID 
FROM JOBS LEFT JOIN CITIZENJOBS 
ON CITIZENJOBS.JOBID=JOBS.JOBID;

-- 7. Retrieve job titles along with their average salary.
select jobtitle, avg(salary) as avg_sal
from jobs 
group by jobtitle;

SELECT Jobs.JobTitle, AVG(Jobs.Salary) AS AvgSalary
FROM Jobs
GROUP BY Jobs.JobTitle;

-- 8. Retrieve job titles that have more than one citizen assigned.

SELECT Jobs.JobTitle, COUNT(CitizenJobs.CitizenID) AS TotalEmployees
FROM Jobs
JOIN CitizenJobs ON Jobs.JobID = CitizenJobs.JobID
GROUP BY Jobs.JobTitle
HAVING COUNT(CitizenJobs.CitizenID) > 1;

-- 9. Retrieve the city name with their total citizens and average age per city.
SELECT Cities.CityName, COUNT(Citizens.CitizenID) AS TotalCitizens, AVG(Citizens.Age) AS AvgAge
FROM Citizens
JOIN Cities ON Citizens.CityID = Cities.CityID
GROUP BY Cities.CityName;

-- 10. Retrieve the city name  with the 
-- total citizen count that has the highest number of citizens.
SELECT Cities.CityName, COUNT(Citizens.CitizenID) AS TotalCitizens
FROM Citizens
JOIN Cities ON Citizens.CityID = Cities.CityID
GROUP BY Cities.CityName
ORDER BY TotalCitizens DESC
LIMIT 1;

-- 11. Assume "Software Engineer" is an IT-related job.
--  Find cities where more than 2 citizens work in this job.
SELECT Cities.CityName, COUNT(CitizenJobs.CitizenID) AS TotalEmployees
FROM Citizens
JOIN Cities ON Citizens.CityID = Cities.CityID
JOIN CitizenJobs ON Citizens.CitizenID = CitizenJobs.CitizenID
JOIN Jobs ON CitizenJobs.JobID = Jobs.JobID
WHERE Jobs.JobTitle = 'Software Engineer'
GROUP BY Cities.CityName
HAVING COUNT(CitizenJobs.CitizenID) > 2;


-- ADVANCE JOIN QUESTIONS

-- 1. Customers Table
CREATE TABLE Customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_name VARCHAR(100),
    city VARCHAR(50),
    phone VARCHAR(15)
);

INSERT INTO Customers (customer_name, city, phone) VALUES
('Amit Sharma', 'Delhi', '9876543210'),
('Priya Verma', 'Mumbai', '9876543211'),
('Rajesh Iyer', 'Bangalore', '9876543212'),
('Sneha Kapoor', 'Kolkata', '9876543213'),
('Vikram Singh', 'Chennai', '9876543214');

-- 2. Orders Table
CREATE TABLE Orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    order_date DATE,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

INSERT INTO Orders (customer_id, order_date) VALUES
(1, '2025-02-01'),
(2, '2025-02-03'),
(3, '2025-02-05'),
(4, '2025-02-07'),
(5, '2025-02-10');

-- 3. Products Table
CREATE TABLE Products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(100),
    price DECIMAL(10,2)
);

INSERT INTO Products (product_name, price) VALUES
('Laptop', 50000.00),
('Smartphone', 20000.00),
('Tablet', 15000.00),
('Headphones', 3000.00),
('Smartwatch', 7000.00);

-- 4. Order_Items Table (Junction Table)
CREATE TABLE Order_Items (
    order_item_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    product_id INT,
    quantity INT,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

INSERT INTO Order_Items (order_id, product_id, quantity) VALUES
(1, 1, 1),
(2, 2, 2),
(3, 3, 1),
(4, 4, 3),
(5, 5, 2);

-- 5. Suppliers Table
CREATE TABLE Suppliers (
    supplier_id INT PRIMARY KEY AUTO_INCREMENT,
    supplier_name VARCHAR(100),
    product_id INT,
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

INSERT INTO Suppliers (supplier_name, product_id) VALUES
('Manish Traders', 1),
('Krishna Electronics', 2),
('Sharma Distributors', 3),
('Vikram Tech', 4),
('Neha Solutions', 5);

USE INDIANBUSINESS;
-- 1. Retrieve all orders along with customer names and products purchased:
SELECT 
    O.order_id, 
    C.customer_name, 
    P.product_name, 
    OI.quantity, 
    O.order_date
FROM Orders O
JOIN Customers C ON O.customer_id = C.customer_id
JOIN Order_Items OI ON O.order_id = OI.order_id
JOIN Products P ON OI.product_id = P.product_id;

-- 2 Find the total quantity of each product sold:

SELECT 
    P.product_name, 
    SUM(OI.quantity) AS total_quantity_sold
FROM Order_Items OI
JOIN Products P ON OI.product_id = P.product_id
GROUP BY P.product_name;

-- 3.Get total sales by each supplier:
SELECT 
    S.supplier_name, 
    SUM(OI.quantity * P.price) AS total_sales
FROM Suppliers S
JOIN Products P ON S.product_id = P.product_id
JOIN Order_Items OI ON P.product_id = OI.product_id
GROUP BY S.supplier_name;

-- 4 Get customers who placed orders
-- between '2025-02-02' and '2025-02-08':
SELECT 
    C.customer_name, 
    O.order_date
FROM Orders O
JOIN Customers C ON O.customer_id = C.customer_id
WHERE O.order_date BETWEEN '2025-02-02' AND '2025-02-08';

-- 5 Find total revenue per city:
SELECT 
    C.city, 
    SUM(OI.quantity * P.price) AS total_revenue
FROM Customers C
JOIN Orders O ON C.customer_id = O.customer_id
JOIN Order_Items OI ON O.order_id = OI.order_id
JOIN Products P ON OI.product_id = P.product_id
GROUP BY C.city;

-- cross join:You want to generate all possible customer-product combinations, but only include products priced above ₹15,000.
SELECT C.customer_name, P.product_name, P.price
FROM Customers C
CROSS JOIN Products P
WHERE P.price > 15000;

-- self join: ou want to find all pairs of customers who live in the same city.
SELECT C1.customer_name AS Customer1, 
       C2.customer_name AS Customer2, 
       C1.city
FROM Customers C1
JOIN Customers C2 
  ON C1.city = C2.city 
  AND C1.customer_id < C2.customer_id;




-- combination of customers and products, offering every product to every customer.
SELECT 
    C.customer_name, 
    P.product_name, 
    P.price
FROM Customers C
CROSS JOIN Products P;

-- Find the top 3 customers who have spent the most on orders.
SELECT C.customer_name, SUM(OI.quantity * P.price) AS total_spent
FROM Customers C
JOIN Orders O ON C.customer_id = O.customer_id
JOIN Order_Items OI ON O.order_id = OI.order_id
JOIN Products P ON OI.product_id = P.product_id
GROUP BY C.customer_name
ORDER BY total_spent DESC
LIMIT 3;

-- List all customers who have never placed an order.
SELECT C.customer_name
FROM Customers C
LEFT JOIN Orders O ON C.customer_id = O.customer_id
WHERE O.order_id IS NULL;

-- Retrieve the most frequently ordered product along with its total quantity ordered.
SELECT P.product_name, SUM(OI.quantity) AS total_quantity
FROM Order_Items OI
JOIN Products P ON OI.product_id = P.product_id
GROUP BY P.product_name
ORDER BY total_quantity DESC
LIMIT 1;

-- Find the supplier who supplies the most expensive product.
SELECT S.supplier_name, P.product_name, P.price
FROM Suppliers S
JOIN Products P ON S.product_id = P.product_id
ORDER BY P.price DESC
LIMIT 1;

-- Identify the customer who has placed the maximum number of orders.

SELECT C.customer_name, COUNT(O.order_id) AS total_orders
FROM Customers C
JOIN Orders O ON C.customer_id = O.customer_id
GROUP BY C.customer_name
ORDER BY total_orders DESC
LIMIT 1;

-- Get a list of customers who have purchased at least 3 different products.
SELECT C.customer_name, COUNT(DISTINCT OI.product_id) AS unique_products
FROM Customers C
JOIN Orders O ON C.customer_id = O.customer_id
JOIN Order_Items OI ON O.order_id = OI.order_id
GROUP BY C.customer_name
HAVING COUNT(DISTINCT OI.product_id) >= 3;

-- Find the total revenue generated by each supplier.
SELECT S.supplier_name, SUM(OI.quantity * P.price) AS total_revenue
FROM Suppliers S
JOIN Products P ON S.product_id = P.product_id
JOIN Order_Items OI ON P.product_id = OI.product_id
GROUP BY S.supplier_name
ORDER BY total_revenue DESC;
use indianbusiness;
-- Retrieve customers who have placed more than 2 orders in the last 30 days.
SELECT C.customer_name, COUNT(O.order_id) AS total_orders
FROM Customers C
JOIN Orders O ON C.customer_id = O.customer_id
WHERE O.order_date >= date_sub(curdate(),interval 30 day)
GROUP BY C.customer_name
HAVING COUNT(O.order_id) > 2;

--  Find the total quantity sold for each product and filter only those products whose total quantity is above 
-- the average sold quantity.
SELECT P.product_name, SUM(OI.quantity) AS total_quantity
FROM Order_Items OI
JOIN Products P ON OI.product_id = P.product_id
GROUP BY P.product_name
HAVING total_quantity > (SELECT AVG(quantity) FROM Order_Items);

-- Get details of the order where the highest amount was spent.
SELECT O.order_id, C.customer_name, SUM(OI.quantity * P.price) AS total_spent
FROM Orders O
JOIN Customers C ON O.customer_id = C.customer_id
JOIN Order_Items OI ON O.order_id = OI.order_id
JOIN Products P ON OI.product_id = P.product_id
GROUP BY O.order_id, C.customer_name
ORDER BY total_spent DESC
LIMIT 1;

-- Find customers who have placed orders but have never purchased a product worth more than ₹10,000.
SELECT DISTINCT C.customer_name
FROM Customers C
JOIN Orders O ON C.customer_id = O.customer_id
JOIN Order_Items OI ON O.order_id = OI.order_id
JOIN Products P ON OI.product_id = P.product_id
GROUP BY C.customer_name
HAVING MAX(P.price) <= 10000;

-- Retrieve the order ID and total amount spent for each order, but only for orders containing more than one product.
SELECT O.order_id, SUM(OI.quantity * P.price) AS total_amount
FROM Orders O
JOIN Order_Items OI ON O.order_id = OI.order_id
JOIN Products P ON OI.product_id = P.product_id
GROUP BY O.order_id
HAVING COUNT(OI.product_id) > 1;

--  Find all orders placed between ‘2025-02-01’ and ‘2025-02-10’ along with the product and customer details.
SELECT O.order_id, C.customer_name, P.product_name, OI.quantity, O.order_date
FROM Orders O
JOIN Customers C ON O.customer_id = C.customer_id
JOIN Order_Items OI ON O.order_id = OI.order_id
JOIN Products P ON OI.product_id = P.product_id
WHERE O.order_date BETWEEN '2025-02-01' AND '2025-02-10';


-- List the products that have never been ordered.
SELECT P.product_name
FROM Products P
LEFT JOIN Order_Items OI ON P.product_id = OI.product_id
WHERE OI.product_id IS NULL;

-- Find the supplier(s) whose products have generated the highest revenue.
SELECT S.supplier_name, SUM(OI.quantity * P.price) AS total_revenue
FROM Suppliers S
JOIN Products P ON S.product_id = P.product_id
JOIN Order_Items OI ON P.product_id = OI.product_id
GROUP BY S.supplier_name
ORDER BY total_revenue DESC
LIMIT 1;

--  Find customers who have placed orders on consecutive days.
SELECT DISTINCT C.customer_name, O1.order_date, O2.order_date
FROM Orders O1
JOIN Orders O2 ON O1.customer_id = O2.customer_id AND DATEDIFF(O2.order_date, O1.order_date) = 1
JOIN Customers C ON O1.customer_id = C.customer_id;

-- Show all customer-product combinations using CROSS JOIN, but only include products priced above ₹15,000.
SELECT C.customer_name, P.product_name, P.price
FROM Customers C
CROSS JOIN Products P
WHERE P.price > 15000;

--  Find customers from the same city who have placed at least one order and display them as pairs.
SELECT C1.customer_name AS Customer1, C2.customer_name AS Customer2, C1.city
FROM Customers C1
JOIN Customers C2 ON C1.city = C2.city AND C1.customer_id < C2.customer_id
JOIN Orders O1 ON C1.customer_id = O1.customer_id
JOIN Orders O2 ON C2.customer_id = O2.customer_id;

--  List the most frequently supplied product along with the supplier name.
SELECT S.supplier_name, P.product_name, COUNT(*) AS supply_count
FROM Suppliers S
JOIN Products P ON S.product_id = P.product_id
GROUP BY S.supplier_name, P.product_name
ORDER BY supply_count DESC
LIMIT 1;

-- Find the total revenue generated by each city from orders.
SELECT C.city, SUM(OI.quantity * P.price) AS total_revenue
FROM Customers C
JOIN Orders O ON C.customer_id = O.customer_id
JOIN Order_Items OI ON O.order_id = OI.order_id
JOIN Products P ON OI.product_id = P.product_id
GROUP BY C.city
ORDER BY total_revenue DESC;
