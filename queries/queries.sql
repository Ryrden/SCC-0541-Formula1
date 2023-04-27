-- EXERCÍCIO 1

SELECT RACES.year, DRIVER.driverid as driver, SUM(DRIVERSTANDINGS.points) AS total_points
FROM DRIVERSTANDINGS
         JOIN RACES ON DRIVERSTANDINGS.raceid = RACES.raceid
         JOIN DRIVER ON DRIVERSTANDINGS.driverId = DRIVER.driverid
GROUP BY RACES.year, DRIVER.driverid
ORDER BY DRIVER.driverid ASC, total_points DESC;

--================================================================================--

-- EXERCÍCIO 2

SELECT count(RACES.raceid) as count, RACES.year
FROM RACES
GROUP BY RACES.year
ORDER BY count DESC;

--================================================================================--

-- EXERCÍCIO 3

SELECT AIRPORTS.type, AIRPORTS.continent, count(AIRPORTS.ident)
FROM AIRPORTS
GROUP BY AIRPORTS.type, AIRPORTS.continent
ORDER BY AIRPORTS.type ASC;

--================================================================================--

-- EXERCÍCIO 4

ALTER TABLE QUALIFYING
ADD Pole_Position VARCHAR(6);

UPDATE QUALIFYING SET pole_position = 'Podium' WHERE position BETWEEN 1 AND 3;

--================================================================================--

-- EXERCÍCIO 5

UPDATE DRIVER SET nationality = 'BR' WHERE nationality = 'Brazilian';

--================================================================================--

-- EXERCÍCIO 6