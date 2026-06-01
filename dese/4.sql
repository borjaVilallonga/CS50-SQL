SELECT city, COUNT(*) AS public_schools
FROM Schools
WHERE TYPE = 'Public School'
GROUP BY city
ORDER BY public_schools DESC, city ASC
LIMIT 10
