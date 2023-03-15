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