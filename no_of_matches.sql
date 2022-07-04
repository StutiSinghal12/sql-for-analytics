table--> icc_world_cup
 i/p
 team1   team2    winner 
 india   pak      india
 us      india.     us
 
o/p
team name        no of matches playes      wins     losses
india            2                         1         1


select Team_1,count(1) as no_of_matches_played,sum(winflag) as no_of_matches_won, count(1)-sum(winflag) as no_of_losses
from (
select Team_1 ,CASE when Team_1 = Winner then 1 else 0 end as winflag
from icc_world_cup
union all
select Team_2 ,CASE when Team_2 = Winner then 1 else 0 end as winflag
from icc_world_cup) A
group by Team_1
order by no_of_matches_won desc
