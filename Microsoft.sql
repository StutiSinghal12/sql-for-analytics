Bottom 2 Companies By Mobile Usage
Write a query that returns a list of the bottom 2 companies by mobile usage. Company is defined in the customer_id column.
Mobile usage is defined as the number of events registered on a client_id == 'mobile'. Order the result by the number of events ascending. 
In the case where there are multiple companies tied for the bottom ranks (rank 1 or 2), return all the companies. Output the customer_id and number of events.

-----------------**************_____________
select customer_id,events,rnk from
(
select customer_id,count(*) as events,dense_rank() over (order by count(*)) as rnk from fact_events where client_id='mobile'  
group by 1
)a
where rnk<=2
order by events asc

o/p:-
customer_id	events	rnk
Electric Gravity	4	1
eShop	4	1
Sendit	7	2
