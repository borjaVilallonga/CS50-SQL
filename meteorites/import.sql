CREATE TABLE "meteorites_temp" (
    "name" TEXT,
    "id" INTEGER,
    "nametype" TEXT,
    "class" TEXT,
    "mass" REAL,
    "discovery" TEXT,
    "year" REAL,
    "lat" REAL,
    "long" REAL
);

.mode csv
.import meteorites.csv meteorites_temp

-- Punto 1
UPDATE "meteorites_temp"
SET "mass" = NULL
WHERE "mass" = '';

UPDATE "meteorites_temp"
SET "year" = NULL
WHERE "year" = '';

UPDATE "meteorites_temp"
SET "lat" = NULL
WHERE "lat" = '';

UPDATE "meteorites_temp"
SET "long" = NULL
WHERE "long" = '';

-- Punto 2

UPDATE "meteorites_temp"
SET "mass" = ROUND(mass, 2)
WHERE "mass" IS NOT NULL;

UPDATE "meteorites_temp"
SET "lat" = ROUND(lat, 2)
WHERE "lat" IS NOT NULL;

UPDATE "meteorites_temp"
SET "long" = ROUND(long, 2)
WHERE "long" IS NOT NULL;

-- Punto 3

DELETE FROM "meteorites_temp"
WHERE "nametype" = 'Relict';

-- Punto 4

SELECT *
FROM "meteorites_temp"
ORDER BY "year" ASC, "name" ASC;

-- Punto 5

CREATE TABLE "meteorites"(
    "id" INTEGER PRIMARY KEY,
    "name" TEXT,
    "class" TEXT,
    "mass" REAL,
    "discovery" TEXT,
    "year" INTEGER,
    "lat" REAL,
    "long" REAL
);

INSERT INTO "meteorites" (
    "id",
    "name",
    "class",
    "mass",
    "discovery",
    "year",
    "lat",
    "long"
)
SELECT
    ROW_NUMBER() OVER (ORDER BY "year" ASC, "name" ASC) AS "id",
    "name",
    "class",
    "mass",
    "discovery",
    CAST("year" AS INTEGER),
    "lat",
    "long"
FROM "meteorites_temp"
