question-->
Below is the flight schedule mentioning the source and destination. We have to show the unique combination of source and destination as an output. For eg: Delhi to Mumbai and Mumbai to Delhi being one unique combination

#Input
+---------------+
src     dest
+---------------+
Delhi    Mum
Mum     Delhi
Delhi    Kolkata
Kolkata   Delhi
Mum     Nagpure 


#Required-Output
+-------------------+
src     dest
+-------------------+
Delhi    Mum
Mum     Nagpure
Delhi    Kolkata

solution-->
select vw1.*
from flight_schedule vw1 left join flight_schedule vw2 on vw1.src = vw2.dest and vw1.dest = vw2.src
where vw2.src is null or vw1.dest > vw1.src

On using left join 
a. We will get matching rows where inverse record exist like Delhi to Mumbai and Mumbai to Delhi
So using vw1.dest > vw1.src in where clause will restrict the one row out of 2

b. Also, we will get rows which have only single record for eg: Indore to Bangalore
In this scenario , I am not doing any comparison , just pulling the row as is by including vw2.src is null
