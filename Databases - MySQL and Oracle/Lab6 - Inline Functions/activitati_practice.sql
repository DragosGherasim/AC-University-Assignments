-- Ex 1
SELECT SYSDATE FROM DUAL;

-- Ex 2
SELECT
    employee_id,
    last_name,
    salary,
    TRUNC(salary * 1.15) as "Salar Nou"
FROM
    EMPLOYEES;

-- Ex 4
SELECT
    employee_id,
    last_name,
    salary,
    TRUNC(salary * 1.15) as "Salar Nou",
    TRUNC(salary * 0.15) as "Crestere"
FROM
    EMPLOYEES;

-- Ex 5
SELECT
    last_name,
    hire_date,
    TO_CHAR(NEXT_DAY(ADD_MONTHS(hire_date, 6), 'MONDAY'), 
'fmDay, "the" Ddspth "of" Month, YYYY')
FROM employees;

-- Ex 6
SELECT
    last_name,
    ROUND(MONTHS_BETWEEN(SYSDATE, hire_date)) as "LUNI_DE_ACTIVITATE"
FROM employees
ORDER BY "LUNI_DE_ACTIVITATE" ASC;

-- Ex 7
SELECT
    last_name ||
    ' castiga $' ||
    salary ||
    ' lunar dar ar dori ' ||
    3 * salary AS "Salariu de vis"
FROM employees;

-- Ex 8
SELECT
    last_name,
    lpad(salary, 15, '$') AS salariu
FROM
    employees;
    
-- Ex 9
SELECT
    initcap(last_name) AS nume,
    length(last_name) AS lungime
FROM
    employees
WHERE
    substr(last_name, 1, 1) IN ( 'J', 'A', 'M' );

-- Ex 10
SELECT
    last_name,
    hire_date,
    TO_CHAR(hire_date, 'Day') AS "ZI"
FROM employees
ORDER BY
    DECODE(TO_NUMBER(TO_CHAR(hire_date, 'D')), 1, 7,
           TO_NUMBER(TO_CHAR(hire_date, 'D')) - 1);

-- Ex 11
SELECT
    last_name,
    DECODE(commission_pct, NULL, 'No commision',
           TO_CHAR(commission_pct)) AS "COMM"
FROM employees;

-- Ex 11 - cap8
SELECT
    rpad(last_name, 15, ' ')
    || rpad('*', salary / 100, '*') AS "EMPLOYEE_AND_THEIR_SALARIES"
FROM
    employees;