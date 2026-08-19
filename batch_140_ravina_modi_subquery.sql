USE SQLASSIGNMENT;

/* 1. Write a query in SQL to display all the details of managers. 
Sample table: employees */

select * from employees
where emp_id in(select manager_id from employees);

/* 2. Write a query in SQL to display the employee ID, name, job name, hire date, and experience of all the managers. 
Sample table: employees  */

select emp_id,emp_name,job_name,hire_date,timestampdiff(year,hire_date,curdate())as 'experience' from employees
where emp_id in(select manager_id from employees);

/* 3. Write a query in SQL to list the employee ID, name, salary, department name of all the 'MANAGERS' and 'ANALYST' working in SYDNEY, PERTH with an exp more than 5 years without receiving the commission and display the list in ascending order of location. 
Sample table: employees    Sample table: department*/

select e.emp_id,e.emp_name,e.salary,d.dep_name from employees e
 join department d on e.dep_id=d.dep_id
and d.dep_location in('sydney','perth')
and e.emp_id in(select e.emp_id from employees
where e.job_name in('manager','analyst')
and timestampdiff(year,e.hire_date,curdate())>5
and e.commission is null)
order by d.dep_location asc;

/* 4. Write a query in SQL to display the employee ID, name, salary, department name, location, department ID, job name of all the employees working at SYDNEY or working in the FINANCE deparment with an annual salary above 28000, but the monthly salary should not be 3000 or 2800 and who does not works as a MANAGER and whose ID containing a digit of '3' or '7' in 3rd position. List the result in ascending order of department ID and descending order of job name.   
Sample table: employees    Sample table: department */

select e.emp_id,e.emp_name,e.salary,d.dep_location,d.dep_id,e.job_name from employees e
join department d on e.dep_id=d.dep_id
where (d.dep_location='sydney' or e.job_name='finance')
and e.emp_id in(select e.emp_id from employees
where (e.salary*12>28000)
and e.salary not in(3000,2800)
and e.job_name!='manager'
and e.emp_id like '__3%' or '__7%')
order by d.dep_id asc,e.job_name desc;

/* 5. Write a query in SQL to list all the employees of grade 2 and 3.   
Sample table: employees    Sample table: salary_grade   */

select * from employees e
join salary_grade s on e.salary between s.min_salary and s.max_salary
and s.grade in(2,3);

/* 6. Write a query in SQL to display all the employees of grade 4 and 5 who are working as ANALYST or MANAGER.    
Sample table: employees    Sample table: salary_grade   */

select * from employees e
join salary_grade s on e.salary between s.min_salary and max_salary
where s.grade in(4,5)
and e.emp_id in(select e.emp_id from employees 
where e.job_name in('analyst','manager'));

/* 7. Write a query in SQL to list the details of the employees whose salary is more than the salary of JONAS. 
Sample table: employees   */

select * from employees 
where salary>(select salary from employees
where emp_name='jonas');

/* 8. Write a query in SQL to list the employees who works in the same designation as FRANK.    
Sample table: employees    */

select * from employees
where job_name =(select job_name from employees
where emp_name in ('frank'));

/* 9. List the employees who are senior to ADELYN    
Sample table: employees    */

select * from employees
 where hire_date>(select hire_date from employees
 where emp_name='adelyn');
 
 /* 10. Write a query in SQL to list the employees of department ID 2001 who works in the designation same as department ID 1001.    
Sample table: employees  Sample table: department     */

select * from employees e
join department d on e.dep_id=d.dep_id
where e.dep_id=2001
and e.job_name in (select e.job_name from employees e
where e.dep_id in (1001));

/* 11. Write a query in SQL to list the employees whose salary is same as the salary of FRANK or SANDRINE. List the result in descending order of salary.    
Sample table: employees    */

select * from employees 
where salary in(select salary from employees
where emp_name in ('frank','sandrine'))
order by salary desc;

/* 12. Write a query in SQL to list the employees whose designation are same as the designation of MARKER or salary is more than the salary of ADELYN.    
Sample table: employees    */

