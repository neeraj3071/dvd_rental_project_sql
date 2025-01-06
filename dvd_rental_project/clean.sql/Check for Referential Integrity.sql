-- ***** Check for Referential Integrity *****--
-- Actor --
SELECT * from actor;

SELECT * from film;

SELECT * FROM film_actor WHERE actor_id NOT IN (SELECT actor_id FROM actor);

--- Film ---
SELECT * from actor;

SELECT * from film;

SELECT * FROM film_category WHERE film_id NOT IN (SELECT film_id FROM film);

--- Rental --- 
SELECT * from rental;

SELECT * from customer;

SELECT * FROM rental WHERE customer_id NOT IN (SELECT customer_id FROM customer);
