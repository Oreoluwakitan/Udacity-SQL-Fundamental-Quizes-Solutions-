*JOINS*
1.
SELECT a.primary_poc, w.occurred_at, w.channel
FROM web_events w
JOIN accounts a
on w.account_id = a.id
WHERE a.name = 'Walmart'

2.
SELECT r.name region_name, s.name rep_name, a.name account_name
FROM region r
JOIN sales_reps s
on r.id = s.region_id
JOIN accounts a
on a.sales_rep_id = s.id
order by 3 

3.
SELECT r.name reg_name, a.name acct_name, o.total_amt_usd/(o.total+0.01) unit_price
FROM orders o
join accounts a
on o.account_id = a.id
join sales_reps s
on a.sales_rep_id = s.id
JOIN region r
on s.region_id = r.id
order by 3 desc

4.
SELECT r.name region_name, s.name rep_name, a.name account_name
FROM region r
JOIN sales_reps s
on r.id = s.region_id
JOIN accounts a
on a.sales_rep_id = s.id
WHERE r.name = 'Midwest'
order by 3 

5.
SELECT r.name regrion_name, s.name rep_name, a.name account_name
FROM region r
JOIN sales_reps s
on r.id = s.region_id
JOIN accounts a
on a.sales_rep_id = s.id
WHERE r.name = 'Midwest' AND s.name like 'S%'
order by 3 

6.
SELECT r.name regrion_name, s.name rep_name, a.name account_name
FROM region r
JOIN sales_reps s
on r.id = s.region_id
JOIN accounts a
on a.sales_rep_id = s.id
WHERE r.name = 'Midwest' AND s.name like '% K%'
order by 3 

7.
SELECT r.name reg_name, a.name acct_name, o.total_amt_usd/(o.total+0.01) unit_price
FROM orders o
join accounts a
on o.account_id = a.id
join sales_reps s
on a.sales_rep_id = s.id
JOIN region r
on s.region_id = r.id
WHERE o.standard_qty >100
order by 3 desc

8.
SELECT r.name reg_name, a.name acct_name, o.total_amt_usd/(o.total+0.01) unit_price
FROM orders o
join accounts a
on o.account_id = a.id
join sales_reps s
on a.sales_rep_id = s.id
JOIN region r
on s.region_id = r.id
WHERE o.standard_qty >100 and poster_qty > 50
order by 3 desc 

9.
SELECT DISTINCT a.id, w.channel
FROM accounts a
JOIN web_events w
on a.id = w.account_id
WHERE a.id = 1001

10.
SELECT o.occurred_at, a.name, o.total, o.total_amt_usd
FROM orders o
JOIN accounts a
on o.account_id = a.id
WHERE o.occurred_at BETWEEN '2015-01-31' and '2015-12-31'
order by 1

*AGGREGATIONS*
1.
SELECT sum(poster_qty) sum_poster_qty
FROM orders

2.
SELECT sum(standard_qty) sum_standard_qty
FROM orders

3.
SELECT sum(total_amt_usd) sales_in_usd
FROM orders

4.
SELECT sum(standard_amt_usd) sales_on_standard,
	   sum(gloss_amt_usd) sales_on_gloss
FROM orders

5.
SELECT round(sum(standard_amt_usd)/sum(standard_qty), 2) unit_price
FROM orders

6.
SELECT min(occurred_at)
FROM orders

7.
SELECT occurred_at
FROM orders
ORDER by 1 
LIMIT 1

8.
SELECT account_id, 
		max(occurred_at) most_recent_time, 
		channel
FROM web_events

9.
SELECT account_id, occurred_at most_recent_time, channel
FROM web_events
ORDER by 2 DESC
LIMIT 1

10.
SELECT avg(standard_amt_usd),
	   avg(gloss_amt_usd),
	   avg(poster_amt_usd),
	   avg(standard_qty),
	   avg(gloss_qty),
	   avg(poster_qty)
FROM orders

11.
SELECT a.name acct_name, min(o.occurred_at) order_date
FROM accounts a
JOIN orders o
on a.id = o.account_id

12.
SELECT a.name acct_name, sum(o.total_amt_usd) total_sales
FROM accounts a
JOIN orders o
on a.id = o.account_id
GROUP by 1
ORDER by 2

