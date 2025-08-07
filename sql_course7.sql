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

















