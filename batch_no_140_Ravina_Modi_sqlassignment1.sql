drop database if exists sqlassignment;

create database sqlassignment;
use sqlassignment;

drop table if exists employees;
drop table if exists department;
drop table if exists salary_grade;

create table department(
dep_id int,
dep_name varchar(20),
dep_location varchar(15),
constraint pk_department_dep_id primary key(dep_id)
);

create table employees(
emp_id int,
emp_name varchar(15),
job_name varchar(10),
manager_id int,
hire_date date,
salary decimal(10,2),
commission decimal(7,2),
dep_id int,
constraint pk_employees_emp_id primary key(emp_id),
constraint fk_employees_dep_id foreign key(dep_id) references department(dep_id)
);

create table salary_grade(
grade int primary key,
min_salary int,
max_salary int
);

delete from employees ;
delete from department;
delete from salary_grade;


insert into department values(1001,'FIANANCE','SYDNEY');
insert into department values(2001,'AUDIT','MELBOURNE');
insert into department values(3001,'MARKETING','PERTH');
insert into department values(4001,'PRODUCTION','BRISBANE');

insert into employees values(68319,'KAYLING','PRESIDENT',NULL,'1991-11-18',6000,NULL,1001);
insert into employees values(66928,'BLAZE','MANAGER',68319,'1991-05-01',2750,NULL,3001);
insert into employees values(67832, 'CLARE', 'MANAGER',68319,'1991-06-09', 2550,NULL,1001);
insert into employees values(65646, 'JONAS', 'MANAGER',68319,'1991-04-02', 2957,NULL,2001);
insert into employees values(64989, 'ADELYN', 'SALESMAN',66928,'1991-02-20', 1700,400,3001);
insert into employees values(65271, 'WADE', 'SALESMAN',66928,'1991-02-22', 1350,600,3001);
insert into employees values(66564, 'MADDEN', 'SALESMAN',66928,'1991-09-28', 1350,1500,3001);
insert into employees values(68454, 'TUCKER', 'SALESMAN',66928,'1991-09-08', 1600,0,3001);
insert into employees values(68736, 'ADNRES', 'CLERK',67858,'1997-05-23', 1200,NULL,2001);
insert into employees values(69000, 'JULIUS', 'CLERK',66928,'1991-12-03', 1050,NULL,3001);
insert into employees values(69324, 'MARKER', 'CLERK',67832,'1992-01-23', 1400,NULL,1001);
insert into employees values(67858, 'SCARLET', 'ANALYST',65646,'1997-04-19', 3100,NULL,2001);
insert into employees values(69062, 'FRANK', 'ANALYST',65646,'1991-12-03', 3100,NULL,2001);
insert into employees values(63679, 'SANDRINE', 'CLERK',69062,'1990-12-18', 900,NULL,2001);

insert into salary_grade values(1,800,1300);
insert into salary_grade values(2,1301,1500);
insert into salary_grade values(3,1501,2100);
insert into salary_grade values(4,2101,3100);
insert into salary_grade values(5,3101,9999);

# 1. Write a query in SQL to display all the information of the employees.   

select * from employees;

# 2. Write a query in SQL to find the salaries of all employees 

select salary from employees;

#3. Write a query in SQL to display the unique designations for the employees.   

select distinct job_name from employees;

#4. Write a query in SQL to list the emp_name and salary is increased by 15% and expressed as no.of Dollars.

select emp_name,
format(1.15*salary,2) as "revised salary"
from employees;

#5. Write a query in SQL to produce the output of employees name and job name as a fromat of "Employee & Job".    

select concat(emp_name,'    ',job_name) as "employee & job"
from employees;

/*6. Write a query in SQL to produce the output of employees as follows.   
 Employee
JONAS (manager).*/

select concat(emp_name,'(',lower(job_name),')') as "employee"
from employees;

#7.  Write a query in SQL to list the employees with Hire date in the format like February 22, 1991.   

SELECT emp_name,
    DATE_FORMAT(hire_date, '%M %d, %Y') AS formatted_hire_date
FROM employees;

#8. Write a query in SQL to count the no. of characters with out considering the spaces for each name.    

select emp_name,length(trim(emp_name))
from employees;
select job_name,length(trim(job_name))
from employees;

#9. Write a query in SQL to list the emp_id,salary, and commission of all the employees.    

select emp_id,salary,commission from employees;

