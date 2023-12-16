-- Ex1
SELECT
    last_name,
    hire_date
FROM
    employees
WHERE
        department_id = (
            SELECT
                department_id
            FROM
                employees
            WHERE
                last_name = 'Zlotkey'
        )
    AND last_name <> 'Zlotkey';

-- Ex2
SELECT
    employee_id,
    last_name,
    salary
FROM
    employees
WHERE
    salary > (
        SELECT
            AVG(salary)
        FROM
            employees
    )
ORDER BY
    salary DESC;
    
-- Ex3
SELECT
    employee_id,
    last_name
FROM
    employees
WHERE
    department_id IN (
        SELECT
            department_id
        FROM
            employees
        WHERE
            last_name LIKE '%u%'
    );
    
-- Ex4
SELECT
    last_name,
    department_id,
    job_id
FROM
    employees
WHERE
    department_id IN (
        SELECT
            department_id
        FROM
            departments
        WHERE
            location_id IN ( 1700 )
    );
    
-- Ex5
SELECT
    last_name,
    salary
FROM
    employees
WHERE
    manager_id = (
        SELECT
            employee_id
        FROM
            employees
        WHERE
            last_name = 'King'
    );
    
-- Ex6
SELECT
    department_id,
    last_name,
    job_id
FROM
    employees
WHERE
    department_id = (
        SELECT
            department_id
        FROM
            departments
        WHERE
            department_name = 'Executive'
    );
    
-- Ex7
SELECT
    employee_id,
    last_name,
    salary
FROM
    employees
WHERE
        salary > (
            SELECT
                AVG(salary)
            FROM
                employees
        )
    AND department_id IN (
        SELECT
            department_id
        FROM
            employees
        WHERE
            last_name LIKE '%u%'
    );
    
-- Ex8
SELECT
    last_name,
    department_id,
    salary
FROM
    employees
WHERE (department_id, salary) IN (
    SELECT
        department_id,
        salary
    FROM
        employees
    WHERE commission_pct IS NOT NULL );
    
-- Ex9
SELECT
    last_name,
    (
        SELECT
            department_name
        FROM
            departments
        WHERE
            department_id = e.department_id
    ) AS department_name,
    salary
FROM
    employees e
WHERE
    ( salary, COALESCE(commission_pct, -1)) IN (
        SELECT
            salary, COALESCE(commission_pct, -1)
        FROM
                 employees
            JOIN departments USING ( department_id )
        WHERE
            location_id =  1700 
    );
    
-- Ex10
SELECT
    last_name,
    hire_date,
    salary
FROM
    employees
WHERE
    ( salary, coalesce(commission_pct, - 1) ) IN (
        SELECT
            salary, coalesce(commission_pct, - 1)
        FROM
            employees
        WHERE
            last_name = 'Kochhar'
    )
    AND last_name <> 'Kochhar';

-- Ex11
SELECT
    last_name,
    job_id,
    salary
FROM
    employees
WHERE
    salary > ALL (
        SELECT
            salary
        FROM
            employees
        WHERE
            job_id = 'SA_MAN'
    )
ORDER BY
    salary DESC;

-- Ex12
SELECT
    employee_id,
    last_name,
    department_id
FROM
    employees
WHERE
    department_id = (
        SELECT
            department_id
        FROM
            departments
        WHERE
            location_id = (
                SELECT
                    location_id
                FROM
                    locations
                WHERE
                    city LIKE 'T%'
            )
    );
    
-- Ex13
SELECT
    a.last_name     AS "ENAME",
    a.salary,
    a.department_id AS "DEPTNO",
    b.DEPT_AVG
FROM
    employees a,
    (
        SELECT
            department_id,
            AVG(salary) AS "DEPT_AVG"
        FROM
            employees
        GROUP BY
            department_id
    ) b
WHERE
    a.department_id = b.department_id
AND
    salary > DEPT_AVG
ORDER BY
    DEPT_AVG;
    
-- Ex14
SELECT
    last_name
FROM
    employees e
WHERE
    NOT EXISTS (
        SELECT
            'X'
        FROM
            employees
        WHERE
            manager_id = e.employee_id
    );
    
SELECT
    last_name
FROM
    employees
WHERE
    employee_id NOT IN (
        SELECT
            manager_id
        FROM
            employees
        WHERE
            manager_id IS NOT NULL
    );

-- Ex15
SELECT
    last_name
FROM
    employees e
WHERE
    salary < (
        SELECT
            AVG(salary)
        FROM
            employees
        WHERE
            department_id = e.department_id
    );
    
-- Ex16
SELECT
    last_name
FROM 
    employees outer
WHERE
    EXISTS (
        SELECT
            'X'
        FROM
            employees
        WHERE
            outer.department_id = department_id
        AND
            outer.salary < salary
        AND
            outer.hire_date < hire_date
    );
    
-- Ex17
SELECT
    employee_id,
    last_name,
    (
        SELECT
            department_name
        FROM
            departments
        WHERE
            department_id = e.department_id
    )
FROM
    employees e;
    
-- Ex18
WITH summary AS (
    SELECT
        department_name,
        SUM(salary) AS "DEPT_TOTAL"
    FROM
             departments
        JOIN employees USING ( department_id )
    GROUP BY
        department_name
)
SELECT
    *
FROM
    summary
WHERE
    dept_total > (
        SELECT
            1 / 8 * SUM(salary)
        FROM
            employees
    );
    
-- Ex20
SELECT
    last_name,
    salary,
    department_id
FROM
    employees
START WITH
    last_name = 'Mourgos'
CONNECT BY
    PRIOR employee_id = manager_id;
    
-- Ex21
SELECT
    last_name
FROM
    employees
WHERE
    last_name <> 'Lorentz'
START WITH
    last_name = 'Lorentz'
CONNECT BY
    PRIOR manager_id = employee_id;
    
-- Ex22
SELECT
    lpad(last_name,
         length(last_name) +(level * 2) - 2,
         '_')     AS "NAME",
    manager_id    AS "MGR",
    department_id AS "DEPTNO"
FROM
    employees
START WITH
    last_name = 'Kochhar'
CONNECT BY
    PRIOR employee_id = manager_id;
    
-- Ex23
SELECT
    last_name,
    employee_id,
    manager_id
FROM
    employees
WHERE
    job_id <> 'IT_PROG'
START WITH
    last_name = 'King'
CONNECT BY PRIOR employee_id = manager_id
           AND last_name <> 'De Haan'