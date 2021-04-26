--Hamza Koc 101274109

--Q1
SELECT email_address, 
  COUNT(o.order_id) AS Total_Orders, 
  SUM(( o.item_price - o.discount_amount ) * o.quantity) AS Amount_Total 
FROM  customers c JOIN orders o1 
   USING(customer_id) 
   JOIN order_items o 
   ON o1.order_id = o.order_id 
GROUP  BY c.email_address 
HAVING Count(o.order_id) > 1 
ORDER  BY 3 DESC; 




--Q2
SELECT product_name, SUM((o.item_price - o.discount_amount) * o.quantity) AS Total_Amount_for_Product 
FROM products p JOIN order_items o USING(product_id)
GROUP BY ROLLUP(product_name);


--Q3
SELECT email_address, 
  COUNT(DISTINCT o.product_id) AS ordered_total_products 
FROM customers c NATURAL JOIN orders NATURAL JOIN order_items o
GROUP  BY email_address 
HAVING COUNT(DISTINCT o.product_id) > 1;



--Q4
SELECT category_name
FROM categories
WHERE category_id IN
 (SELECT category_id
  FROM products
  WHERE categories.category_id = products.category_id)
ORDER BY category_name;


--Q5
SELECT product_name, list_price
FROM products
WHERE list_price> 
 (SELECT AVG(list_price)
  FROM products)
ORDER BY 2 DESC;


--Q6
SELECT category_name
FROM categories
WHERE NOT EXISTS
  (SELECT * 
    FROM products
    WHERE categories.category_id = products.category_id);



--Q7
SELECT p1.product_name, p1.discount_percent
FROM products p1
WHERE NOT EXISTS
	(SELECT *
FROM products p2
WHERE p2.discount_percent=p1.discount_percent
AND p2.product_name !=p1.product_name)
ORDER BY p1.product_name;


--Q8
SELECT email_address, order_id, order_date AS order_date
FROM orders JOIN customers
	ON orders.customer_id = customers.customer_id
WHERE order_date = (SELECT MIN(order_date)
FROM orders 
WHERE orders.customer_id = customers.customer_id);