#10. Write a query in SQL to display the unique department with jobs.    

select distinct dep_id,job_name
from employees;

#11. Write a query in SQL to list the employees who does not belong to department 2001.    

select * from employees
where dep_id not in(2001);

#12. Write a query in SQL to list the employees who joined before 1991.

select * from employees
where hire_date<('1991-1-1');

#13. Write a query in SQL to display the average salaries of all the employees who works as ANALYST.   

select avg(salary),job_name
from employees
where job_name='analyst';

#14. Write a query in SQL to display the average salaries of all the employees who works as ANALYST.   

select * from employees
where emp_name='blaze';

#15. Write a query in SQL to display all the details of the employees whose commission is more than their salary. 

select * from employees
where commission>salary;

#16. Write a query in SQL to list the employees whose salary is more than 3000 after giving 25% increment.    

select * from employees
where(1.25*salary)>3000;

#17. Write a query in SQL to list the name of the employees, those having six characters to their name. 

select emp_name from employees
where length(emp_name)=6;

#18.  Write a query in SQL to list the employees who joined in the month January.

SELECT * FROM employees
WHERE month(hire_date)=01;

#19. Write a query in SQL to list the name of employees and their manager separated by the string 'works for'.   

SELECT CONCAT(e.emp_name, ' works for ', m.emp_name) AS employee_and_manager
FROM Employees e
LEFT JOIN Employees m ON e.manager_id = m.emp_id;

#20.  Write a query in SQL to list all the employees whose designation is CLERK.    

select * from employees
where job_name='clerk';

#21. Write a query in SQL to list the employees whose experience is more than 27 years.   

SELECT * FROM employees 
WHERE TIMESTAMPDIFF(YEAR, hire_date, CURDATE()) > 27;

#22. Write a query in SQL to list the employees whose salaries are less than 3500.

select * from employees
where salary<3500;

#23. Write a query in SQL to list the name, job_name, and salary of any employee whose designation is ANALYST.    

use sqlassignment;
select emp_name,job_name,salary from employees
where job_name='analyst';

#24. Write a query in SQL to list the employees who have joined in the year 1991. 

select * from employees
where year(hire_date)='1991';

#25. Write a query in SQL to list the name, id, hire_date, and salary of all the employees joined before 1 apr 91.    

select emp_name,emp_id,hire_date,salary from employees
where hire_date<'1991-04-01';

#26. Write a query in SQL to list the employee name, and job_name who are not working under a manager.    

select emp_name,job_name from employees
where manager_id is NULL;

#27. Write a query in SQL to list all the employees joined on 1st may 91.

select * from employees
where hire_date='1991-05-01';

#28. Write a query in SQL to list the id, name, salary, and experiences of all the employees working for the manger 68319.

select emp_id,salary,emp_name,TIMESTAMPDIFF(YEAR, hire_date, CURDATE())as "experience"
from employees;

#29. Write a query in SQL to list the id, name, salary, and experience of all the employees who earn more than 100 as daily salary.    

select emp_id,emp_name,salary,timestampdiff(year,hire_date,curdate())as "experience"
from employees
where (salary/30)>100;

#30. Write a query in SQL to list the employees who are retiring after 31-Dec-99 after completion of 8 years of service period. 

SELECT emp_name FROM employees
WHERE DATE_ADD(hire_date, INTERVAL 8 YEAR) > '1999-12-31';

#31. Write a query in SQL to list those employees whose salary is an odd value.    

select * from employees
where salary %2=1;

#32. Write a query in SQL to list those employees whose salary contain only 3 digits. 

select * from employees
where length(format(salary,'#####'))=3;

#33. Write a query in SQL to list the employees who joined in the month of APRIL.    

SELECT * FROM employees
WHERE month (hire_date) =04;

#34. Write a query in SQL to list the employees those who joined in company before 19th of the month.    

select * from employees
where day(hire_date)<'19';

#35. List the employees who are SALESMAN and gathered an experience which month portion is more than 10.    

use sqlassignment;
select * from employees
where job_name='salesman'
and timestampdiff(day,hire_date,curdate())>10;

#36. Write a query in SQL to list the employees of department id 3001 or 1001 joined in the year 1991.    

select * from employees
where (dep_id=3001 or dep_id=1001)
and year(hire_date)=1991;

#37. Write a query in SQL to list the employees who are working for the department ID 1001 or 2001.

