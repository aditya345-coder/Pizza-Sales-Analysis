USE pizza_place_sales;

SELECT * FROM orders;
SELECT * FROM order_details;
SELECT * FROM pizza_types;
SELECT * FROM pizzas;

-- Number of Rows in each table
SELECT COUNT(*) FROM orders; # 21350
SELECT COUNT(*) FROM order_details; # 48620
SELECT COUNT(*) FROM pizza_types; # 32
SELECT COUNT(*) FROM pizzas; # 96

-- year of data
SELECT DISTINCT YEAR(date)
FROM orders; # 2015


-- Total Revenue: The sum of the total price of all pizza orders.
-- Average Order Values (AOV): The average amount spent per order, 
-- calculated by dividing the total revenue by the total number of orders.
-- Total Pizza Solds: The sum of the quantities of all pizza sold.
-- Total Orders: The total number of orders placed.
-- Average Pizza Per Order: The average number of pizzas sold per order, 
-- calculated by dividing the total number of pizzas sold by the total number of orders.


-- Number of pizza sold per each category
SELECT pt.category, COUNT(*) AS number_of_pizza_sold
FROM order_details od
JOIN pizzas p 
ON od.pizza_id=p.pizza_id
JOIN pizza_types pt 
ON p.pizza_type_id=pt.pizza_type_id
GROUP BY pt.category;

-- Percentage of pizza sales per category
SELECT pt.category, 
	   ROUND(SUM(od.quantity*p.price)*100/ (SELECT SUM(od.quantity*p.price) 
											FROM orders o
											JOIN order_details od
											ON o.order_id=od.order_id
											JOIN pizzas p 
											ON od.pizza_id=p.pizza_id
                                            -- WHERE MONTH(o.date) = 1 # if some filter is appliead outside subquery than it should also be present here for accurate results
                                            ), 4) AS percentage_of_sales_per_pizza
FROM orders o
JOIN order_details od
ON o.order_id=od.order_id
JOIN pizzas p 
ON od.pizza_id=p.pizza_id
JOIN pizza_types pt 
ON p.pizza_type_id=pt.pizza_type_id
-- WHERE MONTH(o.date) = 1 # To check for single month (currently checking for January)
GROUP BY pt.category;

-- Percentage of pizza sales per category
SELECT p.size, 
	   ROUND(SUM(od.quantity*p.price)*100/ (SELECT SUM(od.quantity*p.price) 
											FROM orders o
											JOIN order_details od
											ON o.order_id=od.order_id
											JOIN pizzas p 
											ON od.pizza_id=p.pizza_id
                                            -- WHERE MONTH(o.date) = 1 # if some filter is appliead outside subquery than it should also be present here for accurate results
                                            ), 4) AS percentage_of_sales_per_pizza
FROM orders o
JOIN order_details od
ON o.order_id=od.order_id
JOIN pizzas p 
ON od.pizza_id=p.pizza_id
JOIN pizza_types pt 
ON p.pizza_type_id=pt.pizza_type_id
-- WHERE MONTH(o.date) = 1 # To check for single month (currently checking for January)
GROUP BY p.size;

SHOW WARNINGS;
-- Average Order Value
SELECT
	SUM(p.price*od.quantity)/COUNT(DISTINCT od.order_id) AS Avg_Order_Value 
FROM order_details od
JOIN pizzas p 
ON od.pizza_id=p.pizza_id;

-- Total pizza sold
SELECT SUM(quantity) AS total_pizza_sold
FROM order_details;

-- Total order placed
SELECT 
	COUNT(DISTINCT order_id) AS total_order_placed
FROM order_details;

-- Average pizza per order
SELECT
	SUM(quantity)/COUNT(DISTINCT order_id) AS Average_pizza_per_order
FROM order_details;

-- Week wise total orders
SELECT
	DAYNAME(date) AS weekdays,
	COUNT(DISTINCT order_id) AS total_orders
FROM orders
GROUP BY weekdays;

SHOW WARNINGS;

-- What days and times do we tend to be busiest?
SELECT 
    DAY(o.date) AS busiest_day,
    HOUR(o.time) AS busiest_hour,
    COUNT(o.order_id) AS total_number_of_orders
FROM
    orders o
        JOIN
    order_details od ON o.order_id = od.order_id
GROUP BY DAY(o.date) , HOUR(o.time)
ORDER BY total_number_of_orders DESC
LIMIT 1;


-- How many customers do we have each day? Are there any peak hours?
SELECT DATE(o.date) AS date, 
       COUNT(*) AS number_of_customer_each_day
FROM orders o
JOIN order_details od 
ON o.order_id=od.order_id
GROUP BY DATE(o.date);
-- Peak Hours
SELECT 
    DATE(o.date) AS order_date,
    COUNT(DISTINCT o.order_id) AS number_of_customers
FROM
    orders o
        JOIN
    order_details od ON o.order_id = od.order_id
GROUP BY DATE(o.date);

SHOW WARNINGS;
SHOW ERRORS;

