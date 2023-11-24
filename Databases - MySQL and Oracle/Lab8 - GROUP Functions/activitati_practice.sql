-- Ex4
SELECT
    MAX(salary) AS "Maximum",
    MIN(salary) AS "Minimum",
    SUM(salary) AS "Sum",
    AVG(salary) AS "Average"
FROM
    employees;

-- Ex5
SELECT
    job_id,
    MAX(salary)        AS "Maximum",
    MIN(salary)        AS "Minimum",
    SUM(salary)        AS "Sum",
    round(AVG(salary)) AS "Average"
FROM
    employees
GROUP BY
    job_id;

-- Ex6
SELECT
    job_id,
    COUNT(*)
FROM
    employees
GROUP BY
    job_id;

-- Ex7
SELECT
    COUNT(DISTINCT(manager_id)) AS "Number of Managers"
FROM
    employees;

-- Ex8
SELECT
    MAX(salary) - MIN(salary) AS "DIFFERENCE"
FROM
    employees;

-- Ex9
SELECT
    manager_id,
    MIN(salary)
FROM
    employees
WHERE
    manager_id IS NOT NULL
GROUP BY
    manager_id
HAVING
    MIN(salary) >= 7000
ORDER BY
    MIN(salary) DESC;
    
-- Ex10
SELECT
    department_name    AS "Name",
    location_id        AS "Location",
    COUNT(employee_id) AS "Number of People",
    AVG(salary)        AS "Salary"
FROM
         departments
    JOIN employees USING ( department_id )
GROUP BY
    department_name,
    location_id
ORDER BY
    department_name;

-- Ex11
SELECT
    COUNT(employee_id) AS TOTAL,
    SUM(DECODE(SUBSTR(hire_date, -2), '95', 1, 0)) AS "1995", --SUM(DECODE(TO_NUMBER(TO_CHAR(hire_date, 'YYYY'), 1995, 1, 0)) AS "1995",
    SUM(DECODE(SUBSTR(hire_date, -2), '96', 1, 0)) AS "1996",
    SUM(DECODE(SUBSTR(hire_date, -2), '97', 1, 0)) AS "1997",
    SUM(DECODE(SUBSTR(hire_date, -2), '98', 1, 0)) AS "1998"
FROM employees;
--WHERE SUBSTR(hire_date, -2) IN ('95', '96', '97', '98');

-- Ex12
SELECT
    job_id AS "Job",
    SUM(DECODE(department_id, 20, salary, 0)) AS "Dept20",
    SUM(DECODE(department_id, 50, salary, 0)) AS "Dept50",
    SUM(DECODE(department_id, 80, salary, 0)) AS "Dept80",
    SUM(DECODE(department_id, 90, salary, 0)) AS "Dept90",
    SUM(salary) as "Total"
FROM employees
GROUP BY job_id
ORDER BY job_id;