select * from employees
where dep_id=1001 or dep_id=2001;

#38. Write a query in SQL to list all the employees of designation CLERK in department no 2001.   

select * from employees
where job_name='clerk'
and dep_id=2001;

/*39. Write a query in SQL to list the ID, name, salary, and job_name of the employees for -    
1. Annual salary is below 34000 but receiving some commission which should not be more than the salary,
2. And designation is SALESMAN and working for department 3001.*/

select emp_id,emp_name,salary,job_name from employees
where 12*(salary+commission)>34000 and commission is not null
and commission>salary
and job_name='salesman' and dep_id=3001;

#40. Write a query in SQL to list the employees who are either CLERK or MANAGER.    

select emp_name from employees 
where job_name = 'clerk' OR job_name = 'manager';

#41. Write a query in SQL to list the employees who joined in any year except the month February.    

select * from employees
where month(hire_date)!=2;

#42. Write a query in SQL to list the employees who joined in the year 91.    

select * from employees
where year(hire_date)=1991;

#43. Write a query in SQL to list the employees who joined in the month of June in 1991. 

select * from employees
where month(hire_date)=06
and year(hire_date)=1991;

#44. Write a query in SQL to list the employees whose annual salary is within the range 24000 and 50000. 

select * from employees
where 12*salary between 24000 and 50000;

#45. Write a query in SQL to list the employees whose annual salary is within the range 24000 and 50000. 

select * from employees
where hire_date in('1991-05-01','1991-02-20','1991-12-03');

#46. Write a query in SQL to list the employees working under the managers 63679,68319,66564,69000.    

select * from employees
where manager_id in(63679,68319,66564,69000);

#47. Write a query in SQL to list the employees who joined after the month JUNE in the year 1992.    

select * from employees
where hire_date>'1992-06-30';

#48. Write a query in SQL to list the employees who joined in 90's.    

select * from employees
where year(hire_date)between 1990 and 1999;

#49. Write a query in SQL to list the managers of department 1001 or 2001.    

select * from employees
where job_name='manager'
and (dep_id=1001 or dep_id=2001);

#50. Write a query in SQL to list the employees, joined in the month FEBRUARY with a salary range between 1001 to 2000 .

select * from employees
where month(hire_date)=02
and salary between 1001 and 2000;

#51. Write a query in SQL to list all the employees who joined before or after 1991. 

select * from employees
where year(hire_date)!=1991;

#52. Write a query in SQL to list the employees along with department name.    

select e.emp_id,e.emp_name,e.job_name,e.manager_id,
       e.hire_date,e.salary,e.commission,e.dep_id,d.dep_name 
from employees e,department d
where e.dep_id=d.dep_id;

#53. Write a query in SQL to list the name, job name, annual salary, department id, department name and grade of the employees who earn 60000 in a year or not working as an ANALYST.   

select e.emp_name,e.job_name,(e.salary*12)as 'annual_salary',d.dep_id,d.dep_name,s.grade
from employees e,department d,salary_grade s
where e.dep_id=d.dep_id
and e.salary between s.min_salary and s.max_salary
and (((e.salary*12)>=60000)
or e.job_name!='analyst');

#54. Write a query in SQL to list the name, job name, manager id, salary, manager name, manager's salary for those employees whose salary is greater than the salary of their managers.    

select e.emp_name,e.job_name,e.salary,e.manager_id,m.emp_name as 'manager_name',m.dep_id,m.salary as 'manager_salary'
from employees e,employees m
where e.emp_id=m.manager_id
and e.salary>m.salary;

#55. Write a query in SQL to list the employees name, department, salary and commission. For those whose salary is between 2000 and 5000 while location is PERTH.    

select e.emp_name,e.salary,d.dep_name,e.commission
from employees e,department d
where e.dep_id=d.dep_id
and e.salary between 2000 and 5000
and d.dep_location='perth';

#56. Write a query in SQL to list the grade, employee name for the department id 1001 or 3001 but salary grade is not 4 while they joined the company before 1992-12-31.

select s.grade,e.emp_name
from employees e,salary_grade s
where e.dep_id in(1001,3001)
and hire_date<('1992-12-31')
and (e.salary between s.min_salary and s.max_salary and s.grade not in (4));

#57. Write a query in SQL to list the employees whose manager name is JONAS.   

