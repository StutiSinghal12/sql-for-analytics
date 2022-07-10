select month(this_month.order_date),count(last_month.order_id)
from transa as this month left join trans as last month 
where datediff(month,this_month.order_date,last_month.order_date)=1
ad this_month.cx_id=last_month.cx_id
group by month(this_month.order_date)
