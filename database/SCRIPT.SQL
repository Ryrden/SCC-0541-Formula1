COPY airports
    FROM '/database/airports.csv'
    WITH (FORMAT CSV, HEADER true, DELIMITER ',', NULL '', QUOTE '"');

COPY circuits
    FROM '/database/circuits.csv'
    WITH (FORMAT CSV, HEADER true, DELIMITER ',', NULL '\N', QUOTE '"');

COPY constructors
    FROM '/database/constructors.csv'
    WITH (FORMAT CSV, HEADER true, DELIMITER ',', NULL '\N', QUOTE '"');

COPY countries
    FROM '/database/countries.csv'
    WITH (FORMAT CSV, HEADER true, DELIMITER ',', NULL '', QUOTE '"');

COPY seasons
    FROM '/database/seasons.csv'
    WITH (FORMAT CSV, HEADER true, DELIMITER ',', NULL '\N', QUOTE '"');

COPY status
    FROM '/database/status.csv'
    WITH (FORMAT CSV, HEADER true, DELIMITER ',', NULL '\N', QUOTE '"');

COPY drivers
    FROM '/database/drivers.csv'
    WITH (FORMAT CSV, HEADER true, DELIMITER ',', NULL '\N', QUOTE '"');

COPY races
    FROM '/database/races.csv'
    WITH (FORMAT CSV, HEADER true, DELIMITER ',', NULL '\N', QUOTE '"');

COPY driver_standings
    FROM '/database/driver_standings.csv'
    WITH (FORMAT CSV, HEADER true, DELIMITER ',', NULL '', QUOTE '"');

COPY lap_times
    FROM '/database/lap_times.csv'
    WITH (FORMAT CSV, HEADER true, DELIMITER ',', NULL '', QUOTE '"');

COPY pit_stops
    FROM '/database/pit_stops.csv'
    WITH (FORMAT CSV, HEADER true, DELIMITER ',', NULL '', QUOTE '"');

COPY qualifying
    FROM  '/database/qualifying.csv'
    WITH (FORMAT CSV, HEADER true, DELIMITER ',', NULL '\N', QUOTE '"');

COPY results
    FROM '/database/results.csv'
    WITH (FORMAT CSV, HEADER true, DELIMITER ',', NULL '\N', QUOTE '"');