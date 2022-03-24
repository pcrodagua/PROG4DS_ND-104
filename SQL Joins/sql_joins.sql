-- Lesson 2: SQL Joins

SELECT o.*, a.* FROM orders o
JOIN accounts a on a.id = o.account_id

SELECT accounts.name, orders.occurred_at
FROM orders
JOIN accounts
ON orders.account_id = accounts.id ORDER BY accounts.name, orders.occurred_at ;

-- 04. Text + Quiz: Your First JOIN Questions
-- Try pulling all the data from the accounts table, and all the data from the orders table.
SELECT
   a.*,
   o.*
FROM
     accounts a
JOIN
     orders o ON a.id = o.account_id;
-- Try pulling standard_qty, gloss_qty, and poster_qty from the orders table, and the website and the primary_poc from the accounts table.
SELECT
   a.website,
   a.primary_poc,
   o.standard_qty,
   o.gloss_qty,
   o.poster_qty
FROM accounts a
JOIN orders o
ON a.id = o.account_id;

-- 08. Quiz: Primary - Foreign Key Relationship

-- id: The primary key in every table of our example database.
-- account_id: A foreign key that exists in both the web_events and orders tables.
-- Primary Key: Has a unique value for every row in that column. There is one in every table.
-- ON web_events.account_id = accounts.id: The ON statement associated with a JOIN of the web_events and accounts table.
-- Foreign Key: The link to primary key that exist in another table

-- Select all that are true for primary keys.
-- X There is one and only one of these columns in every table.
-- X They are a column in a table.

-- Select all that are true of foreign keys.
-- X They are always linked to a primary key.
-- X In the above database, every foreign key is associated with the crow-foot notation, which suggests it can appear multiple times in the column of a table.

-- 09. Text + Quiz: JOIN Revisited

-- Use the image above to assist you. If we wanted to join the sales_reps and region tables together, how would you do it
--  ON sales_reps.region_id = region.id

-- 11. Quiz: JOIN Questions Part I

-- 1.- Provide a table for all web_events associated with account name of Walmart. There should be three columns. Be sure to
-- include the primary_poc, time of the event, and the channel for each event. Additionally, you might choose to add a
-- fourth column to assure only Walmart events were chosen.

SELECT
    a.primary_poc,
    a.name,
    we.occurred_at,
    we.channel
FROM web_events we
INNER JOIN accounts a
ON a.id = we.account_id
WHERE a.name = 'Walmart';

-- 2.- Provide a table that provides the region for each sales_rep along with their associated accounts. Your final
-- table should include three columns: the region name, the sales rep name, and the account name. Sort the accounts
-- alphabetically (A-Z) according to account name.

SELECT
    r.name AS region_name,
    sr.name AS salesrep_name,
    a.name AS account_name
FROM accounts a
INNER JOIN sales_reps sr on sr.id = a.sales_rep_id
INNER JOIN region r on r.id = sr.region_id
ORDER BY a.name;
-- current solution
SELECT r.name region, s.name rep, a.name account
FROM sales_reps s
JOIN region r
ON s.region_id = r.id
JOIN accounts a
ON a.sales_rep_id = s.id
ORDER BY a.name;

--3.-  Provide the name for each region for every order, as well as the account name and the unit price they
-- paid (total_amt_usd/total) for the order. Your final table should have 3 columns: region name, account name, and
-- unit price. A few accounts have 0 for total, so I divided by (total + 0.01) to assure not dividing by zero.

SELECT
    r.name AS region_name,
    a.name AS account_name,
    (o.total_amt_usd/(o.total + 0.01)) as unit_price
FROM orders o
INNER JOIN accounts a on a.id = o.account_id
INNER JOIN sales_reps sr on sr.id = a.sales_rep_id
INNER JOIN region r on r.id = sr.region_id
ORDER BY a.name;

SELECT r.name region, a.name account,
           o.total_amt_usd/(o.total + 0.01) unit_price
FROM region r
JOIN sales_reps s
ON s.region_id = r.id
JOIN accounts a
ON a.sales_rep_id = s.id
JOIN orders o
ON o.account_id = a.id
ORDER BY a.name;

-- 4.- Mark all the below that are true.
-- X The ON statement should always occur with the foreign key being equal to the primary key.
-- X JOIN statements allow us to pull data from multiple tables in a SQL database.
-- X You can use all of the commands we saw in the first lesson along with JOIN statements.

-- 5.- Select all of the below statements that are true.
-- X If we want to alias a column, we must use an AS in our query.
-- X Aliasing is common to shorten table names when we start JOINing multiple tables together.

-- 16. LEFT and RIGHT JOIN
-- Select all of the below that are true.
-- A LEFT JOIN and RIGHT JOIN do the same thing if we change the tables that are in the FROM and JOIN statements.
-- A LEFT JOIN will at least return all the rows that are in an INNER JOIN.
-- JOIN and INNER JOIN are the same.
-- A LEFT OUTER JOIN is the same as LEFT JOIN.

-- QUIZ QUESTION::
-- Match each statement to the item it describes.

-- Country.countryName
-- State.stateName
-- State.stateid: the primary key of the state table
-- State.countryid The foreign key that would be used in Joining the tables
-- Country.countryid: The primary key of the Country table

-- cols 3
-- brazil 0
-- india 2
--  The number of rows in the resulting table. 6


-- 3 number of columns
-- 8 number of rows
-- the number of times countryid 1 will show up in resulting table: 2
-- the number of times countryid 6 will show up in resulting table: 1

