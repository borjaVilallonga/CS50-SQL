SELECT performances.year, performances.HR
FROM performances
JOIN players
    ON performances.player_id = players.id
WHERE first_name = 'Ken' AND last_name = 'Griffey' AND birth_year = 1969
ORDER BY performances.year DESC
