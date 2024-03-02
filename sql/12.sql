/* 
 * A new James Bond movie will be released soon, and management wants to send promotional material to "action fanatics".
 * They've decided that an action fanatic is any customer where at least 4 of their 5 most recently rented movies are action movies.
 *
 * Write a SQL query that finds all action fanatics.
 */

WITH ActionRentals AS (
    SELECT r.customer_id, fc.category_id,
           ROW_NUMBER() OVER (PARTITION BY r.customer_id ORDER BY r.rental_date DESC) AS rental_rank
    FROM rental r
    JOIN inventory i ON r.inventory_id = i.inventory_id
    JOIN film f ON i.film_id = f.film_id
    JOIN film_category fc ON f.film_id = fc.film_id
    WHERE fc.category_id = (SELECT category_id FROM category WHERE name = 'Action')
)
SELECT c.customer_id, c.first_name, c.last_name
FROM customer c
JOIN (
    SELECT customer_id
    FROM ActionRentals
    WHERE rental_rank <= 5
    GROUP BY customer_id
    HAVING COUNT(*) >= 4
) AS ActionFanatics ON c.customer_id = ActionFanatics.customer_id
ORDER BY c.customer_id;