select e.emp_name,e.job_name,e.manager_id,e.hire_date,e.salary,e.dep_id,
       m.emp_name as manager_name
 from employees e,employees m
where e.emp_id=m.emp_id
and e.emp_name=m.emp_name
and m.emp_name='jonas';

#58. Write a query in SQL to list the name and salary of FRANK if his salary is equal to max_sal of his grade.   

select e.emp_name,e.salary
from employees e,salary_grade s
where e.emp_name='frank'
and e.salary between s.min_salary and s.max_salary
and e.salary=s.max_salary;

#59. Write a query in SQL to list the employees who are working either MANAGER or ANALYST with a salary range between 2000 to 5000 without any commission.   

select * from employees
where job_name='analyst' or job_name='manager'
and salary between 2000 and 5000
and commission is null;

#60. Write a query in SQL to list the id, name, salary, and location of the employees working at PERTH,or MELBOURNE with an experience over 10 years.  

select e.emp_id,e.emp_name,e.dep_id,e.salary,d.dep_location
from employees e,department d
where e.dep_id=d.dep_id
and d.dep_location in('perth','melbourne')
and TIMESTAMPDIFF(YEAR, hire_date, CURDATE()) > 10;

#61. Write a query in SQL to list the employees along with their location who belongs to SYDNEY, MELBOURNE with a salary range between 2000 and 5000 and joined in 1991.

select e.emp_id,e.emp_name,d.dep_location,e.hire_date,e.salary
from employees e,department d
where e.dep_id=d.dep_id
and d.dep_location in('sydney','melbourne')
and e.salary between 2000 and 5000
and year(hire_date)=1991;

#62. Write a query in SQL to list the employees with their location and grade for MARKETING department who comes from MELBOURNE or PERTH within the grade 3 to 5 and experience over 5 years.   

select e.emp_id,e.emp_name,d.dep_location,s.grade,e.hire_date
from employees e,department d,salary_grade s
where e.dep_id=d.dep_id
and dep_name='marketing'
and dep_location in('malbourne','perth')
and e.salary between s.min_salary and s.max_salary
and s.grade in(3,4,5)
and timestampdiff(year,hire_date,curdate())>5;

#63. . Write a query in SQL to list the employees who are senior to their own manager. 

SELECT E.emp_name, E.hire_date,M.emp_name,M.hire_date
FROM employees E
INNER JOIN employees M ON E.manager_id = M.emp_id
WHERE E.hire_date < M.hire_date;

#64. Write a query in SQL to list the employee with their grade for the grade 4.    

select * from employees e,salary_grade s
where e.salary between s.min_salary and s.max_salary
and s.grade=4;

#65. Write a query in SQL to list the employees in department PRODUCTION or AUDIT who joined after 1991 and they are not MARKER or ADELYN to their name. 

select * from employees e
inner join department d on e.dep_id=d.dep_id
and dep_name in('production','audit')
and year(e.hire_date)>1991
and e.emp_name not in('marker','adelyn');

#66. Write a query in SQL to list the employees in the ascending order of their salaries.    

select emp_name from employees 
order by salary asc;

#67. Write a query in SQL to list the details of the employees in ascending order to the department_id and descending order to the jobs.    

select * from employees
order by dep_id asc, job_name desc;

#68. Write a query in SQL to display all the unique job in descending order.   

select distinct job_name from employees
order by job_name desc;

#69. Write a query in SQL to list the id, name, monthly salary, daily salary of all the employees in the ascending order of their annual salary.    

select emp_id,emp_name,salary,salary/30 as 'daily salary',salary*12 as 'annual salary' from employees
order by salary*12 asc;

#70. Write a query in SQL to list the employees in descending order who are either 'CLERK' or 'ANALYST'. 

select * from employees
where job_name in('clerk','analyst')
order by job_name desc;

#71. Write a query in SQL to display the location of CLARE.

select e.emp_name,d.dep_location from employees e
left join department d on e.dep_id=d.dep_id
where e.emp_name='clare';

#72. Write a query in SQL to list the employees in ascending order of seniority who joined on 1-MAY-91,or 3-DEC-91, or 19-JAN-90. 

select * from employees
where hire_date in('1991-05-01','1991-12-03','1990-01-19')
order by hire_date asc;

#73. Write a query in SQL to list the employees who are drawing the salary less than 1000 and sort the output in ascending order on salary. 

select * from employees
where salary<1000
order by salary asc;

