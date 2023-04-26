COPY airports
    FROM '/database/tables_csv/airports.csv'
    WITH (FORMAT CSV, HEADER true, DELIMITER ',', NULL '', QUOTE '"');

COPY circuits
    FROM '/database/tables_csv/circuits.csv'
    WITH (FORMAT CSV, HEADER true, DELIMITER ',', NULL '\N', QUOTE '"');

COPY constructors
    FROM '/database/tables_csv/constructors.csv'
    WITH (FORMAT CSV, HEADER true, DELIMITER ',', NULL '\N', QUOTE '"');

COPY countries
    FROM '/database/tables_csv/countries.csv'
    WITH (FORMAT CSV, HEADER true, DELIMITER ',', NULL '', QUOTE '"');

COPY seasons
    FROM '/database/tables_csv/seasons.csv'
    WITH (FORMAT CSV, HEADER true, DELIMITER ',', NULL '\N', QUOTE '"');

COPY status
    FROM '/database/tables_csv/status.csv'
    WITH (FORMAT CSV, HEADER true, DELIMITER ',', NULL '\N', QUOTE '"');

COPY drivers
    FROM '/database/tables_csv/drivers.csv'
    WITH (FORMAT CSV, HEADER true, DELIMITER ',', NULL '\N', QUOTE '"');

COPY races
    FROM '/database/tables_csv/races.csv'
    WITH (FORMAT CSV, HEADER true, DELIMITER ',', NULL '\N', QUOTE '"');

COPY driver_standings
    FROM '/database/tables_csv/driver_standings.csv'
    WITH (FORMAT CSV, HEADER true, DELIMITER ',', NULL '', QUOTE '"');

COPY lap_times
    FROM '/database/tables_csv/lap_times.csv'
    WITH (FORMAT CSV, HEADER true, DELIMITER ',', NULL '', QUOTE '"');

COPY pit_stops
    FROM '/database/tables_csv/pit_stops.csv'
    WITH (FORMAT CSV, HEADER true, DELIMITER ',', NULL '', QUOTE '"');

COPY qualifying
    FROM  '/database/tables_csv/qualifying.csv'
    WITH (FORMAT CSV, HEADER true, DELIMITER ',', NULL '\N', QUOTE '"');

COPY results
    FROM '/database/tables_csv/results.csv'
    WITH (FORMAT CSV, HEADER true, DELIMITER ',', NULL '\N', QUOTE '"');