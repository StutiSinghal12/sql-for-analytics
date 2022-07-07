find duplicates?
i/p
emp_id sal
1.     100
2.     200
1.     300
1.     400

select emp_id,count(1) from table group by emp id having count(1)>1

delete dup?
with cte as
(
select emp_id,row_num() over(partition by emp_id order by emp_id)as rn from emp
)
delete from cte where rn>1

union all->will not remove duplicates from two select queries

employe salry gr8 than mang salary

select e.empid,e.name as emp_name,m.nmae as manager name,e.sal as emp sal,m.salary as manager salry from employee as e inner join eployee as m 
on e.manager id=m.emp id and e.sal>m.salary

swap gender
upddate employee set cx gender case when  cx_gender='male' then gender='female' 
                               case case when  cx_gender='female' then gender='male' end
