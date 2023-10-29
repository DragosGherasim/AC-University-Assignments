/*1 .Creaţi tabelul DEPT bazat pe structura din tabelul următor. Salvaţi instrucţiunea în scriptul p1.sql , executaţi scriptul şi verificaţi.
Column Name Id Name
Datatype Number Varchar2
Length 7 25 */

CREATE TABLE dept (
    Id NUMBER(7),
    Name VARCHAR2(25)
);

-- 2. Introduceţi înregistrări în tabela DEPT din tabela DEPARTMENTS. Includeți doar coloanele de care aveţi nevoie.

INSERT INTO dept (Id, Name)
SELECT department_id, department_name
FROM departments;

-- Alta abordare pt 1 si 2

CREATE TABLE dept AS
    SELECT
        department_id Id,
        department_name Name
    FROM
        departments;
		
ALTER TABLE dept
MODIFY Id NUMBER(7);

ALTER TABLE dept
MODIFY Name VARCHAR2(25);

/*3. Creaţi tabela EMP bazata pe tabelul următor. Salvaţi instrucţiunea într-un script p3.sql şi apoi executaţi scriptul. Verificaţi existența tabelei.
Column Name ID LAST_NAME FIRST_NAME DEPT_ID
Datatype Number Varchar2 Varchar2 Number
Length 7 25 25 7 */ 

CREATE TABLE EMP (
    ID NUMBER(7),
    LAST_NAME VARCHAR2(25),
    FIRST_NAME VARCHAR2(25),
    DEPT_ID NUMBER(7)
);

-- 4. Modificaţi tabela EMP pentru a permite nume mai lungi în coloana Last_name. Verificaţi efectuarea modificării. 

ALTER TABLE EMP
MODIFY LAST_NAME VARCHAR2(30);

-- 5. Asiguraţi-vă că cele două tabele create sunt stocate de dicţionarul de date. 

SELECT table_name
FROM user_tables
WHERE table_name IN ('dept', 'EMP');

-- 6. Creaţi tabela EMPLOYEE2 bazată pe structura tabelei EMP, incluzând doar coloanele ID, LAST_NAME, DEPT_ID Redenumiţi coloanele în noua tabela astfel: EMPNO, ENAME și DEPTNO.

CREATE TABLE EMPLOYEE2 AS
SELECT
    ID EMPNO,
    LAST_NAME ENAME,
    DEPT_ID DEPTNO
FROM
    EMP;
	
-- 7. Redenumiţi tabela EMPLOYEE2 în EMPLOYEE3. 
RENAME EMPLOYEE2 TO EMPLOYEE3;

-- 8. Ştergeţi tabela EMPLOYEE3. 
DROP TABLE EMPLOYEE3;

-- 9 Adăugaţi o constrângere de tip PRIMARY KEY la tabela EMP folosind coloana ID.
ALTER TABLE EMP
ADD CONSTRAINT emp_id_pk PRIMARY KEY (ID);

-- 10. Creaţi o constrângere PRIMARY KEY în tabela DEPT folosind coloana ID. 
ALTER TABLE DEPT
ADD CONSTRAINT dept_id_pk PRIMARY KEY (ID);

-- 11. Adăugaţi o referinţă de tip cheie externă la tabela EMP care va asigura ca angajaţii nu sunt asignaţi unui departament inexistent.
ALTER TABLE EMP
ADD CONSTRAINT emp_dept_id_fk FOREIGN KEY (DEPT_ID)
REFERENCES DEPT (ID);

-- 12. Confirmaţi constrângerile adăugate interogând tabela USER_CONSTRAINTS. Observaţi numele şi tipul constrângerilor.
SELECT constraint_name, constraint_type
FROM user_constraints
WHERE table_name IN ('DEPT', 'EMP'); 

-- 13. Afişaţi numele şi tipul obiectelor din dicţionarul USER_OBJECTS al tabelelor EMP şi DEPT. Observaţi că a fost creat un nou tabel precum şi un nou index. 
SELECT object_name, object_type
FROM user_objects
WHERE object_name = 'EMP' OR
    object_name LIKE 'EMP\_%' ESCAPE '\' OR
    object_name LIKE 'DEPT%';

-- 14. Modificaţi tabela EMP. Adăugaţi o coloana SALARY de tip NUMBER, precizie 7.
ALTER TABLE EMP
ADD SALARY NUMBER(7); 

-- 15. Ştergeţi coloana FIRST_NAME din tabela EMP. Confirmaţi modificările efectuate prin verificarea descrierii tabelei.
ALTER TABLE EMP
DROP COLUMN FIRST_NAME; 

DESCRIBE EMP;

-- 16. Marcaţi ca fiind nefolosită coloana DEPT_ID din tabela EMP. Confirmaţi modificările efectuate prin verificarea descrierii tabelei. 
ALTER TABLE EMP
SET UNUSED (ID);

DESCRIBE EMP;

-- 17. Ştergeţi toate coloanele nefolosite din tabela EMP. Confirmaţi modificările efectuate prin verificarea descrierii tabelei. 
ALTER TABLE EMP
DROP UNUSED COLUMNS;

DESCRIBE EMP;