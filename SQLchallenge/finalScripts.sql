SELECT TOP 5  
customer.first_name + ' ' + customer.last_name AS 'customer name',
sum(total_price) AS 'total amount'
FROM [order]
INNER JOIN item ON [order].item_id=item.item_id
INNER JOIN category ON item.category_id=category.category_id
INNER JOIN customer ON [order].customer_id=customer.customer_id
WHERE category.category_description = 'celulares'
GROUP BY [order].customer_id, 
customer.first_name,
customer.last_name

lola perez	22100.00
juan guzman	1000.00
mariano martinez	2200.00
sofia gonzalez	2200.00
franco provenzano	2200.00