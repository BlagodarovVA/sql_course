-- 104 INSERT
select * from employees;
select * from countries;
select * from regions;

INSERT into countries VALUES ('SW', 'Sweden', 1);
INSERT into countries VALUES ('GR', 'Greece');      -- ошибка, не все значения и не указаны столбцы
INSERT into countries (country_id, country_name) VALUES ('GR', 'Greece');   -- ошибки не будет
update countries set region_id = 1 where country_name = 'Greece';

INSERT into countries (country_id, country_name, region_id)     -- надежнее указывать поля
VALUES ('NR', 'Norway', 1);

INSERT into countries VALUES ('ID', 'Indonesia', null);

INSERT into countries (country_id, country_name, region_id)
VALUES ('LY', 'Lyagushatiya', 1);

-- 105 INSERT с функциями
select * from employees;

INSERT into employees (employee_id, last_name, email, hire_date, job_id)    -- так себе практика мнаписания
VALUES (210, 'Ignatik', 'IGNAT', '18-SEP-2019', 'SA_REP');

INSERT into employees (employee_id, last_name, email, hire_date, job_id)
VALUES (
    211, 
    INITCAP('zinkevich'), 
    UPPER('zinkevich'), 
    TO_DATE('18-SEP-2019', 'DD-MON-YYYY'), 
    UPPER('sa_rep')
);

INSERT into employees (employee_id, last_name, email, hire_date, job_id)
VALUES (
    (select max(employee_id) + 1 from employees), 
    INITCAP('volyina'), 
    UPPER('volyina'), 
    TO_DATE('03-AUG-2018', 'DD-MON-YYYY'), 
    UPPER('mk_REP')
);

-- 106 INSERT + SUBQUERY
create table nw_emps
(
emp_id integer,
name varchar2(20),
start_date date,
job varchar2(10)
);

INSERT into nw_emps (emp_id, name, start_date)
(select employee_id, first_name, hire_date from employees where employee_id > 200);

select * from nw_emps;

create table emps_with_high_salary(
    name varchar2(20),
    salary integer
);

create table emps_with_dept_100(
    name varchar2(20),
    salary integer
);

create table some_emps(
    name varchar2(20),
    salary integer
);

INSERT ALL
when department_id=100 THEN
INTO emps_with_dept_100 VALUES (first_name, salary)
when salary>15000 THEN
INTO emps_with_high_salary (name) VALUES (last_name)
when 5=5 THEN
INTO some_emps (name, salary) VALUES (first_name, salary)
select first_name, last_name, salary, department_id from employees
where LENGTH(first_name) > 5;

select * from employees where employee_id = 200;

-- 109 UPDATE
select * from EMPLOYEES;
UPDATE employees SET salary = 10000 where employee_id = 100;
UPDATE employees SET salary = salary * 2.5 where employee_id = 100;
UPDATE employees SET salary = 27000, job_id = 'IT_PROG' where employee_id = 101;
UPDATE employees SET salary = 8000 where employee_id > 105 and employee_id < 110;

-- 110 UPDATE SUBQUERY
UPDATE employees SET salary = 5000 where department_id IN
(select department_id from DEPARTMENTS where DEPARTMENT_NAME = 'Marketing');

UPDATE employees SET salary = (select MAX(salary) from employees),
hire_date = (select MIN(start_date) from JOB_HISTORY)
where employee_id = 180;

UPDATE employees SET salary = (select salary from employees where employee_id = 5)  -- если подзапрос ничего не вернет, то значение принимается null
where employee_id = 181;

-- 111 DELETE



















