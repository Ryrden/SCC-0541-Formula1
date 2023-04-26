# Projeto 1 - Fórmula 1 (Criação e inserção de dados)

![modelagem ER](https://i.imgur.com/qJXBMHG.png);
> Projeto 1 da disciplina SCC0541 - Laboratório de Banco de Dados

## Pré-requisitos

Há duas formas de executar o projeto, a primeira é utilizando o `docker` e a segunda é executando o projeto pelo `GUI do POSTGRESQL`.

Portanto, caso opte por utilizar o `docker`, é necessário que o mesmo esteja instalado em sua máquina. Para isso, siga as instruções de instalação do [docker](https://docs.docker.com/engine/install/) e do [docker-compose](https://docs.docker.com/compose/install/).

Caso opte por utilizar o `GUI do POSTGRESQL`, é necessário que o mesmo esteja instalado em sua máquina. Para isso, siga as instruções de instalação do [postgresql](https://www.postgresql.org/download/).

## Executando o projeto

### Subindo o docker

Para executar o projeto utilizando o `docker`, basta executar o seguinte comando na raiz do projeto:

```bash
docker compose up -d
```

Assim que terminar a utilização e quiser parar o projeto, basta executar o seguinte comando:

```bash
docker compose down
```

se deseja apagar os dados do banco de dados, basta executar o mesmo comando anterior, porém com a flag `-v`:

```bash
docker compose down -v
```

### A partir da GUI do POSTGRESQL ou qualquer outra IDE

A partir daqui você deve conectar ao banco de dados utilizando as seguintes credenciais:

- **Host:** localhost
- **Port:** 5432
- **login:** postgres
- **password:** postgres
- **database:** postgres
- **url:** jdbc:postgresql://localhost:5432/postgres

## Criando tabelas e inserindo dados

Após isso, basta executar o script `MAIN.SQL` dentro da pasta `database/` para criar as tabelas e o script `SCRIPT.SQL` na raiz do projeto para inserir os dados nas tabelas.
