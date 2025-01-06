-- Queries for dvdrental database

-- 1. Retrieve all records from the 'actor' table
SELECT * FROM public.actor;

-- 2. Retrieve all films released after the year 2000
SELECT film_id, title, release_year FROM public.film WHERE release_year > 2000;

-- 3. Find the customers who have rented the most films
SELECT customer_id, COUNT(rental_id) AS rentals_count
FROM public.rental
GROUP BY customer_id
ORDER BY rentals_count DESC
LIMIT 10;

-- 4. Get all actors who have acted in films of the 'Comedy' category
SELECT a.first_name, a.last_name
FROM public.actor a
JOIN public.film_actor fa ON a.actor_id = fa.actor_id
JOIN public.film_category fc ON fa.film_id = fc.film_id
JOIN public.category c ON fc.category_id = c.category_id
WHERE c.name = 'Comedy';

-- 5. Find all payments made by customers for a specific film (e.g., 'Date Speed')
SELECT p.payment_id, p.amount, p.payment_date, c.first_name, c.last_name
FROM public.payment p
JOIN public.rental r ON p.rental_id = r.rental_id
JOIN public.customer c ON r.customer_id = c.customer_id
JOIN public.inventory i ON r.inventory_id = i.inventory_id
JOIN public.film f ON i.film_id = f.film_id
WHERE f.title = 'Date Speed';

-- 6. Get all films with more than 2 hours of runtime and a rating of 'PG-13'
SELECT title, length, rating
FROM public.film
WHERE length > 120 AND rating = 'PG-13';

-- 7. List all customers who live in the same city (e.g., 'Dadu')
SELECT c.first_name, c.last_name, a.address
FROM public.customer c
JOIN public.address a ON c.address_id = a.address_id
JOIN public.city ci ON a.city_id = ci.city_id
WHERE ci.city = 'Dadu';

-- 8. List all the films and their categories
SELECT f.title, c.name AS category
FROM public.film f
JOIN public.film_category fc ON f.film_id = fc.film_id
JOIN public.category c ON fc.category_id = c.category_id;



-- 9. To show each staff member and the number of payments they have processed
SELECT s.first_name, s.last_name, COUNT(p.payment_id) AS payment_count
FROM public.staff s
LEFT JOIN public.payment p ON s.staff_id = p.staff_id
GROUP BY s.staff_id;

-- 10. Get the total amount paid by each customer
SELECT c.first_name, c.last_name, SUM(p.amount) AS total_paid
FROM public.payment p
JOIN public.rental r ON p.rental_id = r.rental_id
JOIN public.customer c ON r.customer_id = c.customer_id
GROUP BY c.customer_id
ORDER BY total_paid DESC;

-- 11. Find the top 5 most expensive films based on replacement cost
SELECT title, replacement_cost
FROM public.film
ORDER BY replacement_cost DESC
LIMIT 5;

--- 12.Determine the average rental duration for each film category ---

SELECT 
    c.name AS category_name, 
    AVG(DATE_PART('day', r.return_date - r.rental_date)) AS avg_rental_duration
FROM category c
JOIN film_category fc ON c.category_id = fc.category_id
JOIN film f ON fc.film_id = f.film_id
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
WHERE r.return_date IS NOT NULL
GROUP BY c.name
ORDER BY avg_rental_duration DESC;

--- 13. Find customers who spent above the average total amount on rentals ---
SELECT 
    c.first_name || ' ' || c.last_name AS customer_name, 
    SUM(p.amount) AS total_spent
FROM customer c
JOIN payment p ON c.customer_id = p.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
HAVING SUM(p.amount) > (
    SELECT AVG(total_spent)
    FROM (
        SELECT SUM(p.amount) AS total_spent
        FROM payment p
        GROUP BY p.customer_id
    ) AS avg_spending
)
ORDER BY total_spent DESC;

--- 14. Find the country with the highest number of customers ---
SELECT 
    co.country AS country_name, 
    COUNT(c.customer_id) AS total_customers
FROM customer c
JOIN address a ON c.address_id = a.address_id
JOIN city ci ON a.city_id = ci.city_id
JOIN country co ON ci.country_id = co.country_id
GROUP BY co.country
ORDER BY total_customers DESC
LIMIT 1;

--- 15. Identify staff members who handled the highest total payment transactions ---
SELECT 
    st.first_name || ' ' || st.last_name AS staff_name, 
    SUM(p.amount) AS total_payments_handled
FROM staff st
JOIN payment p ON st.staff_id = p.staff_id
GROUP BY st.staff_id, st.first_name, st.last_name
ORDER BY total_payments_handled DESC;

