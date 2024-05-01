# Subqueries

# are queries within queries

SELECT *
FROM employee_demographics;


#WE wanted to look at employees who actually work in the Parks and Rec Department, 
#instead of join tables together, we could use a subquery


SELECT *
FROM employee_demographics
WHERE employee_id IN 
			(SELECT employee_id
				FROM employee_salary
                WHERE dept_id = 1);
                
#subquery in the where statement and 
#the subquery is basically a list we are selecting from in the outer query
# Subquery can only have 1 column
	
-- Let's say I want to look at the salaries and compare them to the average salary
# I can use subqueries in the select and the from statements

SELECT first_name, salary, AVG(salary)
FROM employee_salary;
-- Run this will return Error because I'm using columns with an aggregate function so I need to use group by
-- if I use group by I don't exactly get what I want

SELECT first_name, salary, AVG(salary)
FROM employee_salary
GROUP BY first_name, salary;

-- it's giving us the average PER GROUP which I don't want
-- here's a good use for a subquery

SELECT first_name, salary, (SELECT AVG(salary) 
				FROM employee_salary)
FROM employee_salary;

--Or I can also use it in the FROM Statement
--that will create a small table we are querying off of
SELECT *
FROM (SELECT gender, MIN(age), MAX(age), COUNT(age),AVG(age)
	FROM employee_demographics
	GROUP BY gender) 
;
-- now this doesn't work because we get an error saying we have to name it
-- let's use aliasing!

SELECT gender, AVG(Min_age)
FROM (SELECT gender, MIN(age) Min_age, MAX(age) Max_age, COUNT(age) Count_age ,AVG(age) Avg_age
	FROM employee_demographics
	GROUP BY gender) AS Agg_Table
GROUP BY gender
;



























