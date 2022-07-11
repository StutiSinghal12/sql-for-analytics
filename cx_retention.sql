---retension 
select month(this_month.order_date),count(last_month.order_id)
from transa as this month left join trans as last month 
where datediff(month,this_month.order_date,last_month.order_date)=1
ad this_month.cx_id=last_month.cx_id
group by month(this_month.order_date)

--churn 
select month(last_month.order_date),count(last_month.order_id)
from transa as last month left join trans as this month 
where datediff(month,last_month.order_date,this_month.order_date)=1
ad this_month.cx_id=last_month.cx_id and this_mnth.customer_id is null
group by month(last_month.order_date)
