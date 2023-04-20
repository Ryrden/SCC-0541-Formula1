/* CREATE TABLE */
CREATE TABLE circuits (
    circuitId INT NOT NULL PRIMARY KEY, -- TODO: SIZE
    circuitRef VARCHAR(255) NOT NULL,
    name VARCHAR(255) NOT NULL,
    location VARCHAR(255),
    country VARCHAR(255),
    lat FLOAT,
    lng FLOAT,
    alt INT, -- TODO: SIZE
    url VARCHAR(255) NOT NULL,
    UNIQUE (URL)
);