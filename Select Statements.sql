-- SELECT statement

-- selecting all the columns in the table 
SELECT * FROM employees;
SELECT * FROM shops;
SELECT * FROM locations;
SELECT * FROM suppliers;

-- select some (3) columns of table
SELECT
	employee_id,
	first_name,
	last_name
FROM employees;

--  select statements with conditions using the WHERE clause, AND & OR

-- Select only the employees who make more than 50k
SELECT *
FROM employees
WHERE salary > 50000
order by salary desc; -- to see the highest paid employees

-- Select only the employees who work in Common Grounds coffeshop
SELECT *
FROM employees
WHERE coffeeshop_id = 1; -- because the id for common grounds is 1

-- Select all the employees who work in Common Grounds and make more than 50k
SELECT *
FROM employees
WHERE salary > 50000 AND coffeeshop_id = 1 -- using 'and' we get only the values that meet BOTH conditions
order by salary desc;

-- Select all the employees who work in Common Grounds or make more than 50k
SELECT *
FROM employees
WHERE salary > 50000 OR coffeeshop_id = 1; -- using 'or' we get all the values that meet ANY of the two conditions

-- Select all the employees who work in Common Grounds, make more than 50k and are male
SELECT *
FROM employees
WHERE
	salary > 50000
	AND coffeeshop_id = 1
	AND gender = 'M';
    
SELECT *
FROM employees
WHERE
	salary > 50000
	AND coffeeshop_id = 1
	AND gender = 'F';    

-- Select all the employees who work in Common Grounds or make more than 50k or are male
SELECT *
FROM employees
WHERE
	salary > 50000
	OR coffeeshop_id = 1
	OR gender = 'M';
    
-- select statements with IN, NOT IN, IS NULL, BETWEEN

-- Select all rows from the suppliers table where the supplier is Beans and Barley
SELECT *
FROM suppliers
WHERE supplier_name = 'Beans and Barley';

-- Select all rows from the suppliers table where the supplier is NOT Beans and Barley
SELECT *
FROM suppliers
WHERE NOT supplier_name = 'Beans and Barley';

SELECT *
FROM suppliers
WHERE supplier_name <> 'Beans and Barley'; -- the not equals sign can also be written as '!='

-- Select all Robusta and Arabica coffee types
SELECT *
FROM suppliers
WHERE coffee_type IN ('Robusta', 'Arabica');

SELECT *
FROM suppliers
WHERE
	coffee_type = 'Robusta'
	OR coffee_type = 'Arabica';

-- Select all coffee types that are not Robusta or Arabica
SELECT *
FROM suppliers
WHERE coffee_type NOT IN ('Robusta', 'Arabica'); -- filtering out the two coffe types

-- Select all employees with missing email addresses
SELECT *
FROM employees
WHERE email IS NULL;

-- Select all employees whose emails are not missing
SELECT *
FROM employees
WHERE NOT email IS NULL;

-- Select all employees who make between 35k and 50k
SELECT
	employee_id,
	first_name,
	last_name,
	salary
FROM employees
WHERE salary BETWEEN 35000 AND 50000;

-- or 
SELECT
	employee_id,
	first_name,
	last_name,
	salary
FROM employees
WHERE
	salary >= 35000
	AND salary <= 50000;   
    
-- ORDER BY, LIMIT, DISTINCT, Renaming columns

-- Order by salary ascending 
SELECT
	employee_id,
	first_name,
	last_name,
	salary
FROM employees
ORDER BY salary;

-- Order by salary descending 
SELECT
	employee_id,
	first_name,
	last_name,
	salary
FROM employees
ORDER BY salary DESC;

-- Top 10 highest paid employees
SELECT
	employee_id,
	first_name,
	last_name,
	salary
FROM employees
ORDER BY salary DESC
LIMIT 10; -- to get specified amount of rows

-- Return all unique coffeeshop ids
SELECT DISTINCT coffeeshop_id
FROM employees; -- to get the number of coffee shops 

-- Return all unique countries
SELECT DISTINCT country
FROM locations; -- we have two countries 

-- Renaming columns
SELECT
	email,
	email AS email_address, 
	hire_date,
  hire_date AS date_joined,
	salary,
  salary AS pay
FROM employees;   

-- EXTRACT - extracting information from the date column 

