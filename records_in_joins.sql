i/p :-
table1
1
1
table2
1
1
1

table1 inner join table2 ---> t1*t2 =6 records
table1 left join table2 --> inner join + unmatched of table1 also-->6
table1 rgt join table2 -->6
outer -->6 

all answers are same because records are matching

i/p:-
1
1
2

1
1
1
3

inner-->2*3=6
left-->6+1=7
right-->6+1=7
outer-->6+1+1=8

i/p
1
1
2
2

1
1
1
3
2
inner-->6+2=8
left-->8
right-->8+1=9
outer-->8+1=9

i/p
1
1
2
2
4

1
1
1
3
2
2

full outer-->6+4+1+1=12

i/p
1
1
2
2
4
null

1
1
1
3
2
2
null

nulls dont join , null is not equal to null
inner-->3*2+2*2=10
left-->6+4+1(null)+1=12
right-->6+4+1+1=12
outer-->10+1+1+1+1=14 records

NULL SAFE JOIN 

i/p:-
col A
1
2
1
5
null
null

col B
2
5
5
null

select c1.cola,c2.colb from tble1 as c1 inner join table2 as c2 on c1.cola=c2.colb or (c1.cola is null and c2.colb is null)

o/p :-

2 2
5 5
5 5
null null
null null

or 
select c1.cola,c2.colb from tble1 as c1 inner join table2 as c2 on c1.cola <=> c2.colb
