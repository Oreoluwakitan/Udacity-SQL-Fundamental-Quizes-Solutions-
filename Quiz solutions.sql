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
