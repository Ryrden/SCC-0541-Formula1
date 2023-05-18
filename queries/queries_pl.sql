-- EXERCÍCIO 1

DROP FUNCTION IF EXISTS Nome_Nacionalidade(constructorName constructors.name%TYPE);

CREATE FUNCTION Nome_Nacionalidade(constructorName constructors.name%TYPE) RETURNS TEXT AS
$$
DECLARE
    Resultado TEXT;
BEGIN
    SELECT constructors.nationality INTO Resultado FROM constructors WHERE constructors.name = constructorName;
    RETURN Resultado;
END;
$$ language plpgsql;

SELECT Nome_Nacionalidade('McLaren');

--=================================================================================--

-- EXERCÍCIO 2

DROP FUNCTION IF EXISTS Pilotos_Nacionalidade(driverNationality driver.nationality%TYPE);

CREATE FUNCTION Pilotos_Nacionalidade(driverNationality driver.nationality%TYPE) RETURNS VOID AS
$$
DECLARE
    DriversCursor CURSOR FOR
        SELECT CONCAT(driver.forename, ' ', driver.surname) AS DriverName
        FROM driver
        WHERE driver.nationality = driverNationality;
    Cont       NUMERIC = 1;
    DriverLine driver%RowType;
BEGIN
    FOR DriverLine IN DriversCursor
        LOOP
            RAISE Notice '% Nome: %', Cont, DriverLine.DriverName;
            Cont := Cont + 1;
        END LOOP;
    RETURN;
END;
$$ language plpgsql;

SELECT Pilotos_Nacionalidade('British');

--=================================================================================--

-- EXERCÍCIO 3

DROP PROCEDURE IF EXISTS Cidade_Chamada(CityName geocities15k.name%TYPE);

CREATE PROCEDURE Cidade_Chamada(
    CityName geocities15k.name%TYPE)
AS
$$
DECLARE
    CityCounter NUMERIC;
    CityCursor CURSOR FOR
        SELECT geocities15k.name, geocities15k.population, geocities15k.country
        FROM geocities15k
        WHERE geocities15k.name = CityName;
    CityLine    geocities15k%RowType;
BEGIN
    SELECT COUNT(*)
    INTO CityCounter
    FROM geocities15k
    WHERE geocities15k.name = CityName;

    RAISE Notice 'Contagem: %|', CityCounter;

    FOR CityLine IN CityCursor
        LOOP
            RAISE NOTICE 'Nome: %, População: %, País: %', CityLine.name, CityLine.population, CityLine.country;
        END LOOP;
    RETURN;
END;
$$ language plpgsql;

CALL Cidade_Chamada('Victoria');

--=================================================================================--

-- EXERCÍCIO 4

DROP FUNCTION IF EXISTS Numero_vitorias(driverForename driver.forename%TYPE, driverSurname driver.surname%TYPE,
                                        yearWins NUMERIC);

CREATE FUNCTION Numero_vitorias(driverForename driver.forename%TYPE,
                                driverSurname driver.surname%TYPE, yearWins NUMERIC DEFAULT NULL) RETURNS NUMERIC AS
$$
DECLARE
    NumVictory NUMERIC;
BEGIN
    IF yearWins IS NOT NULL THEN
        SELECT COUNT(*)
        INTO NumVictory
        FROM driver
                 JOIN results ON driver.driverid = results.driverid
                 JOIN races ON results.raceid = races.raceid
        WHERE driver.forename = driverForename
          AND driver.surname = driverSurname
          AND results.position = 1
          AND races.year = yearWins;
    ELSE

        SELECT COUNT(*)
        INTO NumVictory
        FROM driver
                 JOIN results ON driver.driverid = results.driverid
        WHERE driver.forename = driverForename
          AND driver.surname = driverSurname
          AND results.position = 1;
    END IF;

    RETURN NumVictory;

END;
$$ language plpgsql;

SELECT Numero_vitorias('Lewis', 'Hamilton');
SELECT Numero_vitorias('Lewis', 'Hamilton', 2008);

--=================================================================================--

-- EXERCÍCIO 5

DROP FUNCTION IF EXISTS Pais_Continente();

CREATE FUNCTION Pais_Continente()
    RETURNS TABLE
            (
                name      countries.name%TYPE,
                continent countries.continent%TYPE
            )
AS
$$
DECLARE
    CountriesCursor CURSOR FOR SELECT countries.name, countries.continent
                               FROM countries;
    CountryLine countries%RowType;
BEGIN
    DROP TABLE IF EXISTS temp_countries;

    CREATE TEMPORARY TABLE temp_countries
    (
        name      TEXT,
        continent CHAR(2)
    );

    FOR CountryLine IN CountriesCursor
        LOOP
            IF LENGTH(CountryLine.name) <= 15 THEN
                INSERT INTO temp_countries (name, continent)
                VALUES (CountryLine.name, CountryLine.continent);
            END IF;
        END LOOP;
    RETURN QUERY SELECT * FROM temp_countries;
END;
$$ language plpgsql;

SELECT count(*)
FROM Pais_Continente();

--=================================================================================--
