-- Hello World SQL Query, Select all records from a table
-- Syntax: SELECT column_name FROM table_name
SELECT *
FROM actor;

-- To query specific columns, add them in the SELECT statement
SELECT first_name, last_name
FROM actor;


-- Filter rows by using the WHERE clause
SELECT first_name, last_name
FROM actor
WHERE first_name = 'Nick';


-- The "LIKE" keyword allows us to add widlcards to the string
SELECT first_name, last_name
FROM actor
WHERE first_name LIKE 'Nick';

-- With a LIKE keyword, '%' represents any number of character
SELECT first_name, last_name
FROM actor
WHERE first_name LIKE 'J%'; -- will look FOR 'J' followed BY ANY number OF characters

-- With a LIKE keyword, '_' represents one character
SELECT first_name, last_name
FROM actor 
WHERE first_name LIKE 'K__';

SELECT first_name, last_name
FROM actor
WHERE first_name = 'J%'; -- will literally look FOR 'J%'

-- using AND and OR in the where clause
-- OR - only one needs to be True
SELECT *
FROM actor 
WHERE first_name LIKE 'N%' OR last_name LIKE 'W%';

-- AND - all conditions need to be true
SELECT *
FROM actor 
WHERE first_name LIKE 'N%' AND last_name LIKE 'W%';

-- Comparison Operators in SQL:
-- Greater Than >
-- Less That <
-- Greater Than or Equal To >=
-- Less Than or Equal To <=
-- Equals =
-- Not equals <> or !=

SELECT *
FROM payment;

-- Query all of the payments of more than $7.00
SELECT *
FROM payment 
WHERE amount > 7;

-- Query for all less than 7
SELECT *
FROM payment
WHERE amount <= '6.99';

-- Not Equals
SELECT *
FROM staff
WHERE staff_id <> 1;

SELECT *
FROM staff 
WHERE staff_id != 2;

SELECT *
FROM film 
WHERE title NOT LIKE 'F%';


-- Get all of the payments between $3.00 and $8.00
SELECT *
FROM payment 
WHERE amount >= 3 AND amount <= 8;


-- BETWEEN/AND clause - (*inclusive)
SELECT *
FROM payment 
WHERE amount BETWEEN 3 AND 8;


SELECT *
FROM film 
WHERE film_id BETWEEN 10 AND 20;


-- Order the rows of data using the ORDER BY clause
-- default is Ascending Order (add DESC for descending)
-- Syntax: ORDER BY column_name
SELECT *
FROM film
ORDER BY rental_duration;


SELECT *
FROM film 
ORDER BY title DESC;

-- ORDER BY comes after the WHERE clause (if present)
SELECT *
FROM payment 
WHERE customer_id = 123
ORDER BY amount;


-- Exercise 1 - Write a query that will return all of the films that have an 'h' in the title
-- and order it by rental duration (in ascending order)
SELECT *
FROM film
WHERE title ILIKE '%h%'
ORDER BY rental_duration ASC;


SELECT *
FROM film
WHERE LOWER(title) LIKE '%h%'
ORDER BY rental_duration ASC;

SELECT lower(title)
FROM film;


-- SQL Aggregations -> SUM(), AVG(), COUNT(), MIN(), MAX()
-- take in a column name and return a single value

-- SUM - find the sum of a column
SELECT SUM(amount)
FROM payment;


SELECT SUM(amount)
FROM payment
WHERE customer_id = 123;

--SELECT SUM(first_name)
--FROM actor;

-- AVG - find the average of a column
SELECT AVG(amount)
FROM payment;

-- MIN/MAX - find smallest/largest value in a column
-- alias column names using "as" - col_name AS alias_name
SELECT MIN(amount) AS smallest_amount, MAX(amount) AS largest_amount
FROM payment;

-- Also work with strings (VarChar)
SELECT MIN(first_name), MAX(first_name)
FROM actor;


-- COUNT() - Takes in either a column_name OR * for all columns
-- If column_name, will count any NON-NULL rows in that column
-- If *, will count all rows
SELECT *
FROM staff;


SELECT COUNT(*)
FROM staff; -- will RETURN 2 because there ARE 2 ROWS

SELECT COUNT(picture)
FROM staff; -- will RETURN 1 because ONLY 1 staff MEMBER has a picture, the other IS NULL

-- to count unique values, use the distinct keyword
SELECT *
FROM actor
WHERE first_name LIKE 'A%'
ORDER BY first_name;

SELECT COUNT(first_name)
FROM actor
WHERE first_name LIKE 'A%'; -- 13

