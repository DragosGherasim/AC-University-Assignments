-- Active: 1697283830777@@127.0.0.1@3306@test_lab2

-- 1. Sa se afiseze numele departamentului, numele orasului pentru departamentele a caror denumire contine literele ’pp’ consecutiv si se afla în orasele care contin litera
-- ’u’ pe pozitia a 3-a si ’h’ pe pozitia 5-a (coloana department_name din tabela departments si coloana city din tabela locations).

SELECT
    d.department_name,
    l.city
FROM
    departments d
INNER JOIN 
    locations l ON d.location_id = l.location_id
WHERE
    LOWER(d.department_name) LIKE '%pp%' AND
    SUBSTR(l.city, 3, 1) = 'u' AND
    SUBSTR(l.city, 5, 1) = 'h';


-- 2. Sa se afiseze din tabela employees, în coloane separate: prenumele, numele si o adresa de e-mail de forma: prima litera din prenume, urmat de caracterul ’.’, urmat de
-- nume, urmat de caracterul ’@’, urmat de primele caractere pâna la caracterul ’_’ din id-ul job-ului (coloana job_id), urmat de ’.acme.com’. Afis, area se va face cu 
-- toate literele mici.De exemplu, pentru Peter Vargas va rezulta p.vargas@st.acme.com 

SELECT
    first_name as prenume,
    last_name as nume,
    LOWER(
        CONCAT(
            SUBSTR(first_name, 1, 1), 
            '.',
            last_name, 
            '@', 
            SUBSTR(job_id, 1, INSTR(job_id, '_')-1), '.acme.com'
            )
        ) AS email
FROM
    employees
