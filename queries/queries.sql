-- EXERCÍCIO 1

SELECT RACES.year, DRIVER.driverid as driver, SUM(DRIVERSTANDINGS.points) AS total_points
FROM DRIVERSTANDINGS
         JOIN RACES ON DRIVERSTANDINGS.raceid = RACES.raceid
         JOIN DRIVER ON DRIVERSTANDINGS.driverId = DRIVER.driverid
GROUP BY RACES.year, DRIVER.driverid
ORDER BY DRIVER.driverid ASC, total_points DESC;
