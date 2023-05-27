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

