select last_name, salary, salary*1.3 as bonus from employees;

SELECT commission_pct, commission_pct/2 FROM employees;

SELECT
    start_date, end_date, end_date - start_date + 1 as worktime
FROM job_history;

SELECT start_date, start_date + 7
FROM job_history;

SELECT
    'First and last name and $: '||first_name||' '||last_name||' - '||salary as "Alias Name"
FROM employees;


--16
select * from regions;
select first_name, department_id, salary, last_name from employees;
select employee_id, email, hire_date - 7 as "One week before hire date" from employees;
select first_name || '(' || LOWER (job_id) || ')' our_employees from employees;
SELECT DISTINCT first_name from employees;
SELECT 
    job_title, 
    'min = '||min_salary||', max = '||max_salary as info, 
    max_salary as max, 
    max_salary*2-2000 as new_salary 
    from jobs;
SELECT 'Peter''s dog is very clever' as message from dual;
SELECT q'<Peter's dog is very clever>' as message from dual;

SELECT 100*365.25*24*60 from dual;

--17
select first_name, last_name, salary from employees WHERE salary >= 15000;
select first_name, last_name, hire_date from employees WHERE hire_date >= '01.01.08';
select * from departments WHERE location_id = 3300;
select * from employees WHERE employee_id = manager_id;

select * from employees WHERE 'Dr '||first_name||' '||last_name = 'Dr Lex De Haan';
select first_name, last_name, salary from employees WHERE salary >= (SELECT salary from employees where last_name = 'Russell');
select * from employees WHERE first_name>'Steven';

select * from job_history where start_date < '01.01.05';

select first_name, last_name, salary from employees WHERE salary BETWEEN 7000 and 10000;

select * from job_history where start_date BETWEEN '01.01.06' and '31.12.07';

select * from employees WHERE first_name BETWEEN 'A' and 'D';

--19
select * from departments WHERE location_id in (2400, 3300);
select * from job_history where job_id in ('IT_PROG', 'ST_CLERK');

select * from employees WHERE commission_pct is null;
select * from employees WHERE commission_pct is not null;

--20 LIKE
select * from employees;
select * from employees where first_name LIKE 'S%';
select * from employees where first_name LIKE 'A%d%';
select * from employees where first_name LIKE 'D_n';

select * from employees where job_id LIKE 'ST_%';
select * from employees where job_id LIKE 'ST\_%' escape '\';

--21 AND
select * from employees where first_name like 'D%' and salary > 9000;

--22 OR
select * from employees where first_name like 'D%' or salary > 15000;

--23 NOT
select * from employees where NOT job_id = 'ST_CLERK';
select * from employees where NOT last_name like 'M%';
select * from employees where commission_pct is not null and NOT job_id in ('ST_CLERK', 'SA_REP');

--25 ORDER BY
select first_name, salary from employees where job_id = 'IT_PROG' ORDER BY salary DESC;
select first_name, salary, hire_date from employees where job_id = 'IT_PROG' ORDER BY hire_date ASC;
select last_name, salary, hire_date, hire_date + salary*2 as expr
    from employees 
    where employee_id>170
    ORDER BY expr;

select * from employees ORDER BY commission_pct DESC nulls last;
select * from employees ORDER BY commission_pct DESC nulls first;

select first_name, salary from employees where job_id = 'IT_PROG' ORDER BY 2;

select job_id, first_name, last_name, salary, hire_date 
from employees
order by job_id desc, last_name, 4 DESC;

--27
select * from employees where first_name = 'David';
select * from employees where job_id = 'FI_ACCOUNT';
select first_name, last_name, salary, department_id from employees 
    where department_id = 50 and salary > 4000;
select * from employees where department_id in (20, 30);
select * from employees where first_name like '_a%a';
select * from employees 
    where department_id in (50, 80) and commission_pct is not null
    ORDER by 4;
select * from employees where first_name like 'N%n%' or first_name like '%n%n%';
select * from employees where first_name like '_____%'
    ORDER by department_id DESC nulls last;
