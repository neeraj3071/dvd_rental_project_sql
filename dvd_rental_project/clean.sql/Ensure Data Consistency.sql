-- ***** Ensure Data Consistency *****--
-- Address --
SELECT * FROM address;
SELECT * FROM city;

SELECT * FROM address WHERE city_id NOT IN (SELECT city_id FROM city);

--- Rental ---
SELECT * FROM rental;
SELECT * FROM customer;

SELECT * FROM rental WHERE customer_id NOT IN (SELECT customer_id FROM customer);

SELECT * 
FROM rental 
WHERE customer_id NOT IN (SELECT CAST(customer_id AS INT) FROM customer WHERE customer_id IS NOT NULL);