13.
SELECT a.name acct_name, max(w.occurred_at) event_date, w.channel
FROM accounts a
JOIN web_events w
on a.id = w.account_id

14.
SELECT DISTINCT channel, count(*) Occurence
FROM web_events
GROUP by 1

15.
SELECT a.name acct_name, min(w.occurred_at) event_date, w.channel, a.primary_poc
FROM accounts a
JOIN web_events w
on a.id = w.account_id

16.
SELECT a.name acct_name, min(total_amt_usd)
FROM accounts a
JOIN orders o
on a.id = o.account_id
GROUP by 1
ORDER by 2 DESC

17.
SELECT DISTINCT r.name reg_name, count(*) no_of_salesReps
FROM region r
JOIN sales_reps s
on r.id = s.region_id
GROUP by 1
ORDER by 2 

18.
SELECT a.name acct_name, 
	   round(avg(standard_qty), 2) avg_standard,
	   round(avg(poster_qty), 2) avg_poster,
	   round(avg(gloss_qty), 2) avg_gloss
FROM accounts a
JOIN orders o
on a.id = o.account_id
GROUP by 1
ORDER by 2,3,4

19.
SELECT a.name acct_name, 
	   round(avg(standard_amt_usd), 2) avg_standard,
	   round(avg(poster_amt_usd), 2) avg_poster,
	   round(avg(gloss_amt_usd), 2) avg_gloss
FROM accounts a
JOIN orders o
on a.id = o.account_id
GROUP by 1
ORDER by 2,3,4

20.
SELECT s.name salesRep_name, w.channel, count(*) occurence
FROM sales_reps s
JOIN accounts a
on s.id = a.sales_rep_id
JOIN web_events w
on w.account_id = a.id
GROUP by 1

21.
SELECT r.name reg_name, w.channel event_channel, count(*) occurence
FROM web_events w
JOIN accounts a
on w.account_id = a.id
JOIN sales_reps s
on a.sales_rep_id= s.id
JOIN region r
on r.id = s.region_id
GROUP by 1,2

22.
SELECT DISTINCT a.name acct, r.name reg_name, count(*) occurence
FROM accounts a
JOIN sales_reps s
on a.sales_rep_id= s.id
JOIN region r
on r.id = s.region_id
GROUP by 1

23.
SELECT DISTINCT s.name rep_name, count(a.id) occurence
FROM accounts a
JOIN sales_reps s
on a.sales_rep_id= s.id
JOIN region r
on r.id = s.region_id
GROUP by 1

24.
SELECT DISTINCT s.name rep_name, count(a.id) occurence
FROM accounts a
JOIN sales_reps s
on a.sales_rep_id= s.id
JOIN region r
on r.id = s.region_id
GROUP by 1
HAVING count(a.id) > 5

25.
SELECT a.name acct, count(*) num_of_orders
FROM accounts a
JOIN orders o
on a.id = o.account_id
GROUP by 1
HAVING count(*) > 20

26.
SELECT a.name acct, count(*) num_of_orders
FROM accounts a
JOIN orders o
on a.id = o.account_id
GROUP by 1
HAVING count(*) > 20
ORDER by 2 DESC
LIMIT 1

27.
SELECT a.name acct
FROM accounts a
JOIN orders o
on a.id = o.account_id
GROUP by 1
HAVING sum(o.total_amt_usd) > 30000

28.
SELECT a.name acct
FROM accounts a
JOIN orders o
on a.id = o.account_id
GROUP by 1
HAVING sum(o.total_amt_usd) < 1000

29.
SELECT a.name acct, sum(o.total_amt_usd) total_orders_in_usd
FROM accounts a
JOIN orders o
on a.id = o.account_id
GROUP by 1
ORDER by 2 DESC
LIMIT 1;

30.
SELECT a.name acct, sum(o.total_amt_usd) total_orders_in_usd
FROM accounts a
JOIN orders o
on a.id = o.account_id
GROUP by 1
ORDER by 2 
LIMIT 1;

31.
SELECT a.name acct_name
FROM web_events w
JOIN accounts a
on w.account_id = a.id
WHERE w.channel = 'facebook'
GROUP by 1
HAVING count(*) > 6

