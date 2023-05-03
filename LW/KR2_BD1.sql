-- КР2.Баева Диана. Вариант 1.
--Задача 2.

--1.Вывести город (city), адрес внутри города (street_address), почтовый индекс (postal_code) для городов расположенных в США. 
--Отсортировать полученный результат по наименованию города.
select city city,street_address stree_address ,postal_code postal_code
from locations loc,countries coun
where loc.country_id = coun.country_id and coun.country_name = 'United States of America'
order by loc.city;

--2.Вывести всех работников, работающих в департаментах, расположенных в Канаде. 
--Необходимо вывести их код (employee_id), их имя и фамилию (first_name, last_name), дату приема на работу (hire_date), а также наименование департамента, в котором они работают (department_name).
select emp.employee_id,emp.first_name first_name,emp.last_name last_name,emp.hire_date hire_date,dept.department_name department_name
from employees emp,departments dept, locations loc, countries coun
where emp.department_id = dept.department_id and loc.country_id = coun.country_id and coun.country_name = 'Canada';

--3.Для каждой должности определить среднюю зарплату и число человек, которые работают на данной должности. 
--Вывести наименование должности (job_title), среднюю зарплату и количество человек.
--Выводить только те должности, на которых работает более одного человека.
select j.job_title job_title,avg(emp.salary) avg_salary, count(emp.job_id)number_employee
from jobs j
inner join employees emp on j.job_id = emp.job_id 
group by j.job_title
having avg(salary)>0 and count(emp.job_id)>1;

--4.Вывести список сотрудников (вывести все столбцы таблицы employees),
--у которых в прямом подчинении находится более 5 сотрудников.
select *
from employees emp
where
(
select count(*) 
from employees
where manager_id = emp.employee_id)>5;