CREATE TABLE `Users`(
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `firts_name` VARCHAR(64) NOT NULL,
    `last_name` VARCHAR(64) NOT NULL,
    `user_name` VARCHAR(64) NOT NULL UNIQUE,
    `password` VARCHAR(128) NOT NULL
);

CREATE TABLE `Schools`(
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `name` varchar(128) NOT NULL,
    `type` ENUM('Primaty', 'Secondary', 'Higher Education') NOT NULL,
    `location` VARCHAR(128),
    `founded_year` YEAR
);

CREATE TABLE `Companies`(
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `name` varchar(128) NOT NULL,
    `industry` ENUM('Technology', 'Education', 'Business') NOT NULL,
    `location` VARCHAR(128),
);

CREATE TABLE `user_connections`(
    `user_id` INT,
    `connection_id` INT,
    PRIMARY KEY (user_id, connection_id),
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (connection_id) REFERENCES users(id),
    CHECK (user_id <> connection_id)
);

CREATE TABLE `user_schools`(
    `user_id` INT,
    `school_id` INT,
    `start_date` DATE NOT NULL,
    `end_date` DATE,
    `degree` VARCHAR(32),
    PRIMARY KEY (user_id, school_id, start_id),
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (schools_id) REFERENCES schools(id),
);

CREATE TABLE `user_companies`(
    `user_id` INT,
    `company_id` INT,
    `start_date` DATE NOT NULL,
    `end_date` DATE,
    PRIMARY KEY (user_id, company_id, start_id),
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (company_id) REFERENCES companies(id),
);
