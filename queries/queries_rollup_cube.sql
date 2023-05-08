-- EXERCÍCIO 1
-- 1)
SELECT C.Name, C.Nationality, S.Status, COUNT(*)
FROM Results Re
         JOIN Constructors C ON C.ConstructorID = Re.ConstructorID
         JOIN Status S ON S.StatusID = Re.StatusID
GROUP BY GROUPING SETS ((C.Name, S.Status), (C.Nationality, S.Status))
ORDER BY COUNT(*) DESC;

--===========================--

-- 2)

SELECT C.Name, C.Nationality, COUNT(*)
FROM Results Re
         JOIN Constructors C ON C.ConstructorID = Re.ConstructorID
         JOIN Status S ON S.StatusID = Re.StatusID
WHERE S.Status = 'Accident'
GROUP BY GROUPING SETS ((C.Name, C.Nationality), ())
ORDER BY COUNT(*) DESC;

--===========================--

-- 3)

SELECT C.Nationality, COUNT(*)
FROM Results Re
         JOIN Constructors C ON C.ConstructorID = Re.ConstructorID
         JOIN Status S ON S.StatusID = Re.StatusID and S.Status = 'Accident'
WHERE C.Nationality = 'British'
GROUP BY C.Nationality
ORDER BY COUNT(*) DESC;

--===========================--

-- 4)

SELECT C.Name, C.Nationality, COUNT(*)
FROM Results Re
         JOIN Constructors C ON C.ConstructorID = Re.ConstructorID
         JOIN Status S ON S.StatusID = Re.StatusID
WHERE S.Status = 'Accident' AND C.Nationality = 'Brazilian'
GROUP BY C.Name, C.Nationality
ORDER BY COUNT(*) DESC;

--=================================================================================--

-- EXERCÍCIO 2

SELECT A.isocountry AS Country, A.city AS City, COUNT(*) AS Sum FROM airports A
GROUP BY ROLLUP (1, 2)
HAVING COUNT(*) >= 12
ORDER BY COUNT(*) DESC;

--=================================================================================--

-- EXERCÍCIO 3

SELECT C.name, RA.year, COUNT(*) FROM constructors C
    JOIN results R on C.constructorid = R.constructorid
    JOIN races RA on R.raceid = RA.raceid
WHERE R.position = 1
GROUP BY ROLLUP (1, 2);

--=================================================================================--

-- EXERCÍCIO 4
