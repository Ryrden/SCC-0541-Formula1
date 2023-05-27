-- EXERCÍCIO 1
CREATE OR REPLACE FUNCTION VerificaAeroporto() RETURNS TRIGGER AS
$$
BEGIN
    IF NEW.City IS NOT NULL AND NOT EXISTS (SELECT 1 FROM GEOCITIES15K WHERE Name = NEW.City) THEN
        RAISE EXCEPTION 'Cidade não encontrada! Operação cancelada.';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER TR_Airports
    BEFORE INSERT OR UPDATE
    ON AIRPORTS
    FOR EACH ROW
EXECUTE FUNCTION VerificaAeroporto();

-- Simulando uma INSERÇÃO com FALHA com uma cidade não cadastrada na tabela GEOCITIES15K (City == 'Sao Carlos')
INSERT INTO AIRPORTS (IDENT, Type, Name, Continent, Isocountry, Isoregion, City)
VALUES (9696, 'heliport', 'Trigger Airport', 'SA', 'BR', 'BR-SP', 'Sao Carlos');

-- Simulando uma INSERÇÃO de SUCESSO com uma cidade JÁ cadastrada na tabela GEOCITIES15K (City == 'Campinas')
INSERT INTO AIRPORTS (IDENT, Type, Name, Continent, Isocountry, Isoregion, City)
VALUES (9696, 'heliport', 'Trigger Airport', 'SA', 'BR', 'BR-SP', 'Campinas');
SELECT *
FROM AIRPORTS
WHERE AIRPORTS.IDENT = '9696';

-- Simulando um UPDATE com FALHA com uma cidade não cadastrada na tabela GEOCITIES15K (City == 'Ibate')
UPDATE AIRPORTS
SET City = 'Ibate'
WHERE AIRPORTS.IDENT = '9696';

