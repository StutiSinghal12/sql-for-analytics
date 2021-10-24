1.A...Aggregate function =avg,count,min,max -----difference is if you want to take these aggregates but group them by different categorie sin the column

ques --> max salary 
select max(salary) as max_sal from employee

ques-->max salary in each dept
select dept_name ,max(slary)  as max_sal from employee group by dept_name

ques-->extract max salary +all other details ===use window function 
select e.*,max(salary) over() as max_salary from employee e ;

It will treat max as window function rather than aggregate function creating window of records.

ques-->extract max salary corresponding to each dept ===here we should create one window for every dept and fetch details of that corresponding to max sal of that dept
select e.*,max(salary) over(partition by department) as max_slaray from employee e ;

ques-->compare each employee's salary with average salary of corresponsing department.Output dept,frst name,slaary, along with avg slaary of that dept

select frst_name ,slalary,department,avg(slaary) over(partition by department) as avg from employee ;

*******************************************************************************************************
window functions in sql 

1....ROW_NUMBER()
= assign unique no to each row=== window created with row numbers

select e.* ,row_number() over() as rn from from employee e ;

select e.* ,row_number() over(partition by department) as rn from from employee e ; ===for each unquie dept 1 window and row numbers for each dept.

ques-->fetch 1st 2 employee that joined company in each dept 
select * from(
select e.* ,row_number() over(partition by department order by emp_id) as rn from from employee e ) x where x.rn < 3;

2...RANK()

ques--->fetch top 3 employees who earn max salary in each department

select * from (
select e.*,rank() over(partition by dept_name order by salary desc) as rnk from employee e ) x where x.rnk < 4 ;

3....DENSE_RANK()===it will not skip a rank for duplicate salary 

select e.*,rank() over(partition by dept_name order by salary desc) as rnk 
,dense_rank() over(partition by dept_name order by salary desc) as dense_rnk from employee e ;

NOTHING PASSED INSIDE RANK,ROW_NUM,DENSE_RANK because it assigns a number for every record for whatver is written in over clause

4....LEAD() and LAG()=== record from previous record

select e.*,lag(salary,2,0) over(partition by dept_name order by emp_id ) as prev_emp_salary from employee ===2 record previous to current record and if none then display 0.

ques-->Fetch a query to display if salary of an employee is higher,lower or equal to previous employee.

select e.*,
lag(salary) over(partition by dept_name order by emp_id ) as prev_emp_salary ,
case when e.salary > lag(salary) over(partition by dept_name order by emp_id ) then 'higher then prev employee salary '
     when e.salary < lag(salary) over(partition by dept_name order by emp_id ) then 'lower then prev employee salary '
     when e.salary = lag(salary) over(partition by dept_name order by emp_id ) then 'same as prev employee salary'
     end sal_range
from employee e

-----------------------------------***************************************----------------------------------------------------
Window function specification Via rows between -->

If you don't specify anything then by default all rows in partition participate in calculation
1.unbound preceeding---all row before current row are considered
2.unbound following---all row after current row are considered
3.current row---range starts or ends at current row
--earlier range number has to come first
or u can specify number also 2 preceeding or 1 following
case1--To read previous row value
select sid,
sum(sid) over(order by rows between 1 preceding and 1 preceding)as sid2 from table1
o/p---> 
sid  sid2
1    null
2     1
3     2
4     3
5     4
case2--to read all previous rows value
select sid,
sum(sid) over(order by rows between unbound preceding and 1 preceding)as sid2 from table1
o/p--->
sid  sid2
1    null
2     1
3     3
4     6
5     10
case3--read previous 2 rows
select sid,
sum(sid) over(order by rows between 2 prceding and 1 preceding)as sid2 from table1
case4--to read next row only
select sid,
sum(sid) over(order by rows between 1 following and 1 following )as sid2 from table1
case5--to include current row also
select sid,
sum(sid) over(order by rows between currentrow and 1 following )as sid2 from table1
case6- previous row and current row
select sid,
sum(sid) over(order by rows between  1 preceding and currentrow )...
