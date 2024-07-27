SELECT m.id,
       m.title,
       COUNT(ma.person_id) AS actors_count
FROM movie as m
         LEFT JOIN movie_actor AS ma ON m.id = ma.movie_id
WHERE m.release_date + INTERVAL '5 year' > now()
GROUP BY m.id, m.release_date
