find new customers and repeat customer count by each date
table(cx_tb)-->
order_id.  cx_id.  orderdate
1          100      1 jan
2          200.     1 jan 
3.         300      1 jan
4          100      2 jan 
5          400      2 jan 

with frst_ord as
(
select cx_id,min(order_date) as frst_order from cx_tb group by cx_id
)

select cx.order_date,sum(case when cx.orderdate=fst.frst_order then 1 else 0 end) as new_cx,sum(case when cx.orderdate!=fst.frst_order then 1 else 0 end) 
as old_cx
from cx_tb as cx inner join frst_ord as fst on fst.cx_id=cx.cx_id
groupby 1
