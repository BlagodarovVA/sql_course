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

