select *from employees 
    where salary BETWEEN 3000 and 7000 
    and commission_pct is null 
    and job_id in ('PU_CLERK', 'ST_MAN', 'ST_CLERK');
select * from employees where first_name like '%\%%' ESCAPE '\';
select employee_id, job_id, first_name, salary
    from employees 
    where employee_id >= 120 and job_id != 'IT_PROG'
    ORDER by job_id, first_name DESC;

--29 lower
select first_name, LOWER(first_name) from employees;
select LOWER ('Privet, ' || 'KAK DELa? 888') from dual;
select * from employees where LOWER(first_name) = 'david';
select * from employees where LOWER(first_name) like '%en%';
select LOWER ('PriveT, ' || 'Skolko tebe LET? ' || '34') from dual;

--30 UPPER
select first_name, UPPER(first_name) from employees;
select UPPER ('Privet, ' || 'KAK DELa? 888') from dual;
select * from employees where UPPER(first_name) = 'DAVID';
select * from employees where UPPER(first_name) like '%EN%';
select UPPER ('PriveT, ' || 'Skolko tebe LET? ' || '34') from dual;

--31 INITCAP
select email, INITCAP(email) from employees;
select INITCAP ('Privet, ' || 'KAK DELa? 888') from dual;
select * from employees where INITCAP(first_name) = 'David';
select INITCAP ('PriveT, ' || 'Skolko tebe LET? ' || '34') from dual;

-- 32 CONCAT - �� ��, ��� � ||
SELECT CONCAT('Privet, ', 'drug') from dual;
SELECT CONCAT(555, ' ��� �����') from dual; 
SELECT CONCAT('��� ���� - ', hire_date) from employees;

SELECT SYSDATE from dual;
SELECT CONCAT('������ ', CONCAT('��� ', '����')) from dual;

--33 LENGTH
select first_name, LENGTH(first_name) as dlina from employees;
SELECT LENGTH('Valery Blagodarov') from dual;
SELECT country_name FROM countries where LENGTH(country_name) < 6;

-- 34 LPAD � RPAD
select LPAD('Valery', 8, '#') from dual;
select RPAD('Valery', 8, '#') from dual;
select first_name, LPAD(first_name, 15, '$') as newName from employees;
select first_name, RPAD(first_name, 15, '$') as newName from employees;
select first_name, RPAD(first_name, 15, '���') as newName from employees;
select RPAD('Privetstvuyu', 7, '#') from dual;

select RPAD(first_name, 12, ' ') || LPAD(salary, 6, ' ') as newField from employees;

-- 35 TRIM
select TRIM(trailing 'q' from 'Valery qqq') from dual;
select TRIM(leading '*' from '****Valery**') from dual;
select TRIM(both '*' from '****Valery**') from dual;
-- ��� ���
select TRIM('*' from '****Valery**') from dual;
select TRIM(7 from '775627') from dual;

-- 36 INSTR - ������� ������� ������� (��� ����, ��� ����, ������� � ������ 
--            �������, ����� ���������� �� �����). ������������ 1 � 2 ���������.
select * from employees where INSTR(job_id, 'PROG')=4;
select * from employees where INSTR(hire_date, '05')=4;
select * from employees where INSTR(salary, '2')=2;
select INSTR('Valery Blagodarov', 'l') from dual;
select INSTR('Valery Blagodarov', 'l', 4) from dual;
select INSTR('Valery Blagodarov', 'l', 2, 2) from dual;

-- 37 SUBSTR
select email, SUBSTR(email, 4, 2) from employees;
select SUBSTR('privet, kak dela?', 5, 100) from dual;
select salary, SUBSTR(salary, 2, 3) from employees;
select SUBSTR('privet, kak dela?', -5) from dual;

-- 38 REPLACE
select REPLACE('privet, kak dela? Chto tebe nado?', 'e', 'ii') from dual;
select REPLACE('privet, kak dela? Chto tebe nado?', 'e') from dual;
select salary, REPLACE(salary, 1, 9) from employees;
select hire_date, REPLACE(hire_date, '.', '/') from employees;