SELECT
	hire_date as date,
	EXTRACT(YEAR FROM hire_date) AS year,
	EXTRACT(MONTH FROM hire_date) AS month,
	EXTRACT(DAY FROM hire_date) AS day
FROM employees;

-- String Manipulation - UPPER, LOWER, LENGTH, TRIM

-- Uppercase first and last names
SELECT
	first_name, -- selecting the column 
	UPPER(first_name) AS first_name_upper, -- changing to uppercase and giving an alias 
	last_name,
	UPPER(last_name) AS last_name_upper
FROM employees; -- from the table employees 

-- Lowercase first and last names
SELECT
	first_name,
	LOWER(first_name) AS first_name_upper,
	last_name,
	LOWER(last_name) AS last_name_upper
FROM employees;

-- Return the email and the length of emails
SELECT
	email,
	LENGTH(email) AS email_length
FROM employees;

-- TRIM - removes white space 
SELECT
    LENGTH('     HELLO     ') AS hello_with_spaces,
LENGTH('HELLO') AS hello_no_spaces,
    LENGTH(TRIM('     HELLO     ')) AS hello_trimmed; 
    
-- String Manipulation - Concatenation, Boolean expressions, wildcards

-- Concatenate first and last names to create full names
SELECT
	first_name,
	last_name,
	concat(first_name, ' ', last_name) AS full_name -- we're basically joining the two columns together and adding a space between them 
FROM employees;

-- Concatenate columns to create a sentence
SELECT 
	concat(first_name, ' ', last_name, ',' ' ', 'makes', ' ', salary) as name_pay
FROM employees;

-- Boolean expressios
-- if the person makes less than 50k, then true, otherwise false
SELECT
    salary,
	concat(first_name, ' ', last_name) AS full_name,
	(salary < 50000) AS less_than_50k -- returns 1(True) when the condition is met and 0(False) when the condition isn't met
FROM employees;

-- if the person is a female and makes less than 50k, then true, otherwise false
SELECT
    salary, gender, 
	concat(first_name, ' ', last_name) AS full_name,
	(salary < 50000 AND gender = 'F') AS less_than_50k_female -- boolean with two conditions
FROM employees;

-- Boolean expressions with wildcards (% subString)
-- if email has '.com', return true, otherwise false
SELECT
	email,
	(email like '%.com%') AS dotcom_flag
FROM employees;

SELECT
	email,
	(email like '%.gov%') AS dotgov_flag
FROM employees;

-- return only government employees
select
  concat(first_name, ' ', last_name) AS full_name,
  email as gov_email
from employees
where email like '%.gov%';  

-- String Manipulation SUBSTRING, POSITION, COALESCE

-- SUBSTRING - gets a text from the nth character 
-- Get the email from the 5th character
SELECT 
	email,
	SUBSTRING(email FROM 5) as part_email
FROM employees;

-- POSITION
-- Find the position of '@' in the email
SELECT 
	email,
	POSITION('@' IN email)
FROM employees;

-- SUBSTRING & POSITION to find the email client
SELECT 
	email,
	SUBSTRING(email FROM POSITION('@' IN email)) as email_client
FROM employees;

SELECT 
	email,
	SUBSTRING(email FROM POSITION('@' IN email) + 1) -- this removes the @ sign and now you have the exact email client
FROM employees;

-- COALESCE to fill missing emails with custom value
SELECT 
	email,
	COALESCE(email, 'NO EMAIL PROVIDED') as email_fill_null -- filling null values with 'no email provided' 
FROM employees;

-- Numerical Functions - MIN, MAX, AVG, SUM, COUNT

-- Select the minimum salary
SELECT MIN(salary) as min_sal
FROM employees;

-- Select the maximum salary
SELECT MAX(salary) as max_sal
FROM employees;

-- Select difference between maximum and minimum salary
SELECT MAX(salary) - MIN(salary) as diff_sal
FROM employees;

-- Select the average salary
SELECT AVG(salary)
FROM employees;

-- To remove all the decimals from the previous query, round average salary to nearest integer
SELECT ROUND(AVG(salary),0) as avg_sal
FROM employees;

-- Sum up the salaries
SELECT SUM(salary) as tot_sal
FROM employees;

-- Count the number of entries
SELECT COUNT(*) as no_of_emp
FROM employees;

SELECT COUNT(salary)
FROM employees;

SELECT COUNT(email)
FROM employees;

