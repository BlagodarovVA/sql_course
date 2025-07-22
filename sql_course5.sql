-- 126 create table

CREATE TABLE students (
   student_id  INTEGER,
   name        VARCHAR2(15),
   start_date  DATE DEFAULT round(sysdate),
   scholarship NUMBER(6,2),
   avg_score   NUMBER(4,2) DEFAULT 5
);

SELECT *
  FROM students;

INSERT INTO students (
   student_id,
   name,
   start_date,
   scholarship,
   avg_score
) VALUES ( 1,
           'Valery',
           TO_DATE('02-JUL-25'),
           2500.5,
           7.5 );

INSERT INTO students (
   student_id,
   name,
   start_date,
   scholarship,
   avg_score
) VALUES ( 2,
           'Dmitry',
           TO_DATE('15-SEP-24'),
           2000.7,
           8 );

INSERT INTO students (
   student_id,
   name,
   scholarship
) VALUES ( 2,
           'Katya',
           1000 );

-- 127 CREATE TABLE subquery
SELECT *
  FROM new_emps2;

CREATE TABLE new_emps2
   AS
      (
         SELECT employee_id,
                first_name,
                last_name,
                salary,
                department_id
           FROM employees
      );

CREATE TABLE new_dep
   AS
      (
         SELECT department_name,
                MAX(salary) max_salary,
                MIN(salary) min_salary
           FROM employees e
           JOIN departments d
         ON ( e.department_id = d.department_id )
          GROUP BY department_name
      );

SELECT *
  FROM new_dep;

-- чтобы создать таблицу из другой не заполняя строки указать неверное условие
CREATE TABLE regions2
   AS
      (
         SELECT *
           FROM regions
          WHERE 5 = 6
      );
SELECT *
  FROM regions2;

-- 128 alter table
SELECT *
  FROM students;

ALTER TABLE students ADD (
   course NUMBER DEFAULT 3
);
ALTER TABLE students MODIFY (
   avg_score NUMBER(5,3)
);
ALTER TABLE students MODIFY (
   start_date default NULL
);

INSERT INTO students (
   student_id,
   name
) VALUES ( 4,
           'Ahmed' );

ALTER TABLE students DROP COLUMN scholarship;
ALTER TABLE departments DROP COLUMN department_id;
ALTER TABLE students SET UNUSED COLUMN start_date;
ALTER TABLE students DROP UNUSED COLUMNS;
ALTER TABLE students RENAME COLUMN student_id TO id;
ALTER TABLE students READ ONLY;
DROP TABLE students;

-- 129 TRUNCATE TABLE - очистка таблицы
TRUNCATE TABLE students;

-- 130 DROP TABLE - удаление таблицы
COMMIT;
SELECT *
  FROM students;

DROP TABLE students;