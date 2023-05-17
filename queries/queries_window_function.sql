--EX1
SELECT DISTINCT R.NAME,
                R.YEAR,
                L.LAP,
                L.TIME,
                MIN(L.TIME) OVER (PARTITION BY L.RACEID, L.LAP) AS MIN_TIME, MAX(L.TIME) OVER (PARTITION BY L.RACEID, L.LAP) AS MAX_TIME,
STRING_AGG(CONCAT(D.FORENAME, ' ', D.SURNAME), ', ') AS drivers,  SUM(L.MILLISECONDS) OVER (PARTITION BY L.RACEID, L.LAP) AS timeLap
FROM LAPTIMES L
         INNER JOIN RACES R ON R.RACEID = L.RACEID
         INNER JOIN DRIVER D ON D.DRIVERID = L.DRIVERID
GROUP BY R.NAME, R.YEAR, L.LAP, L.MILLISECONDS, L.TIME, L.RACEID, D.FORENAME, D.SURNAME, L.DRIVERID
ORDER BY R.NAME, R.YEAR, L.LAP, L.TIME;


--EX2.1
SELECT C.name, C.nationality, COUNT(*) victories
FROM CONSTRUCTORS C
         INNER JOIN RESULTS R ON C.constructorId = R.constructorId
WHERE R.position = 1
GROUP BY R.constructorId, C.name, C.nationality, C.constructorId
ORDER BY victories DESC;

--EX2.2
SELECT C.name,
       C.nationality,
       COUNT(*)      victories,
       SUM(COUNT(*)) OVER (PARTITION BY C.nationality) AS total_victories_by_nationality, RANK() OVER (PARTITION BY C.nationality ORDER BY COUNT(*) DESC) AS ranking_within_nationality
FROM CONSTRUCTORS C
         INNER JOIN RESULTS R ON C.constructorId = R.constructorId
WHERE R.position = 1
GROUP BY R.constructorId, C.name, C.nationality, C.constructorId
ORDER BY total_victories_by_nationality DESC;

--EX2.3
SELECT C.name,
       C.nationality,
       COUNT(*)      victories,
       SUM(COUNT(*)) OVER (PARTITION BY C.nationality) AS total_victories_by_nationality, RANK() OVER (PARTITION BY C.nationality ORDER BY COUNT(*) DESC, C.name ASC) AS ranking_within_nationality
FROM CONSTRUCTORS C
         INNER JOIN RESULTS R ON C.constructorId = R.constructorId
WHERE R.position = 1
GROUP BY R.constructorId, C.name, C.nationality, C.constructorId
ORDER BY nationality;

--EX3
SELECT RACES.name                                   AS race_name,
       RACES.year                                   AS race_year,
       CONCAT(DRIVER.forename, ' ', DRIVER.surname) AS driver_name,
       AVG(EXTRACT(epoch FROM PITSTOPS.time::time)) AS avg_pitstop_time,
       RANK()                                          OVER (PARTITION BY RACES.raceId ORDER BY AVG(EXTRACT(epoch FROM PITSTOPS.time::time)) ASC)
AS pitstop_rank, RESULTS.rank,
       results.driverid
FROM RACES
         INNER JOIN PITSTOPS ON PITSTOPS.raceId = RACES.raceId
         INNER JOIN DRIVER ON DRIVER.driverId = PITSTOPS.driverId
         INNER JOIN RESULTS ON RESULTS.driverId = DRIVER.driverId AND RACES.raceId = RESULTS.raceId

GROUP BY RACES.raceId, DRIVER.driverId, RACES.name, RACES.year, DRIVER.forename, DRIVER.surname, RESULTS.rank,
         results.driverid
ORDER BY RACES.name ASC, AVG(EXTRACT(epoch FROM PITSTOPS.time::time)) ASC;

--EX4
SELECT DISTINCT CONSTRUCTORS.nationality,
                ARRAY_AGG(CONSTRUCTORS.name) OVER (PARTITION BY CONSTRUCTORS.nationality) AS teams
FROM CONSTRUCTORS
ORDER BY CONSTRUCTORS.nationality;

--EX5
SELECT DISTINCT RACES.raceId,
                RACES.name                                   AS race_name,
                RACES.year,
                RACES.time,
                CONCAT(DRIVER.forename, ' ', DRIVER.surname) AS driver_name,
                SUM(LAPTIMES.milliseconds)                      OVER (PARTITION BY RACES.raceId, DRIVER.driverId) driver_race_time, SUM(LAPTIMES.milliseconds) OVER (PARTITION BY RACES.raceId, DRIVER.driverId) -
SUM(LAPTIMES.milliseconds) FILTER (WHERE RESULTS.rank = 1)  OVER (PARTITION BY RACES.raceId) AS diff_winner
FROM RACES
         JOIN DRIVERSTANDINGS ON DRIVERSTANDINGS.raceId = RACES.raceId
         JOIN DRIVER ON DRIVER.driverId = DRIVERSTANDINGS.driverId
         JOIN LAPTIMES ON LAPTIMES.raceid = RACES.raceId AND LAPTIMES.driverId = DRIVER.driverId
         JOIN RESULTS ON RESULTS.raceid = RACES.raceId AND RESULTS.driverId = DRIVER.driverId
GROUP BY RACES.raceId, RACES.name, RACES.year, DRIVER.driverId, DRIVER.forename, DRIVER.surname, LAPTIMES.milliseconds,
         RESULTS.rank
ORDER BY RACES.raceId










