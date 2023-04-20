/* CREATE TABLE */
CREATE TABLE drivers
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