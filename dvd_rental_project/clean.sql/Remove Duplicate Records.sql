-- ***** Remove Unnecessary or Irrelevant Data *****--
-- Inventory --
SELECT * from inventory;

DELETE FROM inventory WHERE last_update < '2022-01-01';

--- Payment ---
SELECT * from payment;

DELETE FROM payment WHERE payment_date < '2022-01-01';

--- Rental ---
SELECT * from rental;

DELETE FROM rental WHERE return_date < '2022-01-01';