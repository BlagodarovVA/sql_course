-- 144
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












