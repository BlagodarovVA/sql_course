
-- 62 simple CASE
select 
    CASE 3*4
    when 12 then 'dvenadcat'
    END
from dual;

select 
    CASE 3*4
    when 11 then 'eleven'
    when 12 then 'twelve1'      -- �������� ������ ����������
    when 24/2 then '24/2'
    else 'net sovpadenij'       -- ������ ������ null
    END as case_statement
from dual;

select first_name,
    case length(first_name)
    when 4 then 'ochen korotkoe imya'
    when 5 then 'korotkoe imya'
    when 6 then 'srednej dlini imya'
    when 7 then 'dlinnoe imya'
    when 8 then 'ochen dlinnoe imya'
    else 'ne vhodit v perechen'
    end as case_St
from employees;

-- 63 searched CASE
select 
    CASE
    when 3*4=13 then 'twelve'   -- ������� � ������ when
    when 50/5=11 then 'ten'
    when  'ok'='ok' then 'OK'
    else 'net sovpadenij'
    END as "case statement"
from dual;

select first_name, salary, commission_pct,
    CASE
    when length(first_name)<=5 then 'usloviye #1'
    when salary * 10 > 100000 then 'usloviye #2'
    when commission_pct is not null then 'usloviye #3'
    else 'Ni odno usloviye ne srabotalo'
    end as case_st
from employees;

-- 64 dz
select * from employees where instr(lower(first_name), 'b') > 0;
select * from employees where instr(lower(first_name), 'a', 1, 2) > 0;

select department_name,
    substr(department_name, 0, instr(department_name, ' ')) 
    from DEPARTMENTS 
    where instr(department_name, ' ') > 0;
    
select first_name, 
    substr(first_name, 2, length(first_name)-2) 
    from employees;
    
select job_id, instr(job_id, '_'), substr(job_id, instr(job_id, '_') + 1) 
    from employees
    where substr(job_id, instr(job_id, '_') + 1) != 'CLERK' and length(substr(job_id, instr(job_id, '_') + 1)) > 2;

select * from employees 
    where substr(hire_date, 1, 2) = '01';

select * from employees 
    where substr(hire_date, 8, 9) = '08';
select * from employees 
    where TO_CHAR(hire_date, 'YYYY') = '2008';

select 'Tomorrow is '||TO_CHAR(sysdate + 8, 'DDspth "day of" Month') from dual;

select TO_CHAR(hire_date, 'DDth "of" fmMonth"," YYYY') from employees;

select last_name, salary, TO_CHAR(salary*1.2, '$999,999.99') as "+20%" from employees;

select sysdate as now,
    sysdate + 1/(24*60*60) as plus_sec,
    sysdate + 1/(24*60) as plus_min,
    sysdate + 1/(24) as plus_h,
    sysdate + 1 as plus_d,
    ADD_MONTHS(sysdate, 1) as plus_m,
    ADD_MONTHS(sysdate, 12) as plus_y
from dual;

select last_name, salary, salary + TO_NUMBER('$12,345.55', '$99999.99') as pribavka from employees;

select last_name, hire_date, 
    ROUND(MONTHS_BETWEEN(TO_DATE('SEP, 18:45:00 18 2009', 'MON, HH24:MI:SS dd yyyy'), hire_date), 1) as months_count 
from employees;

select last_name, salary, 
    TO_CHAR(salary + salary * NVL2(commission_pct, commission_pct, 0), '$99,999.99') as s_pribavkoy 
from employees;

select first_name, last_name,
    DECODE(length(first_name), length(last_name), 'same length', 'different length')as length 
from employees;

select last_name, commission_pct, NVL2(commission_pct, 'yes', 'no') as have_comission from employees;

select last_name, COALESCE(commission_pct, manager_id, salary) as info from employees;

select last_name, salary,
    case
    when salary < 5000 then 'Low level'
    when salary >= 5000 and salary < 10000 then 'Normal level'
    when salary >= 10000 then 'High level'
    END as "case statement"
from employees;

select country_name, decode(region_id, 1, 'Europe', 2, 'America', 3, 'Asia', 4, 'Africa') 
    as region from countries;

select country_name, 
    case region_id
    when 1 then 'Europe'
    when 2 then 'America'
    when 3 then 'Asia'
    when 4 then 'Africa'
    end as region 
from countries;

select last_name, salary, commission_pct,
    case
    when salary < 10000 and commission_pct is null then 'BAD'
    when salary >= 10000 and salary < 15000 or commission_pct is not null then 'NORMAL'
    when salary >= 15000 then 'GOOD'
    END as "case"
from employees;