select * from employees
where job_name = (select job_name from employees
where emp_name in('marker') )
or salary>(select salary from employees
where emp_name in ('adelyn'));

/* 13. Write a query in SQL to list the employees whose salary is more than the total remuneration of the SALESMAN. 
Sample table: employees    */

select * from employees
where salary>(select max(salary+commission)as'remuneration' from employees
where job_name='salesman');

/* 14. Write a query in SQL to list the employees who are senior to BLAZE and working at PERTH or BRISBANE.    
Sample table: employees   Sample table: department */

select * from employees e
join department d on e.dep_id=d.dep_id
where d.dep_location in('perth','brisbane')
and e.hire_date < (select e.hire_date from employees e
where e.emp_name='blaze');

/* 15. Write a query in SQL to list the employees of grade 3 and 4 working in the department of FINANCE or AUDIT and whose salary is more than the salary of ADELYN and experience is more than FRANK. List the result in the ascending order of experience. 
Sample table: employees    Sample table: department      Sample table: salary_grade     */

select * from employees e
join department d on e.dep_id=d.dep_id
join salary_grade s on e.salary between s.min_salary and s.max_salary
where s.grade IN (3,4)
and d.dep_id in(select d.dep_id from department d
where d.dep_name in('audit','finance'))
and e.salary >(select e.salary from employees e
where emp_name='adelyn')
and  e.hire_date <(SELECT hire_date FROM employees
     WHERE emp_name = 'FRANK')
ORDER BY e.hire_date ASC;

/* 16. Write a query in SQL to list the employees whose designation is same as the designation of SANDRINE or ADELYN.    
Sample table: employees    */

select * from employees
where job_name in(select job_name from employees
where emp_name in('sandrine','adelyn'));

/* 17. Write a query in SQL to list any job of department ID 1001 those that are not found in department ID 2001.    
Sample table: employees    */

select job_name from employees
where dep_id=1001
and job_name in (select job_name from employees
where dep_id not in(2001));

/* 18. Write a query in SQL to find the details of highest paid employee.    
Sample table: employees    */

select * from employees
where salary in(select max(salary) from employees);

/* 19. Write a query in SQL to find the highest paid employees in the department MARKETING.    
Sample table: employees    Sample table: department    */

SELECT * FROM employees
WHERE dep_id IN (SELECT dep_id FROM department 
    WHERE dep_name = 'MARKETING')
AND salary = (SELECT MAX(salary)FROM employees
    WHERE dep_id IN (SELECT dep_id FROM department 
        WHERE dep_name = 'MARKETING'));

/* 20. Write a query in SQL to list the employees of grade 3 who have been hired in most recently and belongs to PERTH.    
Sample table: employees    Sample table: department    Sample table: salary_grade     */

select * from employees
where dep_id in(select dep_id from department
	where dep_location='perth')
and salary between (select min_salary from salary_grade 
	where grade=3)
    and (select max_salary from salary_grade
    where grade=3); 

/* 21. Write a query in SQL to list the employees who are senior to most recently hired employee working under KAYLING.   
Sample table: employees    */

select * from employees
where hire_date in(select max(hire_date) from employees
	where manager_id in(select emp_id from employees
		where emp_name='kayling'));

/*  22. Write a query in SQL to list the details of the employees within grade 3 to 5 and belongs to SYDNEY. The employees are not in PRESIDENT designated and salary is more than the highest paid employee of PERTH where no MANAGER and SALESMAN are working under KAYLING.    
Sample table: employees    Sample table: department    Sample table: salary_grade   */

SELECT * FROM employees
WHERE dep_id IN(SELECT dep_id FROM department
     WHERE department.dep_location ='SYDNEY')
  AND emp_id IN(SELECT emp_id FROM employees e,salary_grade s
     WHERE e.salary BETWEEN s.min_salary AND s.max_salary
       AND s.grade IN (3,4,5) )
  AND job_name != 'PRESIDENT'
  AND salary >(SELECT max(salary)FROM employees
     WHERE dep_id IN(SELECT dep_id FROM department
          WHERE department.dep_location = 'PERTH')
       AND job_name IN ('MANAGER','SALESMAN')
       AND manager_id NOT IN(SELECT emp_id FROM employees
          WHERE emp_name = 'KAYLING'));

