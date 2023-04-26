/* CREATE TABLE */
CREATE TABLE IF NOT EXISTS laptimes
(
    raceId       INTEGER NOT NULL,
    driverId     INTEGER NOT NULL,
    lap          INTEGER NOT NULL,
    position     INTEGER      DEFAULT NULL,
    time         VARCHAR(255) DEFAULT NULL,
    milliseconds INTEGER      DEFAULT NULL,

    CONSTRAINT PK_LAPTIMES PRIMARY KEY (raceId, driverId, lap),
    CONSTRAINT FK1_LAPTIMES FOREIGN KEY (raceId) REFERENCES races (raceId),
    CONSTRAINT FK2_LAPTIMES FOREIGN KEY (driverId) REFERENCES drivers (driverid)
);