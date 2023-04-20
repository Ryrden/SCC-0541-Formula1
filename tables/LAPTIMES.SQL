/* CREATE TABLE */
CREATE TABLE laptimes (
    raceId INT NOT NULL,
    driverId INT NOT NULL,
    lap INT NOT NULL,
    position INT DEFAULT NULL,
    time VARCHAR(255) DEFAULT NULL,
    milliseconds INT DEFAULT NULL,
    CONSTRAINT PK_LAPTIMES PRIMARY KEY (raceId, driverId, lap),
    CONSTRAINT FK1_LAPTIMES FOREIGN KEY (raceId) REFERENCES races(raceId),
    CONSTRAINT FK2_LAPTIMES FOREIGN KEY (driverId) REFERENCES drivers(driverid)
);