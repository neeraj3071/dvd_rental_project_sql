-- ***** Fix Data Entry Errors *****--
-- Actor --
SELECT * from actor;

SELECT * FROM actor WHERE first_name LIKE '%@%' OR last_name LIKE '%#%';

--- Film ---
SELECT * from film;

SELECT * FROM film WHERE title LIKE '%@%' OR title LIKE '%#%';

SELECT * FROM film WHERE array_to_string(special_features, ' ') LIKE '%@%' OR title LIKE '%#%';