32.
SELECT a.name acct_name, count(*) occurence
FROM web_events w
JOIN accounts a
on w.account_id = a.id
WHERE w.channel = 'facebook'
GROUP by 1
ORDER by 2 DESC
LIMIT 1;

33.
SELECT DISTINCT w.channel web_channel, count(*) occurence
FROM accounts a
JOIN web_events w
ON a.id = w.account_id
GROUP by 1
ORDER by 2 DESC
LIMIT 1;

34.
 /*strftime is how sqlite extracts date.*/
SELECT strftime('%Y', occurred_at) Year, sum(total_amt_usd) total_sales
FROM orders 
GROUP by 1
order by 2 DESC

35.
SELECT strftime('%m', occurred_at) Month, sum(total_amt_usd) total_sales
FROM orders 
GROUP by 1
order by 2 DESC

36.
SELECT strftime('%Y',occurred_at) Year, sum(total) total_orders
FROM orders
GROUP by 1
order by 2 DESC

37.
SELECT strftime('%m',occurred_at) Month, sum(total) total_orders
FROM orders
GROUP by 1
order by 2 DESC

38.
SELECT strftime('%m-%Y', occurred_at) Month, max(o.gloss_amt_usd)
FROM accounts a
JOIN orders o
on a.id = o.account_id
WHERE a.name = 'Walmart'

39.
SELECT account_id,
		sum(total_amt_usd) total_sales_in_dollars,
		CASE
		WHEN sum(total_amt_usd) >= 3000 THEN 'Large'
		WHEN sum(total_amt_usd) < 3000 THEN 'Small'
		END Level_of_order
FROM orders
GROUP by 1

40.
SELECT CASE 
	WHEN total >= 2000 THEN 'AT LEAST 2000' 
	WHEN total >= 1000 AND total < 2000 THEN 'BETWEEN 1000 & 2000' 
	WHEN total < 1000 THEN 'LESS THAN 1000' END Order_categories,
count(*) occurence
FROM orders
GROUP by 1;

41.
SELECT a.name acct_name,
		sum(total_amt_usd) total_sales,
		CASE
		WHEN sum(total_amt_usd) > 200000 THEN 'High_level Customer'
		WHEN sum(total_amt_usd)  BETWEEN 100000 and 200000 THEN 'Mid_Level Customer'
		ELSE 'Lower_level Customer' end Customer_lifetime_value
FROM orders o
JOIN accounts a
on o.account_id = a.id
GROUP by 1
ORDER by 2 DESC

42.
SELECT a.name acct_name,
		sum(total_amt_usd) total_sales,
		CASE
		WHEN sum(total_amt_usd) > 200000 THEN 'High_level Customer'
		WHEN sum(total_amt_usd)  BETWEEN 100000 and 200000 THEN 'Mid_Level Customer'
		ELSE 'Lower_level Customer' end Customer_lifetime_value
FROM orders o
JOIN accounts a
on o.account_id = a.id
WHERE o.occurred_at BETWEEN '2016-01-01' AND '2017-12-31'
GROUP by 1
ORDER by 2 DESC

43.
SELECT s.name rep_name, 
	count(o.id) no_of_sales,
	CASE WHEN count(o.id) > 200 THEN 'Top seller'
	ELSE 'Not Top seller' END Sales_Rep_performance
FROM sales_reps s
JOIN accounts a
on s.id = a.sales_rep_id
JOIN orders o
on a.id = o.account_id
GROUP by 1
ORDER by 2 DESC;

44.
SELECT s.name rep_name, 
	count(o.id) no_of_sales,
	sum(total_amt_usd) total_sales,
	CASE 
	WHEN count(o.id) > 200 or sum(total_amt_usd) > 750000  THEN 'Top seller'
	WHEN count(o.id) > 150 or sum(total_amt_usd) > 500000 THEN 'Mid seller'
	ELSE 'Low seller' END Sales_Rep_performance
FROM sales_reps s
JOIN accounts a
on s.id = a.sales_rep_id
JOIN orders o
on a.id = o.account_id
GROUP by 1
ORDER by 2 DESC;