-- *****Check for Missing or Null Values *****--
-- Actor --
SELECT * FROM actor;

SELECT * FROM actor WHERE first_name IS NULL OR last_name IS NULL;

--- Address ---
SELECT * FROM address;

SELECT * FROM address WHERE address IS NULL OR address2 IS NULL;

-- Alter the foreign key constraint in 'payment' table to cascade on delete
ALTER TABLE payment
DROP CONSTRAINT payment_staff_id_fkey,
ADD CONSTRAINT payment_staff_id_fkey FOREIGN KEY (staff_id) REFERENCES staff(staff_id) ON DELETE CASCADE;

-- Alter the foreign key constraint in 'staff' table to cascade on delete
ALTER TABLE staff
DROP CONSTRAINT staff_address_id_fkey,
ADD CONSTRAINT staff_address_id_fkey FOREIGN KEY (address_id) REFERENCES address(address_id) ON DELETE CASCADE;

-- Alter the foreign key constraint in 'rental' table to cascade on delete
ALTER TABLE rental
DROP CONSTRAINT rental_staff_id_key,
ADD CONSTRAINT rental_staff_id_key FOREIGN KEY (staff_id) REFERENCES staff(staff_id) ON DELETE CASCADE;

-- Delete rows where 'address' or 'address2' is NULL
DELETE FROM address
WHERE address IS NULL OR address2 IS NULL;

--- Category ---
Select * from category;

SELECT * FROM category WHERE name IS NULL OR last_update IS NULL;

--- City ---
Select * from city;

SELECT * FROM city WHERE city IS NULL OR country_id IS NULL;

--- Country ---
Select * from country;

SELECT * FROM country WHERE country IS NULL;

--- Customer --
SELECT * FROM customer;

SELECT * FROM customer WHERE first_name IS NULL OR last_name IS NULL;

--- Film_Id ---
Select * from film_actor;

SELECT * FROM film_actor WHERE actor_id IS NULL OR film_id IS NULL;

--- Film ---
SELECT * FROM film;

SELECT * FROM film WHERE film_id IS NULL OR title IS NULL;

--- Inventory ---
SELECT * FROM inventory;

SELECT * FROM inventory WHERE inventory_id IS NULL OR store_id IS NULL;

--- Language ---
Select * from languages;

--- Payment ---
SELECT * FROM payment;

SELECT * FROM payment WHERE Payment_id IS NULL OR amount IS NULL;

--- Rental --
SELECT * FROM rental;

SELECT * FROM rental WHERE rental_id IS NULL OR return_date IS NULL;

--- Staff ---
Select * from staff;

--- Store ---
Select * from store;


