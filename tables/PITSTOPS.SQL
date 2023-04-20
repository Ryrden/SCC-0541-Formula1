/* CREATE TABLE */
CREATE TABLE pitstops (
    raceId INT(11),
    driverId INT(11),
    stop INT(11),
    lap INT(11),
    time TIME,
    duration VARCHAR(255),
    milliseconds INT(11)
);