/* CREATE TABLE */
CREATE TABLE driver (
    driverId INT NOT NULL PRIMARY KEY,
    driverRef VARCHAR(255) NOT NULL,
    number INT,
    code VARCHAR(3),
    forename VARCHAR(255) NOT NULL,
    surname VARCHAR(255) NOT NULL,
    dob DATE,
    nationality VARCHAR(255),
    url VARCHAR(255) NOT NULL,
    UNIQUE (url)
);