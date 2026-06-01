SELECT salaries.salary
FROM performances
JOIN salaries
    ON performances.player_id = salaries.player_id
    AND performances.year = salaries.year
WHERE performances.year = 2001
AND performances.HR = (
    SELECT MAX(HR)
    FROM performances
    WHERE year = 2001
)
