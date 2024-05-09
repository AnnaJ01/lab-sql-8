-- 1. Rank films by length (filter out the rows with nulls or zeros in length column). Select only columns title, length and rank in your output.

SELECT TITLE, LENGTH,
RANK() OVER (ORDER BY LENGTH DESC) AS RANKING_LENGTH
FROM SAKILA.FILM
WHERE LENGTH <> '0' OR LENGTH <> ' ';


-- 2. Rank films by length within the rating category (filter out the rows with nulls or zeros in length column). 
-- In your output, only select the columns title, length, rating and rank.

SELECT TITLE, LENGTH, RATING,
RANK() OVER (PARTITION BY RATING ORDER BY LENGTH DESC) AS RANKING_LENGTH
FROM SAKILA.FILM
WHERE LENGTH <> '0' OR LENGTH IS NOT NULL;


-- 3. How many films are there for each of the categories in the category table? 
-- Hint: Use appropriate join between the tables "category" and "film_category".

SELECT * FROM SAKILA.CATEGORY;
SELECT * FROM SAKILA.FILM_CATEGORY;

SELECT COUNT(*) FROM SAKILA.CATEGORY;
SELECT COUNT(*) FROM SAKILA.FILM_CATEGORY;

SELECT C.NAME AS CATEGORY_NAME, COUNT(F_C.FILM_ID) AS FILM_COUNT
FROM SAKILA.CATEGORY C
INNER JOIN SAKILA.FILM_CATEGORY F_C 
ON C.CATEGORY_ID = F_C.CATEGORY_ID
GROUP BY C.NAME;


-- 4. Which actor has appeared in the most films? 
-- Hint: You can create a join between the tables "actor" and "film actor" and count the number of times an actor appears.

SELECT * FROM SAKILA.ACTOR;
SELECT * FROM SAKILA.FILM_ACTOR;

SELECT COUNT(*) FROM SAKILA.ACTOR;
SELECT COUNT(*) FROM SAKILA.FILM_ACTOR;

SELECT *
FROM SAKILA.ACTOR A
INNER JOIN SAKILA.FILM_ACTOR F_A
ON A.ACTOR_ID = F_A.ACTOR_ID;

SELECT A.ACTOR_ID AS ACTORS, A.FIRST_NAME, A.LAST_NAME, COUNT(F_A.FILM_ID) AS FILM_COUNT
FROM SAKILA.ACTOR A
INNER JOIN SAKILA.FILM_ACTOR F_A
ON A.ACTOR_ID = F_A.ACTOR_ID
GROUP BY A.ACTOR_ID
ORDER BY FILM_COUNT DESC
LIMIT 1;


-- 5. Which is the most active customer (the customer that has rented the most number of films)? 
-- Hint: Use appropriate join between the tables "customer" and "rental" and count the rental_id for each customer.

SELECT * FROM SAKILA.CUSTOMER;
SELECT * FROM SAKILA.RENTAL;


SELECT C.CUSTOMER_ID, COUNT(R.RENTAL_ID)
FROM SAKILA.CUSTOMER C
INNER JOIN SAKILA.RENTAL R
ON C.CUSTOMER_ID = R.CUSTOMER_ID
GROUP BY 1
ORDER BY 2 DESC
LIMIT 1;

-- Bonus: Which is the most rented film? (The answer is Bucket Brotherhood).
-- This query might require using more than one join statement. Give it a try.
-- We will talk about queries with multiple join statements later in the lessons.
-- Hint: You can use join between three tables - "Film", "Inventory", and "Rental" and count the rental ids for each film.


SELECT * FROM SAKILA.FILM;
SELECT * FROM SAKILA.INVENTORY;
SELECT * FROM SAKILA.RENTAL;

SELECT F.FILM_ID AS Film,
       COUNT(R.RENTAL_ID) AS Rental_Count
FROM SAKILA.FILM F
INNER JOIN SAKILA.INVENTORY I ON F.FILM_ID = I.FILM_ID
INNER JOIN SAKILA.RENTAL R ON I.INVENTORY_ID = R.INVENTORY_ID
GROUP BY F.FILM_ID
ORDER BY Rental_Count DESC;

SELECT TITLE 
FROM SAKILA.FILM
WHERE FILM_ID = 103;

