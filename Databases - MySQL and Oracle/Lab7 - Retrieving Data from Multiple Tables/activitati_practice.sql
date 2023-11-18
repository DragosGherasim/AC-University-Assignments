-- Ex1
SELECT 
    last_name,
    department_id,
    department_name
FROM employees 
JOIN departments USING (department_id);

-- Ex2
SELECT
    DISTINCT(job_id),
    location_id
FROM employees
JOIN departments USING (department_id)
WHERE department_id = 80;

-- Ex3
SELECT
    last_name,
    department_name,
    location_id,
    city
FROM employees 
JOIN departments  USING (department_id)
JOIN locations USING (location_id)
WHERE commission_pct IS NOT NULL;

-- Ex4
SELECT
    last_name,
    department_name
FROM employees
JOIN departments USING (department_id)
WHERE last_name LIKE '%a%'; // INSTR(LOWER(last_name), 'a') != 0;

-- Ex5
SELECT
    last_name,
    job_id,
    department_id,
    department_name
FROM employees
JOIN departments USING (department_id)
JOIN locations USING (location_id)
WHERE city IN ('Toronto');

-- Ex6
SELECT
    emp.last_name AS "Employee",
    emp.employee_id AS "EMP#",
    manag.last_name AS "Manager",
    manag.employee_id AS "Mgr#"
FROM employees emp
JOIN employees manag
ON emp.manager_id = manag.employee_id;

-- Ex7
SELECT
    emp.last_name AS "Employee",
    emp.employee_id AS "EMP#",
    manag.last_name AS "Manager",
    manag.employee_id AS "Mgr#"
FROM employees emp
RIGHT JOIN employees manag
ON emp.manager_id = manag.employee_id;

-- Ex8
SELECT
    emp.department_id AS "DEPARTMENT",
    emp.last_name AS "EMPLOYEE",
    clg.last_name AS "COLLEGUE"
FROM employees emp
JOIN employees clg
ON emp.department_id = clg.department_id AND
    emp.last_name <> clg.last_name;
    
-- Ex9
DESCRIBE job_grades;

SELECT
    last_name,
    job_id,
    department_name,
    salary,
    grade_level as "GRA"
FROM employees
JOIN departments USING (department_id)
JOIN job_grades ON salary BETWEEN lowest_sal AND highest_sal;

-- Ex10
SELECT
    last_name,
    hire_date
FROM employees
WHERE hire_date > (
    SELECT hire_date
    FROM employees
    WHERE last_name = 'Davies'
    );

-- Ex11
SELECT
    emp.last_name AS "EMPLOYEE",
    emp.hire_date AS "EMP Hiredate",
    mang.last_name AS "Manager",
    mang.hire_date AS "Mgr Hiredate"
FROM employees emp
JOIN employees mang
ON emp.manager_id = mang.employee_id AND
    emp.hire_date < mang.hire_date;