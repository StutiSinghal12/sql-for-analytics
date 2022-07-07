i/p

emp_id salary 
1.     300
2.     900
3.     300
4.     10

select empid,rank() over(order by salary desc) as rn
select empid,dense_rank() over(order by salary desc) as rn -->doesnt skip numbers
select empid,row_num() over(order by salary desc) as rn -->normal running nos.

     rank desnser rownum
900. 1.    1.     1
300. 2.    2.     2
300. 2.    2.     3
10.  4.    3.     4

i/p

emp_id salary dep
1.     300.   101 
2.     900.   102
3.     300.   103
4.     10.    104

select empid,rank() over(partiotion by dep order by salary desc) as rn
select empid,dense_rank() over(partiotion by dep order by salary desc) as rn -->doesnt skip numbers
select empid,row_num() over(partiotion by dep order by salary desc) as rn -->normal running nos.

     rank desnser rownum
900. 1.    1.     1
300. 2.    2.     2
300. 2.    2.     3
10.  4.    3.     4

question --->give dept wise highest salray
rank=1 wale is answer