--39 ROUND
select ROUND(124.659822, 3) from dual;
select ROUND(124.659822) from dual;
select salary * 0.4237, ROUND(salary * 0.4237, 1) from employees;
select ROUND(35874, -2) from dual;
select first_name, ROUND((sysdate - hire_date) + employee_id) as digi from employees;

-- 40 TRUNC
select TRUNC(124.659822, 3) from dual;
select ROUND(35874, -2) from dual;

-- 41 MOD
select MOD(8, 3) from dual;     -- 2
select MOD(8, 10) from dual;    -- 8
select MOD(3.1, 2.2) from dual;    -- 0.9

select * from employees where MOD(employee_id, 2) = 0;
select employee_id, first_name, last_name, MOD(employee_id, 3)+1 as Team 
from employees;

-- 42
select * from job_history;
select * from nls_session_parameters WHERE parameter = 'NLS_DATE_FORMAT';

-- 43 SYSDATE
select sysdate from dual;
select TO_CHAR(SYSDATE, 'DD-MM-RR hh24:mi:ss') from dual;   -- �������� ���� � �����
select sysdate-hire_date from employees;
select sysdate, sysdate + 5, sysdate + 5.5 from dual;

-- 44 MONTHS_BETWEEN
select employee_id, MONTHS_BETWEEN(end_date, start_date) from job_history;
select MONTHS_BETWEEN('12.02.20', '05.01.19') from dual;
select MONTHS_BETWEEN('17.01.25', '15.01.25')*31 from dual; --2
select * from employees where MONTHS_BETWEEN('01.01.10', hire_date) > 60;

-- 45 ADD_MONTHS
select * from job_history;
select end_date, ADD_MONTHS(end_date, 4) from job_history;
-- ������� � ���������� �� ��������� ���� ���������� ������
select ADD_MONTHS('30.09.19', 1) from dual;
select ADD_MONTHS('31.12.24', 2) from dual; 

-- 46 NEXT_DAY
select NEXT_DAY('17.01.25', 5) from dual;   -- 17-JAN-25 - �������� ���� � ������������ ��
select NEXT_DAY(SYSDATE, 3) from dual;      -- ��������� �����
select NEXT_DAY(SYSDATE, '�����������') from dual;
select NEXT_DAY(SYSDATE, '��') from dual;
select NEXT_DAY('31.12.25', '��')-7 from dual;  -- ��������� �� ����

-- 47 LAST_DAY
select LAST_DAY(SYSDATE) from dual;
select LAST_DAY('17.02.25') from dual;
SELECT hire_date, last_day(hire_date) - hire_date as Otrabotal_dney FROM employees;

-- 48 ROUND
SELECT hire_date, 
    ROUND(hire_date, 'CC') as year100,
    ROUND(hire_date, 'YYYY') as year,
    ROUND(hire_date, 'Q') as quarter,
    ROUND(hire_date, 'MM') as month
    FROM employees where employee_id in (120, 121, 122, 123);

-- 49 TRUNC
SELECT hire_date, 
    TRUNC(hire_date, 'CC') as year100,
    TRUNC(hire_date, 'YYYY') as year,
    TRUNC(hire_date, 'Q') as quarter,
    TRUNC(hire_date, 'MM') as month
    FROM employees where employee_id in (120, 121, 122, 123);

-- 50
select * from employees where LENGTH(first_name) > 10;

select * from employees where MOD(salary, 1000) = 0;

select phone_number, SUBSTR(phone_number, 1, 3) 
    from employees where phone_number LIKE '___.___.____';
    
select * from employees 
    where LENGTH(first_name) > 5 and SUBSTR(first_name, -1) = 'm';
    
select NEXT_DAY('21.01.25', 5) from dual;

select hire_date, last_name, MONTHS_BETWEEN(SYSDATE, hire_date) as months from employees 
    where MONTHS_BETWEEN(SYSDATE, hire_date) > 250;
    
select phone_number, REPLACE(phone_number, '.', '-') as newNumber from employees;

select UPPER(first_name), LOWER(email), INITCAP(job_id) from employees;

