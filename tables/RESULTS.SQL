/* CREATE TABLE */
CREATE TABLE results (
    resultId SERIAL,
    raceId SERIAL,
    driverId SERIAL,
    constructorId SERIAL,
    number SERIAL,
    grid SERIAL,
    position SERIAL,
    positionText VARCHAR(1),
    positionOrder SERIAL,
    points SERIAL,
    laps SERIAL,
    time VARCHAR(100), -- TODO: Rever dps
    milliseconds DOUBLE,
    fastestLap DOUBLE,
    rank DOUBLE,
    fastestLapTime VARCHAR(100),
    fastestLapSpeed VARCHAR(100),
    statusId SMALLSERIAL
);