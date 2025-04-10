-- 66 COUNT
select count(*) from employees;                         -- сколько строк
select count(commission_pct) from employees;            -- сколько заполненных, null не считает
select count(NVL(commission_pct, 0)) from employees;    -- чтобы посчитать все значени€, null замен€ем на 0
select count(*) from employees where salary > 7000; 
select count(ALL commission_pct) from employees;        -- ALL испоользуетс€ по умолчанию, не вли€ет
select count(DISTINCT commission_pct) from employees;   -- только уникальные
select count(DISTINCT first_name) from employees;
select count(DISTINCT first_name), count(first_name) from employees;
select count(*), count(commission_pct), count(DISTINCT commission_pct) from employees;
select count('abc') from employees;

select count(salary), first_name from employees;    -- будет ошибка

-- 67 SUM
select SUM(salary) from employees;                   -- сумма значений не счита€ null
select SUM(commission_pct) from employees;
select SUM(distinct commission_pct) from employees;
select 5 + null from dual;                           -- null
select SUM(salary), 
        sum(distinct salary), 
        count(salary) from employees;               -- разные групп функции
select sum(7) from employees;                        -- 7 * кол-во строк
select ROUND(sum(sysdate - hire_date)/365) from employees;  -- кол-во лет, которое отработали все сотрудники
select sum(length(first_name))/count(*) from employees;      -- среднее кол-во букв в именах сотрудников

-- 68 AVG - среднеарифметическое
select avg(salary) from employees;      -- средн€€ «ѕ
select avg(distinct salary) from employees;
select count(*) a, sum(salary) b, avg(commission_pct) c from employees;
select avg(7) from employees;
select avg(sysdate - hire_date)/365 from employees;     -- средний срок работы сотрудников
select avg(commission_pct) from employees; 
select avg(NVL(commission_pct, 0)) from employees; 

-- MAX и MIN
select min(salary), max(salary) from employees where department_id = 50;
select min(hire_date), max(hire_date) from employees;
select min(last_name), max(last_name) from employees;       -- работает по алфавиту
select count(salary), min(salary), max(salary), sum(salary), avg(salary) from employees;
select min(length(first_name)), max(length(first_name)) from employees;

-- GROUP BY
select department_id, count(*), min(salary) from employees  -- count количество строк дл€ каждой группы
    group by department_id 
    order by 1, 2;                                          -- order by 1,2сортировка по 1 и 2 столбцам
select job_id, round(avg(salary)), min(salary) as mymin, max(salary)
    from employees
    group by job_id 
    order by mymin;                            -- можно сортировать по алиасу, но не группировать
select department_id, max(hire_date), min(first_name), count(*), round(avg(salary)), sum(employee_id)
    from employees group by department_id;

select to_char(hire_date, 'Month'), count(*)
    from employees group by to_char(hire_date, 'Month') 
    order by to_char(hire_date, 'Month');

select location_id, count(*) 
    from departments group by location_id;

select department_id, count(*) 
    from employees 
    group by department_id;

select department_id, job_id, count(*) 
    from employees 
    group by department_id, job_id
    order by department_id, job_id;

select department_id, manager_id, count(*) 
    from employees 
    group by department_id, manager_id
    order by department_id, manager_id;

select job_id, to_char(hire_date, 'yyyy') as year, sum(salary), count(*)
from employees
where job_id IN ('ST_CLERK', 'SA_REP', 'SH_CLERK') and employee_id > 115
group by job_id, to_char(hire_date, 'yyyy');

-- HAVING
select * from employees 
    where salary > 10000;
    
select department_id, count(*) from employees
    group by department_id
    HAVING count(*) > 3
    order by department_id;
    
select department_id, count(*), round(avg(salary)) from employees
    group by department_id
    HAVING count(*) > 3 and round(avg(salary)) > 5000
    order by department_id;

-- Nested group
select department_id, avg(salary) from employees group by department_id;
select sum(avg(salary)) from employees group by department_id;
select round(sum(avg(length(upper(last_name))))) from employees group by department_id; -- можно миксовать групповые и сингл функции

-- 75 DZ
select department_id,
    min(salary),
    max(salary),
    min(hire_date),
    max(hire_date),
    count(*)
    from employees
    group by department_id
    order by count(*) DESC;

select substr(first_name, 1, 1) as first_char, count(*)
    from employees
    group by substr(first_name, 1, 1)
    HAVING count(*) > 1
    order by 2 DESC;

select department_id, salary, count(*)
    from employees
    group by department_id, salary
    order by count(*);

select to_char(hire_date, 'Day') as day, count(*)
    from employees
    group by to_char(hire_date, 'Day')
    order by 1;

select department_id, count(*)
    from employees
    group by department_id
    having count(*) > 30 and sum(salary) > 300000;

