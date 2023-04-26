/* CREATE TABLE */
CREATE TABLE IF NOT EXISTS airports
(
    id                INTEGER,
    ident             VARCHAR(100) NOT NULL,
    type              VARCHAR(100) NOT NULL,
    name              VARCHAR(100) NOT NULL,
    latitude_deg      INTEGER,
    longitude_deg     INTEGER,
    elevation_ft      INTEGER,
    continent         VARCHAR(100) NOT NULL,
    iso_country       VARCHAR(100),
    iso_region        VARCHAR(100),
    municipality      VARCHAR(100),
    scheduled_service VARCHAR(100),
    gps_code          VARCHAR(100),
    iata_code         VARCHAR(100),
    local_code        VARCHAR(100),
    home_link         VARCHAR(100),
    wikipedia_link    VARCHAR(255),
    keywords          VARCHAR(100),

    CONSTRAINT PK_AIRPORTS PRIMARY KEY (id),
    CONSTRAINT UK_AIRPORTS UNIQUE (iata_code)
);
/*----------------------------------------------------------*/

/* CREATE TABLE */
CREATE TABLE IF NOT EXISTS circuits
(
    circuitId  INTEGER      NOT NULL, -- TODO: SIZE
    circuitRef VARCHAR(255) NOT NULL,
    name       VARCHAR(255) NOT NULL,
    location   VARCHAR(255),
    country    VARCHAR(255),
    lat        FLOAT,
    lng        FLOAT,
    alt        INTEGER,               -- TODO: SIZE
    url        VARCHAR(255) NOT NULL,

    CONSTRAINT PK_CIRCUITS PRIMARY KEY (circuitId),
    CONSTRAINT UK_CIRCUITS UNIQUE (URL)
);
/*----------------------------------------------------------*/

/* CREATE TABLE */
CREATE TABLE IF NOT EXISTS constructors
(
    constructorId  INTEGER      NOT NULL,
    constructorRef VARCHAR(255) NOT NULL,
    name           VARCHAR(255) NOT NULL,
    nationality    VARCHAR(255) DEFAULT NULL,
    url            VARCHAR(255) NOT NULL,

    CONSTRAINT PK_CONSTRUCTORS PRIMARY KEY (constructorId),
    CONSTRAINT UK_CONSTRUCTORS UNIQUE (name)
);
/*----------------------------------------------------------*/

/* CREATE TABLE */
CREATE TABLE IF NOT EXISTS countries
(
    id             INTEGER NOT NULL,
    code           VARCHAR(100),
    name           VARCHAR(100),
    continent      VARCHAR(100),
    wikipedia_link VARCHAR(100),
    keywords       VARCHAR(100),

    CONSTRAINT PK_COUNTRIES PRIMARY KEY (id)
);
/*----------------------------------------------------------*/

/* CREATE TABLE */
CREATE TABLE IF NOT EXISTS seasons
(
    year INTEGER      NOT NULL DEFAULT 0,
    url  VARCHAR(255) NOT NULL,

    CONSTRAINT PK_SEASONS PRIMARY KEY (year)
);
/*----------------------------------------------------------*/

/* CREATE TABLE */
CREATE TABLE IF NOT EXISTS status
(
    statusId INTEGER      NOT NULL,
    status   VARCHAR(255) NOT NULL,

    CONSTRAINT PK_STATUS PRIMARY KEY (statusId)
);
/*----------------------------------------------------------*/

/* CREATE TABLE */
CREATE TABLE IF NOT EXISTS drivers
(
    driverId    INTEGER      NOT NULL,
    driverRef   VARCHAR(255) NOT NULL,
    number      INTEGER      DEFAULT NULL,
    code        VARCHAR(3)   DEFAULT NULL,
    forename    VARCHAR(255) NOT NULL,
    surname     VARCHAR(255) NOT NULL,
    dob         DATE         DEFAULT NULL,
    nationality VARCHAR(255) DEFAULT NULL,
    url         VARCHAR(255) NOT NULL,

    CONSTRAINT PK_DRIVERS PRIMARY KEY (driverId),
    CONSTRAINT UK_DRIVERS UNIQUE (url)
);
/*----------------------------------------------------------*/

/* CREATE TABLE */
CREATE TABLE IF NOT EXISTS races
(
    raceId      INTEGER      NOT NULL,
    year        INTEGER      NOT NULL DEFAULT 0,
    round       INTEGER      NOT NULL DEFAULT 0,
    circuitId   INTEGER      NOT NULL DEFAULT 0,
    name        VARCHAR(255) NOT NULL,
    date        DATE         NOT NULL DEFAULT MAKE_DATE(0000, 00, 00),
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
/*----------------------------------------------------------*/


/* CREATE TABLE */
CREATE TABLE IF NOT EXISTS driver_standings
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
/*----------------------------------------------------------*/

/* CREATE TABLE */
CREATE TABLE IF NOT EXISTS lap_times
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
/*----------------------------------------------------------*/

/* CREATE TABLE */
CREATE TABLE IF NOT EXISTS pit_stops
(
    raceId       INTEGER NOT NULL,
    driverId     INTEGER NOT NULL,
    stop         INTEGER NOT NULL,
    lap          INTEGER      DEFAULT NULL,
    time         TIME         DEFAULT NULL,
    duration     VARCHAR(255) DEFAULT NULL,
    milliseconds INTEGER      DEFAULT NULL,

    CONSTRAINT PK_PITSTOPS PRIMARY KEY (raceId, driverId, stop),
    CONSTRAINT FK1_PITSTOPS FOREIGN KEY (raceId) references races (raceId),
    CONSTRAINT FK2_PITSTOPS FOREIGN KEY (driverId) references drivers (driverId)
);
/*----------------------------------------------------------*/

/* CREATE TABLE */
CREATE TABLE IF NOT EXISTS qualifying
(
    qualifyId     INTEGER NOT NULL,
    raceId        INTEGER NOT NULL,
    driverId      INTEGER NOT NULL,
    constructorId INTEGER NOT NULL,
    number        INTEGER NOT NULL,
    position      INTEGER      DEFAULT NULL,
    q1            VARCHAR(255) DEFAULT NULL, -- TODO: Rever tipo desse tempo aqui
    q2            VARCHAR(255) DEFAULT NULL,
    q3            VARCHAR(255) DEFAULT NULL,

    CONSTRAINT PK_QUALIFYING PRIMARY KEY (qualifyId),
    CONSTRAINT FK1_QUALIFYING FOREIGN KEY (raceId) references races (raceId),
    CONSTRAINT FK2_QUALIFYING FOREIGN KEY (driverId) references drivers (driverId),
    CONSTRAINT FK3_QUALIFYING FOREIGN KEY (constructorId) references constructors (constructorId)
);
/*----------------------------------------------------------*/

/* CREATE TABLE */
CREATE TABLE IF NOT EXISTS results
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