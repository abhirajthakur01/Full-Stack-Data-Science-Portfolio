create database flipkart_db;
use flipkart_db;

create table products (
product_id serial primary key,
name varchar(100) not null,
sku_code char(8) unique not null,
price numeric(10,2) default 0 check (price >= 0),
stock_quantity int default 0 check (stock_quantity >=0),
is_available boolean default TRUE,
category text not null,
add_on date default (current_date),
last_updates timestamp default now()
);

INSERT INTO products
  (name, sku_code, price, stock_quantity, is_available, category)
VALUES
  ('Wireless Mouse',      'WM123456',  699.99, 50,  TRUE, 'Electronics'),
  ('Bluetooth Speaker',   'BS234567', 1499.00, 30,  TRUE, 'Electronics'),
  ('Laptop Stand',        'LS345678',  799.50, 20,  TRUE, 'Accessories'),
  ('USB-C Hub',           'UC456789', 1299.99, 15,  TRUE, 'Accessories'),
  ('Notebook',            'NB567890',  199.00,100,  TRUE, 'Stationery'),
  ('Pen Set',             'PS678901',  199.00,200,  TRUE, 'Stationery'),
  ('Coffee Mug',          'CM789012',  299.00, 75,  TRUE, 'Home & Kitchen'),
  ('LED Desk Lamp',       'DL890123',  899.00, 40,  TRUE, 'Home & Kitchen'),
  ('Yoga Mat',            'YM901234',  499.00, 25,  TRUE, 'Fitness'),
  ('Water Bottle',        'WB012345',  349.00, 60,  TRUE, 'Fitness');
  
select * from products;
select name,price from products;

select * from products where category = 'Electronics';

select category from products group by category;

select category, count(*) from products
group by category
having count(*) >1;

select * from products order by name;
select * from products order by price;

select * from products limit 3;
select name as item_name, price as item_price from products;
select distinct category from products;

select * from products where category != 'Electronics';
select * from products where price>1000;
select * from products where price<1000;
select * from products where price>1000 and category = 'Electronics';
select * from products where price<1000 and price >400;
select * from products where price between 400 and 1000;
select * from products where category = 'Electronics' or category = 'Fitness';
select * from products where category in ('Electronics','Home & kitchen','Fitness');


select * from products where sku_code like 'W%';
select * from products where sku_code like '%123%';
select * from products where sku_code like '_B%';
select * from products where not category = 'Electronics';

select count(product_id) from products;
select sum(price) from products;
select sum(price) from products where category = 'Electronics';
select avg(price) from products;
select round(avg(price),2) from products;
select min(price) from products;
select max(price) from products;

select name , price from products
where price = (select min(price) from products);

select round(avg(price),2) from products
where category in ('Fitness','Home & kitchen');

select name , stock_quantity from products
where is_available = true and stock_quantity > 50 and price != 299.00;

select category , Max(price) as Max_price from products
group by category;

select distinct upper(category) as category_upper
from products
order by category_upper DESC;

select upper(name) from products;
select length(sku_code) from products;
select lower(sku_code) from products;
select substring('brother in arms',1,7);
select substring('brother in arms',13,4);
select name ,substring(sku_code,1,2) from products;
select name , lower(substring(sku_code,1,2)) as sku_code_lower from products;

select left('brother arms',7);
select right('brother arms',4);
select name , left(sku_code,2) from products;
select name , right(sku_code,2) from products;
select concat(name,' ',category) from products;
select concat(name,' ',category,' ',sku_code) as product_with_category from products;
select concat_ws(' ',name,category,sku_code) as product_with_category from products;

select trim('  brother   ');
select name,replace(sku_code,left(sku_code,2),'GG') from products;

select * from products;
select name, price,
case when (price>1000) then 'Expensive'
     when price  between 500 and 1000 then 'Moderate'
     else 'cheap'
end as price_tag from products;  

set sql_safe_updates = 0;  
 
 alter table  products
 add column price_tag text;
 
 update products
 set price_tag =
 case
	 when (price>1000) then 'Expensive'
     when price  between 500 and 1000 then 'Moderate'
     else 'cheap'
 end;    
 select * from products;    
 
 select
	name,
    case
    when is_available then 'in stock'
    else 'out of stock'
   end as availability_status
from products;   

select
name,
case
 when stock_quantity > 100 then 'high school'
 when stock_quantity between 30 and 100 then ' medium stock'
 else 'low stock'
end as stock_level
from products; 


 
 
     