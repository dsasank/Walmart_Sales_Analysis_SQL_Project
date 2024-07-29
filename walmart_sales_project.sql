create database if not exists walmart;
use walmart;
CREATE TABLE IF NOT EXISTS sales(
	invoice_id VARCHAR(30) NOT NULL PRIMARY KEY,
    branch VARCHAR(5) NOT NULL,
    city VARCHAR(30) NOT NULL,
    customer_type VARCHAR(30) NOT NULL,
    gender VARCHAR(30) NOT NULL,
    product_line VARCHAR(100) NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    quantity INT NOT NULL,
    tax_pct FLOAT(6,4) NOT NULL,
    total DECIMAL(12, 4) NOT NULL,
    date DATETIME NOT NULL,
    time TIME NOT NULL,
    payment VARCHAR(15) NOT NULL,
    cogs DECIMAL(10,2) NOT NULL,
    gross_margin_pct FLOAT(11,9),
    gross_income DECIMAL(12, 4),
    rating FLOAT(2, 1)
);
select time,
(
case 
when time between "00:00:00" and "12:00:00" then "morning"
when time between "12:01:00" and "16:00:00" then "afternoon"
else "evening"
end
) as time_of_sale
from sales;
alter table sales add column part varchar(15);
set SQL_SAFE_UPDATES=0;
update sales
set part=(
case
when time between "00:00:00" and "12:00:00" then "morning"
when time between "12:01:00" and "16:00:00" then "afternoon"
else "evening"
end
);
ALTER TABLE SALES ADD COLUMN WEEKNAME VARCHAR(20);
UPDATE SALES SET WEEKNAME=(
DAYNAME(DATE)
);
ALTER TABLE SALES ADD COLUMN MON_NAME VARCHAR(10);
UPDATE SALES SET MON_NAME =(
monthname(DATE)
);
SELECT count(city),city FROM SALES group by (city);
select branch,city from sales group by city,branch;

select count(distinct(product_line)) from sales;

select count(payment) from sales group by payment;

select count(product_line),product_line from sales group by product_line order by count(product_line) desc;

select sum(total),mon_name from sales group by mon_name;

select sum(cogs),mon_name from sales group by mon_name;

select sum(total),product_line from sales group by product_line;

select sum(total),city from sales group by city;

alter table sales add column rev varchar(10);

select avg(total) from sales group by product_line;

select gender,product_line,count(product_line)as m from sales where gender="male" group by product_line
union
select gender,product_line,count(product_line) as n from sales where gender="female" group by product_line;

select product_line,avg(rating) from sales group by product_line;


select weekname,part,sum(quantity) from sales group by weekname,part order by weekname 

select customer_type,sum(total) as t from sales group by customer_type order by t desc 

select city,sum(tax_pct)as tax from sales group by city order by tax desc limit 1

select customer_type, sum(tax_pct) as tax from sales group by customer_type order by tax desc 

select count(distinct(customer_type)) from sales 

select payment from sales group by payment

select customer_type,count(customer_type) from sales group by customer_type

select customer_type,sum(total) from sales group by customer_type

select branch,gender,count(gender) from sales group by branch,gender order by branch

select branch, part,count(rating)as fin from sales group by part,branch 