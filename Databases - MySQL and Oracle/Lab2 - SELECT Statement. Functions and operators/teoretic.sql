-- Active: 1697283830777@@127.0.0.1@3306

-- -- SHOW DATABASES;
-- USE test_lab2;
-- SOURCE /home/student/Downloads/cretabs_mysql.sql;
-- SHOW TABLES;

-- #Comanda SELECT

-- DESC departments;
-- SELECT * FROM departments;
-- DESC employees;
-- SELECT * FROM employees;
-- SELECT * FROM employees WHERE job_id="IT_PROG";
-- SELECT COUNT(*) FROM employees WHERE job_id="IT_PROG";


-- #Operatori. BETWEEN ... AND ...

-- SELECT * FROM employees WHERE salary BETWEEN 5000 AND 7000;
-- SELECT * FROM employees WHERE salary >= 5000 AND salary <= 7000;
-- SELECT * FROM employees WHERE salary NOT BETWEEN 5000 AND 7000;


-- #LIKE
-- SELECT * FROM employees WHERE first_name LIKE "E1%";
-- SELECT * FROM employees WHERE phone_decimal LIKE "07______12";
-- SELECT * FROM employees WHERE job_id LIKE "IT_\%"; -- cauta 'IT_%'
-- SELECT * FROM employees WHERE job_id LIKE "IT_!%" ESCAPE '!';


-- #CASE
-- SELECT * FROM departments;
-- SELECT department_id, department_name,
--     CASE 
--         WHEN department_name LIKE 'A%' THEN "Canada"
--         WHEN department_name LIKE 'S%' THEN "Australia" 
--         ELSE  'America'
--     END "Regiunea"
-- FROM departments;

-- #Functii
SELECT first_name, last_name,
    CONCAT(first_name, " ", last_name) AS "nume_complet",
    SUBSTR(CONCAT(first_name, ' ', last_name), 1, INSTR(CONCAT(first_name, ' ', last_name), ' ')) AS "nume extras din nume complet",
    SUBSTR(CONCAT(first_name, ' ', last_name), INSTR(CONCAT(first_name, ' ', last_name), ' ')) AS "prenume extras din nume complet"
FROM employees;
