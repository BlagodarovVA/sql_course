-- 144 VIEW
select * from employees;

create view fin_emp AS
    select employee_id, job_id, salary from employees;

select * from fin_emp;

create view fin_emp2 AS
    select department_name, SUM(salary) as sum_salary from employees e
    JOIN departments d ON (e.department_id = d.department_id)
    group by department_name;
    
select * from fin_emp2;
select department_name from fin_emp2 where sum_salary > 10000;

create view emps_with_high_salary as
    select first_name, last_name from employees where salary>=10000;

select * from emps_with_high_salary;

update employees set salary = 15000 where first_name = 'Valery';

drop TABLE students;

CREATE TABLE students (
   id         NUMBER,
   name       VARCHAR2(15),
   course     NUMBER,
   email      VARCHAR2(15),
   faculty_id INTEGER
);

INSERT INTO students VALUES ( 1, 'Diana', 3, 'diana@doc.com', 1 );
INSERT INTO students VALUES ( 3, 'Valery', 4, 'valery@it.com', 2 );

-- 145 Simple и Complex
select * from students;

create view v101 as select name, course from students;
select * from v101;

insert into v101 values ('Fedor', 4);

delete from v101 where name ='Fedor';

alter table students modify (id not null);

insert into v101 values ('Fedor', 4);   -- не прокатит

select * from fin_emp2;

create view v106 as select distinct name, course from students;
select * from v106;

create view v107 as select name as n, course as с from students;
select * from v107;
alter table students modify (id null);
insert into v107 values ('Zinaida', 2);

create view v108 as select rownum r, name, course from students;
select * from v108;

-- 146 CREATE VIEW
select * from students;
drop TABLE students;

CREATE TABLE students (
   id         NUMBER,
   name       VARCHAR2(15),
   course     NUMBER
);

INSERT INTO students VALUES ( 1, 'Diana', 3);
INSERT INTO students VALUES ( 3, 'Valery', 4);
INSERT INTO students VALUES ( 2, 'Frosya', 2);
INSERT INTO students VALUES ( 4, 'Hamyak', 1);

create or replace VIEW fin_emp2 AS select * from students;
select * from fin_emp2;

create FORCE VIEW v201 AS select * from students111;

create FORCE VIEW v202 AS select * from students where course > 2;
select * from v202;
INSERT INTO v202 VALUES ( 5, 'Katya', 2);

create FORCE VIEW v203 AS select * from students where course > 2 WITH CHECK OPTION;
select * from v203;
INSERT INTO v203 VALUES ( 6, 'Ivan', 1);    -- не прокатит, т.к. чек не проходит
update v203 set course = 2 where name = 'Diana'; -- не прокатит, т.к. чек не проходит

create VIEW v204 AS select * from students WITH READ ONLY;
select * from v204;
update v204 set course = 5 where name = 'Ivan'; -- не прокатит, т.к. вьюха для чтения

create VIEW v205 (uniq_id, st_name, st_course) AS select * from students;
select * from v205;

-- 147 ALTER и DROP
create FORCE VIEW v18 AS select name, last_name from students;
select * from v18;

alter table students add (last_name varchar2(15));
alter view v18 compile;

drop view v18;

create VIEW v206 AS select * from v205;
select * from v206;

-- 148 SYNONYM

select * from hr.employees@xepdb1; -- полный путь можно заменить синонимом

create SYNONYM syn1 for students;
drop synonym syn1;

select * from syn1;

delete from syn1 where id = 5;


create PUBLIC SYNONYM syn1 for employees;

SELECT * FROM syn1;

DROP PUBLIC SYNONYM syn1;

ALTER SYNONYM syn1 compile;

-- 150 SEQUENCE

create sequence s1;

select s1.nextval from dual;    -- выдает следующее значение. уникально для всех сессий
select s1.currval from dual;    -- текущее значение, относится только к текущей сессии

drop table students;
drop table faculties;

create table students (
    id number,
    name varchar2(25),
    coutrse number,
    faculty_id integer
);

