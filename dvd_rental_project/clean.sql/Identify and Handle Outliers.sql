-- ***** Identify and Handle Outliers *****--
-- Film --
SELECT * from film;

SELECT * FROM film WHERE LENGTH(description) < 500;

--- Payment ---
SELECT * from payment;

SELECT * FROM payment WHERE rental_id > 500;

--- Rental ---

SELECT * from rental;

SELECT * FROM rental WHERE inventory_id > 500;
