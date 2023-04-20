/* CREATE TABLE */
CREATE TABLE qualifying
(
    qualifyId     INTEGER PRIMARY KEY NOT NULL,
    raceId        INTEGER             NOT NULL,
    driverId      INTEGER             NOT NULL,
    constructorId INTEGER             NOT NULL,
    number        INTEGER             NOT NULL,
    position      INTEGER      DEFAULT NULL,
    q1            VARCHAR(255) DEFAULT NULL, -- TODO: Rever tipo desse tempo aqui
    q2            VARCHAR(255) DEFAULT NULL,
    q3            VARCHAR(255) DEFAULT NULL,

    CONSTRAINT PK_QUALIFYING PRIMARY KEY (qualifyId),
    CONSTRAINT FK1_QUALIFYING FOREIGN KEY (raceId) references races (raceId),
    CONSTRAINT FK2_QUALIFYING FOREIGN KEY (driverId) references drivers (driverId),
    CONSTRAINT FK3_QUALIFYING FOREIGN KEY (constructorId) references constructors (constructorId)
);
