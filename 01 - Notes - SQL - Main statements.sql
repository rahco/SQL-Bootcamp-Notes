
/* NOTES FROM : The Complete SQL Bootcamp */


/* SELECT */

SELECT * FROM actor;

SELECT first_name FROM actor;

SELECT first_name, last_name FROM actor;


/* SELECT DISTINCT */

/* The DISTINCT keyword can be used to return only the distinct values in a column.*/

SELECT DISTINCT(release_year) FROM film;

SELECT DISTINCT(rental_rate) FROM film;


/* COUNT */

SELECT COUNT(title) FROM film
WHERE rental_rate > 4 AND replacement_cost >= 19.99
AND rating = 'R';

SELECT COUNT(title) FROM film
WHERE rating = 'R' OR rating = 'PG-13';


/* WHERE | AND | OR */

SELECT * FROM film
WHERE rating != 'R';

SELECT email FROM customer
WHERE first_name = 'Nancy'
AND last_name = 'Thomas';

SELECT description FROM film
WHERE title = 'Outlaw Hanky';

SELECT phone FROM address
WHERE address = '259 Ipoh Drive';


/* ORDER BY */

SELECT store_id, first_name, last_name FROM customer
ORDER BY store_id DESC, first_name ASC;

SELECT first_name, last_name FROM customer
ORDER BY store_id DESC, first_name ASC;


/* LIMIT */

SELECT * FROM payment
WHERE amount != 0.00
ORDER BY payment_date DESC
LIMIT 5;

SELECT customer_id FROM payment
ORDER BY payment_date ASC
LIMIT 10;

SELECT * FROM film;

SELECT title, length FROM film
ORDER BY length ASC
LIMIT 5;


/* BETWEEN */

/* Filtering the table Payments considering amount between 8 and 9 */
SELECT * FROM payment
WHERE amount BETWEEN 8 AND 9;

/* Total payments considering amount between 8 and 9 */
SELECT COUNT(*) FROM payment
WHERE amount BETWEEN 8 AND 9;

/* Total payments considering amount NOT between 8 and 9 */
SELECT COUNT(*) FROM payment
WHERE amount NOT BETWEEN 8 AND 9;

/* Filtering the table Payments considering dates between */
SELECT * FROM payment
WHERE payment_date BETWEEN '2007-02-01' AND '2007-02-15';


/* IN */

/* Filtering the table Payments considering a list using IN statement */
SELECT * FROM payment
WHERE amount IN (0.99, 1.98, 1.99);

/* Total payments considering amount IN a list */
SELECT COUNT(*) FROM payment
WHERE amount IN (0.99, 1.98, 1.99);

/* Total payments considering amount NOT IN a list */
SELECT COUNT(*) FROM payment
WHERE amount NOT IN (0.99, 1.98, 1.99);

/* Filtering the table customer considering a list using strings on IN statement */
SELECT * FROM customer
WHERE first_name IN ('John', 'Jake', 'Julie');


/* LIKE and ILIKE

The LIKE and ILIKE operator allows us to perform pattern matching 
against string data with the use of wildcard characters:

> Percent % >> Matches any sequence of characters
> Underscore _ >> Matches any single character 

LIKE is case-sensitive and ILIKE is case-insensitive*/

/* Filtering customer table considering nomes that start with J using LIKE */
SELECT * FROM customer
WHERE first_name LIKE 'J%';

SELECT * FROM customer
WHERE first_name LIKE 'J%' AND last_name LIKE 'S%';

SELECT * FROM customer
WHERE first_name ILIKE 'j%';

/* Filtering customer table considering nomes with 'er' in the name */
SELECT * FROM customer
WHERE first_name LIKE '%er%';

/* Using _ to limit the number of character before 'her' */
SELECT * FROM customer
WHERE first_name LIKE '_her%';

/* Using NOT to get the opposite result */
SELECT * FROM customer
WHERE first_name NOT LIKE '_her%';

/* Using multiple statements */
SELECT * FROM customer
WHERE first_name LIKE 'A%' AND last_name NOT LIKE 'B%'
ORDER BY last_name;


/* Challenges */

/* How many payment transactions were greater than $5.00? */
SELECT COUNT(amount) FROM payment
WHERE amount > 5;

