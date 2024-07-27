SELECT p.id, CONCAT(p.first_name, ' ', p.last_name), AVG(m.budget)
FROM person AS p
         JOIN movie AS m ON m.director = p.id
GROUP BY p.id;