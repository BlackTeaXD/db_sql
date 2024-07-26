SELECT
    p.id,
    p.first_name,
    p.last_name,
    SUM(m.budget) AS total_budget
FROM person AS p
JOIN movie_actor AS ma ON p.id = ma.person_id
JOIN movie AS m ON m.id = ma.movie_id
GROUP BY p.id;