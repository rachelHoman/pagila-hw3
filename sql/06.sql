/*
 * This question and the next one are inspired by the Bacon Number:
 * https://en.wikipedia.org/wiki/Six_Degrees_of_Kevin_Bacon#Bacon_numbers
 *
 * List all actors with Bacall Number 1.
 * That is, list all actors that have appeared in a film with 'RUSSELL BACALL'.
 * Do not list 'RUSSELL BACALL', since he has a Bacall Number of 0.
 */

SELECT DISTINCT a2.first_name || ' ' || a2.last_name AS "Actor Name"
FROM actor a1
JOIN film_actor f1 ON a1.actor_id = f1.actor_id
JOIN film f ON f1.film_id = f.film_id
JOIN film_actor f2 ON f.film_id = f2.film_id
JOIN actor a2 ON f2.actor_id = a2.actor_id
WHERE a1.first_name = 'RUSSELL' AND a1.last_name = 'BACALL'
AND (a2.first_name != 'RUSSELL' OR a2.last_name != 'BACALL')
ORDER BY "Actor Name";
