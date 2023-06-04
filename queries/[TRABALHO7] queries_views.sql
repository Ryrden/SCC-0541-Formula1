-- EXERCÍCIO 1
DROP MATERIALIZED VIEW IF EXISTS Aeroportos_Brasileiros;

CREATE MATERIALIZED VIEW Aeroportos_Brasileiros AS
SELECT A.name    AS AIRPORT,
       A.latdeg  AS AIRPORT_LAT,
       A.longdeg AS AIRPORT_LONG,
       CI.name   AS CITY,
       CI.population,
       CO.name   AS COUNTRY,
       CO.continent
FROM AIRPORTS A
         JOIN COUNTRIES CO ON A.isocountry = CO.code
         JOIN GEOCITIES15K CI ON CO.code = CI.country
WHERE A.city = CI.name;

-- Number of elements created in View
SELECT *
FROM Aeroportos_Brasileiros;
SELECT count(*)
FROM Aeroportos_Brasileiros;

--=================================================================================--

-- EXERCÍCIO 2

--=================================================================================--

-- EXERCÍCIO 3
DROP VIEW IF EXISTS Circuitos_completa;

CREATE VIEW Circuitos_completa AS
SELECT CI.Name AS circuit_name, CI.Location AS circuit_location, CI.Country, CO.Code, CO.Continent
FROM CIRCUITS CI
         LEFT JOIN COUNTRIES CO ON CI.Country = CO.Name;

SELECT *
FROM Circuitos_completa;
SELECT COUNT(*)
FROM Circuitos_completa;

--=================================================================================--

-- EXERCÍCIO 4

DROP VIEW IF EXISTS Problemas_circuitos;

CREATE VIEW Problemas_circuitos AS
SELECT *
FROM Circuitos_completa CC
WHERE CC.Code IS NULL;

SELECT *
FROM Problemas_circuitos;
SELECT COUNT(*)
FROM Problemas_circuitos;
--=================================================================================--

-- EXERCÍCIO 5

DROP MATERIALIZED VIEW IF EXISTS Correcao_circuitos;

CREATE MATERIALIZED VIEW Correcao_circuitos AS
SELECT PC.Circuit_name, PC.Circuit_location, PC.Country
FROM Problemas_circuitos PC;

SELECT * FROM Correcao_circuitos;

--=================================================================================--