-- Simulando um UPDATE com SUCESSO com uma cidade não cadastrada na tabela GEOCITIES15K (City == 'São Paulo)
UPDATE AIRPORTS
SET City = 'São Paulo'
WHERE AIRPORTS.IDENT = '9696';

--=================================================================================--

-- EXERCÍCIO 2

CREATE TABLE ResultsStatus
(
    StatusID INTEGER PRIMARY KEY,
    Contagem INTEGER,
    FOREIGN KEY (StatusID) REFERENCES Status (StatusID)
);
INSERT INTO ResultsStatus
SELECT S.StatusId, COUNT(*)
FROM Status S
         JOIN Results R ON R.StatusID = S.StatusID
GROUP BY S.StatusId, S.Status;

-- Alternativas A,B e C
CREATE OR REPLACE FUNCTION AtualizaContagem() RETURNS TRIGGER AS
$$
BEGIN
    CASE TG_OP
        WHEN 'INSERT' THEN UPDATE ResultsStatus RS
                           SET Contagem = Contagem + 1
                           WHERE NEW.Statusid = RS.StatusID;
                           RAISE NOTICE 'StatusID: %, Contagem: %', NEW.Statusid, (SELECT Contagem FROM ResultsStatus WHERE StatusID = NEW.StatusID);
                           RETURN NEW;


        WHEN 'DELETE' THEN UPDATE ResultsStatus RS
                           SET Contagem = Contagem - 1
                           WHERE OLD.Statusid = RS.StatusID;
                           RAISE NOTICE 'StatusID: %, Contagem: %', OLD.Statusid, (SELECT Contagem FROM ResultsStatus WHERE StatusID = OLD.StatusID);
                           RETURN OLD;

        WHEN 'UPDATE' THEN UPDATE ResultsStatus
                           SET Contagem = Contagem - 1
                           WHERE StatusID = OLD.StatusID;

                           UPDATE ResultsStatus
                           SET Contagem = Contagem + 1
                           WHERE StatusID = NEW.StatusID;

                           RAISE NOTICE 'StatusID Anterior: %, Contagem: %.', OLD.StatusID, (SELECT Contagem FROM ResultsStatus WHERE StatusID = OLD.StatusID);
                           RAISE NOTICE 'StatusID Atual: %, Contagem: %.', NEW.StatusID, (SELECT Contagem FROM ResultsStatus WHERE StatusID = NEW.StatusID);

                           RETURN NEW;

        END CASE;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER TR_ResultsStatus
    AFTER INSERT OR DELETE OR UPDATE OF StatusId
    ON RESULTS
    FOR EACH ROW
EXECUTE FUNCTION AtualizaContagem();


-- Exemplo item A
INSERT INTO Results (ResultId, RaceId, DriverId, ConstructorId, Number, Grid, Position, PositionText, PositionOrder,
                     Points, Laps, Time, Milliseconds, FastestLap, Rank, FastestLapTime, FastestLapSpeed, StatusId)
VALUES (25910, 1101, 1, 1, 22, 1, 1, '1', 1, 10.5, 58, '1:34:50.616', 5690616, 39, 2, '1:27.452', '218.300', 2);

-- Exemplo item C
UPDATE Results
SET Statusid = 2
WHERE Resultid = 25910;


-- Exemplo item B
DELETE
FROM Results
WHERE Resultid = 25910;


-- 2.D)
CREATE OR REPLACE FUNCTION VerificaStatus() RETURNS TRIGGER AS
$$
BEGIN
    IF NEW.Statusid < 0 OR NEW.Statusid IS NULL THEN
        RAISE EXCEPTION 'StatusID Negativo! Operação cancelada.';
    END IF;

    CASE TG_OP
        WHEN 'INSERT' THEN UPDATE ResultsStatus RS
                           SET Contagem = Contagem + 1
                           WHERE NEW.Statusid = RS.StatusID;
                           RAISE NOTICE 'StatusID: %, Contagem: %', NEW.Statusid, (SELECT Contagem FROM ResultsStatus WHERE StatusID = NEW.StatusID);
                           RETURN NEW;


        WHEN 'UPDATE' THEN UPDATE ResultsStatus
                           SET Contagem = Contagem - 1
                           WHERE StatusID = OLD.StatusID;

                           UPDATE ResultsStatus
                           SET Contagem = Contagem + 1
                           WHERE StatusID = NEW.StatusID;

                           RAISE NOTICE 'StatusID Anterior: %, Contagem: %.', OLD.StatusID, (SELECT Contagem FROM ResultsStatus WHERE StatusID = OLD.StatusID);
                           RAISE NOTICE 'StatusID Atual: %, Contagem: %.', NEW.StatusID, (SELECT Contagem FROM ResultsStatus WHERE StatusID = NEW.StatusID);

                           RETURN NEW;
        END CASE;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER TR_Results
    BEFORE INSERT OR UPDATE OF StatusId
    ON RESULTS
    FOR EACH ROW
EXECUTE FUNCTION VerificaStatus();

-- Exemplo de inserção para a alternativa D
INSERT INTO Results (ResultId, RaceId, DriverId, ConstructorId, Number, Grid, Position, PositionText, PositionOrder,
                     Points, Laps, Time, Milliseconds, FastestLap, Rank, FastestLapTime, FastestLapSpeed, StatusId)
VALUES (25910, 1101, 1, 1, 22, 1, 1, '1', 1, 10.5, 58, '1:34:50.616', 5690616, 39, 2, '1:27.452', '218.300', -2);

-- Exemplo de UPDATE para a alternativa D
INSERT INTO Results (ResultId, RaceId, DriverId, ConstructorId, Number, Grid, Position, PositionText, PositionOrder,
                     Points, Laps, Time, Milliseconds, FastestLap, Rank, FastestLapTime, FastestLapSpeed, StatusId)
VALUES (25910, 1101, 1, 1, 22, 1, 1, '1', 1, 10.5, 58, '1:34:50.616', 5690616, 39, 2, '1:27.452', '218.300', 2);

UPDATE Results
SET Statusid = -3
WHERE Resultid = 25910;