SELECT city, COUNT(*) AS numeroEscuelas
FROM schools
WHERE type = 'Public School'
GROUP BY city
HAVING COUNT(*) <= 3
ORDER BY numeroEscuelas DESC, city ASC;

