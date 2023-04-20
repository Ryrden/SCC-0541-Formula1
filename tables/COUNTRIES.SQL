/* CREATE TABLE */
CREATE TABLE countries
(
    id             INTEGER NOT NULL,
    code           VARCHAR(100),
    name           VARCHAR(100),
    continent      VARCHAR(100),
    wikipedia_link VARCHAR(100),
    keywords       VARCHAR(100),

    CONSTRAINT PK_COUNTRIES PRIMARY KEY (id)
);
