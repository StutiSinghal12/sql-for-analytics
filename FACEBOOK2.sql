Rank Variance Per Country
Which countries have risen in the rankings based on the number of 
comments between Dec 2019 vs Jan 2020? Hint: Avoid gaps between ranks when ranking countries.

FB_comments_count
user_id                 int
created_At              date time
number_of_comments     int

fb_active_users
user_id                int
name                   varchar
status                 varchar
country                varchar

---users in a country by inner joining two tables 
--filter rows with no country
--sum(number of comments) in each country
--create 2 subq for dec and jan because we want to compare 
--use left join to compare keeping all jan and whose rank inc from dec
--rank 2019 comment counts and 2020 counts 
--apply final filter to fetch only countries with rank greater in jan rank >dec rank
with dec as
(
select country,sum(number_of_comments)
 dec_comments,
dense_rank() over (order by sum(number_of_comments) desc) as country_rank
from fb_active_users au left join
fb_comments_count cc
on cc.user_id=au.user_id
where date(created_at) between '2019-12-01' and '2019-12-31'
and country is not null
group by 1
order by 2 desc
)
,jan as
(
select country,sum(number_of_comments)
 as jan_comments,
dense_rank() over (order by sum(number_of_comments) desc) as country_rank
from fb_active_users au left join
fb_comments_count cc
on cc.user_id=au.user_id
where date(created_at) between '2020-01-01' and '2020-12-31'
and country is not null
group by 1
order by 2 desc
)

select * from jan j left join dec d on d.country=j.country
where (j.country_rank<d.country_rank) 
or d.country=null
