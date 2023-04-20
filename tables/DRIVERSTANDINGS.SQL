/* CREATE TABLE */
CREATE TABLE driver_standings (
    driverStandingsId INT NOT NULL,
    raceId INT NOT NULL DEFAULT 0,
    driverId INT NOT NULL DEFAULT 0,
    points FLOAT NOT NULL DEFAULT 0,
    position INT,
    positionText VARCHAR(255),
    wins INT NOT NULL DEFAULT 0,
    CONSTRAINT PK_DRIVER_STANDINGS PRIMARY KEY (driverStandingsId)
);