/* 23. Write a query in SQL to list the details of the senior employees as on year 1991.    
Sample table: employees    */

select * from employees
where hire_date in(select min(hire_date) from employees
	where year(hire_date)=1991);
    
/* 24. Write a query in SQL to list the employees who joined in 1991 in a designation same as the most senior person of the year 1991.    
Sample table: employees    */

select * from employees
where year(hire_date)=1991
and job_name in (select job_name from employees
	where hire_date in(select min(hire_date) from employees
	where year(hire_date)=1991));

/* 25. Write a query in SQL to list the most senior employee working under KAYLING and grade is more than 3.    
Sample table: employees    Sample table: salary_grade    */

select * from employees
where hire_date in(select min(hire_date) from employees
	where emp_id in(select emp_id from employees e,salary_grade s
    where e.salary between s.min_salary and s.max_salary
    and s.grade in(4,5)))
and manager_id in(select emp_id from employees
	where emp_name='kayling');
	
/* 26. Write a query in SQL to find the total salary given to the MANAGER. 
Sample table: employees    */

select sum(salary) from employees
where job_name='manager';

/* 27. Write a query in SQL to display the total salary of employees belonging to grade 3.   
Sample table: employees   Sample table: salary_grade   */

select sum(salary) from employees
where emp_name in(select emp_name from employees e,salary_grade s
	where e.salary between s.min_salary and s.max_salary
    and s.grade=3);
    
/* 28. Write a query in SQL to list the employees in department 1001 whose salary is more than the average salary of employees in department 2001.    
Sample table: employees   */

select * from employees
where dep_id=1001
and salary>(select avg(salary) from employees
	where dep_id=2001);
    
/* 29. Write a query in SQL to list the details of the departments where maximum number of employees are working.    
Sample table: employees    Sample table: department   */

select d.dep_name,d.dep_id,d.dep_location,count(*) from employees e,department d
where e.dep_id=d.dep_id
group by d.dep_id
having count(*)=(select max(mycount) from 
	(select count(*) mycount from employees
    group by dep_id)a);
    
/* 30. Write a query in SQL to display the employees whose manager name is JONAS.    
Sample table: employees    */

select * from employees
where manager_id in(select emp_id from employees
	where emp_name='jonas');
    
/* 31. Write a query in SQL to list the employees who are not working in the department MARKETING.    
Sample table: employees     Sample table: department    */

select * from employees
where dep_id not in(select dep_id from department
	where dep_name='marketing');

/* 32. Write a query in SQL to list the name, job name, department name, location for those who are working as a manager.    
Sample table: employees    Sample table: department    */

select e.emp_name,e.job_name,d.dep_name,d.dep_location from employees e,department d
where e.dep_id=d.dep_id
and emp_id in(select manager_id from employees);

/* 33. Write a query in SQL to list the name of the employees who are getting the highest salary of each department.    
Sample table: employees    */

select emp_name from employees
where salary in(select max(salary) from employees
	group by dep_id);
    
/* 34. Write a query in SQL to list the employees whose salary is equal or more to the average of maximum and minimum salary.    
Sample table: employees   */

select * from employees
where salary >=(select (max(salary)+min(salary))/2 from employees);

/* 35. Write a query in SQL to list the employees who are SALESMAN and gathered an experience which month portion is more than 10.    
Sample table: employees   */

select * from employees 
where job_name='salesman'
and timestampdiff(month,hire_date,curdate())>10;

/* 36. Write a query in SQL to list the employees whose salary is less than the salary of his manager but more than the salary of any other manager.    
Sample table: employees   */

select * from employees e,employees m
where e.manager_id=m.emp_id
and e.salary<m.salary
	and e.salary > any (select salary from employees
		where emp_id in(select manager_id from employees));
        
/* 37. Write a query in SQL to list the name and average salary of employees in department wise.    
Sample table: employees   */

