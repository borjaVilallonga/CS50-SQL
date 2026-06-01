DROP TABLE IF EXISTS Users;
DROP TABLE IF EXISTS Schools_Universities;
DROP TABLE IF EXISTS Companies;
DROP TABLE IF EXISTS userConnections;
DROP TABLE IF EXISTS affiliation_schools;
DROP TABLE IF EXISTS affiliation_companies;

CREATE TABLE Users (
    "id" INTEGER PRIMARY KEY,
    "first_name" TEXT NOT NULL,
    "last_name" TEXT NOT NULL,
    "username" TEXT NOT NULL UNIQUE,
    "password" TEXT NOT NULL
);

CREATE TABLE Schools_Universities (
    "id" INTEGER PRIMARY KEY,
    "name_school" TEXT NOT NULL,
    "type_school" TEXT NOT NULL,
    "school_location" TEXT NOT NULL,
    "year_funded" INTEGER NOT NULL
);

CREATE TABLE Companies (
    "id" TEXT PRIMARY KEY,
    "name" TEXT NOT NULL,
    "type_company" TEXT NOT NULL,
    "company_location" TEXT NOT NULL
);

CREATE TABLE userConnections (
    "user_id" INTEGER NOT NULL,
    "connected_user_id" INTEGER NOT NULL,
    PRIMARY KEY ("user_id", "connected_user_id"),
    FOREIGN KEY ("user_id") REFERENCES Users("id"),
    FOREIGN KEY ("connected_user_id") REFERENCES Users("id"),
    CHECK ("user_id"<>"connected_user_id")
);

CREATE TABLE affiliation_schools (
    "star_date" DATETIME DEFAULT CURRENT_TIMESTAMP,
    "end_date" DATETIME DEFAULT CURRENT_TIMESTAMP,
    "type_degree" TEXT,
    "user_id" INTEGER NOT NULL,
    "schools_id" INTEGER NOT NULL,
    PRIMARY KEY ("user_id", "schools_id"),
    FOREIGN KEY ("user_id") REFERENCES Users("id"),
    FOREIGN KEY ("schools_id") REFERENCES Schools_Universities("id")
);

CREATE TABLE affiliation_companies (
    "star_date" DATETIME DEFAULT CURRENT_TIMESTAMP,
    "end_date" DATETIME DEFAULT CURRENT_TIMESTAMP,
    "title" TEXT,
    "user_id" TEXT NOT NULL,
    "companies_id" TEXT NOT NULL,
    PRIMARY KEY ("user_id", "companies_id"),
    FOREIGN KEY ("user_id") REFERENCES Users("id"),
    FOREIGN KEY ("companies_id") REFERENCES Schools_Universities("id")
);
