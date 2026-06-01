CREATE TABLE "tripletas" (
    "sentence_id" INTEGER,
    "start" INTEGER,
    "length" INTEGER
);

INSERT INTO "tripletas" ("sentence_id", "start", "length") VALUES
(14, 98, 4), (114, 3, 5), (618, 72, 9), (630, 7, 3), (932, 12, 5),
(2230, 50, 7), (2346, 44, 10), (3041, 14, 5);

CREATE VIEW "message" AS
SELECT substr(s.sentence, t.start, t.length) AS "phrase"
FROM tripletas t
JOIN sentences s
    ON s.id = t.sentence_id;