SELECT dep_name,AVG(salary) AS average_salary from employees e,department d
GROUP BY dep_name;

/* 38. Write a query in SQL to find out the least 5 earners of the company.    
Sample table: employees   */

SELECT * FROM employees
ORDER BY salary ASC
LIMIT 5;

/* 39. Write a query in SQL to list the managers who are not working under the PRESIDENT.   
Sample table: employees   */

select * from employees
where emp_id in(select manager_id from employees)
	and manager_id not in(select emp_id from employees
	where job_name='president');

/* 40. Write a query in SQL to list the name, salary, commission and netpay for those employees whose netpay is more than any other employee.    
Sample table: employees   */

select emp_name,salary,commission,salary+coalesce(commission+0)as netpay from employees
	where (salary+coalesce(commission+0))=
		(select max(salary+coalesce(commission+0)) from employees);
        
/* 41.Write a query in SQL to list the name of the department where number of employees is equal to the number of characters in the department name.    
Sample table: employees    Sample table: department    */

select * from department d
		where length(trim(dep_name)) in (select count(*) from employees e
			where e.dep_id=d.dep_id);
            
/* 42. Write a query in SQL to list the name of the departments where highest number of employees are working.   
Sample table: employees     Sample table: department    */

SELECT d.dep_name FROM department d
JOIN employees e ON d.dep_id = e.dep_id
GROUP BY d.dep_id, d.dep_name
ORDER BY COUNT(*) DESC
LIMIT 1;

/* 43. Write a query in SQL to list the employees who joined in the company on the same date.    
Sample table: employees    */

select * from employees e
where hire_date in(select hire_date from employees 
	where e.emp_id<>emp_id);
    
/* 44. Write a query in SQL to list the name of the departments where more than average number of employees are working. 
Sample table: employees    Sample table: department    */

select d.dep_name  from department d
JOIN employees e ON d.dep_id = e.dep_id
			group by d.dep_name,d.dep_id
            having count(*) > 
            (select avg(emp_count) from 
				(select count(*) as emp_count from employees
            group by dep_id )as a);
            
/* 45. Write a query in SQL to list the name of the managers who is having maximum number of employees working under him.    
Sample table: employees   */

select m.emp_name,count(*) from employees e,employees m
where m.emp_id=e.manager_id
group by m.emp_name,m.emp_id
having count(*) =(select max(emp_count) from 
					(select count(*) as emp_count from employees 
                    where manager_id is not null
                    group by manager_id)as a);
                    
/* 46. Write a query in SQL to list those managers who are getting salary to less than the salary of his employees.   
Sample table: employees   */

select * from employees e
 where salary< any (select salary from employees
	where e.emp_id=manager_id);
    
/* 47. Write a query in SQL to list the details of all the employees who are sub-ordinates to BLAZE .
Sample table: employees   */

select * from employees
 where manager_id in(select emp_id from employees
	where emp_name='blaze');
    
/* 48. Write a query in SQL to list the employees who are working as managers, using co-related subquery.    
Sample table: employees   */

select * from employees
where  emp_id in(select manager_id from employees);

/* 49. Write a query in SQL to list the name of the employees for their manager JONAS and also the name of the manager of JONAS.   
Sample table: employees   */

SELECT e.emp_name AS "Employee Name",
    m1.emp_name AS "Manager Name",
    m2.emp_name AS "Jonas's Manager"
FROM employees e
JOIN employees m1 ON e.manager_id = m1.emp_id 
LEFT JOIN employees m2 ON m1.manager_id = m2.emp_id 
WHERE m1.emp_name = 'JONAS';

/* 50. Write a query in SQL to find all the employees who earn the minimum salary for a designation and arrange the list in ascending order on salary.    
Sample table: employees   */

select * from employees
	where salary in(select min(salary) from employees
		group by job_name)
		order by salary asc;
        
/* 51. Write a query in SQL to find all the employees who earn the highest salary for a designation and arrange the list in descending order on salary.    
Sample table: employees   */

select * from employees
where salary in(select max(salary) from employees
	group by emp_name)
    order by salary desc;
    
