-- 1.- Select everything from orders

SELECT * FROM orders;


-- 2.- Select id_account_id and occured_at from orders

SELECT id, account_id, occurred_at FROM orders;


-- 3.- From the previous query limit the data to only 15
SELECT
   table_name,
   column_name,
   data_type
FROM
   information_schema.columns
WHERE
   table_name = 'orders';

SELECT
   channel,
   account_id,
   occurred_at
FROM
     web_events
LIMIT 15;

-- 18: QUIZ - Order by
-- 1.- Write a query to return the 10 earliest orders in the orders table.
-- Include the id, occurred_at, and total_amt_usd.
SELECT
   id,
   total_amt_usd,
   occurred_at
FROM orders
ORDER BY occurred_at
LIMIT 10;


-- 2.- Write a query to return the top 5 orders in terms of largest total_amt_usd.
-- Include the id, account_id, and total_amt_usd.
SELECT
   id,
   account_id,
   occurred_at
FROM orders
ORDER BY total_amt_usd
DESC LIMIT 5;


-- 3.- Write a query to return the lowest 20 orders in terms of smallest total_amt_usd.
-- Include the id, account_id, and total_amt_usd.
SELECT
   id,
   account_id,
   total_amt_usd
FROM orders
ORDER BY total_amt_usd
LIMIT 20;

-- 21. Quiz: ORDER BY Part II

-- 1.- Write a query that displays the order ID, account ID, and total dollar amount for all the orders, sorted first by
-- the account ID (in ascending order), and then by the total dollar amount (in descending order).
SELECT
    id,
    account_id,
    total_amt_usd
FROM orders
ORDER BY
    account_id,
    total_amt_usd DESC;

-- 2.- Now write a query that again displays order ID, account ID, and total dollar amount for each order, but this time
-- sorted first by total dollar amount (in descending order), and then by account ID (in ascending order).

SELECT
    id,
    account_id,
    total_amt_usd
FROM orders
ORDER BY
    total_amt_usd DESC,
    account_id;

-- Compare the results of these two queries above. How are the results different when you switch the column you sort on first?
-- The first one first orders the accounts_id and then it shows the amounts in descending orders by account_id, besides
-- the other one orders first by the total amount and then it sorts by the account_id

-- In query #1, all of the orders for each account ID are grouped together, and then within each of those groupings,
-- the orders appear from the greatest order amount to the least. In query #2, since you sorted by the total dollar
-- amount first, the orders appear from greatest to least regardless of which account ID they were from. Then they are
-- sorted by account ID next. (The secondary sorting by account ID is difficult to see here, since only if there were
-- two orders with equal total dollar amounts would there need to be any sorting by account ID.) **


--- 24. Quiz: WHERE

-- 1.- Pulls the first 5 rows and all columns from the orders table that have a dollar amount of gloss_amt_usd greater than or equal to 1000.
SELECT * FROM orders WHERE gloss_amt_usd >= 1000 LIMIT 5;


-- 2.- Pulls the first 10 rows and all columns from the orders table that have a total_amt_usd less than 500.
SELECT * FROM orders WHERE total_amt_usd < 1000 LIMIT 10;


-- 27. Quiz: WHERE with Non-Numeric
SELECT name, website, primary_poc FROM accounts WHERE name = 'Exxon Mobil';

-- 30. Quiz: Arithmetic Operators

-- 1.- Create a column that divides the standard_amt_usd by the standard_qty to find the unit price for standard paper
-- for each order. Limit the results to the first 10 orders, and include the id and account_id fields.

SELECT id, account_id, standard_amt_usd/standard_qty AS unit_price_4paper FROM orders LIMIT 10;


-- 2.-Write a query that finds the percentage of revenue that comes from poster paper for each order. You will need to
-- use only the columns that end with _usd. (Try to do this without using the total column.) Display the id and account_id fields also.
-- NOTE - you will receive an error with the correct solution to this question. This occurs because at least one of the
-- values in the data creates a division by zero in your formula. You will learn later in the course how to fully handle
-- this issue. For now, you can just limit your calculations to the first 10 orders, as we did in question #1, and
-- you'll avoid that set of data that causes the problem.

SELECT id, account_id,
       poster_amt_usd/(standard_amt_usd + gloss_amt_usd + poster_amt_usd) AS post_per
