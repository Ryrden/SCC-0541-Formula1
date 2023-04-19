/* CREATE TABLE */
CREATE TABLE qualifying(
qualifyId SERIAL,
raceId SERIAL,
driverId SERIAL,
constructorId SERIAL,
number SERIAL,
position SERIAL,
q1 VARCHAR(100), -- TODO: Rever tipo desse tempo aqui
q2 VARCHAR(100),
q3 VARCHAR(100)
);
