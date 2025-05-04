-- 104 INSERT
SELECT *
  FROM employees;
SELECT *
  FROM countries;
SELECT *
  FROM regions;

INSERT INTO countries VALUES ( 'SW',
                               'Sweden',
                               1 );
INSERT INTO countries VALUES ( 'GR',
                               'Greece' );      -- ошибка, не все значения и не указаны столбцы
INSERT INTO countries (
   country_id,
   country_name
) VALUES ( 'GR',
           'Greece' );   -- ошибки не будет
UPDATE countries
   SET
   region_id = 1
 WHERE country_name = 'Greece';

INSERT INTO countries (
   country_id,
   country_name,
   region_id
)     -- надежнее указывать поля
 VALUES ( 'NR',
           'Norway',
           1 );

INSERT INTO countries VALUES ( 'ID',
                               'Indonesia',
                               NULL );

INSERT INTO countries (
   country_id,
   country_name,
   region_id
) VALUES ( 'LY',
           'Lyagushatiya',
           1 );

-- 105 INSERT с функциями
SELECT *
  FROM employees;

INSERT INTO employees (
   employee_id,
   last_name,
   email,
   hire_date,
   job_id
)    -- так себе практика мнаписания
 VALUES ( 210,
           'Ignatik',
           'IGNAT',
           '18-SEP-2019',
           'SA_REP' );

INSERT INTO employees (
   employee_id,
   last_name,
   email,
   hire_date,
   job_id
) VALUES ( 211,
           initcap('zinkevich'),
           upper('zinkevich'),
           TO_DATE('18-SEP-2019','DD-MON-YYYY'),
           upper('sa_rep') );

INSERT INTO employees (
   employee_id,
   last_name,
   email,
   hire_date,
   job_id
) VALUES ( (
   SELECT MAX(employee_id) + 1
     FROM employees
),
           initcap('volyina'),
           upper('volyina'),
           TO_DATE('03-AUG-2018','DD-MON-YYYY'),
           upper('mk_REP') );

-- 106 INSERT + SUBQUERY
CREATE TABLE new_emps (
   emp_id     INTEGER,
   name       VARCHAR2(20),
   start_date DATE,
   job        VARCHAR2(10)
);

INSERT INTO new_emps (
   emp_id,
   name,
   start_date
)
   (
      SELECT employee_id,
             first_name,
             hire_date
        FROM employees
       WHERE employee_id > 200
   );

SELECT *
  FROM new_emps;

CREATE TABLE emps_with_high_salary (
   name   VARCHAR2(20),
   salary INTEGER
);

CREATE TABLE emps_with_dept_100 (
   name   VARCHAR2(20),
   salary INTEGER
);

CREATE TABLE some_emps (
   name   VARCHAR2(20),
   salary INTEGER
);

INSERT
   ALL WHEN department_id = 100 THEN
        INTO emps_with_dept_100
      VALUES ( first_name,
               salary )
      WHEN salary > 15000 THEN
           INTO emps_with_high_salary ( name )
         VALUES ( last_name )
      WHEN 5 = 5 THEN
           INTO some_emps (
            name,
            salary
         )
         VALUES ( first_name,
                  salary )
SELECT first_name,
       last_name,
       salary,
       department_id
  FROM employees
 WHERE length(first_name) > 5;

SELECT *
  FROM employees
 WHERE employee_id = 200;

-- 109 UPDATE
SELECT *
  FROM employees;
UPDATE employees
   SET
   salary = 10000
 WHERE employee_id = 100;
UPDATE employees
   SET
   salary = salary * 2.5
 WHERE employee_id = 100;
UPDATE employees
   SET salary = 27000,
       job_id = 'IT_PROG'
 WHERE employee_id = 101;
UPDATE employees
   SET
   salary = 8000
 WHERE employee_id > 105
   AND employee_id < 110;

-- 110 UPDATE SUBQUERY
UPDATE employees
   SET
   salary = 5000
 WHERE department_id IN (
   SELECT department_id
     FROM departments
    WHERE department_name = 'Marketing'
);

UPDATE employees
   SET salary = (
   SELECT MAX(salary)
     FROM employees
),
       hire_date = (
          SELECT MIN(start_date)
            FROM job_history
       )
 WHERE employee_id = 180;

UPDATE employees
   SET
   salary = (
      SELECT salary
        FROM employees
       WHERE employee_id = 5
   )  -- если подзапрос ничего не вернет, то значение принимается null
 WHERE employee_id = 181;

-- 111 DELETE
SELECT *
  FROM new_emps;

DELETE FROM new_emps;    -- удалит все строки

INSERT INTO new_emps
   (
      SELECT employee_id,
             first_name,
             hire_date,
             job_id
        FROM employees
   );

