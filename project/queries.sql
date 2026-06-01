-- In this SQL file, write (and comment!) the typical SQL queries users will run on your database

-- 1. INSERTION QUERIES -> Adding new data

-- 1.1 Add, edit, delete observations
INSERT INTO observations (id_animal, registration_date, observation) VALUES (?, ?, ?)
UPDATE observations SET observation = ?, registration_date = ? WHERE id_observation = ?
DELETE FROM observations WHERE id_observation = ?;

-- 1.2 Register a new animal bith
INSERT INTO births (id_animal, id_calving_season, birth_date, birth_status)
VALUES (?, ?, ?, ?);

-- 1.3 Add new animal
INSERT INTO animals (ear_tag, short_ear_tag, breed, sex, birth_date, brand, coat,
                     id_birth_farm, status, mother_ear_tag, id_mother)
VALUES (?, ?, ?, ?, ?, ?, ?, ?, 'VIVA', ?, (SELECT id_animal FROM animals WHERE ear_tag = ?));

-- 2 SELECTION QUERIES -> Generic filters and reports

-- 2.1 Search data for a specific data from live animals in a explotation
SELECT a.id_animal, a.ear_tag, a.short_ear_tag, a.breed, a.sex, a.birth_date,
       a.brand, a.coat, a.id_birth_farm, m.id_farm as current_farm_id
FROM animals a
INNER JOIN movements m ON a.id_animal = m.id_animal AND m.exit_date IS NULL
WHERE m.id_explotacion = ? AND a.estado = 'VIVA'
ORDER BY a.birth_date DESC;

-- 2.2 List all pthos from animals currently present in a specific farm
SELECT i.file_path, i.photo_date, i.life_cycle
FROM imagenes i
INNER JOIN animals a ON i.id_animal = a.id_animal
WHERE a.ear_tag = ?
ORDER BY i.photo_date DESC;

-- 2.3 Obtain names from the explotation
SELECT name FROM farms WHERE id_farm = ?;

-- 3 UPDATES QUERIES (Templates for modifying data)

-- 3.1 Move an animal from a localization to another
UPDATE movements SET exit_date = date('now','localtime')
WHERE id_animal = ? AND exit_date IS NULL;

INSERT INTO movements (id_animal, id_farm, entry_date, exit_date)
VALUES (?, ?, date('now','localtime'), NULL);

-- 3.2 Remove an animal
UPDATE animals SET status = ?, removal_date = ? WHERE ear_tag = ?;
UPDATE movements SET exit_date = ? WHERE id_animal = ? AND exit_date IS NULL;


-- 4 DELETE QUERIES

-- 4.1 Remove a specific observation record by its Id
DELETE FROM observations
WHERE id_observation = ?;

-- 4.2 Remove an animal record
DELETE FROM animals
WHERE id_animal = ?;
