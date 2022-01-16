Q30: Inactive customers in May (easy)
https://sqlpad.io/questions/30/inactive-customers-in-may/

Instruction

Write a query to return the total number of customers who didn't rent any movies in May 2020.

Hint

You can use NOT IN to exclude customers who have rented movies in May 2020. 

        
Table 1: customer

  col_name   | col_type
-------------+--------------------------
 customer_id | integer
 store_id    | smallint
 first_name  | text
 last_name   | text
 email       | text
 address_id  | smallint
 activebool  | boolean
 create_date | date
 active      | integer
        
Table 2: rental

   col_name   | col_type
--------------+--------------------------
 rental_id    | integer
 rental_ts    | timestamp with time zone
 inventory_id | integer
 customer_id  | smallint
 return_ts    | timestamp with time zone
 staff_id     | smallint
        
        
Sample results:

 count
-------
 1234
        
*/

SELECT count(c.customer_id) FROM
customer c left join rental r on c.customer_id=r.customer_id 
where c.customer_id NOT IN (select customer_id from rental where extract(month from rental_ts)='5')
LIMIT 5;