SELECT COUNT(DISTINCT first_name)
FROM actor
WHERE first_name LIKE 'A%'; -- 9



-- GROUP BY clause
-- used with aggregations
SELECT *
FROM payment
ORDER BY amount;

SELECT COUNT(*)
FROM payment
WHERE amount = 0; -- 24


SELECT COUNT(*)
FROM payment 
WHERE amount = 0.99; -- 2720

SELECT COUNT(*)
FROM payment
WHERE amount = 1.99; -- 580

SELECT amount, COUNT(*), SUM(amount), AVG(amount)
FROM payment
GROUP BY amount
ORDER BY amount;

-- columns selected from the table must also be in the GROUP BY
SELECT amount, customer_id, COUNT(*)
FROM payment
GROUP BY amount; 
-- column "payment.customer_id" must appear in the GROUP BY clause 
-- or be used in an aggregate FUNCTION


SELECT amount, customer_id, COUNT(*)
FROM payment
GROUP BY amount, customer_id
ORDER BY customer_id;


SELECT customer_id, COUNT(*)
FROM payment
GROUP BY customer_id
ORDER BY customer_id;

SELECT customer_id, SUM(amount)
FROM payment 
GROUP BY customer_id
ORDER BY customer_id;



-- Use aggregations in the ORDER BY clause
SELECT customer_id, SUM(amount)
FROM payment 
GROUP BY customer_id
ORDER BY SUM(amount) DESC;


-- We can use aliased column names in the order by clause
SELECT customer_id, SUM(amount) AS total_spend
FROM payment 
GROUP BY customer_id
ORDER BY total_spend DESC;


-- HAVING Clause - Having is to GROUP BY/Aggregations as WHERE is to SELECT
SELECT *
FROM payment
WHERE amount > 10;


SELECT customer_id, SUM(amount) AS total_spend
FROM payment 
GROUP BY customer_id
HAVING SUM(amount) > 200
ORDER BY total_spend DESC;


SELECT customer_id, SUM(amount)
FROM payment 
GROUP BY customer_id
HAVING SUM(amount) BETWEEN 75 AND 100;


-- LIMIT and OFFSET clauses

-- LIMIT - limit the number of rows that are returned
SELECT *
FROM city
LIMIT 10;

SELECT *
FROM film
LIMIT 10;


-- OFFSET - start your rows after a certain name
SELECT *
FROM city
OFFSET 5;

-- Can be used together
SELECT *
FROM city
OFFSET 20
LIMIT 10;


-- Syntax Order -- (SELECT and FROM are the only mandatory clauses)

-- SELECT (column_names)
-- FROM (table_name)
-- WHERE (row filter)
-- GROUP BY (aggregations)
-- HAVING (filter aggregations)
-- ORDER BY (column_value ASC or DESC)
-- OFFSET (number of rows to skip)
-- LIMIT (max number of rows to display)

SELECT first_name, COUNT(*)
FROM actor
WHERE actor_id > 10
GROUP BY first_name
HAVING first_name LIKE '%t%'
ORDER BY first_name
OFFSET 5
LIMIT 5;


SELECT first_name, COUNT(*) FROM actor WHERE actor_id > 10 GROUP BY first_name HAVING first_name LIKE '%t%' ORDER BY first_name OFFSET 5 LIMIT 5;


SELECT *
FROM (
	SELECT first_name, COUNT(*) AS num_names
	FROM actor
	WHERE actor_id > 10
	GROUP BY first_name
	HAVING first_name LIKE '%t%'
	ORDER BY first_name
	OFFSET 5
	LIMIT 5
) AS example ORDER BY num_names;


-- Start Home work *** 
-- 1. How many actors are there with the last name ‘Wahlberg’?
SELECT first_name ,last_name FROM actor WHERE last_name = 'Wahlberg'
-- there are 2 actors with the last name Wahlberg

--2. How many payments were made between $3.99 and $5.99?

--3. What films have exactly 7 copies? (search in inventory)
--4. How many customers have the first name ‘Willie’?
--5. What store employee (get the id) sold the most rentals (use the rental table)?
--6. How many unique district names are there?
--7. What film has the most actors in it? (use film_actor table and get film_id)
--8. From store_id 1, how many customers have a last name ending with ‘es’? (use customer table)
--9. How many payment amounts (4.99, 5.99, etc.) had a number of rentals above 250 for customers with ids between 380 and 430? (use group by and having > 250)
--10. Within the film table, how many rating categories are there? And what rating has the most movies total?