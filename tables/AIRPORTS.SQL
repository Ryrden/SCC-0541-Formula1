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