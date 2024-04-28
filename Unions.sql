#UNIONS

#A union is how you can combine rows together- not columns like joins
#Important to keep the same kind of data otherwise if you start mixing
  
--I'll try use Union to bring together some random data

SELECT first_name, last_name
FROM employee_demographics
UNION
SELECT occupation, salary
FROM employee_salary;

#The data will be one on top of the other in the same columns; not side by side in different columns
--This obviously is not good since I'm mixing data, but it can be done if needed.

SELECT first_name, last_name
FROM employee_demographics
UNION
SELECT first_name, last_name
FROM employee_salary;

-- It gets rid of duplicates! Union is actually shorthand for Union Distinct
-- Like this:
SELECT first_name, last_name
FROM employee_demographics
UNION DISTINCT
SELECT first_name, last_name
FROM employee_salary;

-- UNION ALL: to show all values

SELECT first_name, last_name
FROM employee_demographics
UNION ALL
SELECT first_name, last_name
FROM employee_salary;


--Now I'll use UNION in actual case
# The Parks department is trying to cut their budget 
  #and wants to identify older employees they can push out 
  #or high paid employees who they can reduce pay or push out
-- let's create some queries to help with this

SELECT first_name, last_name, 'Old'
FROM employee_demographics
WHERE age > 50;


SELECT first_name, last_name, 'Old Lady' as Label
FROM employee_demographics
WHERE age > 40 AND gender = 'Female'
UNION
SELECT first_name, last_name, 'Old Man'
FROM employee_demographics
WHERE age > 40 AND gender = 'Male'
UNION
SELECT first_name, last_name, 'Highly Paid Employee'
FROM employee_salary
WHERE salary >= 70000
ORDER BY first_name
;