DELETE FROM new_emps
 WHERE emp_id = 210;

DELETE FROM new_emps
 WHERE job LIKE '%CLERK%'
    OR name IS NULL;

-- 112 DELETE SUBQUERY
SELECT *
  FROM new_emps;

DELETE FROM new_emps
 WHERE job IN (
   SELECT DISTINCT job_id
     FROM employees
    WHERE department_id IN (
      SELECT department_id
        FROM departments
       WHERE manager_id = 100
   )
);

-- 113 MERGE
DELETE FROM new_emps;
SELECT *
  FROM employees;
SELECT *
  FROM new_emps;

INSERT INTO new_emps
   (
      SELECT employee_id,
             first_name,
             hire_date,
             job_id
        FROM employees
       WHERE employee_id < 110
   );

MERGE INTO new_emps ne
USING employees e ON ( ne.emp_id = e.employee_id )
WHEN MATCHED THEN UPDATE
SET ne.start_date = sysdate DELETE
 WHERE ne.job LIKE '%IT%'
WHEN NOT MATCHED THEN
INSERT (
   emp_id,
   name,
   start_date,
   job )
VALUES
   ( employee_id,
     last_name,
     hire_date,
     job_id );

-- 116 COMMIT;
COMMIT;  -- закончит транзакцию и внесет изменения

SELECT *
  FROM new_emps;
DELETE FROM new_emps
 WHERE name = 'Grant';
COMMIT;
INSERT INTO new_emps VALUES ( 1000,
                              'Igor',
                              sysdate,
                              'IT_Prog' );
UPDATE new_emps
   SET
   emp_id = 300
 WHERE emp_id = 100;

DELETE FROM new_emps
 WHERE emp_id = 102;
COMMIT;

-- 117 ROLLBACK
ROLLBACK;

SELECT *
  FROM new_emps;
DELETE FROM new_emps;

INSERT INTO new_emps
   (
      SELECT employee_id,
             last_name,
             hire_date,
             job_id
        FROM employees
   );
COMMIT;

DELETE FROM new_emps
 WHERE name = 'Zinkevich';
INSERT INTO new_emps VALUES ( 1000,
                              'Igor',
                              sysdate,
                              'IT_Prog' );
UPDATE new_emps
   SET
   emp_id = 300
 WHERE emp_id = 100;
DELETE FROM new_emps
 WHERE emp_id = 101;
ROLLBACK;

-- 118 SAVEPOINT
SELECT *
  FROM new_emps;
DELETE FROM new_emps;

INSERT INTO new_emps VALUES ( 1000,
                              'Igor',
                              sysdate,
                              'IT_Prog' );
SAVEPOINT s1;

UPDATE new_emps
   SET
   emp_id = 300
 WHERE emp_id = 100;
SAVEPOINT s2;

DELETE FROM new_emps
 WHERE emp_id = 101;

ROLLBACK TO SAVEPOINT s2;
SELECT *
  FROM new_emps;

-- 119 AUTOCOMMIT
   set autocommit on;
set autocommit off;

-- 120 SELECT FOR UPDATE
SELECT *
  FROM new_emps
FOR UPDATE;  -- строки запроса лочатся для изменения

UPDATE new_emps
   SET
   emp_id = 1500
 WHERE emp_id = 104;
COMMIT;                -- commit или rollback завершает транзакцию и снимает лок с записей

-- 121 dz
CREATE TABLE locations2
   AS
      (
         SELECT *
           FROM locations
          WHERE 1 = 2
      );

INSERT INTO locations2 (
   location_id,
   street_address,
   city,
   country_id
) VALUES ( 1001,
           'Makaronnik str',
           'Big makarona',
           'IT' );

INSERT INTO locations2 (
   location_id,
   street_address,
   city,
   country_id
) VALUES ( 1002,
           'Pizza str',
           'Rome',
           'IT' );
COMMIT;

SELECT *
  FROM locations2;

INSERT INTO locations2 VALUES ( (
   SELECT MAX(location_id) + 1
     FROM locations2
),
                                initcap('shokoladniy kruasan str'),
                                256887,
                                upper('paris'),
                                initcap('zhabka parafiya'),
                                'FR' );
INSERT INTO locations2 VALUES ( (
   SELECT MAX(location_id) + 1
     FROM locations2
),
                                initcap('lyagushka str'),
                                256887,
                                upper('marsel'),
                                initcap('taxi fed.'),
                                'FR' );
COMMIT;

INSERT INTO locations2
   (
      SELECT *
        FROM locations
       WHERE length(locations.state_province) > 9
   );

COMMIT;

CREATE TABLE locations4europe
   AS
      (
         SELECT *
           FROM locations
          WHERE 1 = 2
      );