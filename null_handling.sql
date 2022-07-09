where dob=null -->wont work since null cant be compared to anything
where null=null--> this is also not valid and results in error
where dob is null , where dob is not null -->works 

select *,isnull(age,11) from customers --> if we want to fill null with something ,datatype of dob and 11 shd be same
select *,coalesce(dob,null,null,'2020-01-12') from blabla --> it will pick up first not null value ,yahan many arguments we can pass

select count(age) --> 5
select count(isnull(age,0)) -->6

select avg(age) from cus --> 21 ,it is dividing by 5 not by 6 
s0, select avg(isnull(age,0)) from cus-->17
