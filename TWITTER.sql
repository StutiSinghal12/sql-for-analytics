Highest Salary In Department
Find the employee with the highest salary per department.
Output the department name, employee's first name along with the corresponding salary.


--1.subquery approach

select department,first_name,salary from employee where
(department,salary) in 
(
select department,max(salary) from employee group by 1
)


--2. self join
select e.first_name,e.department,e.salary from employee e join (
select department,max(salary) as max_salary from employee group by 1)a
on e.department=a.department and e.salary=a.max_salary

--3window 
select department,first_name,salary from (
 select * ,max(salary) over(partition by department)highest_salary from employee
 )a
 where salary=highest_salary
 
 --4 window rank
 select * from 
(
select department,first_name,salary,rank() over
(partition by department order by salary desc) as rank from employee
)a
where rank=1

