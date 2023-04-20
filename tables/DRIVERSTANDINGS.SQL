/* CREATE TABLE */
CREATE TABLE driver_standings (
    driverStandingsId INT(11),
    raceId INT(11),
    driverId INT(11),
    points FLOAT,
    position INT(11),
    positionText VARCHAR(255),
    wins INT(11)
);