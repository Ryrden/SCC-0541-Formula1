/* CREATE TABLE */
CREATE TABLE airports(
    id INT,
    ident VARCHAR(100),
    type VARCHAR(100),
    name VARCHAR(100),
    latitude_deg INT,
    longitude_deg INT,
    elevation_ft INT,
    continent VARCHAR(100),
    iso_country VARCHAR(100),
    iso_region VARCHAR(100),
    municipality VARCHAR(100),
    scheduled_service VARCHAR(100),
    gps_code VARCHAR(100),
    iata_code VARCHAR(100),
    local_code VARCHAR(100),
    home_link VARCHAR(100),
    wikipedia_link VARCHAR(255),
    keywords VARCHAR(100),
    CONSTRAINT PK_AIRPORTS PRIMARY KEY (id),
    CONSTRAINT UK_AIRPORTS UNIQUE (iata_code)
);