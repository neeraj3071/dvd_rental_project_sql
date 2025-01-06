-- ***** Standardize format *****--
-- Customer --
SELECT * FROM customer;

UPDATE customer
SET first_name = INITCAP(first_name), 
    last_name = INITCAP(last_name), 
	create_date = TO_DATE('2006-02-14', 'YYYY-MM-DD');

--- Address ---
SELECT * FROM address;

UPDATE address
SET address = INITCAP(address), 
    district = INITCAP(district);
	
--- Film ---
SELECT * FROM film;

UPDATE film
SET title = INITCAP(title), 
    description = INITCAP(description);
	
--- Payment ---
UPDATE payment
SET payment_date = TO_DATE('2006-02-14', 'YYYY-MM-DD')::TIMESTAMP AT TIME ZONE 'UTC';

ROLLBACK; 

SELECT * from payment;


