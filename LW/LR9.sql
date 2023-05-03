--1. �� ������� �������������, �������������� � ��� �� ������, ��� � �����������,
--������������� �������� �������� King, ������� ��������� ���������� � ������� � ���������������� �������:
--�������� ������������  department name
--��� ������������ first_name,last_name

SELECT dep.department_name department_name, emp.first_name first_name, emp.last_name last_name
FROM employees emp
JOIN departments dep on emp.department_id = dep.department_id
JOIN locations loc on dep.location_id = loc.location_id
WHERE loc.city = ( SELECT loct.city
                   FROM employees empl
                   JOIN departments dept on dept.manager_id = empl.employee_id
                   JOIN locations loct on dept.location_id = loct.location_id
                   WHERE empl.last_name= 'King');

--2.������� �������� ���� �������������,������� ������������� � ���.
SELECT DISTINCT dep.department_name department_name
FROM departments dep, locations loc
WHERE dep.location_id in (SELECT loc.location_id 
                          FROM locations loc
                          WHERE loc.country_id = 'US');
--����. SELECT DISTINCT - ����� �������� ��� ����������

--3.������� �������� ���� �������������, ��������������� � ���
--� ������� �� �������������, � ������� �������� ���� �� 1 ����������� 
SELECT dep.department_name department_name, emp.last_name last_name_manager
FROM departments dep, employees emp
WHERE dep.manager_id = emp.employee_id AND dep.location_id IN (SELECT loc.location_id 
                                                               FROM locations loc
                                                               WHERE loc.country_id = 'US')
                                       AND EXISTS (SELECT *
                                                   FROM employees empl
                                                   WHERE empl.department_id = dep.department_id 
                                                   AND empl.job_id = (SELECT j.job_id 
                                                                      FROM jobs j
                                                                      WHERE job_title = 'Programmer'));
                                                                      
 --4.�� ������� ������ �������:
 --�������� ������, ���������� �������������, ��������� ������� �� ������ ��������, ���������� �����������
 
select distinct loc.city, dep_cnt.dep_count ����������_�������������, 
    city_sal.salary_sum �������_��_��, emp_cnt.emp_count ����������_�����������

    from (select loc.city, count(*) emp_count
        from employees emp, departments dep, locations loc
            where emp.department_id = dep.department_id
            and dep.location_id = loc.location_id
            group by loc.city) emp_cnt,
            
        (select loc.city, count(*) dep_count
        from departments dep, locations loc
            where dep.location_id = loc.location_id
            group by loc.city) dep_cnt,
    
        (select loc.city, sum(COALESCE(emp.salary * (1 + emp.commission_pct), emp.salary)) salary_sum
        from employees emp, departments dep, locations loc
            where emp.department_id = dep.department_id
            and dep.location_id = loc.location_id
            group by loc.city) city_sal,

    departments dep, locations loc
    where loc.city = emp_cnt.city
    and loc.city = dep_cnt.city
    and loc.city = city_sal.city;
