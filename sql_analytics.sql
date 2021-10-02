How many US mentors and non US mentors are there?

SELECT
  CASE
    WHEN region != 'United States' THEN 'Non US'
    ELSE region
  END AS mentor_region,
  COUNT(*) AS mentor_count
FROM trading.members
GROUP BY mentor_region
ORDER BY mentor_count DESC;


mentor_region	mentor_count
United States	7
Non US	7

----*****------

How many mentors have a first name starting with a letter before 'E'?

Click here to reveal the solution!
SELECT
  COUNT(*) AS mentor_count
FROM trading.members
WHERE LEFT(first_name, 1) < 'E';

mentor_count
6

-----*****----
SELECT now()::timestamp(0);

Is equivalent to:

SELECT 
    CAST (now() AS timestamp(0))

In PostgreSQL - we cannot apply the ROUND function directly to approximate FLOAT or DOUBLE PRECISION data types.

Instead we will need to cast any outputs from functions such as AVG to an exact NUMERIC data type before we can use it with other approximation functions such as ROUND

 if we were to remove our ::NUMERIC from our query - we would run into this error:

ERROR:  function round(double precision, integer) does not exist
LINE 3:   ROUND(AVG(price), 2) AS average_eth_price
          ^
HINT:  No function matches the given name and argument types. You might need to add explicit type casts.

---*****-----
DATE_TRUNC() function can be tremendously useful for 
aggregating time-based data

DATE_TRUNC returns a TIMESTAMP data type which can be cast back to a regular
DATE using the ::DATE notation when used in a SELECT query.

----****--------
SELECT
  DATE_TRUNC('MON', market_date) AS month_start,
  -- need to cast approx. floats to exact numeric types for round!
  ROUND(AVG(price)::NUMERIC, 2) AS average_eth_price
FROM trading.prices
WHERE EXTRACT(YEAR FROM market_date) = 2020
GROUP BY month_start
ORDER BY month_start;

month_start	average_eth_price
2020-01-01 00:00:00+00	4267.73
2020-02-01 00:00:00+00	4937.66

---*****----------------------------------------

How many "breakout" days were there in 2020 where 
the price column is greater than the open 
column for each ticker?

SELECT
  ticker,
  SUM(CASE WHEN price > open THEN 1 ELSE 0 END) AS breakout_days
FROM trading.prices
WHERE DATE_TRUNC('YEAR', market_date) = '2020-01-01'
GROUP BY ticker;

ticker	breakout_days
BTC	207
ETH	200

-----*****-------
What percentage of days in 2020 were breakout days vs non-breakout days? Round the percentages to 2 decimal places

Click here to reveal the solution!

SELECT
  ticker,
  ROUND(
    SUM(CASE WHEN price > open THEN 1 ELSE 0 END)
      / COUNT(*)::NUMERIC,
    2
  ) AS breakout_percentage,
  ROUND(
    SUM(CASE WHEN price < open THEN 1 ELSE 0 END)
      / COUNT(*)::NUMERIC,
    2
  ) AS non_breakout_percentage
FROM trading.prices
WHERE market_date >= '2020-01-01' AND market_date <= '2020-12-31'
GROUP BY ticker;

ticker	breakout_percentage	non_breakout_percentage
BTC	0.57	                 0.43
ETH	0.55	                 0.45

When there is an INTEGER / INTEGER as there is in this case - SQL will default to FLOOR division in this case!

You can try running the same query as the solution to question 5 above - but this time remove the 2 instances of ::NUMERIC and the decimal place rounding to see what happens!

This is a super common error found in SQL queries and we usually recommend casting either the numerator or the denominator as a NUMERIC type using the shorthand ::NUMERIC syntax to ensure that you will avoid the dreaded integer floor division!

Click here to see the "wrong" code!
----***----

What was the monthly total quantity purchased and sold for Ethereum in 2020?

select month(mrkt_date),
sum(case when transcation_type='buy' then quantity else 0 end) as buy_quantity
 sum(case when transcation_type='sell' then quantity else 0 end) as sell_quantity
from t 
where ticker='etc'
month(ye)=2020
grp by cal_month
order by cal_month

calendar_month	buy_quantity	sell_quantity
2020-01-01	1882.7000203746428756	349.3725812083231374
2020-02-01	1531.0106358610396384	343.508128084135167
2020-03-01	1693.5669211461637014	366.959518007770558

-----****-------

select member_id,
sum(case when tt=buy and tick=bit then quant else 0 end ) as buy_q_bit 
sum(case when tt=sell and tick=bit then quant else 0 end) as sell_q_bit 
sum(case when tt=buy and tick=eth then quant else 0 end ) as buy_q_eth
sum(case when tt=sell and tick=eth then quant else 0 end) as sell_q_eth
from t group by m_id

-----*****------

What was the final quantity holding of Bitcoin for each member? Sort the output from the highest BTC holding to lowest

SELECT
  member_id,
  SUM(
    CASE
      WHEN txn_type = 'BUY' THEN quantity
      WHEN txn_type = 'SELL' THEN -quantity
      ELSE 0
    END
  ) AS final_btc_holding
FROM trading.transactions
WHERE ticker = 'BTC'
GROUP BY member_id
ORDER BY final_btc_holding DESC;

member_id	final_btc_holding
a87ff6	4160.219869506641749735
c20ad4	4046.09089667256706404
167909	3945.19808326050497234

Which members have sold less than 500 Bitcoin? Sort the output from the most BTC sold to least

Click here to reveal the `HAVING` solution!

SELECT
  member_id,
  SUM(quantity) AS btc_sold_quantity
FROM trading.transactions
WHERE ticker = 'BTC'
  AND txn_type = 'SELL'
GROUP BY member_id
HAVING SUM(quantity) < 500
ORDER BY btc_sold_quantity DESC;

Click here to reveal the `CTE` solution!

WITH cte AS (
SELECT
  member_id,
  SUM(quantity) AS btc_sold_quantity
FROM trading.transactions
WHERE ticker = 'BTC'
  AND txn_type = 'SELL'
GROUP BY member_id
)
SELECT * FROM cte
WHERE btc_sold_quantity < 500
ORDER BY btc_sold_quantity DESC;

Click here to reveal the `subquery` solution!

SELECT * FROM (
  SELECT
    member_id,
    SUM(quantity) AS btc_sold_quantity
  FROM trading.transactions
  WHERE ticker = 'BTC'
    AND txn_type = 'SELL'
  GROUP BY member_id
) AS subquery
WHERE btc_sold_quantity < 500
ORDER BY btc_sold_quantity DESC;

member_id	btc_sold_quantity
8f14e4	       445.743862547520261
eccbc8	       305.345489355233177

----*****-----

Which member_id has the highest buy to sell ratio by quantity?

Click here to reveal the solution!

SELECT
  member_id,
  SUM(CASE WHEN txn_type = 'BUY' THEN quantity ELSE 0 END) /
    SUM(CASE WHEN txn_type = 'SELL' THEN quantity ELSE 0 END) AS buy_to_sell_ratio
FROM trading.transactions
GROUP BY member_id
ORDER BY buy_to_sell_ratio DESC;

member_id	buy_to_sell_ratio
45c48c	19.91269871111331881
a87ff6	7.486010484765204502

step 4 last ques left