/* How many actors have a first name that starts with the letter P? */
SELECT COUNT(actor) FROM actor
WHERE first_name LIKE 'P%';

/* How many unique districts are our customers from? */
SELECT COUNT(DISTINCT(district)) FROM address;

/* Retrieve the list of names for those distinct distrincts from the previous question */
SELECT DISTINCT(district) FROM address;

/* How many films have a rating of R and a replacement cost between $5 and $15? */
SELECT COUNT(*) FROM film
WHERE rating = 'R' AND replacement_cost BETWEEN 5 AND 15;

/* How many films have the word Truman somewhere in the title? */
SELECT COUNT(*) FROM film
WHERE title LIKE '%Truman%';


/* AGGREGATE FUNCTIONS */

/*
Most Common Aggregate Functions:

> AVG() - return average value
> COUNT() - returns number of values
> MAX() - returns maximum value
> MIN() - returns minimum value
> SUM() - returns the sum of all values
*/

/* Selecting de minimum replacement_cost */
SELECT MIN(replacement_cost) FROM film;

/* Selecting de maximum replacement_cost */
SELECT MAX(replacement_cost) FROM film;

/* Combining MIN and MAX statements */
SELECT MIN(replacement_cost), MAX(replacement_cost) FROM film;

/* Selecting de avg from replacement_cost */
SELECT ROUND(AVG(replacement_cost), 2) FROM film;

/* SUM of the replacement_cost */
SELECT SUM(replacement_cost) FROM film;


/* GROUP BY */

/* Using GROUP BY to query the customer who is spending the most amount of money */
SELECT customer_id, SUM(amount) FROM payment
GROUP BY customer_id
ORDER BY SUM(amount) DESC;

/* Using GROUP BY to query the number of transactions per customer */
SELECT customer_id, COUNT(amount) FROM payment
GROUP BY customer_id
ORDER BY COUNT(amount) DESC;

/* GROUP BY with multiple columns */
SELECT customer_id, staff_id, SUM(amount) FROM payment
GROUP BY customer_id, staff_id
ORDER BY customer_id;

/* Using GROUP BY to query the sum amount per date */
/* DATE = extract de date from a timestamp format */
SELECT DATE(payment_date), SUM(amount) FROM payment
GROUP BY DATE(payment_date)
ORDER BY SUM(amount) DESC;


/* Challenges | GROUP BY */

/* How many payments did each staff member handle and who gets the bonus? */
SELECT staff_id, COUNT(*) FROM payment
GROUP BY staff_id
ORDER BY COUNT(*) DESC;

/* What is the average replacement cost per MPAA rating? */
SELECT rating, ROUND(AVG(replacement_cost), 2) FROM film
GROUP BY rating;

/* What are the customer ids of the top 5 customers by total spend? */
SELECT customer_id, SUM(amount) FROM payment
GROUP BY customer_id
ORDER BY SUM(amount) DESC
LIMIT 5;


/* HAVING */

/* HAVING clause allow us to use aggregate result as a filter along with a GROUP BY */

/* Using HAVING to filter the result of the aggregate function SUM */
SELECT customer_id, SUM(amount) FROM payment
GROUP BY customer_id
HAVING SUM(amount) > 100;

/* Using HAVING to filter the result of the aggregate function COUNT */
SELECT store_id, COUNT(*) FROM customer
GROUP BY store_id
HAVING COUNT(*) > 300;


/* Challenges | HAVING */

/* Filtering the customer_id that have had 40 or more transactions payments */
SELECT customer_id, COUNT(*) FROM payment
GROUP BY customer_id
HAVING COUNT(*) >= 40;

/* What are the customer ids of customers who have spent more 
than $100 in payment transactions with our staff_id member 2? */
SELECT customer_id, SUM(amount) FROM payment
WHERE staff_id = 2
GROUP BY customer_id
HAVING SUM(amount) > 100;


/* ASSESSMENT TEST 1 */

/* 1. Return the customer IDs of customers who have spent 
at least $110 with the staff member who has an ID of 2. */
SELECT customer_id, SUM(amount) FROM payment
WHERE staff_id = 2
GROUP BY customer_id
HAVING SUM(amount) >= 110;

/* 2. How many films begin with the letter J? */
SELECT COUNT(*) FROM film
WHERE title LIKE 'J%'

