COPY airports
    FROM './database/airports.csv'
    WITH (DELIMITER ',', HEADER true, FORMAT CSV);

COPY CIRCUITS
    FROM './database/circuits.csv'
    WITH (DELIMITER ',', HEADER true, FORMAT CSV);

COPY CONSTRUCTORS
    FROM './database/constructors.csv'
    WITH (DELIMITER ',', HEADER true, FORMAT CSV);

COPY COUNTRIES
    FROM './database/countries.csv'
    WITH (DELIMITER ',', HEADER true, FORMAT CSV);

COPY DRIVERS
    FROM './database/drivers.csv'
    WITH (DELIMITER ',', HEADER true, FORMAT CSV);

COPY DRIVER_STANDINGS
    FROM './database/driver_standings.csv'
    WITH (DELIMITER ',', HEADER true, FORMAT CSV);

COPY LAPTIMES
    FROM './database/laptimes.csv'
    WITH (DELIMITER ',', HEADER true, FORMAT CSV);

COPY PIT_STOPS
    FROM './database/pit_stops.csv'
    WITH (DELIMITER ',', HEADER true, FORMAT CSV);

COPY QUALIFYING
    FROM  './database/qualifying.csv'
    WITH (DELIMITER ',', HEADER true, FORMAT CSV);

COPY RACES 
    FROM './database/races.csv'
    WITH (DELIMITER ',', HEADER true, FORMAT CSV);

COPY RESULTS
    FROM './database/results.csv'
    WITH (DELIMITER ',', HEADER true, FORMAT CSV);

COPY SEASONS
    FROM './database/seasons.csv'
    WITH (DELIMITER ',', HEADER true, FORMAT CSV);

COPY STATUS
    FROM './database/status.csv'
    WITH (DELIMITER ',', HEADER true, FORMAT CSV);