select CONCAT(first_name, salary) from employees;

select hire_date, 
    ROUND(hire_date, 'MM') as month, 
    TRUNC(hire_date, 'YYYY') as year 
    from employees;
    
select RPAD(first_name, 10, '$'), LPAD(last_name, 15, '!')  from employees;

select first_name, INSTR(first_name, 'a', 1, 2) as Pos_2_A from employees;

select '!!!HELLO!! MY FRIEND!!!!!!!!', TRIM('!' from '!!!HELLO!! MY FRIEND!!!!!!!!') from dual;

select salary, 
    salary*3.1415, 
    ROUND(salary*3.1415, 0), 
    ROUND(salary*3.1415, -3)/1000
    from employees;
    
select hire_date, 
    ADD_MONTHS(hire_date, 6),
    LAST_DAY(hire_date)
    from employees;

-- 51
select LENGTH(123) from dual;
select SYSDATE, LENGTH(SYSDATE) from dual;
select ADD_MONTHS('21.01.25', 3) from dual;
select ADD_MONTHS('21/01*25', 3) from dual;     -- ��������� ����� ���� ����� ��� �������� NLS
-- ���� ��������� NLS
select ADD_MONTHS('21-JAN-25', 3) from dual;
select NEXT_DAY('21-JAN-25', 2) from dual;      -- ��� ���� NLS �� - ��� 2 ���� ������

-- 52 TO_CHAR ��� �����
select TO_CHAR(255, '99') from dual;                -- ������������ ������
select TO_CHAR(255, '0999') from dual;              -- ����������� ����� �������
select TO_CHAR(255.35, '09999.999') from dual;      -- ������� ���������� �����
select TO_CHAR(255.35, '09999D999') from dual;      -- �� ��, ��� � ������� ���������� �����
select TO_CHAR(1234567, '099,999,999') from dual;   -- ������� ���������� �������
select TO_CHAR(1234567, '099G99G9G999') from dual;  -- ��������� �� �������
select TO_CHAR(255, '$0999') from dual;             -- ���������� $
select TO_CHAR(255, '0999L') from dual;             -- ���������� ����� ��������� ������
select TO_CHAR(-255, '0999MI') from dual;           -- ������� ������ �������������� �����
select TO_CHAR(-255, '0999PR') from dual;           -- ���� ����� �������������, �� ����� ����� � ������ <>
select TO_CHAR(255, 'S0999') from dual;             -- ������� ������� + ��� - ����� �����

select first_name, salary*1.11111111,
    TO_CHAR(salary*1.11111111, '$999,999.99'),
    TO_CHAR(salary*1.11111111, '$9,999.99')
    from employees;

-- 53 TO_CHAR ��� ����
select TO_CHAR('23-SEP-83') from dual;

select TO_CHAR(SYSDATE, 'YY') from dual;    -- ��� 2025: Y - 5, Y - 25 � �.�
select TO_CHAR(SYSDATE, 'RR') from dual;    -- ������ YY
select TO_CHAR(SYSDATE, 'Year') from dual;  -- ��� �������. ����������������� ������
select TO_CHAR(SYSDATE, 'MM') from dual;    -- ����� � ������� 2 ����
select TO_CHAR(SYSDATE, 'Mon') from dual;   -- 3 ����� �� �������� ������. �����������������
select TO_CHAR(SYSDATE, 'Month') from dual; -- ��������� ��������� ������. �����������������

select hire_date, TO_CHAR(hire_date, 'Month', 'NLS_DATE_LANGUAGE = RUSSIAN') from employees;
select hire_date, TO_CHAR(hire_date, 'Month')||'_Hello!' from employees;    -- ������������� ����������� �������
select hire_date, TO_CHAR(hire_date, 'fmMonth')||'_Hello!' from employees;  -- fm - ������� �� �����������

select last_name, hire_date from employees WHERE TO_CHAR(hire_date, 'fmMonth') = 'August' ;