select region_id
    from countries
    group by region_id
    having sum(length(country_name)) > 50;
    
select job_id, round(avg(salary))
    from employees
    group by job_id;

select department_id
    from employees
    group by department_id
    having count(distinct(job_id)) > 1;

select department_id, job_id, min(salary), max(salary)
    from employees
    group by department_id, job_id
    having avg(salary) > 10000
    order by department_id;

select manager_id, avg(salary)
    from employees
    where commission_pct is null
    group by manager_id
    having avg(salary) BETWEEN 6000 and 9000;

select round(max(avg(salary)), -3) as maximum_salary
    from employees
    group by department_id;

-- 76 JOIN
select e.salary, e.first_name from employees e; -- алиас таблицы дл€ обращени€ к полному имени пол€

-- 77 INNER JOIN (NATURAL JOIN)
select * from regions;
select * from countries;
select * from regions natural join countries;
select c.country_name, c.country_id, r.region_name, region_id 
    from regions r natural join countries c;

select * from employees;
select * from departments;

select first_name, last_name, salary, department_name, department_id, manager_id
    from employees natural join departments;    -- объединение по 2 столбцам, т.к. они есть в обеих таблицах

select * from employees;
select * from countries;
select * from employees natural join countries;     -- если нет общих столбцов, то все комбинации перемножатс€

select * from employees;
select * from job_history;
select * from employees natural join job_history;

select c.country_name, c.country_id, r.region_name, region_id 
    from regions r natural join countries c where r.region_name = 'Europe';

-- 78 JOIN USING
select first_name, last_name, salary, department_name,
    e.manager_id emp_manager, d.manager_id dep_manager, department_id
    from employees e join departments d USING (department_id);      -- объединение по выбранным столбцам
    
select * from regions;
select * from countries;
select * from regions 
    join countries using (region_id);     -- аналогично NATURAL JOIN, но лучше, т.к. пон€тно, по какому столбцу объединение
    
select * from job_history;
select first_name, last_name, jh.job_id, start_date, end_date
    from employees join job_history jh using (employee_id, department_id);

-- 78 JOIN ON
select first_name, last_name, jh.job_id, start_date, end_date
    from employees emp JOIN job_history jh ON (emp.employee_id = jh.employee_id);

select * from regions;
select * from departments;
select * from departments JOIN regions 
    ON (region_id*10 = department_id);

select first_name, last_name, jh.job_id, start_date, end_date
    from employees emp JOIN job_history jh 
    ON (emp.employee_id = jh.employee_id and emp.department_id = jh.department_id); -- объединение по 2 столбцам

select * from departments;
select * from employees;
select first_name, department_name from employees JOIN departments dep
    ON (employee_id = dep.manager_id);

-- 80 объединение более 2 таблиц
select * from regions;
select * from locations;
select * from countries;
select * from locations NATURAL JOIN countries NATURAL JOIN regions;

select * from locations JOIN countries USING(country_id)
    JOIN regions USING (region_id);

select first_name, last_name, jh.job_id, start_date, end_date, department_name
    from employees e JOIN job_history jh ON (e.employee_id = jh.employee_id)
    JOIN departments d ON (jh.department_id = d.department_id);     -- 

select first_name, last_name, jh.job_id, start_date, end_date, department_name
    from employees e JOIN job_history jh USING (employee_id)
    JOIN departments d ON (jh.department_id = d.department_id);     -- джойны можно миксовать, но не желатеьно

select department_name, min(salary), max(salary)
    from employees e JOIN departments d ON (e.department_id = d.department_id)
    group by department_name order by department_name DESC;

-- 81 NONEQUIJOIN
select * from jobs;

select first_name, salary, min_salary, max_salary
    from employees e JOIN jobs j ON (e.job_id = j.job_id and salary*2<max_salary);

select first_name, salary, min_salary, max_salary
    from employees e JOIN jobs j ON (e.job_id = j.job_id and salary = max_salary);

select first_name, salary, min_salary, max_salary
    from employees e JOIN jobs j ON (e.job_id = j.job_id and
    salary between min_salary + 2000 and max_salary - 3000);

-- 82 SELF JOIN - джойн внутри одной таблицы
select emp1.employee_id, emp1.last_name, emp1.manager_id, emp2.last_name as manager_name
    from employees emp1 JOIN employees emp2 ON (emp1.manager_id = emp2.employee_id)
    order by emp1.last_name;

select emp2.last_name as manager_name, count(*)
    from employees emp1 JOIN employees emp2 ON (emp1.manager_id = emp2.employee_id)
    group by emp2.last_name order by count(*);

-- 84 LEFT OUTER JOIN
select * from employees;
select * from departments;

select first_name, last_name, department_name
    from employees e JOIN departments d 
    on (e.department_id = d.department_id);

