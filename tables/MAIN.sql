/* CREATE TABLE */
CREATE TABLE IF NOT EXISTS airports
(
    id                INT,
    ident             VARCHAR(8)   NOT NULL,
    type              VARCHAR(32)  NOT NULL,
    name              VARCHAR(256) NOT NULL,
    latitude_deg      NUMERIC(25, 20),
    longitude_deg     NUMERIC(25, 20),
    elevation_ft      INT,
    continent         CHAR(2)      NOT NULL,
    iso_country       CHAR(2),
    iso_region        CHAR(8),
    municipality      VARCHAR(128),
    scheduled_service VARCHAR(3),
    gps_code          CHAR(4),
    iata_code         CHAR(3),
    local_code        VARCHAR(64),
    home_link         VARCHAR(256),
    wikipedia_link    VARCHAR(512),
    keywords          VARCHAR(256),

    CONSTRAINT PK_AIRPORTS PRIMARY KEY (id),
    CONSTRAINT UK_AIRPORTS UNIQUE (iata_code)
);
/*----------------------------------------------------------*/

/* CREATE TABLE */
CREATE TABLE IF NOT EXISTS circuits
(
    circuitId  INT          NOT NULL,
    circuitRef VARCHAR(64)  NOT NULL,
    name       VARCHAR(256) NOT NULL,
    location   VARCHAR(64),
    country    VARCHAR(64),
    lat        FLOAT,
    lng        FLOAT,
    alt        INT,
    url        VARCHAR(256) NOT NULL,

    CONSTRAINT PK_CIRCUITS PRIMARY KEY (circuitId),
    CONSTRAINT UK_CIRCUITS UNIQUE (URL)
);
/*----------------------------------------------------------*/

/* CREATE TABLE */
CREATE TABLE IF NOT EXISTS constructors
(
    constructorId  INT          NOT NULL,
    constructorRef VARCHAR(64)  NOT NULL,
    name           VARCHAR(256) NOT NULL,
    nationality    VARCHAR(256) DEFAULT NULL,
    url            VARCHAR(256) NOT NULL,

    CONSTRAINT PK_CONSTRUCTORS PRIMARY KEY (constructorId),
    CONSTRAINT UK_CONSTRUCTORS UNIQUE (name)
);
/*----------------------------------------------------------*/

/* CREATE TABLE */
CREATE TABLE IF NOT EXISTS countries
(
    id             INT NOT NULL,
    code           CHAR(2),
    name           VARCHAR(64),
    continent      CHAR(2),
    wikipedia_link VARCHAR(512),
    keywords       VARCHAR(256),

    CONSTRAINT PK_COUNTRIES PRIMARY KEY (id)
);
/*----------------------------------------------------------*/

/* CREATE TABLE */
CREATE TABLE IF NOT EXISTS seasons
(
    year INT          NOT NULL DEFAULT 0,
    url  VARCHAR(256) NOT NULL,

    CONSTRAINT PK_SEASONS PRIMARY KEY (year)
);
/*----------------------------------------------------------*/

/* CREATE TABLE */
CREATE TABLE IF NOT EXISTS status
(
    statusId INT         NOT NULL,
    status   VARCHAR(32) NOT NULL,

    CONSTRAINT PK_STATUS PRIMARY KEY (statusId)
);
/*----------------------------------------------------------*/

/* CREATE TABLE */
CREATE TABLE IF NOT EXISTS drivers
(
    driverId    INT          NOT NULL,
    driverRef   VARCHAR(64)  NOT NULL,
    number      INT          DEFAULT NULL,
    code        CHAR(3)      DEFAULT NULL,
    forename    VARCHAR(128) NOT NULL,
    surname     VARCHAR(128) NOT NULL,
    dob         DATE         DEFAULT NULL,
    nationality VARCHAR(256) DEFAULT NULL,
    url         VARCHAR(256) NOT NULL,

    CONSTRAINT PK_DRIVERS PRIMARY KEY (driverId),
    CONSTRAINT UK_DRIVERS UNIQUE (url)
);
/*----------------------------------------------------------*/

/* CREATE TABLE */
CREATE TABLE IF NOT EXISTS races
(
    raceId      INT          NOT NULL,
    year        INT          NOT NULL DEFAULT 0,
    round       INT          NOT NULL DEFAULT 0,
    circuitId   INT          NOT NULL DEFAULT 0,
    name        VARCHAR(256) NOT NULL,
    date        DATE         NOT NULL DEFAULT MAKE_DATE(0000, 00, 00),
    time        TIME,
    url         VARCHAR(256),
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
    CONSTRAINT FK1_RACES FOREIGN KEY (year) REFERENCES seasons (year) ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT FK2_RACES FOREIGN KEY (circuitId) REFERENCES circuits (circuitid) ON UPDATE CASCADE ON DELETE NO ACTION
);
/*----------------------------------------------------------*/