/* 52. Write a query in SQL to find the most recently hired emps in each department order by hire_date.    
Sample table: employees   */

select * from employees e
where hire_date in(select max(hire_date) from employees
	where e.dep_id=dep_id
    group by dep_id)
    order by hire_date desc;
	
/* 53. Write a query in SQL to list the name,salary, and department id for each employee who earns a salary greater than the average salary for their department and list the result in ascending order on department id.   
Sample table: employees   */

select e.emp_name,e.salary,e.dep_id from employees e
where salary >(select avg(salary) from employees
	where e.dep_id=dep_id)
	order by dep_id asc;

/* 54. Write a query in SQL to find the name and designation of the employees who earns a commission and salary is the maximum.   
Sample table: employees    */

select emp_name,job_name from employees
where commission is not null
	and salary =(select max(salary) from employees
		where commission is not null);
        
/* 55. Write a query in SQL to list the name, designation, and salary of the employees who does not work in the department 1001 but works in same designation and salary as the employees in department 3001    
Sample table: employees   */

select emp_name,job_name,salary from employees
where dep_id!=1001
and job_name in(select job_name from employees)
	and salary in(select salary from employees
     where dep_id=3001);

/* 56. Write a query in SQL to list the department id, name, designation, salary, and net salary (salary+commission) of the SALESMAN who are earning maximum net salary.   
Sample table: employees   */

select dep_id,emp_name,job_name,salary,(salary+commission)as 'net salary' from employees
where job_name='salesman'
and (salary+commission) in(select max(salary+commission) from employees
	where commission is not null);
    
/* 57. Write a query in SQL to list the department id, name, designation, salary, and net salary of the employees only who gets a commission and earn the second highest earnings. 
Sample table: employees  */

select dep_id,emp_name,job_name,salary,(salary+commission)as 'net salary' from employees
where commission is not null
and (salary+commission)=(select max(salary+commission) from employees
	where commission is not null
    and (salary+commission) <(select max(salary+commission) from employees
		where commission is not null));

/* 58. Write a query in SQL to list the department ID and their average salaries for those department where the average salary is less than the averages for all departments.    
Sample table: employees   */

select dep_id,avg(salary)as 'average salary' from employees
group by dep_id
having avg(salary)<(select avg(salary) from employees);

/* 59. Write a query in SQL to display the unique department of the employees. 
Sample table: employees   Sample table: department   */

select * from department 
where dep_id in (select distinct(dep_id) from employees );

/* 60. Write a query in SQL to list the details of the employees working at PERTH.   
Sample table: employees    Sample table: department   */

select * from employees 
where dep_id in(select dep_id from department
	where dep_location='perth');

/* 61. Write a query in SQL to list the employees of grade 2 and 3 who belongs to the city PERTH.   
Sample table: employees     Sample table: department     Sample table: salary_grade   */

select * from employees e
join department d on e.dep_id=d.dep_id
join salary_grade s on e.salary between s.min_salary and s.max_salary
where s.grade in(2,3)
	and d.dep_location='perth';
    
/* 62. Write a query in SQL to list the employees whose designation is same as either the designation of ADLYNE or the salary is more than salary of WADE.  
Sample table: employees   */

select * from employees
where job_name in (select job_name from employees 
	where emp_name='adelyn')
or salary > (select salary from employees 
	where emp_name='wade');
    
/* 63. Write a query in SQL to list the employees of department 1001 whose salary is more than the salary of ADELYN.   
Sample table: employees   */

select * from employees
where dep_id=1001
and salary> (select salary from employees
	where emp_name='adelyn');
    
/* 64. Write a query in SQL to list the managers who are senior to KAYLING and who are junior to SANDRINE.   
Sample table: employees  */

select * from employees
where emp_id in(select manager_id from employees
	where hire_date<(select hire_date from employees
		where emp_name='kayling')
    and hire_date>(select hire_date from employees
		where emp_name='sandrine'))
	and manager_id is not null;

/* 65.Write a query in SQL to list the ID, name,location,salary, and department of the all the employees belonging to the department where KAYLING works.   
Sample table: employees   Sample table: department   */