create table faculties (
    id number,
    name varchar2(25)
);

create sequence seq_st;
create sequence seq_faculty start with 20 increment by 5;

insert into faculties values(seq_faculty.nextval, 'IT' );

insert into students values(seq_st.nextval, 'Valery', 4, seq_faculty.currval);

insert into faculties values(seq_faculty.nextval, 'FKP' );
insert into faculties values(seq_faculty.nextval, 'FITU' );

insert into students values(seq_st.nextval, 'Diana', 3, 25);

select * from faculties;
select * from students;

create sequence s4 increment by 2 maxvalue 17 cycle cache 3;
select s4.nextval from dual;

create sequence s5 start with 7 increment by 4 maxvalue 17 cycle cache 2;
select s5.nextval from dual;

create table students (
    id number,
    name varchar2(25)
);

create sequence s10;
insert into students values (s10.nextval, 'Valery');
insert into students values (s10.nextval, 'Diana');

-- 151
create table seq (
    n number
);

insert into seq values(1);

DROP TABLE students;

CREATE TABLE students (
   id         NUMBER primary key,
   name       VARCHAR2(25)
);

insert into students values(
    (select n from seq),
    'Valery'
);
update seq set n = n + 1;
commit;

SELECT * FROM students;
SELECT * FROM seq;

alter sequence s10 increment by 5;

drop sequence s3;
DROP SEQUENCE s10;

-- 152 DZ

CREATE TABLE emp1000
   AS ( SELECT first_name,
                last_name,
                salary,
                department_id
           FROM employees
    );

select * from departments;
SELECT * FROM emp1000;

CREATE FORCE VIEW v1000 AS 
    SELECT first_name, last_name, salary, department_name, e.city FROM emp1000 e 
    JOIN departments d ON ( e.department_id = d.department_id );

alter table emp1000 add city varchar2(25);

alter view v1000 compile;

create SYNONYM syn1000 for v1000;

drop view v1000;

DROP SYNONYM syn1000;

drop table emp1000;

CREATE SEQUENCE seq1000 START WITH 12 INCREMENT BY 4 MAXVALUE 200 cycle;

alter SEQUENCE seq1000 nomaxvalue nocycle;

INSERT INTO employees (
   employee_id,
   last_name,
   email,
   hire_date,
   job_id
)
 VALUES ( seq1000.nextval,
           'Peven',
           'PEVEN',
           '11-AUG-2025',
           'AD_VP'
);

SELECT * FROM employees;

commit;

-- 153 ampersand substitution (&)
select first_name, last_name, salary
    from employees
    where employee_id = 130;

-- оракл спросит значение для ID - ampersand substitution
SELECT first_name, last_name, salary
    FROM employees
    WHERE employee_id = &ID;

SELECT first_name,
       last_name,
       salary
    FROM employees
    WHERE first_name = '&name'; -- для типа текст, чтобы не вводить кавычки позже

SELECT first_name, last_name, salary
    FROM employees
    WHERE first_name = '&namee'
    and salary > &sal;          -- 2 подстановка

-- 154 double ampersand substitution (&&)
SELECT first_name, last_name, salary
    FROM employees
    WHERE first_name like '%&bukva%'
    AND last_name like '%&bukva%';

SELECT first_name,
       last_name,
       salary
    FROM employees
    WHERE first_name LIKE '%&&bukva2%'  -- 2 амперсант спросит 1 раз значение
    AND last_name LIKE '%&bukva2%';

SELECT first_name,
       last_name,
       &vars1        -- оракл спросит название поля
  FROM employees
  order by &vars2;

SELECT first_name,
       last_name,
       &vars        -- оракл спросит название поля
  FROM employees
 ORDER BY &vars;

select &prodoljenie2;   -- при запросе дописать селект

SELECT &select_list     -- first_name, last_name, salary
    from &table_name    -- employees
    where &conditions   -- salary > 10000
    order by &col;      -- salary

select * from students;

update students set &col2 = &value2 where &condition2;

-- 155 DEFINE и UNDEFINE










