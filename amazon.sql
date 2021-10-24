Revenue Over Time
Find the 3-month rolling average of total revenue from purchases given a 
table with users, their purchase amount, and date purchased. Do not include 
returns which are represented by negative purchase values. Output the year-month (YYYY-MM) 
and 3-month rolling average of revenue, sorted from earliest month to latest month.

A 3-month rolling average is defined by calculating the average total revenue from all user
purchases for the current month and previous two months. The first two months will not be a true 3-month 
rolling average since we are not given data from last year. Assume each month has at least one purchase.

amazon_purchases
user_id            int
created_at         datetime
purchase_amt       int


--define cte with total revenue per month
--type cast column to date dtype to aggregate
--filter negavtibve purchase amt
--merge cte with itself for monthly shift
--calculate avg
--order earliest to latest
with revenue as
(
    select to_date(to_char(created_at,'YYYY-MM'),'YYYY-MM-01') as month_year,
    sum(purchase_amt) as revenue_month
    from amazon_purchases
    where purchase_amt>=0
    group by month_year
)
select to_char(m1.month_year,'YYYY-MM') AS MONTH,
(m1.revenue_month+ m2.revenue_month+ m3.revenue_month)/3 as
rolling_avg from revenue m1
join revenue m2 on m2.month_year =m1.month_year- INTERVAL '1 months'
join revenue m3 on m3.month_year =m1.month_year- INTERVAL '2 months'

------------------------------------------------------------------------------------------------------------

WITH WINDOW FUNC
--define cte with total revenue per month
--type cast column to date dtype to aggregate
--filter negavtibve purchase amt
--use window fun to calulctae roln avg
--order earliest to latest
with revenue as
(
    select to_date(to_char(created_at::date,'YYYY-MM'),'YYYY-MM-01') as month_year,
    sum(purchase_amt) as revenue_month
    from amazon_purchases
    where purchase_amt>=0
    group by month_year
)

select month_year ,
avg(revenue_month) over (order by month_year rows between  2 preceding and current row)
as rolln_avg
from revenue
