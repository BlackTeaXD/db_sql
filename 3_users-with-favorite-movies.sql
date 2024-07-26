SELECT u.id, u.username, ARRAY_AGG(fm.movie_id)
FROM users AS u
JOIN favorite_movie as fm ON u.id = fm.user_id
GROUP BY u.id