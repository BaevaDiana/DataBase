-- ��2.����� �����. ������� 1.
--������ 2.

--1.������� ����� (city), ����� ������ ������ (street_address), �������� ������ (postal_code) ��� ������� ������������� � ���. 
--������������� ���������� ��������� �� ������������ ������.
select city city,street_address stree_address ,postal_code postal_code
from locations loc,countries coun
where loc.country_id = coun.country_id and coun.country_name = 'United States of America'
order by loc.city;

--2.������� ���� ����������, ���������� � �������������, ������������� � ������. 
--���������� ������� �� ��� (employee_id), �� ��� � ������� (first_name, last_name), ���� ������ �� ������ (hire_date), � ����� ������������ ������������, � ������� ��� �������� (department_name).
select emp.employee_id,emp.first_name first_name,emp.last_name last_name,emp.hire_date hire_date,dept.department_name department_name
from employees emp,departments dept, locations loc, countries coun
where emp.department_id = dept.department_id and loc.country_id = coun.country_id and coun.country_name = 'Canada';

--3.��� ������ ��������� ���������� ������� �������� � ����� �������, ������� �������� �� ������ ���������. 
--������� ������������ ��������� (job_title), ������� �������� � ���������� �������.
--�������� ������ �� ���������, �� ������� �������� ����� ������ ��������.
select j.job_title job_title,avg(emp.salary) avg_salary, count(emp.job_id)number_employee
from jobs j
inner join employees emp on j.job_id = emp.job_id 
group by j.job_title
having avg(salary)>0 and count(emp.job_id)>1;

--4.������� ������ ����������� (������� ��� ������� ������� employees),
--� ������� � ������ ���������� ��������� ����� 5 �����������.
select *
from employees emp
where
(
select count(*) 
from employees
where manager_id = emp.employee_id)>5;