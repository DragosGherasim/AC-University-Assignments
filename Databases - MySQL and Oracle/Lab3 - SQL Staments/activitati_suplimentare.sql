-- Active: 1697283830777@@127.0.0.1@3306@lab3

-- 1. Studiati si celelalte comenzi DDL, DML si DTL

-- DTL:
SET autocommit = 0;

START TRANSACTION;

UPDATE users
SET email = "dragosghera13@gmail.com"
WHERE ID = 1;
SAVEPOINT svp_example;

UPDATE users
SET email = "daniroca11@gmail.com"
WHERE ID = 2;

SELECT * FROM users;

ROLLBACK TO SAVEPOINT svp_example;

COMMIT;

SELECT * FROM users;


-- 2. Folosind tabelele create la activitatea practica 1, users si details, afisati numele si nickname-ul pentru toti utilizatorii.
SELECT
    u.name, d.nickname
FROM
    users u, details d
WHERE
    u.`ID` = d.`ID`;

SELECT
    u.name, d.nickname
FROM
    users u
INNER JOIN
    details d ON u.`ID` = d.`ID`;