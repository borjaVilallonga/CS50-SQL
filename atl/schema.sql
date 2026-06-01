CREATE TABLE Passengers (
    "id" TEXT PRIMARY KEY,
    "firtsName" TEXT NOT NULL,
    "lastName" TEXT NOT NULL,
    "Age" INTEGER NOT NULL
);

CREATE TABLE CheckIns (
    "id" INTEGER PRIMARY KEY,
    "passenger_id" INTEGER NOT NULL,
    "flight_id" INTEGER NOT NULL,
    "datetime_checktime" DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY ("passenger_id") REFERENCES Passengers("id")
    FOREIGN KEY ("flight_id") REFERENCES Flights("id")
);

CREATE TABLE Airlines (
    "id" TEXT PRIMARY KEY,
    "name" TEXT NOT NULL,
    "concourse" TEXT NOT NULL
);

CREATE TABLE Flights (
    "flight_number" INTEGER NOT NULL,
    "airline_id" INTEGER NOT NULL,
    "codeFrom" TEXT NOT NULL,
    "codeTo" TEXT NOT NULL,
    "datetimeFrom" DATETIME DEFAULT CURRENT_TIMESTAMP,
    "datetimeTo" DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY ("airline_id") REFERENCES Airlines("id")
);