-- How many pizzas are we making during peak periods? 
WITH peak_hour AS (
    SELECT HOUR(o.time) AS busiest_hour
    FROM orders o
    GROUP BY HOUR(o.time)
    ORDER BY COUNT(o.order_id) DESC
    LIMIT 1
)
SELECT COUNT(od.pizza_id) AS pizzas_at_peak_hour
FROM order_details od
JOIN orders o ON od.order_id = o.order_id
JOIN peak_hour ph ON HOUR(o.time) = ph.busiest_hour;

-- How many pizzas are typically in an order? Do we have any bestsellers?
SELECT 
    order_id, MIN(quantity) AS pizzas_typically_in_an_order
FROM
    order_details
GROUP BY order_id;
-- best seller
SELECT 
    p.pizza_id,
    pt.name,
    SUM(od.quantity * p.price) AS total_sales
FROM
    order_details od
        JOIN
    pizzas p ON od.pizza_id = p.pizza_id
        JOIN
    pizza_types pt ON p.pizza_type_id = pt.pizza_type_id
GROUP BY p.pizza_id
ORDER BY total_sales DESC
LIMIT 1;

SHOW WARNINGS;

-- What are our best and worst selling pizzas?
-- Top 5 Best selling pizzas
SELECT 
    pt.name,
    ROUND(SUM(od.quantity*p.price), 4) AS total_sales
FROM
    order_details od
        JOIN
    pizzas p ON od.pizza_id = p.pizza_id
        JOIN
    pizza_types pt ON p.pizza_type_id = pt.pizza_type_id
GROUP BY pt.name
ORDER BY total_sales DESC
LIMIT 5;

-- Top 5 Worst selling pizzas
SELECT 
    pt.name, 
    ROUND(SUM(od.quantity*p.price), 4) AS total_revenue
FROM
    order_details od
        JOIN
    pizzas p ON od.pizza_id = p.pizza_id
        JOIN
    pizza_types pt ON p.pizza_type_id = pt.pizza_type_id
GROUP BY pt.name
ORDER BY total_revenue ASC
LIMIT 5;

-- Are there any pizzas we should take of the menu, or any promotions we could leverage?
SELECT 
    pt.name, 
    ROUND(SUM(od.quantity * p.price), 4) AS sales
FROM
    order_details od
        JOIN
    pizzas p ON od.pizza_id = p.pizza_id
        JOIN
    pizza_types pt ON p.pizza_type_id = pt.pizza_type_id
GROUP BY pt.name
ORDER BY SUM(od.quantity * p.price) ASC
LIMIT 1;

-- What's our average order value? 
SELECT 
    ROUND(AVG(order_total), 4) AS avg_order_value
FROM (
    SELECT SUM(od.quantity * p.price) AS order_total
    FROM order_details od
    JOIN pizzas p ON od.pizza_id = p.pizza_id
    GROUP BY od.order_id
) AS order_values;


-- How much money did we make this year? Can we indentify any seasonality in the sales?
SELECT 
    ROUND(SUM(od.quantity * p.price), 4) AS total_money_year
FROM
    pizzas p
        JOIN
    order_details od ON p.pizza_id = od.pizza_id;

-- Monthly orders
SELECT 
	MONTHNAME(date) AS month, 
    COUNT(DISTINCT order_id) AS total_orders
FROM orders
GROUP BY MONTH(date);

SHOW WARNINGS;

-- Monthly sales
SELECT 
    MONTHNAME(o.date) AS month, 
    ROUND(SUM(od.quantity * p.price), 2) AS total_sales
FROM 
    orders o
JOIN 
    order_details od ON o.order_id = od.order_id
JOIN 
    pizzas p ON od.pizza_id = p.pizza_id
GROUP BY 
    MONTH(o.date)
ORDER BY 
    MONTH(month);


-- Weekly orders
SELECT 
	DAYNAME(date) AS weekday, 
    COUNT(DISTINCT order_id) AS total_orders
FROM orders
GROUP BY weekday;

-- Weekly sales
SELECT 
    WEEK(o.date) AS week, 
    ROUND(SUM(od.quantity * p.price), 2) AS total_sales
FROM 
    orders o
JOIN 
    order_details od ON o.order_id = od.order_id
JOIN 
    pizzas p ON od.pizza_id = p.pizza_id
GROUP BY 
    WEEK(o.date)
ORDER BY 
    week;

-- Day of week order
SELECT 
	DAY(date) AS day, 
    COUNT(DISTINCT order_id) AS total_orders
FROM orders
GROUP BY day;

SHOW WARNINGS;
-- Day of week sales
SELECT 
    DAYOFWEEK(o.date) AS day_of_week, 
    ROUND(SUM(od.quantity * p.price), 2) AS total_sales
FROM 
    orders o
JOIN 
    order_details od ON o.order_id = od.order_id
JOIN 
    pizzas p ON od.pizza_id = p.pizza_id
GROUP BY 
    DAYOFWEEK(o.date)
ORDER BY 
    total_sales DESC;

-- How well are we utilizing our seating capacity?