-- 19. Quiz: Last Check

-- 1.- Provide a table that provides the region for each sales_rep along with their associated accounts.
-- This time only for the Midwest region. Your final table should include three columns: the region name,
-- the sales rep name, and the account name. Sort the accounts alphabetically (A-Z) according to account name.

SELECT
    r.name region_name,
    s.name sales_rep_name,
    a.name account_name
FROM sales_reps s
JOIN region r on r.id = s.region_id
JOIN accounts a on s.id = a.sales_rep_id
WHERE r.name = 'Midwest'
ORDER BY a.name;

-- 2.- Provide a table that provides the region for each sales_rep along with their associated accounts.
-- This time only for accounts where the sales rep has a first name starting with S and in the Midwest region.
-- Your final table should include three columns: the region name, the sales rep name, and the account name.
-- Sort the accounts alphabetically (A-Z) according to account name.
SELECT
    r.name region_name,
    s.name sales_rep_name,
    a.name account_name
FROM sales_reps s
JOIN region r on r.id = s.region_id
JOIN accounts a on s.id = a.sales_rep_id
WHERE r.name = 'Midwest' AND s.name LIKE 'S%'
ORDER BY a.name;

-- 3.- Provide a table that provides the region for each sales_rep along with their associated accounts.
-- This time only for accounts where the sales rep has a last name starting with K and in the Midwest region.
-- Your final table should include three columns: the region name, the sales rep name, and the account name.
-- Sort the accounts alphabetically (A-Z) according to account name.
SELECT
    r.name region_name,
    s.name sales_rep_name,
    a.name account_name
FROM sales_reps s
JOIN region r on r.id = s.region_id
JOIN accounts a on s.id = a.sales_rep_id
WHERE r.name = 'Midwest' AND (s.name LIKE '_%K%' or s.name LIKE '_%k%')
ORDER BY a.name;

-- 4.- Provide the name for each region for every order, as well as the account name and the
-- unit price they paid (total_amt_usd/total) for the order. However, you should only provide the results if the
-- standard order quantity exceeds 100. Your final table should have 3 columns: region name, account name, and unit price.
-- In order to avoid a division by zero error, adding .01 to the denominator here is helpful total_amt_usd/(total+0.01).

SELECT
    r.name region_name,
    a.name account_name,
    (o.total_amt_usd/o.total + 0.01) unit_price
FROM sales_reps s
JOIN region r on r.id = s.region_id
JOIN accounts a on s.id = a.sales_rep_id
JOIN orders o on a.id = o.account_id
WHERE standard_qty > 100
ORDER BY a.name;

-- 5.- Provide the name for each region for every order, as well as the account name and the unit price they
-- paid (total_amt_usd/total) for the order. However, you should only provide the results if the standard order quantity
-- exceeds 100 and the poster order quantity exceeds 50. Your final table should have 3 columns: region name, account name, and unit price.
-- Sort for the smallest unit price first. In order to avoid a division by zero error, adding .01 to the denominator here is helpful (total_amt_usd/(total+0.01).

SELECT
    r.name region_name,
    a.name account_name,
    (o.total_amt_usd/o.total + 0.01) unit_price
FROM sales_reps s
JOIN region r on r.id = s.region_id
JOIN accounts a on s.id = a.sales_rep_id
JOIN orders o on a.id = o.account_id
WHERE standard_qty > 100 AND o.poster_qty > 50
ORDER BY unit_price;

-- 6.- Provide the name for each region for every order, as well as the account name and the unit price they
-- paid (total_amt_usd/total) for the order. However, you should only provide the results if the standard order quantity
-- exceeds 100 and the poster order quantity exceeds 50. Your final table should have 3 columns: region name, account name, and unit price.
-- Sort for the largest unit price first. In order to avoid a division by zero error, adding .01 to the denominator here is helpful (total_amt_usd/(total+0.01).

SELECT
    r.name region_name,
    a.name account_name,
    (o.total_amt_usd/o.total + 0.01) unit_price
FROM sales_reps s
JOIN region r on r.id = s.region_id
JOIN accounts a on s.id = a.sales_rep_id
JOIN orders o on a.id = o.account_id
WHERE o.standard_qty > 100 AND o.poster_qty > 50
ORDER BY unit_price DESC ;

-- 7.- What are the different channels used by account id 1001? Your final table should have only 2 columns: account name
-- and the different channels. You can try SELECT DISTINCT to narrow down the results to only the unique values.
SELECT DISTINCT a.name, w.channel
FROM accounts a
JOIN web_events w ON a.id = w.account_id
WHERE a.id = 1001;

-- 8.- Find all the orders that occurred in 2015. Your final table should have 4 columns: occurred_at, account name, order total, and order total_amt_usd.
SELECT
    o.total,
    o.total_amt_usd,
    a.name,
    o.occurred_at
FROM orders o
JOIN accounts a on a.id = o.account_id
WHERE o.occurred_at BETWEEN '2015-01-01' AND '2016-01-01'
ORDER BY o.occurred_at DESC, a.name;

-- did not match the same query but same result
SELECT o.occurred_at, a.name, o.total, o.total_amt_usd
FROM accounts a
JOIN orders o
ON o.account_id = a.id
WHERE o.occurred_at BETWEEN '01-01-2015' AND '01-01-2016'
ORDER BY o.occurred_at DESC, a.name;
