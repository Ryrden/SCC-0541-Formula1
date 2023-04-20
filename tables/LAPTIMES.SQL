/* CREATE TABLE */
CREATE TABLE laptimes (
    raceId INT NOT NULL,
    driverId INT NOT NULL,
    lap INT NOT NULL,
    position INT DEFAULT NULL,
    time VARCHAR(255) DEFAULT NULL,
    milliseconds INT DEFAULT NULL,
    PRIMARY KEY (raceId, driverId, lap)
);