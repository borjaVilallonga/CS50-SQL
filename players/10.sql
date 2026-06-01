SELECT first_name AS jugador, last_name AS apellido, height
FROM players
WHERE height > (SELECT AVG(height) FROM players)
ORDER BY height DESC, first_name ASC, last_name ASC;

