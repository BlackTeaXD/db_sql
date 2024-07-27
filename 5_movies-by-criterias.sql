SELECT m.id,
       m.title,
       m.release_date,
       m.duration,
       m.description,
       ROW_TO_JSON(f.*)                                                                                   AS poster,
       JSON_AGG(JSON_BUILD_OBJECT('id', p.id, 'first_name', p.first_name, 'last_name', p.last_name)) -> 0 AS director
FROM movie AS m
         JOIN movie_genre AS mg ON mg.movie_id = m.id
         JOIN genre AS g ON mg.genre_id = g.id
         JOIN posters AS post ON post.movie_id = m.id
         JOIN file AS f ON post.poster_id = f.id
         JOIN person AS p ON p.id = m.director
WHERE m.country = 1
  AND m.release_date
    > '2022-01-01'
  AND m.duration
    > '2:15'
  AND (g.name = 'Action'
    OR g.name = 'Drama')
GROUP BY m.id, f
