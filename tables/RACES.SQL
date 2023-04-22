/* CREATE TABLE */
CREATE TABLE races
(
    raceId      INTEGER      NOT NULL,
    year        INTEGER      NOT NULL DEFAULT 0,
    round       INTEGER      NOT NULL DEFAULT 0,
    circuitId   INTEGER      NOT NULL DEFAULT 0,
    name        VARCHAR(255) NOT NULL,
    date        DATE         NOT NULL DEFAULT "0000-00-00",
    time        TIME,
    url         VARCHAR(255),
    fp1_date    DATE,
    fp1_time    TIME,
    fp2_date    DATE,
    fp2_time    TIME,
    fp3_date    DATE,
    fp3_time    TIME,
    quali_date  DATE,
    quali_time  TIME,
    sprint_date DATE,
    sprint_time TIME,

    CONSTRAINT PK_RACES PRIMARY KEY (raceId),
    CONSTRAINT UK_RACES UNIQUE (url),
    CONSTRAINT FK1_RACES FOREIGN KEY (year) REFERENCES seasons(year),
    CONSTRAINT FK2_RACES FOREIGN KEY (circuitId) REFERENCES circuits (circuitid)
);