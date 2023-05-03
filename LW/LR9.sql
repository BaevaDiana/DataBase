--1. По каждому депарматменту, расположенному в том же городе, что и департамент,
--руководителем которого является King, вывести следующую информацию в стобцах с соответствующими именами:
--название департамента  department name
--имя руководителя first_name,last_name

SELECT dep.department_name department_name, emp.first_name first_name, emp.last_name last_name
FROM employees emp
JOIN departments dep on emp.department_id = dep.department_id
JOIN locations loc on dep.location_id = loc.location_id
WHERE loc.city = ( SELECT loct.city
                   FROM employees empl
                   JOIN departments dept on dept.manager_id = empl.employee_id
                   JOIN locations loct on dept.location_id = loct.location_id
                   WHERE empl.last_name= 'King');

--2.Вывести названия всех департаментов,которые распологаются в США.
SELECT DISTINCT dep.department_name department_name
FROM departments dep, locations loc
WHERE dep.location_id in (SELECT loc.location_id 
                          FROM locations loc
                          WHERE loc.country_id = 'US');
--Прим. SELECT DISTINCT - чтобы выводить без повторений

--3.Вывести названия всех департаментов, распологающихся в США
--и фамилии их руководителей, в которых работает хотя бы 1 программист 
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
                                                                      
 --4.По каждому городу вывести:
 --название города, количество департаментов, суммарные затраты на оплату зарплаты, количество сотрудников
 
select distinct loc.city, dep_cnt.dep_count количество_департаментов, 
    city_sal.salary_sum затраты_на_зп, emp_cnt.emp_count количество_сотрудников

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