/* 3. What customer has the highest customer ID number whose
name starts with an 'E' and has an address ID lower than 500? */
SELECT * FROM customer
WHERE first_name LIKE 'E%' 
AND address_id < 500
ORDER BY customer_id DESC
LIMIT 1;


/* AS */

/* AS is used to rename a column name in the output of a query */
/* Note: The alias created by AS cannot be used in filtering clauses such as WHERE or HAVING */

/* Alias example */
SELECT COUNT(amount) AS num_transactions FROM payment;

/* Alias example */
SELECT customer_id, SUM(amount) AS total_spent FROM payment
GROUP BY customer_id;


/* JOINS */

/* JOINs allow us to combine multiple tables together. */
/* SELECTING COLUMNS */
/* If the column exists in only one table, we can call its name in the SELECT clause */
/* If the column exists in both tables, we need to specify the column selected by
the command table.column */

/* INNER JOINS */
/* INNER JOIN produces only the set of records that match in both Table A and Table B. */

/* Selecting with * will create a table with all columns in 
both tables, repeating the columns that exist in both tables */
SELECT *
FROM payment
INNER JOIN customer
ON payment.customer_id = customer.customer_id;

/* Selecting columns with INNER JOIN */
SELECT payment_id, payment.customer_id, first_name
FROM payment
INNER JOIN customer
ON payment.customer_id = customer.customer_id;


/* FULL OUTER JOIN */
/* Full outer join produces the set of all records in Table A and
Table B, with matching records from both sides where available. 
If there is no match, the missing side will contain null. */

SELECT * 
FROM customer
FULL OUTER JOIN payment
ON customer.customer_id = payment.customer_id;

/* WHERE with IS null is useful when we need to select from the output
only records that do not match between tables */
SELECT * 
FROM customer
FULL OUTER JOIN payment
ON customer.customer_id = payment.customer_id
WHERE customer.customer_id IS null
OR payment.customer_id IS null;


/* LEFT JOIN = LEFT OUTER JOIN */
/* Left outer join produces a complete set of records from Table A, 
with the matching records (where available) in Table B. If there is 
no match, the right side will contain null. */

/* Example of filtering where we use the film table as LEFT, entering 
the output just the film table records. In this case, values that do not 
match between the table are represented as null. */
SELECT film.film_id, title, inventory_id, store_id
FROM film
LEFT JOIN inventory
ON inventory.film_id = film.film_id;

/* Using WHERE with IS null to select from the output only the records that
do not exist in the RIGHT table but are in the LEFT table */
SELECT film.film_id, title, inventory_id, store_id
FROM film
LEFT JOIN inventory
ON inventory.film_id = film.film_id
WHERE inventory.film_id IS null;


/* RIGHT JOINS */
/* Right join produces a complete set of records from Table B, 
with the matching records (where available) in Table A. If there is 
no match, the right side will contain null. */

/* Example of filtering where we use the film table as LEFT, entering 
the output just the film table records. In this case, values that do not 
match between the table are represented as null. */
SELECT film.film_id, title, inventory_id, store_id
FROM film
RIGHT JOIN inventory
ON inventory.film_id = film.film_id;


/* UNION */
/* The UNION operator is used to combine the result-set of two or more SELECT statements. */


/* Challenges | JOIN */

/* What are the emails of the customers who live in California? */
SELECT district, email FROM address
INNER JOIN customer
ON address.address_id = customer.address_id
WHERE district = 'California';

/* Get a list of all the movies 'Nick Wahlberg' has been in */
SELECT title, first_name, last_name FROM film_actor
INNER JOIN film
ON film_actor.film_id = film.film_id
INNER JOIN actor
ON film_actor.actor_id = actor.actor_id
WHERE first_name = 'Nick'
AND last_name = 'Wahlberg';


/* TIMESTAMPS 

TIME - Contains only time 
DATE - Contains only date
TIMESTAMP - Contains date and time 
TIMESTAMPTZ - Contains date,time, and timezone 

*/

/* Command to get the current timezone */
SHOW TIMEZONE;

/* Command to get the current timestamptz */
SELECT NOW();

/* Command to get the current timestamptz in string format*/
SELECT TIMEOFDAY();

/* Getting the current time */
SELECT CURRENT_TIME