select TO_CHAR(SYSDATE, 'D') from dual;     -- ���� ������
select TO_CHAR(SYSDATE, 'DD') from dual;    -- ���� ������
select TO_CHAR(SYSDATE, 'DDD') from dual;   -- ���� ����
select TO_CHAR(SYSDATE, 'Dy') from dual;    -- 3 ����� ��� ������. �����������������
select TO_CHAR(SYSDATE, 'Day') from dual;   -- ������ �������� ��� ������. �����������������
select TO_CHAR(SYSDATE, 'W') from dual;     -- ������ ������
select TO_CHAR(SYSDATE, 'WW') from dual;    -- ������ ����
select TO_CHAR(SYSDATE, 'Q') from dual;     -- �������
select TO_CHAR(SYSDATE, 'CC') from dual;    -- ���

select TO_CHAR(SYSDATE, 'PM') from dual;    -- AM, PM, P.M., A.M - ��������� ������� ���������
select TO_CHAR(SYSDATE, 'HH24') from dual;  -- HH, HH:MI, HH12, HH24 - ���������� � ������� � ������ �������
select TO_CHAR(SYSDATE, 'HH:MI:SS') from dual;    -- �����, ����� ��� � ��� �� ����������� �������
select TO_CHAR(SYSDATE, 'SSSSS') from dual;    -- ������� ����� ��������
select TO_CHAR(SYSDATE, 'fmDAY,Mon,yyyy!') from dual;    -- �� ������� ����������
select TO_CHAR(SYSDATE, '"Quarter" Q "of" YYYY "year"') from dual;    -- ������� ������
select TO_CHAR(SYSDATE, 'DDth "of" mm') from dual;    -- ��������� th ��� st ��������� � �����
select TO_CHAR(SYSDATE, 'yyyysp, mmsp') from dual;    -- sp - ������� �������
select TO_CHAR(SYSDATE, 'SSthsp') from dual;    -- ���������� th � sp
select TO_CHAR(SYSDATE, 'CC') from dual;    -- ���

select 'my colleague with ID = ' || employee_id || ' and job_id = ' || job_id || ' joined us on ' || 
TO_CHAR(hire_date, 'Day "the" ddTH "of" fmMonth YYYY') from employees;

-- 54 TO_DATE
select TO_DATE('28-jan?25') from dual;  -- ����� ������ ������� ������������
select TO_CHAR(TO_DATE('28-jan?25'), 'dd-mon-yyyy hh24:mi:ss') from dual;   -- ����� 00:00 �� ���������
select TO_DATE('28-jan-2025 18:30') from dual;  -- ����� ��� ������� ������
select TO_DATE('18:30 2025-jan-28', 'HH24:MI yyyy-mon-dd') from dual;   -- ����������� � ���� �� �������
select TO_DATE('18:30 jan-2025', 'HH24:MI mon-yyyy') from dual;     -- ���� �� ������� �����, �� ��������� ������� 01
select TO_CHAR(TO_DATE('18:30:55 2025-jan-28', 'HH24:MI:ss yyyy-mon-dd'), 
    'HH24:MI:ss yyyy-mon-dd') from dual;                                    -- ����� � ��������� ���� � ��������
select TO_DATE('28-jan-25', 'DD-MON-YYYY') from dual;   -- ���� ��� ������ � �������, �� ��� � ������, �����������
select * from employees where hire_date > '01-jan-08';  -- ������� �����������, ����� �� ������������
select * from employees where hire_date > TO_DATE('01-jan-08', 'DD-MON-RR');  -- ����� �����������

select TO_CHAR(TO_DATE('28-jan-2025', 'DD-MON-RR'), 'Month') from dual;
select TO_CHAR(TO_DATE('15?1987$17$18$19/09', 'hh24?YYYY$MI$SS$DD/mm'), 'dd-MON-yyyy hh24:mi:ss') from dual;

-- 55 TO_NUMBER
select TO_NUMBER('455.77') from dual;   -- ����������� � ����� ��� �����
select TO_NUMBER('$455.77', '$99999.999') from dual;    -- � ������
select TO_NUMBER('4,555.77', '999,999.999') from dual;
select TO_CHAR(3.17, '99.9') from dual;     -- ��������� �����, ���� ����� �� ������ � �����
select TO_NUMBER('3.17', '99.9') from dual; -- ����� ������, �� ��������� �����

