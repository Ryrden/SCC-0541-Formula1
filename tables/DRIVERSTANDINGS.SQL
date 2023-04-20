/* CREATE TABLE */
CREATE TABLE driver_standings
(
    driverStandingsId INTEGER NOT NULL,
    raceId            INTEGER NOT NULL DEFAULT 0,
    driverId          INTEGER NOT NULL DEFAULT 0,
    points            FLOAT   NOT NULL DEFAULT 0,
    position          INTEGER,
    positionText      VARCHAR(255),
    wins              INTEGER NOT NULL DEFAULT 0,

    CONSTRAINT PK_DRIVER_STANDINGS PRIMARY KEY (driverStandingsId),
    CONSTRAINT FK1_DRIVER_STANDINGS FOREIGN KEY (raceId) REFERENCES races (raceid),
    CONSTRAINT FK2_DRIVER_STANDINGS FOREIGN KEY (driverId) REFERENCES drivers (driverid)
);