FROM orders
LIMIT 10;

-- 34. Quiz: LIKE
-- Use the  table to find

-- All the companies whose names start with 'C'.
SELECT * FROM accounts WHERE name LIKE 'C%';

-- All companies whose names contain the string 'one' somewhere in the name.
SELECT * FROM accounts WHERE name LIKE '%one%';

-- All companies whose names end with 's'.
SELECT * FROM accounts WHERE name LIKE '%s';


-- 37. Quiz: IN
-- 1.- Use the accounts table to find the account name, primary_poc, and sales_rep_id for Walmart, Target, and Nordstrom.
SELECT name, primary_poc, sales_rep_id FROM accounts WHERE name IN ('Walmart', 'Target', 'Nordstrom');

-- 2.- Use the web_events table to find all information regarding individuals who were contacted via the channel of organic or adwords.

SELECT * FROM web_events WHERE channel IN ('organic', 'adwords');

-- 40. Quiz: NOT
-- Questions using the NOT operator
-- We can pull all of the rows that were excluded from the queries in the previous two concepts with our new operator.
--
-- Use the accounts table to find the account name, primary poc, and sales rep id for all stores except Walmart, Target, and Nordstrom.
SELECT name, primary_poc, sales_rep_id FROM accounts WHERE name NOT IN ('Walmart', 'Target', 'Nordstrom');

-- Use the web_events table to find all information regarding individuals who were contacted via any method except using organic or adwords methods.
-- Use the accounts table to find:
SELECT * FROM web_events WHERE channel NOT IN ('organic', 'adwords');

-- All the companies whose names do not start with 'C'.
SELECT * FROM accounts WHERE name NOT LIKE 'C%';

-- All companies whose names do not contain the string 'one' somewhere in the name.
SELECT * FROM accounts WHERE name NOT LIKE '%one%';

-- All companies whose names do not end with 's'.
SELECT * FROM accounts WHERE name NOT LIKE '%s';

-- 43. Quiz: AND and BETWEEN
-- Write a query that returns all the orders where the standard_qty is over 1000, the poster_qty is 0, and the gloss_qty is 0.
SELECT * FROM orders WHERE standard_qty > 1000 AND poster_qty = 0 AND gloss_qty = 0;

-- Using the accounts table, find all the companies whose names do not start with 'C' and end with 's'.
SELECT * FROM accounts WHERE name NOT LIKE 'C%' AND name LIKE '%s';

-- When you use the BETWEEN operator in SQL, do the results include the values of your endpoints, or not? Figure out the
-- answer to this important question by writing a query that displays the order date and gloss_qty data for all orders
-- where gloss_qty is between 24 and 29. Then look at your output to see if the BETWEEN operator included the begin and end values or not.
SELECT * FROM orders WHERE gloss_qty BETWEEN 24 AND 29;
SELECT * FROM orders WHERE gloss_qty BETWEEN 24 AND 29 ORDER BY gloss_qty DESC ;

-- Use the web_events table to find all information regarding individuals who were contacted via the organic or adwords
-- channels, and started their account at any point in 2016, sorted from newest to oldest.
SELECT * FROM web_events WHERE
       channel IN ('organic', 'adwords') AND  occurred_at BETWEEN '2016-01-01' AND '2017-01-02' ORDER BY occurred_at DESC ;


-- 46. Quiz: OR
-- Find list of orders ids where either gloss_qty or poster_qty is greater than 4000. Only include the id field in the resulting table.
SELECT id FROM orders WHERE gloss_qty  > 4000 OR poster_qty > 4000;

-- Write a query that returns a list of orders where the standard_qty is zero and either the gloss_qty or poster_qty is over 1000.
SELECT id FROM orders WHERE standard_qty = 0 AND (gloss_qty  > 1000 OR poster_qty > 1000);

-- Find all the company names that start with a 'C' or 'W', and the primary contact contains 'ana' or 'Ana', but it doesn't contain 'eana'.
SELECT name, primary_poc FROM accounts WHERE (name LIKE 'C%' OR name LIKE 'W%')
              AND ((primary_poc LIKE '%ana%' OR primary_poc LIKE '%Ana%')
              AND primary_poc NOT LIKE '%eana%');
