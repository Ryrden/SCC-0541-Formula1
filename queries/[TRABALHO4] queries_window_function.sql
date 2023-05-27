--=================================================================================--

-- EXERCÍCIO 1

--1
SELECT *
FROM (SELECT R.name,
             R.year,
             L.Lap,
             L.Milliseconds,
             D.Forename,
             D.Surname,
             MIN(L.Milliseconds) OVER (PARTITION BY L.RaceId, L.Lap) AS Minimo,
             MAX(L.Milliseconds) OVER (PARTITION BY L.RaceId, L.Lap) AS Maximo
      FROM Laptimes L
               JOIN Races R ON L.Raceid = R.Raceid
               JOIN Driver D ON D.Driverid = L.Driverid) Tbl
WHERE Tbl.Milliseconds = Tbl.Minimo
   OR Tbl.Milliseconds = Tbl.Maximo
ORDER BY RANDOM()
LIMIT 10;

--=================================================================================--

-- EXERCÍCIO 2

--EX2.1
SELECT C.Name, C.Nationality, COUNT(*) AS contagem
FROM Results Re
         JOIN Constructors C ON Re.ConstructorId = C.ConstructorId
WHERE Re.Position = 1
GROUP BY C.Name, C.Nationality;


--2.2
SELECT Temp.*,
       SUM(contagem) OVER (PARTITION BY Temp.Nationality) AS Vitorias
FROM (SELECT C.Name, C.Nationality, COUNT(*) AS contagem
      FROM Results Re
               JOIN Constructors C ON Re.ConstructorId = C.ConstructorId
      WHERE Re.Position = 1
      GROUP BY C.Name, C.Nationality) Temp
ORDER BY Vitorias DESC;


--EX2.3
SELECT Temp.*,
       SUM(contagem) OVER (PARTITION BY Temp.Nationality)                                 AS Vitorias,
       RANK() OVER (PARTITION BY Temp.Nationality ORDER BY Temp.contagem DESC, Temp.name) AS Ordem
FROM (SELECT C.Name,
             C.Nationality,
             COUNT(*) AS Contagem
      FROM Results Re
               JOIN Constructors C ON Re.ConstructorId = C.ConstructorId
      WHERE Re.Position = 1
      GROUP BY C.Name, C.Nationality) Temp
ORDER BY Vitorias DESC, Ordem;


--=================================================================================--

-- EXERCÍCIO 3

--EX3
SELECT Temp.*,
       RANK() OVER (PARTITION BY Temp.Name, Temp.Year
           ORDER BY Tempo_Medio ASC)
FROM (SELECT R.Name,
             R.Year,
             D.Forename,
             D.Surname,
             AVG(P.Milliseconds) Tempo_Medio
      FROM Pitstops P
               JOIN Races R ON P.Raceid = R.Raceid
               JOIN Driver D ON D.Driverid = P.Driverid
      GROUP BY R.Name, R.Year, D.Forename, D.Surname) Temp
ORDER BY Random();

--=================================================================================--

-- EXERCÍCIO 4

--EX4
SELECT DISTINCT CONSTRUCTORS.nationality,
                ARRAY_AGG(CONSTRUCTORS.name) OVER (PARTITION BY CONSTRUCTORS.nationality) AS teams
FROM CONSTRUCTORS
ORDER BY CONSTRUCTORS.nationality;

--=================================================================================--

-- EXERCÍCIO 5

--EX5
SELECT Ra.Raceid,
       Ra.Name,
       Ra.Year,
       D.Forename || ' ' || D.Surname                                                                            AS Nome,
       Re.Milliseconds                                                                                           AS "Tempo total",
       Row_Number() OVER (PARTITION BY Ra.RaceId ORDER BY Re.Milliseconds ASC)                                   AS Position,
       Re.Milliseconds - First_Value(Re.Milliseconds)
                         OVER (PARTITION BY Ra.RaceId ORDER BY Re.Milliseconds ASC)                              AS "Atrás do 1º",
       Re.Milliseconds - Lag(Re.Milliseconds)
                         OVER (PARTITION BY Ra.RaceId ORDER BY Re.Milliseconds ASC)                              AS "Atrás anterior"
FROM Results Re
         JOIN Races Ra ON Ra.Raceid = Re.Raceid
         JOIN Driver D ON Re.Driverid = D.Driverid
ORDER BY RaceId, Position;