select first_name, last_name, department_name           -- помимо иннер джойна выводит все строки из левой таблицы
    from employees e LEFT OUTER JOIN departments d      -- которые не удовлетвор€ют условие
    on (e.department_id = d.department_id)
    order by department_name;

select first_name, last_name, department_name
    from departments d LEFT OUTER JOIN employees e
    on (e.department_id = d.department_id)
    where department_name like '%i%'
    order by first_name;

select first_name, salary, min_salary, max_salary
    from employees e LEFT OUTER JOIN jobs j 
    ON (e.job_id = j.job_id and salary*2 < max_salary);

select postal_code, city, department_name
    from locations l LEFT OUTER JOIN departments d ON (d.location_id = l.location_id);

select department_name, d.department_id, e.FIRST_NAME
    from departments d left outer join employees e
    ON (e.department_id = d.department_id)
    where e.FIRST_NAME is null;

-- 85 RIGHT OUTER JOIN

select first_name, last_name, department_name           -- помимо иннер джойна выводит все строки из правой таблицы
    from employees e RIGHT OUTER JOIN departments d      -- которые не удовлетвор€ют условие
    on (e.department_id = d.department_id)
    order by department_name;

select first_name, last_name, department_name
    from employees e RIGHT OUTER JOIN departments d     
    USING (department_id)
    order by department_name;

select * from countries;
select * from locations;
select country_name, city, street_address
    from locations l RIGHT OUTER JOIN countries c ON (l.country_id = c.country_id);

-- 86 FULL OUTER JOIN
select * from employees;
select * from departments;
select NVL(first_name, '-no emloyee-'), NVL(last_name, '-no emloyee-'), NVL(department_name, '-no department-')
    from employees e FULL OUTER JOIN departments d
    ON (e.department_id = d.department_id);

-- 87 CROSS JOIN
select * from countries;
select * from regions;
select * from countries CROSS JOIN regions;     -- перемножаем все строки таблицы 1 на строки из 2

select * from countries CROSS JOIN regions
    where countries.region_id >=3
    order by country_id;

-- 88 ORACLE JOIN синтаксис
select first_name, last_name, e.department_id, department_name      -- Inner Join
    from employees e, departments d
    where e.department_id = d.department_id;

select first_name, last_name, e.department_id, department_name      -- (+) Right Outer Join
    from employees e, departments d
    where e.department_id(+) = d.department_id;

select first_name, last_name, e.department_id, department_name      -- Left Outer Join (+)
    from employees e, departments d
    where e.department_id = d.department_id(+);

select * from countries, regions;                                   -- Cross Join

-- 89 DZ
select * from employees;
select * from departments;
select * from locations;
select * from countries;
select * from regions;

select region_name, count(*)
    from employees e 
    JOIN departments d ON (e.department_id = d.department_id)
    JOIN locations l ON (d.location_id = l.location_id)
    JOIN countries c ON (l.country_id = c.country_id)
    JOIN regions r ON (c.region_id = r.region_id)
    group by region_name;

select first_name, last_name, d.department_name, job_id, l.street_address, c.country_name, r.region_name
    from employees e
    JOIN departments d ON (e.department_id = d.department_id)
    JOIN locations l ON (d.location_id = l.location_id)
    JOIN countries c ON (l.country_id = c.country_id)
    JOIN regions r ON (c.region_id = r.region_id);

select man.last_name as manager_name, count(*)
    from employees emp JOIN employees man ON (emp.manager_id = man.employee_id)
    HAVING count(*) > 6
    group by man.last_name order by count(*);

select d.department_name, count(*)
    from departments d JOIN employees e using (department_id)
    HAVING count(*) > 30
    group by d.department_name order by count(*);

select d.department_name, first_name
    from employees e
    RIGHT JOIN departments d ON (e.department_id = d.department_id)
    where first_name is null;

select emp.last_name, emp.hire_date, man.last_name, man.hire_date as manager_hire_date
    from employees emp
    JOIN employees man ON (emp.manager_id = man.employee_id)
    where emp.hire_date < '01-JAN-2005' 
    and TO_CHAR(man.hire_date, 'YYYY') = '2005'
    order by man.hire_date;

select * from regions;
select * from countries;
select * from regions natural join countries;
select country_name, region_name 
    from regions natural join countries
    order by country_name ;

select last_name, first_name, salary, job_id from employees
natural join jobs
where salary < min_salary + 1000
order by last_name;
-- »Ћ»
select last_name, first_name, salary, e.job_id from employees e
join jobs j
on (e.job_id = j.job_id and salary < min_salary + 1000)
order by last_name;

select last_name, first_name, c.country_name 
from employees e
full outer join departments d on (e.department_id = d.department_id)
full outer join locations l on (d.location_id = l.location_id)
full outer join countries c on (l.country_id = c.country_id)
order by last_name; 

select last_name, first_name, country_name
from employees
cross join countries;