/* Getting the current date */
SELECT CURRENT_DATE


/* EXTRACT 

Allows you to “extract” or obtain a sub-component of a date value:
> YEAR
> MONTH
> DAY
> WEEK
> QUARTER

*/

/* Extracting year */
SELECT *, EXTRACT(YEAR FROM payment_date) AS myyear
FROM payment;

/* Extracting month */
SELECT *, EXTRACT(MONTH FROM payment_date) AS mymonth
FROM payment;

/* Extracting month */
SELECT *, EXTRACT(DAY FROM payment_date) AS myday
FROM payment;


/* AGE */
/* Age is useful to get how old the timestamp is */
SELECT *, AGE(payment_date) AS payment_age
FROM payment;


/* TO_CHAR */
/* General function to convert data types to text based on specific patterns */
/* Doc: https://www.postgresql.org/docs/current/functions-formatting.html */

SELECT *, TO_CHAR(payment_date, 'dd/mm/yyyy') AS text_payment_date
FROM payment;


/* Challenges | TIMESTAMP and EXTRACT */

/* During which months did payments occur? */
SELECT DISTINCT(TO_CHAR(payment_date, 'MONTH')) FROM payment;

/* How many payments occurred on a Monday? */
SELECT COUNT(*) FROM payment
WHERE EXTRACT(DOW FROM payment_date) = 1;


/* MATHEMATICAL FUNCTIONS AND OPERATORS */

/* Operations between columns */
SELECT title, rental_rate, replacement_cost, 
ROUND((rental_rate/replacement_cost) * 100, 2) AS percent_cost
FROM film;

/* Operations with numbers and columns */
SELECT title, rental_rate, replacement_cost, 
0.1 * replacement_cost AS deposit
FROM film;


/* STRING FUNCTIONS and OPERATIONS */
/* Doc: https://www.postgresql.org/docs/9.1/functions-string.html */

/* Getting the length of a string */
SELECT LENGTH(first_name) FROM customer;

/* String concatenation : Example 01 */
SELECT first_name, last_name,
first_name || ' ' || last_name AS full_name
FROM customer;

/* String concatenation : Example 02 */
SELECT first_name, last_name,
UPPER(first_name) || ' ' || UPPER(last_name) AS full_name
FROM customer;

/* String concatenation : Example 03 */
SELECT first_name, last_name,
LOWER(LEFT(first_name,1)) || '.' || LOWER(last_name) || '@myemail.com' AS corporate_email
FROM customer;


/* SUBQUERY  */
/* A sub query allows you to construct complex queries, essentially 
performing a query on the results of another query. */

/* Getting movies that have rental_rate greater than avg rental_rate */
SELECT title, rental_rate 
FROM film
WHERE rental_rate > /*subquery*/ (SELECT AVG(rental_rate) FROM film)

/* Using subquery with JOIN and IN clause */
/* We want to grab the movie titles that were returned between a certain set of dates */
SELECT film_id, title
FROM film
WHERE film_id  IN
/*subquery*/
(SELECT inventory.film_id
FROM rental
INNER JOIN inventory
ON inventory.inventory_id = rental.inventory_id
WHERE return_date BETWEEN '2005-05-29' AND '2005-05-30')
ORDER BY title;


/* SUBQUERY with EXISTS */
/* 
> The EXISTS operator is used to test for existence of rows in a subquery.
> Typically a subquery is passed in the EXISTS() function to check if any 
rows are returned with the subquery.
> EXISTS is useful when we have a list of records to filter the results of a query.
*/

/* We want to find customers who have at least one payment whose amount is greater than 11 */
SELECT first_name, last_name
FROM CUSTOMER AS c
WHERE EXISTS
/*subquery*/
(SELECT * FROM payment AS p
WHERE p.customer_id = c.customer_id
AND amount > 11)

/* Using the NOT operator we get the opposite result */ 
SELECT first_name, last_name
FROM CUSTOMER AS c
WHERE NOT EXISTS
/*subquery*/
(SELECT * FROM payment AS p
WHERE p.customer_id = c.customer_id
AND amount > 11)


/* SELF-JOIN
Self-join can be viewed as a join of two copies of the same table. */

