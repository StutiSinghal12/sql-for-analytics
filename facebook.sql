Return the share of monthly active users in the United States (US). Active users are the ones with an "open" status in the table

select 
   count(case when status = 'open' then user_id else null end) / 
   count(*)::FLOAT as ratio_active_users
from fb_active_users
where country = 'USA'

https://www.stratascratch.com/blog/most-common-sql-data-analyst-interview-questions-by-facebook/