#74. Write a query in SQL to list the details of the employees in ascending order on the salary. 

select * from employees
order by salary asc;

#75. Write a query in SQL to list the employees in ascending order on job name and descending order on employee id. 

select * from employees
order by job_name asc,emp_id desc;

#76. Write a query in SQL to list the unique jobs of department 2001 and 3001 in descending order.  

select distinct job_name from employees
where dep_id in(2001,3001)
order by job_name desc;

#77. Write a query in SQL to list all the employees except PRESIDENT and MANAGER in ascending order of salaries.

select * from employees
where job_name not in('president','manager')
order by salary asc;

#78. Write a query in SQL to list the employees in ascending order of the salary whose annual salary is below 25000.    

select * from employees
where salary*12<25000
order by salary;

#79. Write a query in SQL to list the employee id, name, annual salary, daily salary of all the employees in the ascending order of annual salary who works as a SALESMAN.   

select emp_id,emp_name,salary*12 as 'annual salary',salary/30 as 'daily salary' from employees
where job_name='salesman'
order by salary*12 asc;

#80. Write a query in SQL to list the employee id, name, hire_date, current date and experience of the employees in ascending order on their experiences.   

select emp_id,emp_name,hire_date,
timestampdiff(year,hire_date,curdate())as 'experience',
curdate()as 'current date' from employees
order by experience asc;

#81. Write a query in SQL to list the employees in ascending order of designations of those, joined after the second half of 1991.  

select * from employees
where hire_date between '1991-07-01' and '1991-12-31'
order by job_name asc;

#82. Write a query in SQL to list the total information of employees table along with department, and location of all the employees working under FINANCE and AUDIT in the ascending department no. 

select * from employees e
left join department d on e.dep_id=d.dep_id
where d.dep_name in('finance','audit')
order by d.dep_id;

#83. Write a query in SQL to display the total information of the employees along with grades in ascending order.

select * from employees e,salary_grade s
where e.salary between s.min_salary and  s.max_salary
order by grade asc;

#84. Write a query in SQL to list the name, job name, department, salary, and grade of the employees according to the department in ascending order.

select e.emp_name,e.job_name,e.dep_id,e.salary,d.dep_name,s.grade
from employees e,department d,salary_grade s
where e.dep_id=d.dep_id
and e.salary between s.min_salary and s.max_salary
order by d.dep_name asc;

#85. Write a query in SQL to list the name, job name, salary, grade and department name of employees except CLERK and sort result set on the basis of highest salary.   

select e.emp_name,e.job_name,e.salary,d.dep_name
from employees e,department d,salary_grade s
where e.dep_id=d.dep_id
and e.job_name!='clerk'
order by e.salary desc;

#86. Write a query in SQL to list the employee ID, name, salary, department, grade, experience, and annual salary of employees working for department 1001 or 2001.  

select e.emp_id,e.emp_name,e.salary,(12*e.salary)as 'annual salary',d.dep_name,s.grade,timestampdiff(year,e.hire_date,curdate()) as 'experience'
from employees e
left join department d on e.dep_id=d.dep_id
left join salary_grade s on salary between min_salary and max_salary
where e.dep_id in(1001,2001);

#87. Write a query in SQL to list the details of the employees along with the details of their departments. 

select * from employees e
left join department d on e.dep_id=d.dep_id;

#88. Write a query in SQL to list the employees who are senior to their own MANAGERS.    

select e.emp_id,e.emp_name,m.manager_id from employees e,employees m
where m.emp_id=e.manager_id
and  m.hire_date>e.hire_date;

#89. Write a query in SQL to list the employee id, name, salary, and department id of the employees in ascending order of salary who works in the department 1001.   

select emp_id,emp_name,salary,dep_id from employees
where dep_id=1001
order by salary asc;

#90. Write a query in SQL to find the highest salary from all the employees.    

select max(salary)as "highest salary"  from employees;

#91. Write a query in SQL to find the average salary and average total remuneration(salary and commission) for each type of job.    

select avg(salary) as "average salary",
avg(salary+coalesce(commission,0))as 'remuration',job_name from employees
group by job_name;

#92. Write a query in SQL to find the total annual salary distributed against each job in the year 1991. 

select sum(12*salary)as "annual salary",job_name from employees
where year(hire_date)='1991'
group by job_name;

#93. Write a query in SQL to list the employee id, name, department id, location of all the employees.    

