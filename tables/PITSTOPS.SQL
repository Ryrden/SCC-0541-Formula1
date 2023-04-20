/* CREATE TABLE */
CREATE TABLE pit_stops
(
    raceId       INTEGER NOT NULL,
    driverId     INTEGER NOT NULL,
    stop         INTEGER NOT NULL,
    lap          INTEGER      DEFAULT NULL,
    time         TIME         DEFAULT NULL,
    duration     VARCHAR(255) DEFAULT NULL,
    milliseconds INTEGER      DEFAULT NULL,
    CONSTRAINT PK_PITSTOPS PRIMARY KEY (raceId, driverId, stop)
    --CONSTRAINT FK1_PITSTOPS FOREIGN KEY (raceId) references races(raceId),
    --CONSTRAINT FK2_PITSTOPS FOREIGN KEY (driverId) references drivers(driverId)
);