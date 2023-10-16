-- Active: 1697283830777@@127.0.0.1@3306

-- 1. Sa se afiseze toti angajatii a caror nume contine literele ’a’ si ’o’ (coloana last_name din tabela employees), în aceasta ordine (mai întai ’a’ si apoi ’o’).
SELECT *
FROM employees
WHERE last_name LIKE '%a%o%';

-- 2. Sa se afiseze toti angajatii a caror prenume contine literele ’ll’ consecutiv (coloana first_name din tabela employees).
SELECT *
FROM employees
WHERE first_name LIKE '%ll%';

-- 3. Folosind tabela employees, afisati numele, prenumele, numele si prenumele concatenat si lungimea numelui concatenat.
SELECT
    last_name,
    first_name,
    CONCAT(last_name, " ", first_name) AS numele_complet,
    LENGTH(CONCAT(last_name, " ", first_name)) AS lungime_nume_complet
FROM 
    employees

-- 4. Folosind tabela employees, afisati numele, salariul si o a treia coloana folosind operatorul CASE care va afisa sirul de caractere "mic", "mediu" sau "mare"
-- în functie de valoarea salariului. (sub 5000 "mic", 5000–7000 "mediu", peste 7000 "mare").
SELECT
    last_name,
    salary,
    CASE 
        WHEN salary < 5000 THEN 'Mic'
        WHEN salary BETWEEN 5000 and 7000 THEN 'Mediu'  
        ELSE  'Mare'
    END AS status_salariu
FROM
    employees

-- 5. Folosind tabela employees, afisati salariul minim, salariul maxim si media salariala utilizând functiile de agregare
SELECT
    MIN(salary) AS salariul_min,
    MAX(salary) AS salariul_max,
    AVG(salary) AS salariul_mediu
FROM
    employees

-- 6. Folosind tabela employees, afisati numele, salariul si salariul marit cu 20% (rotunjit la a doua zecimala) doar pentru angajatii care au manager.
SELECT 
    last_name,
    salary,
    ROUND(salary * 1.2, 2) AS 'salariu_marit'
FROM
    employees
WHERE
    manager_id IS NOT NULL;