/* Creating a list of movies with the same length */
SELECT f1.title, f2.title, f1.length
FROM film AS f1
INNER JOIN film AS f2
ON f1.film_id != f2.film_id
AND f1.length = f2.length;


/* CASE */

/*
> We can use the CASE statement to only execute SQL code when certain conditions are met.
> This is very similar to IF/ELSE statements in other programming languages. 
> There are two main ways to use a CASE statement, either a general CASE or a CASE expression.

General syntax:
CASE
	WHEN condition1 THEN result1
     WHEN condition2 THEN result2
     ELSE some_other_result
END

CASE expression syntax:
CASE expression
	WHEN value1 THEN result1
     WHEN value2 THEN result2
     ELSE some_other_result
END
*/

/* Using CASE statement to classify customers by customer_id number */
SELECT customer_id,
CASE
	WHEN (customer_id <= 100) THEN 'Premium'
	WHEN (customer_id BETWEEN 100 AND 200) THEN 'Plus'
	ELSE 'Normal'
END AS customer_class
FROM customer;

/* Using CASE expression to classify customers by specific customer_id number */
SELECT customer_id,
CASE customer_id
	WHEN 2 THEN 'Winner'
	WHEN 5 THEN 'Second Place'
	ELSE 'Normal'
END AS raffle_results
FROM customer;

/* Using CASE expression with aggregate funcions to summarize results */
SELECT
SUM (CASE rental_rate
	WHEN 0.99 THEN 1
	ELSE 0
END) AS bargains,
SUM (CASE rental_rate
	WHEN 2.99 THEN 1
	ELSE 0
END) AS regular,
SUM (CASE rental_rate
	WHEN 4.99 THEN 1
	ELSE 0
END) AS premium
FROM film;


/* Challenges | CASE */
/* We want to know and compare the various amounts of films we have per movie rating. */

SELECT
SUM (
	CASE rating
	WHEN 'R' THEN 1
	ELSE 0
	END
) AS r,
SUM (
	CASE rating
	WHEN 'PG' THEN 1
	ELSE 0
	END
) AS pg,
SUM (
	CASE rating
	WHEN 'PG-13' THEN 1
	ELSE 0
	END
) AS pg13
FROM film;


/* COALESCE */

/* 
The COALESCE function accepts an unlimited number of arguments. 
It returns the first argument that is not null. If all arguments are null, 
the COALESCE function will return null.

The COALESCE function becomes useful when querying a table that contains 
null values and substituting it with another value. 
*/

/* Using COALESCE to avoid erros due to the possible NULL value in the replacement_cost column */ 
SELECT 
title, 
ROUND(((rental_rate / COALESCE(replacement_cost, 0)) * 100),2) AS percent_rental_rate
FROM film;


/* CAST */

/* 
The CAST operator let’s you convert from one data type into another.
*/

/* 
Using CAST to convert the integer inventory_id to a variable string.
The goal here is to identify the number of characters per inventory_id.
*/
SELECT CHAR_LENGTH(CAST(inventory_id AS VARCHAR)) 
FROM rental;


/* NULLIF */

/* 
The NULLIF function takes in 2 inputs and returns NULL if both are equal, 
otherwise it returns the first argument passed.
NULLIF(arg1,arg2)
*/

SELECT (
SUM(CASE WHEN department = 'A' THEN 1 ELSE 0 END) /
NULLIF(SUM(CASE WHEN department = 'B' THEN 1 ELSE 0 END), 0)
) AS department_ratio
FROM depts


/* VIEWS */

/*
> A view is a database object that is of a stored query. 
> A view can be accessed as a virtual table.
> Notice that a view does not store data physically, it simply stores the query.
*/

/* Creating a view */
CREATE VIEW customer_info AS
SELECT first_name, last_name, address
FROM customer
INNER JOIN address
ON customer.address_id = address.address_id;

SELECT * FROM customer_info;

/* Editing an existing view */
CREATE OR REPLACE VIEW customer_info AS
SELECT first_name, last_name, address, district
FROM customer
INNER JOIN address
ON customer.address_id = address.address_id;

SELECT * FROM customer_info;

/* Altering the name of a view */
ALTER VIEW customer_info RENAME TO c_info

SELECT * FROM c_info;

/* Deleting a view */
DROP VIEW IF EXISTS c_info;

SELECT * FROM c_info;

