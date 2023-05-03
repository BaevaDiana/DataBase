--1.ѕолучить данные по департаментам: 
--дл€ каждого департамента определить минимальную и максимальную зарплату, 
--определить дату устройства на работу первого и последнего сотрудника, 
--а также общее количество сотрудников в департаменте. 
--—ортировать по количеству сотрудников (по убыванию)
select dept.department_name, min(emp.salary) min_salary, max(emp.salary) max_salary, 
min(emp.hire_date) first_employees, max(emp.hire_date) last_employeees, count(emp.employee_id) number_employees
from departments dept
inner join employees emp on dept.department_id = emp.department_id
group by dept.department_name 
order by number_employees desc;

--2.ƒл€ каждого года вывести количество сотрудников нан€тых в этом году. 
--—ортировать по количеству сотрудников.
select TO_CHAR(hire_date,'YYYY') year, count(*) count
from employees 
group by TO_CHAR(hire_date,'YYYY') 
order by count(*);

--3.Ќайти управл€ющих (а именно их manager_id), 
--у которых количество подчиненных больше 5 и сумма всех зарплат подчиненных больше 50000.
select manager_id, count(employee_id) number_employees, sum(salary) total_salary
from employees
group by manager_id
having count(employee_id)>5 and sum(salary)>5000;

--4.ѕолучить максимальную зарплату среди всех средних зарплат по департаменту.
select max(avg_salary) max_avg_salary 
from 
(select avg(salary) avg_salary 
from employees
group by department_id);









