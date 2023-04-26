/* CREATE TABLE */
CREATE TABLE IF NOT EXISTS constructors
(
    constructorId  INTEGER      NOT NULL,
    constructorRef VARCHAR(255) NOT NULL,
    name           VARCHAR(255) NOT NULL,
    nationality    VARCHAR(255) DEFAULT NULL,
    url            VARCHAR(255) NOT NULL,

    CONSTRAINT PK_CONSTRUCTORS PRIMARY KEY (constructorId),
    CONSTRAINT UK_CONSTRUCTORS UNIQUE (name)
);