--- 16. List films that have never been rented ---
SELECT 
    f.title AS film_title
FROM film f
LEFT JOIN inventory i ON f.film_id = i.film_id
LEFT JOIN rental r ON i.inventory_id = r.inventory_id
WHERE r.rental_id IS NULL;

--- 17. Rank films based on their popularity (number of rentals) ---
SELECT 
    f.title AS film_title, 
    COUNT(r.rental_id) AS rental_count, 
    RANK() OVER (ORDER BY COUNT(r.rental_id) DESC) AS popularity_rank
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
GROUP BY f.title
ORDER BY popularity_rank;

--- 18.Retrieve films that were rented but never returned ---
SELECT 
    f.title AS film_title, 
    r.rental_date AS rented_on
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
WHERE r.return_date IS NULL;

--- 19. Top actors who appeared in the most films ---

SELECT 
    s.store_id, 
    SUM(p.amount) AS total_revenue
FROM store s
JOIN staff st ON s.store_id = st.store_id
JOIN payment p ON st.staff_id = p.staff_id
GROUP BY s.store_id
ORDER BY total_revenue DESC;

-- 20. Get the inventory details of a specific store (e.g., store_id = 1)
SELECT i.inventory_id, f.title, i.store_id
FROM public.inventory i
JOIN public.film f ON i.film_id = f.film_id
WHERE i.store_id = 1;

-- 21. Get the total number of rentals per store
SELECT s.store_id, COUNT(r.rental_id) AS total_rentals
FROM public.store s
JOIN public.inventory i ON s.store_id = i.store_id
JOIN public.rental r ON i.inventory_id = r.inventory_id
GROUP BY s.store_id;

-- 22. Find the customers who rented films in the month of Feb 2006
SELECT c.first_name, c.last_name, r.rental_date
FROM public.customer c
JOIN public.rental r ON c.customer_id = r.customer_id
WHERE EXTRACT(MONTH FROM r.rental_date) = 2 AND EXTRACT(YEAR FROM r.rental_date) = 2006;

-- 23. Get the most popular film categories based on the number of rentals
SELECT c.name AS category, COUNT(r.rental_id) AS rental_count
FROM public.film_category fc
JOIN public.category c ON fc.category_id = c.category_id
JOIN public.inventory i ON fc.film_id = i.film_id
JOIN public.rental r ON i.inventory_id = r.inventory_id
GROUP BY c.category_id
ORDER BY rental_count DESC;

-- 24. Retrieve the rental and payment details for each customer, showing film title, rental amount, and payment
SELECT c.first_name, c.last_name, f.title AS film_title, r.rental_date, p.amount AS payment_amount
FROM public.customer c
JOIN public.rental r ON c.customer_id = r.customer_id
JOIN public.payment p ON r.rental_id = p.rental_id
JOIN public.inventory i ON r.inventory_id = i.inventory_id
JOIN public.film f ON i.film_id = f.film_id
ORDER BY r.rental_date DESC;

-- 25. Calculate the average rental amount for each staff member
SELECT s.first_name, s.last_name, AVG(p.amount) AS avg_payment
FROM public.staff s
JOIN public.payment p ON s.staff_id = p.staff_id
GROUP BY s.staff_id
ORDER BY avg_payment DESC;

-- 26. Find customers who have rented films for more than 5 days
SELECT c.first_name, c.last_name, COUNT(r.rental_id) AS rental_count
FROM public.customer c
JOIN public.rental r ON c.customer_id = r.customer_id
WHERE r.return_date - r.rental_date > INTERVAL '5 days'
GROUP BY c.customer_id;

-- 27. Analyze rental trends over time,
-- Using indexes and analyzing performance.
SELECT DATE_TRUNC('month', r.rental_date) AS rental_month, COUNT(*) AS total_rentals
FROM rental r
GROUP BY rental_month
ORDER BY rental_month;

-- 28 To find staff who processed the most payments and the total amount they processed
SELECT s.first_name, s.last_name, COUNT(p.payment_id) AS total_payments, SUM(p.amount) AS total_amount
FROM public.staff s
JOIN public.payment p ON s.staff_id = p.staff_id
GROUP BY s.staff_id
ORDER BY total_amount DESC
LIMIT 5;

-- 29 Query to get the most popular films (based on rentals)
SELECT f.film_id, f.title, COUNT(r.rental_id) AS rental_count
FROM public.film f
JOIN public.inventory i ON f.film_id = i.film_id
JOIN public.rental r ON i.inventory_id = r.inventory_id
GROUP BY f.film_id
ORDER BY rental_count DESC
LIMIT 10;