-- 56
select LENGTH(UPPER(SYSDATE)) from dual;
select SUBSTR(SYSDATE, 4) from dual;
select first_name, LENGTH(first_name) as len, ROUND(123.456789123456, LENGTH(first_name)) as round from employees;
select first_name, employee_id, LENGTH(employee_id) as len1,
    SUBSTR(first_name, LENGTH(employee_id)) as subs,
    LENGTH(SUBSTR(first_name, LENGTH(employee_id))) as len2 from employees;

select TO_DATE('18-09-87', 'DD-MM-RR'),
    to_char(TO_DATE('18-09-87', 'DD-MM-RR'), 'DAY'),
    length(to_char(TO_DATE('18-09-87', 'DD-MM-RR'), 'fmDAY')) from dual;
    
select first_name, last_name, phone_number,
    to_number(substr(phone_number, instr(phone_number, '.') + 1), '999.9999') * 10000 as form_number
    from employees where employee_id < 130;

-- 57 NVL
select NVL(null, 19) from dual;
select last_name, NVL(commission_pct, 0) from employees;
select first_name, NVL(substr(first_name, 6), 'name is too short') from employees;
select last_name, commission_pct, NVL(salary*commission_pct, 500) as bonus from employees;

-- 58 NVL2
select NVL2(null, 19, 20) from dual;    -- ���� 1 �������� �� null, �� ���������� 2, ����� 3
select NVL2('str', 'not null', 'str null') from dual; 
select last_name, NVL2(commission_pct, commission_pct*100, 0) as "commission_%" from employees;
select last_name, NVL2(commission_pct, 'yes', 'no') as "commission_have" from employees;

-- 59 NULLIF
select NULLIF(19, 20) from dual;	-- ���������� null, ���� ����� 1 � 2 �����, � ���������� ����� 1, ���� �� �����
select NULLIF('raz', 'raz') from dual;
select NULLIF('15', 15) from dual;	-- ����� ������, ��� ������� �����������
select NULLIF('raz', 'raz') from dual;
select NULLIF(TO_DATE('18-SEP-87'), TO_DATE('18/SEP/87')) from dual;    -- ����� �������������� ���� �����
select * from countries;
select country_id, country_name,
    NVL2(NULLIF(country_id, UPPER(SUBSTR(country_name, 1, 2))),
    'Sovpadeniya net', 'Sovpadenie najdeno') as sovpadenie from countries;

-- 60 COALESCE
select COALESCE(1, null, 2) from dual;  -- ���������� ������ �������� �� ������ �� null
select COALESCE(null, null, 'ok', 'not ok') from dual;
select COALESCE(null, null, null) from dual;

select first_name, commission_pct, manager_id, salary,
   COALESCE(commission_pct, manager_id, salary) as info from employees;

-- 61 DECODE (oracle sql)
select DECODE(3*4, 12, 'dvenadcat') from dual;  -- ���� �����.2 = �����.1, �� ������� �����.3
select DECODE(3*4, 13, 'dvenadcat') from dual;  -- ������� null
select DECODE(3*4, 13, 'dvenadcat', 14, 'chetyrnadcat', 15, 'pyatnadcat', 12, 'dvenadcat') from dual;
select DECODE(3*4, 13, 'dvenadcat', 
                    14, 'chetyrnadcat', 
                    15, 'pyatnadcat', 
                    'net sovpadeniy') from dual;  -- ��������� �������� - else, ���� ������ �� �������
select decode(null, 5, 'ok', null, 55) from dual;   -- ���� ����� ����������
select decode(2+2*2, 5, 'five', 12/2, 'six1', 6, 'six2') from dual; -- ������ ������ ����������

select first_name, commission_pct as pct,
    decode(commission_pct, 
        null, 'net komissionnih', 
        0.1, 'malo', 
        0.4, 'mnogo', 
        'sredne') as commissionniye from employees where employee_id BETWEEN 140 and 180;

