--1
SELECT COUNT(customer_id)
FROM customer
WHERE last_name LIKE 'm%';

--2
SELECT *
FROM customer
WHERE MONTH(birthdate) = MONTH(GETDATE()) 
AND DAY(birthdate) = DAY(GETDATE())

--3
--3.1
CREATE PROCEDURE ventasDeLaFecha
AS
SELECT COUNT(order_id) AS 'Amount of sales', 
SUM(quantity) AS 'Amount of sold products'
FROM [order]
WHERE DAY(order_date)=DAY(GETDATE())
AND MONTH(order_date)=MONTH(GETDATE())
AND YEAR(order_date)=YEAR(GETDATE())
--OR
SELECT order_date, 
COUNT(order_id) AS 'Amount of saless', 
SUM(quantity) AS 'Amount of sold products'
FROM [order]
GROUP BY order_date
--3.2
SELECT SUM(total_price)
FROM [order]
WHERE MONTH(order_date) = 1 
AND YEAR(order_date)=2020



--4
DECLARE @month smallint,
@year smallint
SET @month='01'
SET @year='2019'
SELECT TOP 5
@month as 'month', 
@year as 'year',
customer.first_name + ' ' +customer.last_name AS 'full name',  
sum([order].quantity) AS 'total amount',
sum([order].total_price) AS 'total sold'
FROM [order] 
INNER JOIN customer 
ON [order].customer_id=customer.customer_id
WHERE [order].category_id=1 
AND YEAR([order].order_date)=@year 
AND MONTH([order].order_date)=@month 
GROUP BY customer.first_name, 
customer.last_name

--5
--Create a JOB with the following script and schedule it for executing at 11:59:59PM
INSERT INTO itemEvolution
SELECT item_id, item_price, item_status, getdate() as 'date'
FROM item


--6
SELECT DISTINCT category_id, 
category_description, 
category_path, 
last_updated
INTO Updated_categories
FROM category;