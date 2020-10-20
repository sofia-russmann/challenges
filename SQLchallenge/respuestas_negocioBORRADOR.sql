--1
--Cantidad de usuarios donde su apellido comience con la letra ‘M’
SELECT COUNT(customer_id)
FROM customer
WHERE last_name LIKE 'm%';

--2
--Listado de los usuarios que cumplan años en el día de la fecha (hoy).
SELECT *
FROM customer
WHERE MONTH(birthdate) = MONTH(GETDATE()) 
AND DAY(birthdate) = DAY(GETDATE())
    
--3
--******Por día**********+ se necesita, cantidad de ventas realizadas, cantidad de productos vendidos
--for each day (stored procedure)
SELECT COUNT(order_id) AS 'Cantidad de ventas realizadas', SUM(quantity) AS 'Cantidad de productos vendidos'
FROM orders
WHERE order_date=GETDATE()
--y monto total transaccionado para el mes de Enero del 2020.
SELECT SUM(total_price)
FROM orders
WHERE MONTH(order_date) = 1 
AND YEAR(order_date)=2020

--4
--***Por cada mes**** del 2019, se solicita el top 5 de usuarios que más vendieron ($) en la
--categoría Celulares. Se requiere el mes y año de análisis, nombre y apellido del
--vendedor, la cantidad vendida y el monto total transaccionado.

-- tablas: customer, order


SELECT TOP 5 sum(order.total_price) 
FROM 
(SELECT MONTH(order.order_date), 
YEAR(order.order_date), 
customer.first_name, 
customer.last_name, 
sum(order.quantity), 
sum(order.total_price)
FROM customer_id
INNER JOIN order ON customerid=customerid
WHERE category.categoy_description='Celulares' 
AND YEAR(order.order_date) = 2019
GROUP BY MONTH(order_date)


--5. Se solicita poblar una tabla con el precio y estado de los Items a fin del día (se puede resolver a través de StoredProcedure).
CREATE PROCEDURE historicItems
INSERT INTO itemEvolution
SELECT item_id, item_price, item_status, getdate() as 'date'
FROM item
--WHERE CURRENT_TIMESTAMP=TIME('23:59')FORMAT(GETDATE(),'hh:mm') 
--a. Vale resaltar que en la tabla Item, vamos a tener únicamente el último estado
--informado por la PK definida.
--b. Esta información nos va a permitir realizar análisis para entender el
--comportamiento de los diferentes Items (por ejemplo evolución de Precios,
--cantidad de Items activos).

--6
--Desde IT nos comentan que la tabla de Categorías tiene un issue ya que cuando generan modificaciones de una categoría se genera un nuevo registro con la misma
--PK en vez de actualizar el ya existente. Teniendo en cuenta que tenemos una columna de Fecha de LastUpdated, se solicita crear una nueva tabla y poblar la
--misma sin ningún tipo de duplicados garantizando la calidad y consistencia de los datos.


SELECT 
     DISTINCT category_id, category_description, category_path, last_updated
INTO 
    Updated_categories
FROM
    category;