/* CREATE TABLE */
CREATE TABLE IF NOT EXISTS driver_standings
(
    driverStandingsId INT   NOT NULL,
    raceId            INT   NOT NULL DEFAULT 0,
    driverId          INT   NOT NULL DEFAULT 0,
    points            FLOAT NOT NULL DEFAULT 0,
    position          INT,
    positionText      VARCHAR(3),
    wins              INT   NOT NULL DEFAULT 0,

    CONSTRAINT PK_DRIVER_STANDINGS PRIMARY KEY (driverStandingsId),
    CONSTRAINT FK1_DRIVER_STANDINGS FOREIGN KEY (raceId) REFERENCES races (raceid) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT FK2_DRIVER_STANDINGS FOREIGN KEY (driverId) REFERENCES drivers (driverid) ON UPDATE CASCADE ON DELETE NO ACTION
);
/*----------------------------------------------------------*/

/* CREATE TABLE */
CREATE TABLE IF NOT EXISTS lap_times
(
    raceId       INT NOT NULL,
    driverId     INT NOT NULL,
    lap          INT NOT NULL,
    position     INT         DEFAULT NULL,
    time         VARCHAR(16) DEFAULT NULL,
    milliseconds INT         DEFAULT NULL,

    CONSTRAINT PK_LAPTIMES PRIMARY KEY (raceId, driverId, lap),
    CONSTRAINT FK1_LAPTIMES FOREIGN KEY (raceId) REFERENCES races (raceId) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT FK2_LAPTIMES FOREIGN KEY (driverId) REFERENCES drivers (driverid) ON UPDATE CASCADE ON DELETE RESTRICT
);
/*----------------------------------------------------------*/

/* CREATE TABLE */
CREATE TABLE IF NOT EXISTS pit_stops
(
    raceId       INT NOT NULL,
    driverId     INT NOT NULL,
    stop         INT NOT NULL,
    lap          INT         DEFAULT NULL,
    time         TIME        DEFAULT NULL,
    duration     VARCHAR(16) DEFAULT NULL,
    milliseconds INT         DEFAULT NULL,

    CONSTRAINT PK_PITSTOPS PRIMARY KEY (raceId, driverId, stop),
    CONSTRAINT FK1_PITSTOPS FOREIGN KEY (raceId) references races (raceId) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT FK2_PITSTOPS FOREIGN KEY (driverId) references drivers (driverId) ON UPDATE CASCADE ON DELETE RESTRICT
);
/*----------------------------------------------------------*/

/* CREATE TABLE */
CREATE TABLE IF NOT EXISTS qualifying
(
    qualifyId     INT NOT NULL,
    raceId        INT NOT NULL,
    driverId      INT NOT NULL,
    constructorId INT NOT NULL,
    number        INT NOT NULL,
    position      INT         DEFAULT NULL,
    q1            VARCHAR(16) DEFAULT NULL,
    q2            VARCHAR(16) DEFAULT NULL,
    q3            VARCHAR(16) DEFAULT NULL,

    CONSTRAINT PK_QUALIFYING PRIMARY KEY (qualifyId),
    CONSTRAINT FK1_QUALIFYING FOREIGN KEY (raceId) references races (raceId) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT FK2_QUALIFYING FOREIGN KEY (driverId) references drivers (driverId) ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT FK3_QUALIFYING FOREIGN KEY (constructorId) references constructors (constructorId) ON UPDATE CASCADE ON DELETE RESTRICT
);
/*----------------------------------------------------------*/

/* CREATE TABLE */
CREATE TABLE IF NOT EXISTS results
(
    resultId        INT        NOT NULL,
    raceId          INT        NOT NULL DEFAULT 0,
    driverId        INT        NOT NULL DEFAULT 0,
    constructorId   INT        NOT NULL DEFAULT 0,
    number          INT,
    grid            INT        NOT NULL DEFAULT 0,
    position        INT                 DEFAULT NULL,
    positionText    VARCHAR(3) NOT NULL,
    positionOrder   INT        NOT NULL DEFAULT 0,
    points          FLOAT      NOT NULL DEFAULT 0,
    laps            INT        NOT NULL DEFAULT 0,
    time            VARCHAR(16)         DEFAULT NULL,
    milliseconds    INT                 DEFAULT NULL,
    fastestLap      INT                 DEFAULT NULL,
    rank            INT                 DEFAULT 0,
    fastestLapTime  VARCHAR(16)         DEFAULT NULL,
    fastestLapSpeed VARCHAR(16)         DEFAULT NULL,
    statusId        INT        NOT NULL DEFAULT 0,

    CONSTRAINT PK_RESULTS PRIMARY KEY (resultId),
    CONSTRAINT FK1_RESULTS FOREIGN KEY (raceId) REFERENCES races (raceId) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT FK2_RESULTS FOREIGN KEY (driverId) REFERENCES drivers (driverId) ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT FK3_RESULTS FOREIGN KEY (constructorId) REFERENCES constructors (constructorId) ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT FK4_RESULTS FOREIGN KEY (statusId) REFERENCES status (statusId) ON UPDATE CASCADE ON DELETE NO ACTION
);