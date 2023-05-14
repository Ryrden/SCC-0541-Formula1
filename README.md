# Projeto 3 - Fórmula 1 (Queries SQL - Rollup, Cube & Partition)

![modelagem ER](https://i.imgur.com/nF4Y3IT.png)
> Projeto 2 da disciplina SCC0541 - Laboratório de Banco de Dados

## Pré-requisitos

Há duas formas de executar o projeto, a primeira é utilizando o `docker` e a segunda é executando o projeto pelo `GUI do POSTGRESQL`.

Portanto, caso opte por utilizar o `docker`, é necessário que o mesmo esteja instalado em sua máquina. Para isso, siga as instruções de instalação do [docker](https://docs.docker.com/engine/install/) e do [docker-compose](https://docs.docker.com/compose/install/).

Caso opte por utilizar o `GUI do POSTGRESQL` (PG_ADMIN), é necessário que o mesmo esteja instalado em sua máquina. Para isso, siga as instruções de instalação do [postgresql](https://www.pgadmin.org/download/).

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

### A partir da GUI do POSTGRESQL ou qualquer outra IDE adequada

A partir daqui você deve conectar ao banco de dados utilizando as seguintes credenciais:

- **Host:** localhost
- **Port:** 5432
- **login:** postgres
- **password:** postgres
- **database:** postgres
- **url:** jdbc:postgresql://localhost:5432/postgres

## Criando tabelas e inserindo dados

Após isso, dentro do script `MAIN.SQL` na pasta `load_database/`, substitua a `string` DirLocal pelo endereço onde se encontra as tabelas CSV para inserção dos dados. exemplo:

**Caso esteja utilizando o `docker`:**

substitua a string `DirLocal` por `/database/tables_csv/`:

**Caso esteja utilizando o `GUI do POSTGRESQL`:**

substitua a string `DirLocal` pelo endereço completo de uma pasta que contenha os arquivos CSV dentro do GUI do POSTGRESQL.

por exemplo, se o PG_ADMIN estiver instalado em `C:\Program Files\pgAdmin 4\`, então crie a pasta `tables_csv` ai dentro e substitua a string `DirLocal` por `C:\\Program Files\\pgAdmin 4\\tables_csv\\`. (É necessário utilizar duas barras invertidas somente se estiver utilizando o SO Windows).

Outra opção para inserir os dados pelo `PG_ADMIN` é utilizar a interface de Import/export para arquivos csv, para saber mais, acesse [Import/Export Data](https://www.pgadmin.org/docs/pgadmin4/development/import_export_data.html).
