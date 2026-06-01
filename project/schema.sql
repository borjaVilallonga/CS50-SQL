-- In this SQL file, write (and comment!) the schema of your database, including the CREATE TABLE, CREATE INDEX, CREATE VIEW, etc. statements that compose it

-- LIVESTOCK MANAGEMENT DATABASE SCHEMA--

-- ENTITY:EXPLOTACIONES(Farms/Holdings)
-- Stores information about different physical location or farms
-- Each record represents a site where animals can be kept

CREATE TABLE farms (
    id_farm INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(255) NOT NULL, -- name of the farm
    location TEXT -- Geographic location of the farm
);

-- ENTITY: PARIDERA(Calving seasons)
-- Defines specific time periods for biths occurring within a date range
-- Use to locate a birth in a birth season.

CREATE TABLE calving_seasons (
    id_calving_season INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR (255) NOT NULL,
    start_date DATE,
    end_date DATE
);

-- ENTITY: ANIMALES
-- The place when records the animals and their features.
-- Adding biology data

CREATE TABLE animals (
    id_animal INTEGER PRIMARY KEY AUTOINCREMENT,
    id_mother INT NULL,
    id_father INT NULL,
    id_birth_farm INTEGER,
    ear_tag VARCHAR(50) UNIQUE NOT NULL,
    short_ear_tag INTEGER,
    brand INTEGER,
    breed VARCHAR(100),
    sex VARCHAR(10) CHECK (sexo IN ('FEMALE', 'MALE')),
    birth_date DATE,
    removal_date DATE NULL,
    status VARCHAR(20) CHECK (estado IN ('ALIVE', 'DEAD', 'SOLD'))

    FOREIGN KEY(id_mother) REFERENCES animals(id_animal) ON DETELE SET NULL,
    FOREIGN KEY(id_father) REFERENCES animals(id_animal) ON DELETE SET NULL,
    FOREIGN KEY(id_birth_farm) REFERENCES farms(id_farm);
)

-- ENTITY: PARTOS (Births)
-- Dates and data from female animals.
-- Links the mother to a specific calving season (paridera table)

CREATE TABLE births(
    id_birth INTEGER PRIMARY KEY AUTOINCREMENT,
    id_animal INT NOT NULL,
    id_calving_season INT NOT NULL,
    birth_status VARCHAR (100) NOT NULL,
    birth_date DATE NULL,
    birth_type VARCHAR(20) NULL,
    observations TEXT,

    FOREIGN KEY (id_animal) REFERENCES animals(id_animal) ON DELETE CASCADE,
    FOREIGN KEY (id_calving_season) REFERENCES calving_seasons(id_calving_season)
);

-- ENTITY: MOVIMIENTOS(Movements/Ttransfers)
-- Movement history. Tracks when a animal enter or leaves a explotacion
-- A specific traceability purposes.

CREATE TABLE movements (
    id_movement INTEGER PRIMARY KEY AUTOINCREMENT,
    id_animal INT NOT NULL,
    id_farm INT NOT NULL,
    star_date DATE,
    exit_date DATE,

    FOREIGN KEY (id_animal) REFERENCES animals(id_animal) ON DELETE CASCADE,
    FOREIGN KEY (id_farm) REFERENCES farms(id_farm)
);

-- IMAGENES(Images/Photos)
-- Stores file paths for animal photos used for visual identification of animals

CREATE TABLE imagenes (
    id_image INTEGER PRIMARY KEY AUTOINCREMENT,
    id_animal INT NOT NULL,
    file_path TEXT NOT NULL,
    photo_date DATE,

    FOREIGN KEY (id_animal) REFERENCES animals(id_animal) ON DELETE CASCADE
);

-- OBSERVACIONES(Observations/Notes)
-- A diary for recording incidents or specific events for each animal

CREATE TABLE observations (
    id_observations INTEGER PRIMARY KEY AUROINCREMENT,
    id_animal INT NOT NULL,
    registration_date DATE,
    observation TEXT,

    FOREIGN KEY (id_animal) REFERENCES animals(id_animal) ON DELETE CASCADE
);

-- VIEWS

-- VIEW: CURRENT ANIMALS BY FARN
-- Displays: all animals currently located at a farm
-- An animal is considered currently present if exit_date is NULL

CREATE VIEW current_animals_by_farm AS
SELECT
    a.id_animal, a.ear_tag, a.breed, a.sex, a.birth_date, a.status, f.id_farm. f.name AS farm_name
FROM animals a
INNER JOIN movements m
    ON a.id_animal = m.id_animal
INNER JOIN farms f
    ON m.id_farm = f.id_farm
WHERE m.exit_date IS NULL

-- VIEW: ANIMAL FAMILY TREE
-- Displays parent-child relationships

CREATE VIEW animal_family_tree AS
SELECT
    child.id_animal, child.ear_tag AS animal, mother.id_animal AS mother_id, mother.ear_tag AS mother, father.id_animal AS father_id, father.ear_tag As father
FROM animal child
LEFT JOIN animals mother
    ON child.id_mother = mother.id_animal
LEFT JOIN animals father
    ON child.id_father = father.id_animal;

-- VIEW: BIRTHS STATISTICS BY CALVING SEASON
-- Displays birth counts grouped by calvings season

CREATE VIEW birth_statistics_by_season AS
SELECT
    cs.id_calving_season, cs.name AS calving_season, COUNT(b.id_birth) AS total_births, MIN(b.birth_date) AS first_birth, MAX(b.birth_date) AS last_birth
FROM calving_seasons cd
LEFT JOIN births b
    ON cs.id_calving_season = b.id_calving_season
GROUP BY cs.id_calving_season, cs.name

-- INDEX

-- Speeds up the reconstruction of maternal family trees
CREATE INDEX idx_animals_mother ON animals(id_mother);

-- Optimizes list of animals currently located at a specific farm
CREATE INDEX idx_movements_farm ON movements(id_farm);

-- Allows near-instant searches by ear tag number
CREATE INDEX idx_animals_ear_tag ON animales(ear_tag);
