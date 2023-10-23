-- Active: 1697283830777@@127.0.0.1@3306@lab3

-- 1. Testati comenzile DDL listate în acest laborator.

-- Creati o tabela users cu urmatoarele coloane: ID (PRIMARY KEY, NUMERIC, 3 cifre); name (NOT NULL, VARCHAR, 20 caractere).
CREATE TABLE users (
        ID DECIMAL(3) PRIMARY KEY,
        name VARCHAR(20) NOT NULL);


-- Adaugati 3 înregistrari în tabela.
INSERT INTO users
VALUES
        (1, 'ragos Gherasim'),
        (2, 'Daniel Roca'),
        (3, 'Eliza Norses');


-- Folosind comanda ALTER TABLE, adaugati o noua coloana, email (VARCHAR, 30 caractere) care sa nu permita inserarea de valori NULL.
ALTER TABLE users
ADD email VARCHAR(30) NOT NULL;


-- Creati o tabela details cu urmatoarele coloane: ID (PRIMARY KEY, NUMERIC, 3 cifre) care este si FOREIGN KEY catre tabela users, coloana ID, 
-- nickname (UNIQUE, NOT NULL, VARCHAR, 10 caractere); details (VARCHAR, 30 caractere).
CREATE TABLE details (
        ID DECIMAL(3) PRIMARY KEY,
        nickname VARCHAR(10) NOT NULL UNIQUE,
        details VARCHAR(30),
        FOREIGN Key (ID) REFERENCES users(ID)
);

-- Inserati câteva înregistrari în tabela si verificati faptul ca constrângerea FOREIGN KEY forteaza introducerea unor referinte valide catre datele
-- existente din tabla users.

INSERT INTO details
VALUES
        (1, 'Ghera', 'SW Veoneer'),
        (2, 'Dani', 'SW Veooner'),
        (3, 'Luiza', 'Teacher');

INSERT INTO details
VALUES
        (4, "Boss", "chetar");

INSERT INTO users()
VALUES
        (4, 'Codrut Prescovita', 'codrutpres5@yahoo.com');

INSERT INTO details
VALUES
        (4, "Boss", "chetar");

DELETE FROM 
        details
WHERE
        ID = 4;

DELETE FROM
        users
WHERE
        ID = 3;

UPDATE users
SET name = 'Elisabetta'
WHERE ID = 3;

ALTER TABLE details
RENAME TO detalii;

TRUNCATE TABLE detalii;


-- 2. Testati comenzile DML listate in acest laborator.
UPDATE  users
SET ID = 5
WHERE name = 'Codrut Prescovita';

UPDATE details
SET ID = 5
WHERE nickname = 'Boss';


-- 3. Testati comenzile DTL listate in acest laborator.

-- Configurati modalitatea de executie a tranzactiilor
SET autocommit = 0;

-- Porniti o tranzactie (folositi START TRANSACTION sau BEGIN);
START TRANSACTION;

-- Folositi instructiuni DML pentru modificarea datelor (INSERT / UPDATE / DELETE);
INSERT INTO users
VALUES
        (5, 'Sebastian Paval', 'sebipaval4@gmail.com');

UPDATE users
SET email = 'elizanorses3@yahoo.com'
WHERE `ID` = 3;

INSERT INTO users
VALUES
        (6, 'George', 'georgegeorge@gmail.com');

DELETE FROM users
WHERE ID = 6;

-- Folositi comanda SELECT pentru a vizualiza modificarile;
SELECT * FROM users;

-- Anulati efectele tranzactiei (folositi ROLLBACK) si verificati prin reluarea comenzii SELECT;
ROLLBACK;
SELECT * FROM users;

-- Reluati comenzile DML si de aceasta data marcati efectele tranzactiei ca fiind permanente (folositi comanda COMMIT).
INSERT INTO users
VALUES
        (5, 'Sebastian Paval', 'sebipaval4@gmail.com');

UPDATE users
SET email = 'elizanorses3@yahoo.com'
WHERE `ID` = 3;

INSERT INTO users
VALUES
        (6, 'George', 'georgegeorge@gmail.com');

DELETE FROM users
WHERE ID = 6;

COMMIT;

SELECT * FROM users;

-- Încercati sa refolositi ROLLBACK. De aceasta data, nu mai exista efecte care sa fie anulate.
ROLLBACK;

SELECT * FROM users;