-- 1. List all customers who live in Texas (use
-- JOINs)
--ans: 5 customers that live in Texas

SELECT customer_id, first_name, last_name, customer.address_id, address.district
FROM customer
LEFT JOIN address
ON customer.address_id = address.address_id
WHERE district = 'Texas';


-- 2. Get all payments above $6.99 with the Customer's Full
-- Name
--ans:

SELECT payment_id, payment.customer_id, amount, customer.first_name, customer.last_name
FROM payment
FULL JOIN customer
ON payment.customer_id = customer.customer_id
order by amount > 6.99;


-- 3. Show all customers names who have made payments over $175(use
-- subqueries)
--ans:

SELECT * FROM customer
WHERE customer_id IN(
    SELECT customer_id, sum(amount)
    FROM payment
    GROUP BY customer_id
    HAVING sum(amount)>175
    ORDER BY sum(amount) DESC
);

-- 4. List all customers that live in Nepal (use the city
-- table)
--ans: 1 customer lived in Nepal

SELECT first_name, last_name
FROM customer
INNER JOIN address
ON customer.address_id = address.address_id
INNER JOIN city
ON address.city_id = city.city_id
INNER JOIN country
ON country.country_id = city.country_id
WHERE country = 'Nepal';

-- 5. Which staff member had the most
-- transactions?
--ans: Jon Stephens with 7304 transactions.

SELECT first_name, last_name, COUNT(payment.staff_id)
FROM staff
INNER JOIN payment
ON staff.staff_id = payment.staff_id
GROUP BY first_name, last_name;

-- 6. How many movies of each rating are
-- there?
--ans: pg-13: 223, nc-17: 209, g: 179, pg: 194, R: 195

SELECT rating, COUNT(rating)
FROM film
GROUP BY rating;

-- 7.Show all customers who have made a single payment
-- above $6.99 (Use Subqueries)
--ans:

SELECT first_name, last_name, customer_id
FROM customer
WHERE customer_id IN (
    SELECT customer_id, amount
    FROM payment
    WHERE amount > 6.99;
);
--8. How many free rentals did our stores give away?
--ans: 0 free rentals

select * from payment
where amount = 0