-- summary
SELECT
  MIN(salary) as min_sal,
  MAX(salary) as max_sal,
  MAX(salary) - MIN(salary) as diff_sal,
  round(avg(salary), 0) as average_sal,
  sum(salary) as total_sal,
  count(*) as num_of_emp
FROM employees;  

-- GROUP BY & HAVING

-- Return the number of employees for each coffeeshop
SELECT
  coffeeshop_id,
	COUNT(employee_id)
FROM employees
GROUP BY coffeeshop_id;

-- Return the total salaries for each coffeeshop
SELECT
  coffeeshop_id,
	SUM(salary) as tot_sal
FROM employees
GROUP BY coffeeshop_id -- whenever you use an aggregated func in your select statement, you always have to group by the column 
order by tot_sal desc;

-- Return the number of employees, the avg & min & max & total salaries for each coffeeshop
SELECT
	coffeeshop_id, 
	COUNT(*) AS num_of_emp,
	ROUND(AVG(salary), 0) AS avg_sal,
	MIN(salary) AS min_sal,
    MAX(salary) AS max_sal,
	SUM(salary) AS total_sal
FROM employees
GROUP BY coffeeshop_id
ORDER BY num_of_emp DESC;

-- HAVING
-- After GROUP BY, return only the coffeeshops with more than 200 employees
SELECT
	coffeeshop_id, 
	COUNT(*) AS num_of_emp,
	ROUND(AVG(salary), 0) AS avg_sal,
	MIN(salary) AS min_sal,
    MAX(salary) AS max_sal,
	SUM(salary) AS total_sal
FROM employees
GROUP BY coffeeshop_id
HAVING COUNT(*) > 200  -- after a group by, to filter we use the 'having' rather than the 'where' clause
ORDER BY num_of_emp DESC;

-- After GROUP BY, return only the coffeeshops with a minimum salary of less than 10k
SELECT
	coffeeshop_id, 
	COUNT(*) AS num_of_emp,
	ROUND(AVG(salary), 0) AS avg_sal,
	MIN(salary) AS min_sal,
    MAX(salary) AS max_sal,
	SUM(salary) AS total_sal
FROM employees
GROUP BY coffeeshop_id
HAVING MIN(salary) < 10000
ORDER BY num_of_emp DESC;

-- CASE STATEMENTS, CASE with GROUP BY, and CASE for transposing data

-- CASE - like if statements 
-- If pay is less than 50k, then low pay, otherwise high pay
SELECT
	employee_id,
	concat(first_name, ' ', last_name) as full_name,
	salary,
	CASE
		WHEN salary < 50000 THEN 'low pay'
		WHEN salary >= 50000 THEN 'high pay'
		ELSE 'no pay' -- if it doesn't meet the 2 criteria, then 'no pay'
	END as pay_category -- case statements should always finish with 'end'
FROM employees
ORDER BY salary DESC;

-- If pay is less than 20k, then low pay
-- if between 20k-50k inclusive, then medium pay
-- if over 50k, then high pay
SELECT
	employee_id,
	concat(first_name, ' ', last_name) as full_name,
	salary,
	CASE
		WHEN salary < 20000 THEN 'low pay'
		WHEN salary BETWEEN 20000 and 50000 THEN 'medium pay'
		WHEN salary > 50000 THEN 'high pay'
		ELSE 'no pay'
	END as pay_category
FROM employees
ORDER BY salary DESC;

-- CASE & GROUP BY 
-- Return the count of employees in each pay category
SELECT a.pay_category, COUNT(*) -- we're selecting from our sub category that we gave the alias a and counting the number in each category
FROM(
	SELECT
		employee_id,
	    concat(first_name, ' ', last_name) as full_name,
		salary,
    CASE
			WHEN salary < 20000 THEN 'low pay'
			WHEN salary BETWEEN 20000 and 50000 THEN 'medium pay'
			WHEN salary > 50000 THEN 'high pay'
			ELSE 'no pay'
		END as pay_category
	FROM employees
	ORDER BY salary DESC
) a
GROUP BY a.pay_category;

-- Transpose above - turning the rows into columns 
SELECT
	SUM(CASE WHEN salary < 20000 THEN 1 ELSE 0 END) AS low_pay,
	SUM(CASE WHEN salary BETWEEN 20000 AND 50000 THEN 1 ELSE 0 END) AS medium_pay,
	SUM(CASE WHEN salary > 50000 THEN 1 ELSE 0 END) AS high_pay
