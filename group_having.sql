i/p
stu_id subject   marks
1.      physics.  91
1       chem.     91
2       bio.      90
2.      chem.     90
3       ph.       89
3       chem.     23
3       bio.      15
4.      geo       12

Find students with same marks in physics and chem

select student_id from stu where subject in ('physics','chem') group by student_id having count(distinct subject)=2 and count(distinct marks)=1

i/p
company_id. user_id language
1           1            eng
1           1            ger
1           2            eng
1           3            german 
1           3            eng 
1           4            eng



find companies who have ateast 2 users who speak 2 languages english and german both

select com_id,count(1) from
(
select comp_id,userid,count(1) as no_of_lan from company where language in("eng",'german') groupby compid,userid having count(1)=2
)tab groupby comp_id having count(1)>=2
