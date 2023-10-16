-- Active: 1697274654825@@127.0.0.1@3306

- #Crearea unei baze date

-- CREATE DATABASE test_lab1;
-- SHOW DATABASES;
-- USE test_lab1;
-- SHOW TABLES;


-- #Crearea si stergerea unei tabele

-- CREATE TABLE tab_users (id INTEGER(3), nume VARCHAR(20));
-- SHOW TABLES;
-- DESC tab_users;
-- SELECT * FROM tab_users;
-- INSERT INTO tab_users VALUES (1, "Ana");
-- INSERT INTO tab_users VALUES (2, "Maria");
-- INSERT INTO tab_users VALUES (3, "Ionut");
-- INSERT INTO tab_users VALUES (4, "Vasile"), (5, "Maria");
-- DELETE FROM tab_users WHERE nume="Vasile";
-- SELECT * FROM tab_users;
-- DELETE FROM tab_users WHERE nume="xyz";
-- SELECT * FROM tab_users;
-- DELETE FROM tab_users WHERE nume="Maria";
-- SELECT * FROM tab_users;
-- DROP TABLE tab_users;
-- SHOW TABLES;


-- #Stergerea unei baze de DATE

-- DROP DATABASE test_lab1;
-- SHOW DATABASES;


-- #Schimbarea bezei de date curente

-- CREATE DATABASE test_1;
-- CREATE DATABASE test_2;
-- CREATE DATABASE test_3;
-- SHOW DATABASES;
-- USE test_1;
-- SELECT DATABASE();
-- USE test_2;
-- SELECT DATABASE();


-- #Tipuri de date. Tipul ENUM

-- DROP DATABASE test_3;
-- DROP DATABASE test_2;
-- USE test_1;
-- CREATE TABLE test1 (c_enum ENUM ('Luni', 'Marti', 'Miercuri'));
-- DESC test1;
-- INSERT INTO test1 VALUES (1), (2), (4);
-- SELECT * FROM test1;


-- #Tipul SET
-- CREATE TABLE test2 (c_set SET ('a', 'b', 'c', 'd'));
-- INSERT INTO test2 VALUES (7);
-- INSERT INTO test2 VALUES (15);
-- SELECT * FROM test2; 

-- DROP DATABASE test_1;