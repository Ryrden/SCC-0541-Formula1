/* CREATE TABLE */
CREATE TABLE circuits (
    circuitId INT NOT NULL, -- TODO: SIZE
    circuitRef VARCHAR(255) NOT NULL,
    name VARCHAR(255) NOT NULL,
    location VARCHAR(255),
    country VARCHAR(255),
    lat FLOAT,
    lng FLOAT,
    alt INT, -- TODO: SIZE
    url VARCHAR(255) NOT NULL,
    CONSTRAINT PK_CIRCUITS PRIMARY KEY (circuitId),
    CONSTRAINT UK_CIRCUITS UNIQUE (URL)
);