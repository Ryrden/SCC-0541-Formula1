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
    ADD Podium_Position VARCHAR(6);

UPDATE QUALIFYING
SET Podium_Position = 'Podium'
WHERE position BETWEEN 1 AND 3;

--================================================================================--

-- EXERCÍCIO 5

UPDATE DRIVER
SET nationality = 'BR'
WHERE nationality = 'Brazilian';

--================================================================================--

-- EXERCÍCIO 6

SELECT DRIVER.forename, DRIVER.surname, COUNT(*) AS pole_position
FROM QUALIFYING
         JOIN DRIVER ON QUALIFYING.driverid = DRIVER.driverid
WHERE QUALIFYING.position = 1
GROUP BY DRIVER.forename, DRIVER.surname, QUALIFYING.driverid
ORDER BY pole_position DESC
LIMIT 1;

--================================================================================--

-- EXERCÍCIO 7

SELECT CITIES.country, num_cities, num_airports
FROM (SELECT GEOCITIES15K.country, COUNT(DISTINCT GEOCITIES15K.geonameid) AS num_cities
      FROM GEOCITIES15K
               JOIN COUNTRIES ON GEOCITIES15K.country = COUNTRIES.code
               JOIN CIRCUITS ON COUNTRIES.name = CIRCUITS.country
      GROUP BY GEOCITIES15K.country) AS CITIES
         JOIN (SELECT AIRPORTS.ISOCountry, COUNT(DISTINCT AIRPORTS.ident) AS num_airports
               FROM AIRPORTS
                        JOIN COUNTRIES ON AIRPORTS.ISOCountry = COUNTRIES.code
                        JOIN CIRCUITS ON COUNTRIES.name = CIRCUITS.country
               GROUP BY AIRPORTS.ISOCountry) AS airports
              ON AIRPORTS.ISOCountry = CITIES.country;

--================================================================================--

-- EXERCÍCIO 8

-- Alternativa 1: Criar uma tabela com a mesma estrutura da tabela COUNTRIES, porém que contém apenas os países que tenham menos que 10 aeroportos, utilizando a claúsula NOT IN.
-- Essa alternativa é a melhor em termos de complexidade, pois reduz a necessidade de criarmos uma tabela temporarária para armazenarmos os dados e depois deletarmos as tuplas que não atendem a condição especificada.
CREATE TABLE countriesv2 AS
SELECT *
FROM COUNTRIES
WHERE COUNTRIES.code NOT IN (SELECT AIRPORTS.isocountry
                             FROM AIRPORTS
                                      JOIN COUNTRIES ON AIRPORTS.isocountry = COUNTRIES.code
                             GROUP BY AIRPORTS.isocountry, COUNTRIES.name
                             HAVING COUNT(AIRPORTS.ident) > 10
                             ORDER BY AIRPORTS.isocountry);

-- Alternativa 2: Essa alternativa também contempla a criação de uma tabela COUNTRIESV2 com a mesma estrutura da tabela COUNTRIES, porém que contém apenas os países que tenham menos que 10 aeroportos.
-- Nessa alternativa, utilizamos a claúsula NOT IN e a claúsula DELETE, como especificado no exercício. Entretanto, vale ressaltar que,  comando DELETE não é necessário para essa operação. Em vez disso, seria possível utilizar uma cláusula NOT IN para excluir os países que têm mais de 10 aeroportos. Ou seja, uma clausúla substitui a outra.
-- Além disso, tal alternativa aumenta a complexidade de operação, visto que é necessário criar uma tabela temporária desnecessariamente apenas para fazer tal operação.
-- Dito isso, foi necessário seguir os seguintes passos:
-- 1. Criamos uma tabela TEMPORÁRIA que contém TODOS os países (é uma cópia da tabela COUNTRIES).
-- 2. Deletamos todos países que tem MENOS de 10 aeroportos, da tabela TEMPORÁRIA.
-- 3. Criamos a tabela  COUNTRIESV2 que seleciona todos os países da tabela COUNTRIES e utiliza a cláusula NOT IN para selecionar APENAS aqueles países que estão na tabela COUNTRIES mas não estão na tabela TEMPORÁRIA, ou seja, apenas aqueles países que tem <= 10 aeroportos.

CREATE TEMPORARY TABLE temp AS
SELECT AIRPORTS.ISOCountry, COUNT(AIRPORTS.ident) as count
FROM AIRPORTS
GROUP BY AIRPORTS.ISOCountry;

DELETE
FROM TEMP
WHERE TEMP.count <= 10;

CREATE TABLE IF NOT EXISTS countriesv2 AS
SELECT *
FROM COUNTRIES
WHERE COUNTRIES.code NOT IN (SELECT TEMP.ISOCountry FROM TEMP);

