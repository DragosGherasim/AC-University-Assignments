-- Ex 7
DESC employees;

SELECT
    first_name || last_name AS nume,
    job_title,
    hire_date,
    employee_id
FROM
    employees e,
    jobs      j
WHERE
    e.job_id = j.job_id;

-- Ex 9
SELECT DISTINCT
    job_title "Joburi Distincte"
FROM
         employees e
    JOIN jobs j ON e.job_id = j.job_id;
    
-- Ex 10
SELECT
    first_name
    || ' '
    || last_name AS "Nume",
    employee_id  AS employees#,
    job_title    AS "Job",
    hire_date    AS "Hire Date"
FROM
         employees e
    JOIN jobs j ON e.job_id = j.job_id;
    
-- Ex 11
SELECT
    first_name
    || ' '
    || last_name
    || ', '
    || job_title AS "EMPLOYEES-JOB and Title"
FROM
         employees e
    JOIN jobs j ON e.job_id = j.job_id;
    

-- Ex 12
SELECT
    first_name
    || ' '
    || last_name
    || ', '
    || salary
    || ', '
    || job_title AS "THE_OUTPUT"
FROM
         employees e
    JOIN jobs j ON e.job_id = j.job_id;
    

-- Ex 13
SELECT
    last_name,
    salary * 12 AS "Salariu Anual"
FROM
    employees
WHERE
    salary * 12 > 28500;

-- Ex 14
SELECT
    last_name,
    department_id
FROM
    employees
WHERE
    employee_id = 201;
  
    
-- Ex 15
SELECT
    last_name,
    salary * 12 AS "Salariu Anual"
FROM
    employees
WHERE
    salary * 12 NOT BETWEEN 15000 AND 28500;

-- Ex 16
SELECT
    last_name,
    job_title,
    hire_date
FROM
         employees e
    JOIN jobs j ON e.job_id = j.job_id
WHERE
    hire_date BETWEEN '20-feb-85' AND '01-may-92'
ORDER BY
    hire_date;

-- Ex 17
SELECT
    last_name,
    department_id
FROM
    employees
WHERE
    department_id IN ( 10, 30 )
ORDER BY
    last_name;
    
-- Ex 19
SELECT
    last_name,
    hire_date
FROM
    employees
WHERE
    hire_date LIKE '%1995'
ORDER BY
    hire_date;

-- Ex 20
SELECT
    last_name,
    job_title
FROM
         employees e
    JOIN jobs j ON e.job_id = j.job_id
WHERE
    manager_id IS NULL;
    
-- Ex 21
SELECT
    last_name,
    salary,
    commission_pct
FROM
    employees
WHERE
    commission_pct IS NOT NULL
ORDER BY
    salary DESC,
    commission_pct DESC;
    
-- Ex 22
SELECT
    last_name ||
    ' ' ||
    first_name AS "Nume"
FROM employees
WHERE last_name LIKE '__a%';

-- Ex 23
SELECT
    last_name ||
    ' ' ||
    first_name AS "Nume"
FROM employees
WHERE REGEXP_COUNT(last_name || first_name, 'L', 1, 'i') = 2 AND
    (department_id = 50 OR manager_id = 100);
    
-- Ex 24
SELECT 
    last_name,
    job_title,
    salary
FROM employees e
JOIN jobs j
ON j.job_id = e.job_id
WHERE (job_title = 'Accounting Manager' OR
    job_title = 'Stock Clerk') AND
    salary NOT IN (10000, 30000, 50000);
    
-- Ex 25
SELECT
    last_name,
    salary,
    commission_pct
FROM employees
WHERE commission_pct > .15;