FROM employees; -- this query gives the same answer as the one above but instead of getting the result as rows, we get columns

-- JOIN

INSERT INTO locations VALUES (4, 'Paris', 'France');
INSERT INTO shops VALUES (6, 'Happy Brew', NULL);

-- Checking the values
SELECT * FROM shops;
SELECT * FROM locations;

-- INNER JOIN
SELECT 
	s.coffeeshop_name, -- s is an alias for the shop table
	l.city, -- l is an alias for the loacation table
	l.country -- l is an alias for the loacation table
FROM (
	shops s
	inner JOIN locations as l  -- inner join is the same with join, it is an intersection of the two tables, gives us the values that are in both tables 
	ON s.city_id = l.city_id
);

-- LEFT JOIN
SELECT
  s.coffeeshop_name,
  l.city,
  l.country
FROM
	shops s
	LEFT JOIN locations l
	ON s.city_id = l.city_id; -- this join gives us everything in the left table even if it's missing in the right table

-- RIGHT JOIN
SELECT
  s.coffeeshop_name,
  l.city,
  l.country
FROM
	shops s
	RIGHT JOIN locations l -- this join gives us everything in the right table even if it's missing in the left table
	ON s.city_id = l.city_id;

-- FULL OUTER JOIN - returns everything from both tables
SELECT * FROM
	shops s
    left join locations l
    ON s.city_id = l.city_id
union
SELECT * FROM
	shops s
    right join locations l
    ON s.city_id = l.city_id
    where s.city_id is Null; -- to exclude the rows already included in the left join
	

-- Delete values 
DELETE FROM locations WHERE city_id = 4;
DELETE FROM shops WHERE coffeeshop_id = 6;

-- UNION (to stack data on top each other) rather than joining data horizontally, we're stacking it vertically 

-- Return all cities and countries
SELECT city FROM locations
UNION
SELECT country FROM locations;

-- UNION removes duplicates
SELECT country FROM locations
UNION
SELECT country FROM locations;

-- UNION ALL keeps duplicates
SELECT country FROM locations
UNION ALL
SELECT country FROM locations;

-- Return all coffeeshop names, cities and countries
SELECT coffeeshop_name FROM shops
UNION
SELECT city FROM locations
UNION
SELECT country FROM locations;

-- Subqueries

-- Basic subqueries with subqueries in the FROM clause
SELECT *
FROM (
	SELECT *
	FROM employees
	where coffeeshop_id IN (3,4)
) as a;

SELECT
  a.employee_id,
	a.first_name,
	a.last_name -- now we are using the alias from our subquery to retrieve specific columns
FROM (
	SELECT *
	FROM employees
	where coffeeshop_id IN (3,4)
) a;

-- Basic subqueries with subqueries in the SELECT clause
SELECT
	first_name, 
	last_name, 
	salary,
	(
		SELECT MAX(salary)
		FROM employees
		LIMIT 1
	) max_sal
FROM employees;

SELECT
	first_name, 
	last_name, 
	salary,
	(
		SELECT ROUND(AVG(salary), 0)
		FROM employees
		LIMIT 1
	) avg_sal
FROM employees;

SELECT
	first_name, 
	last_name, 
	salary, 
	salary - ( -- avg_sal
		SELECT ROUND(AVG(salary), 0)
		FROM employees
		LIMIT 1
	) avg_sal_diff
FROM employees;

-- Subqueries in the WHERE clause
-- Return all US coffee shops
SELECT * 
FROM shops
WHERE city_id IN ( -- US city_id's
	SELECT city_id
	FROM locations
	WHERE country = 'United States'
);

-- Return all employees who work in US coffee shops
SELECT *
FROM employees
WHERE coffeeshop_id IN ( -- US coffeeshop_id's
	SELECT coffeeshop_id 
	FROM shops
	WHERE city_id IN ( -- US city-id's
		SELECT city_id
		FROM locations
		WHERE country = 'United States'
	)
);

-- Return all employees who make over 35k and work in US coffee shops
SELECT *
FROM employees
WHERE salary > 35000 AND coffeeshop_id IN ( -- US coffeeshop_id's
	SELECT coffeeshop_id
	FROM shops
	WHERE city_id IN ( -- US city_id's
		SELECT city_id
		FROM locations
		WHERE country = 'United States'
	)
);
