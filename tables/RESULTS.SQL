/* CREATE TABLE */
CREATE TABLE results
(
    resultId        INTEGER      NOT NULL,
    raceId          INTEGER      NOT NULL DEFAULT 0,
    driverId        INTEGER      NOT NULL DEFAULT 0,
    constructorId   INTEGER      NOT NULL DEFAULT 0,
    number          INTEGER,
    grid            INTEGER      NOT NULL DEFAULT 0,
    position        INTEGER               DEFAULT NULL,
    positionText    VARCHAR(255) NOT NULL,
    positionOrder   INTEGER      NOT NULL DEFAULT 0,
    points          FLOAT        NOT NULL DEFAULT 0,
    laps            INTEGER      NOT NULL DEFAULT 0,
    time            VARCHAR(255)          DEFAULT NULL, -- TODO: Rever dps
    milliseconds    INTEGER               DEFAULT NULL, -- TODO: TYPE PROBLEM
    fastestLap      INTEGER               DEFAULT NULL,
    rank            INTEGER               DEFAULT 0,
    fastestLapTime  VARCHAR(255)          DEFAULT NULL,
    fastestLapSpeed VARCHAR(255)          DEFAULT NULL,
    statusId        INTEGER      NOT NULL DEFAULT 0,

    CONSTRAINT PK_RESULTS PRIMARY KEY (resultId),
    CONSTRAINT FK1_RESULTS FOREIGN KEY (raceId) REFERENCES races (raceId),
    CONSTRAINT FK2_RESULTS FOREIGN KEY (driverId) REFERENCES drivers (driverId),
    CONSTRAINT FK3_RESULTS FOREIGN KEY (constructorId) REFERENCES constructors (constructorId),
    CONSTRAINT FK4_RESULTS FOREIGN KEY (statusId) REFERENCES status (statusId)
);