select e.emp_id,e.emp_name,d.dep_location,e.salary,d.dep_name from employees e,department d
where e.dep_id=d.dep_id
and e.dep_id in(select e.dep_id from employees e
					where e.emp_name='kayling');

 /* 66. Write a query in SQL to list the employees whose salary grade are greater than the grade of MARKER.    
Sample table: employees    Sample table: salary_grade   */

select * from employees e
join salary_grade s on e.salary between s.min_salary and s.max_salary
and s.grade > (select s.grade from salary_grade s,employees e
	where e.salary between s.min_salary and s.max_salary
	and e.emp_name='marker');

/* 67. Write a query in SQL to list the employees of the grade same as the grade of TUCKER or experience is more than SANDRINE and who are belonging to SYDNEY or PERTH. 
Sample table: employees      Sample table: department     Sample table: salary_grade       */

select * from employees e
join department d on e.dep_id=d.dep_id
join salary_grade s on e.salary between s.min_salary and s.max_salary
where (s.grade in(select s.grade from employees e,salary_grade s
				where e.salary between s.min_salary and s.max_salary
                and e.emp_name='tucker')
or e.hire_date < (select e.hire_date from employees e
                  where e.emp_name='sandrine')
		)
                  and d.dep_location in('sydney','perth');
                  
/* 68. Write a query in SQL to list the employees whose salary is same as any one of the employee.    
Sample table: employees   */

select * from employees
where salary in (select salary from employees
				group by salary
                having count(*)>1);

/* 69. Write a query in SQL to list the total remuneration (salary+commission) of all sales person of MARKETING department.    
Sample table: employees    Sample table: department   */

select * from employees e
join department d on e.dep_id=d.dep_id
where (salary+commission) in(select (salary+commission) from employees e
		where d.dep_name='marketing');
        
/* 70. Write a query in SQL to list the details of most recently hired employees of department 3001. 
Sample table: employees   */

select * from employees
where hire_date in (select max(hire_date) from employees
					where dep_id=3001);
                    
/* 71. Write a query in SQL to list the highest paid employees of PERTH who joined before the most recently hired employee of grade 2 
Sample table: employees    Sample table: department    Sample table: salary_grade    */

select * from employees 
where salary =(select max(salary)from employees e,department d
					where e.dep_id=d.dep_id
					and d.dep_location='perth')
and hire_date < (select max(hire_date) from employees e,salary_grade s
					where e.salary between s.min_salary and s.max_salary
                    and s.grade=2);

/* 72. Write a query in SQL to list the highest paid employees working under KAYLING.    
Sample table: employees   */

select * from employees
where salary in (select max(salary) from employees
				where manager_id in(select emp_id from employees
					where emp_name='kayling'));
                    
/* 73. Write a query in SQL to list the name, salary, and commission for those employees whose net pay is greater than or equal to the salary of any other employee in the company.    
Sample table: employees   */

select e.emp_name,e.salary,e.commission from employees e
where (select max(salary+commission) from employees) >= any (select salary from employees);

/* 74. Write a query in SQL to find out the employees whose salaries are greater than the salaries of their managers.    
Sample table: employees   */

select * from employees e,employees m
where e.manager_id=m.emp_id
and e.salary>m.salary;

/* 75. Write a query in SQL to find the maximum average salary drawn for each job name except for PRESIDENT.    
Sample table: employees   */

SELECT MAX(avg_salary) AS 'max average salary'
FROM (
    SELECT job_name, AVG(salary) AS avg_salary
    FROM employees
    WHERE job_name != 'PRESIDENT'
    GROUP BY job_name
) a;

/* 76. Write a query in SQL to find the number of employees are performing the duty of a manager.    
Sample table: employees    */

select count(*) as 'no of managers' from employees
where emp_id in(select distinct manager_id from employees
	where manager_id is not null);

/* 77. Write a query in SQL to list the department where there are no employees.     
Sample table: employees     Sample table: department    */

select * from department 
where dep_id not in(select dep_id from employees);





