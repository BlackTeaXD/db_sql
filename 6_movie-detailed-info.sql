WITH movie_genres AS (SELECT movie.id, movie.title, json_agg(genre.*) AS genre
                      FROM movie
                               JOIN movie_genre ON movie.id = movie_genre.movie_id
                               JOIN genre ON genre.id = movie_genre.genre_id
                      GROUP BY movie.id, movie.title),
     movie_director AS (SELECT movie.id,
                               json_agg(json_build_object('id', person.id, 'first_name', person.first_name, 'last_name',
                                                          person.last_name, 'photo', file.*))->0 AS director
                        FROM movie
                                 JOIN person ON movie.director = person.id
                                 JOIN photos ON photos.person_id = person.id AND photos.primary = true
                                 JOIN file ON file.id = photos.photo_id
                        GROUP BY movie.id),
     movie_actors AS (SELECT movie.id,
                             json_agg(json_build_object('id', person.id, 'first_name', person.first_name, 'last_name',
                                                        person.last_name, 'photo', file.*)) AS actors
                      FROM movie
                               JOIN movie_actor ON movie.id = movie_actor.movie_id
                               JOIN person ON movie_actor.person_id = person.id
                               LEFT JOIN photos ON photos.person_id = person.id AND photos."primary" = true
                               LEFT JOIN file ON file.id = photos.photo_id
                      GROUP BY movie.id),
     movie_poster AS (SELECT movie.id,
                             json_agg(file)->0 as poster
                      FROM movie
                               JOIN posters ON posters.poster_id = movie.id
                               JOIN file ON posters.poster_id = file.id
                      GROUP BY movie.id)
SELECT m.id,
       m.title,
       m.release_date,
       m.duration,
       m.description,
       movie_poster.poster,
       movie_director.director,
       movie_actors.actors,
       movie_genres.genre
FROM movie AS m
         JOIN movie_poster ON movie_poster.id = m.id
         JOIN movie_genres ON movie_genres.id = m.id
         JOIN movie_director ON movie_director.id = m.id
         JOIN movie_actors ON movie_actors.id = m.id
WHERE m.id = 1;