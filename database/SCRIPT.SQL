COPY airports
    FROM 'database/airports.csv'
    WITH (DELIMITER ',', HEADER true, FORMAT CSV);

COPY circuits
    FROM './database/circuits.csv'
    WITH (DELIMITER ',', HEADER true, FORMAT CSV);

COPY constructors
    FROM './database/constructors.csv'
    WITH (DELIMITER ',', HEADER true, FORMAT CSV);

COPY countries
    FROM './database/countries.csv'
    WITH (DELIMITER ',', HEADER true, FORMAT CSV);

COPY seasons
    FROM './database/seasons.csv'
    WITH (DELIMITER ',', HEADER true, FORMAT CSV);

COPY status
    FROM './database/status.csv'
    WITH (DELIMITER ',', HEADER true, FORMAT CSV);

COPY drivers
    FROM './database/drivers.csv'
    WITH (DELIMITER ',', HEADER true, FORMAT CSV);

COPY races
    FROM './database/races.csv'
    WITH (DELIMITER ',', HEADER true, FORMAT CSV);

COPY driver_standings
    FROM './database/driver_standings.csv'
    WITH (DELIMITER ',', HEADER true, FORMAT CSV);

COPY lap_times
    FROM './database/laptimes.csv'
    WITH (DELIMITER ',', HEADER true, FORMAT CSV);

COPY pit_stops
    FROM './database/pit_stops.csv'
    WITH (DELIMITER ',', HEADER true, FORMAT CSV);

COPY qualifying
    FROM  './database/qualifying.csv'
    WITH (DELIMITER ',', HEADER true, FORMAT CSV);

COPY results
    FROM './database/results.csv'
    WITH (DELIMITER ',', HEADER true, FORMAT CSV);