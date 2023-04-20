/* CREATE TABLE */
CREATE TABLE constructors (
    constructorId INT NOT NULL PRIMARY KEY,
    constructorRef VARCHAR(255) NOT NULL,
    name VARCHAR(255) NOT NULL,
    nationality VARCHAR(255) DEFAULT NULL,
    url VARCHAR(255) NOT NULL,
    UNIQUE (name)
);
