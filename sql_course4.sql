-- 104 INSERT
select *
  from employees;
select *
  from countries;
select *
  from regions;

insert into countries values ( 'SW',
                               'Sweden',
                               1 );
insert into countries values ( 'GR',
                               'Greece' );      -- ошибка, не все значения и не указаны столбцы
insert into countries (
   country_id,
   country_name
) values ( 'GR',
           'Greece' );   -- ошибки не будет
update countries
   set
   region_id = 1
 where country_name = 'Greece';

insert into countries (
   country_id,
   country_name,
   region_id
)     -- надежнее указывать поля
 values ( 'NR',
           'Norway',
           1 );

insert into countries values ( 'ID',
                               'Indonesia',
                               null );

insert into countries (
   country_id,
   country_name,
   region_id
) values ( 'LY',
           'Lyagushatiya',
           1 );

-- 105 INSERT с функциями
select *
  from employees;

insert into employees (
   employee_id,
   last_name,
   email,
   hire_date,
   job_id
)    -- так себе практика мнаписания
 values ( 210,
           'Ignatik',
           'IGNAT',
           '18-SEP-2019',
           'SA_REP' );

insert into employees (
   employee_id,
   last_name,
   email,
   hire_date,
   job_id
) values ( 211,
           initcap('zinkevich'),
           upper('zinkevich'),
           to_date('18-SEP-2019','DD-MON-YYYY'),
           upper('sa_rep') );

insert into employees (
   employee_id,
   last_name,
   email,
   hire_date,
   job_id
) values ( (
   select max(employee_id) + 1
     from employees
),
           initcap('volyina'),
           upper('volyina'),
           to_date('03-AUG-2018','DD-MON-YYYY'),
           upper('mk_REP') );

-- 106 INSERT + SUBQUERY
create table new_emps (
   emp_id     integer,
   name       varchar2(20),
   start_date date,
   job        varchar2(10)
);

insert into new_emps (
   emp_id,
   name,
   start_date
)
   (
      select employee_id,
             first_name,
             hire_date
        from employees
       where employee_id > 200
   );

select *
  from new_emps;

create table emps_with_high_salary (
   name   varchar2(20),
   salary integer
);

create table emps_with_dept_100 (
   name   varchar2(20),
   salary integer
);

create table some_emps (
   name   varchar2(20),
   salary integer
);

insert
   all when department_id = 100 then
        into emps_with_dept_100
      values ( first_name,
               salary )
      when salary > 15000 then
           into emps_with_high_salary ( name )
         values ( last_name )
      when 5 = 5 then
           into some_emps (
            name,
            salary
         )
         values ( first_name,
                  salary )
select first_name,
       last_name,
       salary,
       department_id
  from employees
 where length(first_name) > 5;

select *
  from employees
 where employee_id = 200;

-- 109 UPDATE
select *
  from employees;
update employees
   set
   salary = 10000
 where employee_id = 100;
update employees
   set
   salary = salary * 2.5
 where employee_id = 100;
update employees
   set salary = 27000,
       job_id = 'IT_PROG'
 where employee_id = 101;
update employees
   set
   salary = 8000
 where employee_id > 105
   and employee_id < 110;

-- 110 UPDATE SUBQUERY
update employees
   set
   salary = 5000
 where department_id in (
   select department_id
     from departments
    where department_name = 'Marketing'
);

update employees
   set salary = (
   select max(salary)
     from employees
),
       hire_date = (
          select min(start_date)
            from job_history
       )
 where employee_id = 180;

update employees
   set
   salary = (
      select salary
        from employees
       where employee_id = 5
   )  -- если подзапрос ничего не вернет, то значение принимается null
 where employee_id = 181;

-- 111 DELETE
select *
  from new_emps;

delete from new_emps;    -- удалит все строки

insert into new_emps
   (
      select employee_id,
             first_name,
             hire_date,
             job_id
        from employees
   );

delete from new_emps
 where emp_id = 210;

delete from new_emps
 where job like '%CLERK%'
    or name is null;

-- 112 DELETE SUBQUERY
select *
  from new_emps;

delete from new_emps
 where job in (
   select distinct job_id
     from employees
    where department_id in (
      select department_id
        from departments
       where manager_id = 100
   )
);

-- 113 MERGE
delete from new_emps;
select *
  from employees;
select *
  from new_emps;

insert into new_emps
   (
      select employee_id,
             first_name,
             hire_date,
             job_id
        from employees
       where employee_id < 110
   );

merge into new_emps ne
using employees e on ( ne.emp_id = e.employee_id )
when matched then update
set ne.start_date = sysdate delete
 where ne.job like '%IT%'
when not matched then
insert (
   emp_id,
   name,
   start_date,
   job )
values
   ( employee_id,
     last_name,
     hire_date,
     job_id );

-- 116 COMMIT;
commit;  -- закончит транзакцию и внесет изменения

select *
  from new_emps;
delete from new_emps
 where name = 'Grant';
commit;
insert into new_emps values ( 1000,
                              'Igor',
                              sysdate,
                              'IT_Prog' );
update new_emps
   set
   emp_id = 300
 where emp_id = 100;
delete from new_emps
 where emp_id = 102;
commit;

-- 117 ROLLBACK
rollback;