select e.emp_id,e.emp_name,e.dep_id,d.dep_location from employees e
left join department d on e.dep_id=d.dep_id;

#94. Write a query in SQL to list the employee id, name, location, department of all the departments 1001 and 2001.    

select e.emp_id,e.emp_name,e.dep_id,d.dep_name,d.dep_location from employees e
left join department d on e.dep_id=d.dep_id
where e.dep_id in(1001,2001);

#95. Write a query in SQL to list the employee id, name, salary, grade of all the employees. Sample table: employees.

select e.emp_id,e.emp_name,e.salary,s.grade from employees e
left join salary_grade s on salary between min_salary and max_salary;

#96. Write a query in SQL to list the manager no and the number of employees working for those managers in ascending order on manager id. 

select manager_id,count(*)as 'number of employees' from employees
where manager_id is not null
group by manager_id
order by manager_id asc;

#97. Write a query in SQL to display the number of employee for each job in each department.

select count(*)as 'no of employees',job_name,dep_id from employees
group by job_name,dep_id;

#98. . Write a query in SQL to list the department where at least two employees are working.    

select dep_id,count(*)as 'no of employees' from employees
group by dep_id
having count(*)>=2;

#99. Write a query in SQL to display the Grade, Number of employees, and maximum salary of each grade.   

select s.grade,count(*)as 'no of employees',s.max_salary from employees e
left join salary_grade s on e.salary between s.min_salary and s.max_salary
group by s.grade;

#100. Write a query in SQL to display the department name, grade, no. of employees where at least two employees are working as a SALESMAN.

select d.dep_name,s.grade,count(*)as 'no of employees',e.job_name from employees e
left join department d on e.dep_id=d.dep_id
left join salary_grade s on e.salary between s.min_salary and s.max_salary
where e.job_name='salesman'
group by d.dep_name,s.grade
having count(*)>=2;

#101. Write a query in SQL to list the no. of employees in each department where the no. is less than 4. 

select count(*)as 'no of employees',dep_id from employees
group by dep_id
having count(*)<4;

#102. Write a query in SQL to list the name of departments where atleast 2 employees are working in that department.    

select count(*)as 'no of employess',d.dep_name from employees e
left join department d on e.dep_id=d.dep_id
group by d.dep_name
having count(*)>=2;

#103. Write a query in SQL to check whether all the employees numbers are indeed unique.

select emp_id,count(*)as 'no of employees' from employees
group by emp_id;

#104. Write a query in SQL to list the no. of employees and average salary within each department for each job name.    

select count(*)as 'no of employees',avg(salary)as'average salary',dep_id,job_name from employees
group by dep_id,job_name;

#105. Write a query in SQL to list the names of those employees starting with 'A' and with six characters in length.    

select emp_name from employees
where emp_name like 'a%'
and length(trim(emp_name))=6;

#106. Write a query in SQL to list the employees whose name is six characters in length and third character must be 'R'.    

select emp_name from employees
where emp_name like '__r%'
and length(trim(emp_name))=6;

#107. Write a query in SQL to list the name of the employee of six characters long and starting with 'A' and ending with 'N'. 
 
select emp_name from employees
where emp_name like 'a%n'
and length(trim(emp_name))=6; 

#108. Write a query in SQL to list the employees who joined in the month of which second character is 'a'.   

select * from employees
where date_format(hire_date,'%M') like '_a%';

#109. . Write a query in SQL to list the employees whose names containing the character set 'AR' together.   

select * from employees
where emp_name like '%ar%';

#110. Write a query in SQL to list the employees those who joined in 90's. 

select * from employees
where year(hire_date)=1990;

#111. Write a query in SQL to list the employees whose ID not starting with digit 68.    

select * from employees
where emp_id not like '68%';

#112. Write a query in SQL to list the employees whose names containing the letter 'A'.   

select * from employees
where emp_name like '%a%';

#113. Write a query in SQL to list the employees whose name is ending with 'S' and six characters long.    

select * from employees
where emp_name like '%s'
and length(trim(emp_name))=6;

#114. Write a query in SQL to list the employees who joined in the month having char 'A' at any position. 

select * from employees
where date_format(hire_date,'%M') like '%a%';

#115. Write a query in SQL to list the employees who joined in the month having second char is 'A'.    

select * from employees
where date_format(hire_date,'%M') like '_a%';





















