-- Active: 1697283830777@@127.0.0.1@3306

-- 1. Creati o baza de date care sa aiba in denumire prefixul test_ si ca sufix numele semigrupei
CREATE DATABASE test_1306A;
SHOW DATABASES;

-- 2. Conectati-va la baza de date nou creata
USE test_1306A;

-- 3. Creati o tabela cu studenti care sa aiba coloanele id de tip INTEGER de dimensiune 2, nume de tip VARCHAR de dimensiune 20 si data_nasterii de tip DATE.
CREATE TABLE studenti (id INTEGER(2), nume VARCHAR(20), data_nasterii DATE);
DESC studenti;
INSERT INTO studenti VALUES (1, "Dragos", "2000-12-13");
INSERT INTO studenti VALUES (2, "Eliza", "2004-09-03"), (3, "Codrut", "2001-05-16");
SELECT * FROM studenti;