select region_name, count(*)
    from employees e, departments d, locations l, countries c, regions r
    where (e.department_id = d.department_id 
        and d.location_id = l.location_id 
        and l.country_id = c.country_id 
        and c.region_id = r.region_id)
    group by region_name;

select department_name, first_name
    from employees e, departments d
    where e.department_id(+) = d.department_id 
    and first_name is null;

-- 90 SUBQUERY
select last_name, first_name, salary
from employees where salary > (select avg(salary) from employees);

select (select MIN(min_salary) from jobs) min_zp,
(select MAX(LENGTH(first_name)) from employees) samoe_dlinnoe_imya
from dual;

select last_name, first_name from employees 
where employee_id IN (select manager_id from employees);

select department_name, min(salary), max(salary) from
(select salary, department_name from employees e JOIN departments d
on (e.department_id = d.department_id))
group by department_name;

select department_name, min(salary), max(salary) from
(select salary, department_name from employees e JOIN departments d
on (e.department_id = d.department_id))
group by department_name
having max(salary) > (select 2*5000 from dual)
and min(salary) < (select salary from employees where employee_id = 113);

-- 91 SINGLE-ROW SUBQUERY
select last_name, first_name, salary from employees
where salary < (select max(salary)/5 from employees);

select last_name, first_name, salary from employees 
where salary > (select avg(salary) from employees);

select job_title from jobs j join employees e       -- максимальна€ средн€€ зарплата по должност€м
ON (j.job_id = e.job_id)
group by job_title
having avg(salary) = (select max(avg(salary)) from employees group by job_id);

-- 92 MULTIPLE-ROW SUBQUERY
select last_name, first_name, salary, job_id from employees
where job_id IN (select job_id from jobs where min_salary > 8000);  -- IN или NOT IN

-- ANY зарплата работника больше любой из подзапроса
-- ALL зарплата работника больше каждого из подзапроса
select last_name, first_name, salary, job_id from employees
where salary > ALL(select salary from employees where department_id = 100);

select last_name, first_name, salary, job_id from employees
where salary < ANY(select salary from employees where department_id = 100);

select distinct(department_name) from departments d     -- отделы, в которых есть сотрудники
join employees e on (d.department_id = e.department_id)
order by department_name;

select department_name from departments    -- аналогично через подзапрос
where department_id IN (select department_id from employees)
order by department_name;

-- 93 CORRELATED SUBQUERY - ресурсоЄмкий запрос, лучше не использовать
select last_name, first_name, salary from employees
where salary > (select avg(salary) from employees);

select e1.last_name, e1.first_name, e1.salary, e1.department_id from employees e1
where salary > (select avg(e2.salary) from employees e2
where e2.department_id = e1.department_id)
order by e1.department_id;

-- 94
select first_name, last_name, salary from employees where department_id IN  -- поиск сотрудников из конкретной страны
(select department_id from departments where location_id IN
(select location_id from locations where country_id IN
(select country_id from countries where country_name = 'Belarus')));

select first_name, last_name, salary from employees
where job_id IN (select job_id from jobs where UPPER(job_title)like '%MANAGER%')
and salary > (select avg(salary) + 5000 from employees);

select first_name, last_name, salary from employees
where salary > ALL(select salary from employees where first_name = 'David');

-- 95 DZ
select * from employees
where LENGTH(first_name) = (select MAX(LENGTH(first_name)) from employees);

select * from employees
where salary > (select avg(salary) from employees);

select city from locations where location_id IN
(select department_id from departments where department_id IN
(select sum(salary) from employees));

select * from employees ;
select * from locations;
select * from departments;

select city, sum(salary) from employees e
    join departments d on (e.department_id = d.department_id)
    join locations l on (d.location_id = l.location_id)
    group by city
    having sum(salary) =
        (select min(sum(salary))
            from employees e
                join departments d on (e.department_id = d.department_id)
                join locations l on (d.location_id = l.location_id)
            group by city);

select * from employees where manager_id
IN (select employee_id from employees where salary > 15000);

select * from departments where department_id
NOT IN (select distinct(department_id) from employees where department_id is not null);

select * from employees where employee_id
NOT IN (select distinct(manager_id) from departments where manager_id is not null);

select * from employees e
where (select count(*) from employees 
        where manager_id = e.employee_id) > 6;

select * from employees where department_id = 
(select department_id from departments where department_name= 'IT');

select * from employees where manager_id IN
    (select employee_id from employees where TO_CHAR(hire_date, 'YYYY') = '2005')
and hire_date < TO_DATE('01012005', 'DDMMYYYY');

select * from employees e where manager_id IN
    (select employee_id from employees where TO_CHAR(hire_date, 'MM') = '01')
    and 15 < (select LENGTH(job_title) from jobs where job_id = e.job_id);







