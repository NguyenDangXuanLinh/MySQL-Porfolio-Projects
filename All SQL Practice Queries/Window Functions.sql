-- Window Functions: OVER()
# OVER(PATITION BY __) | OVER(PATITION BY __ GROUP BY__)  : more funtionality 
-- Allow us to look at a partition or a group, but they each keep their own unique rows in the output

# ROW_NUMBER()  |  RANK()  | DENSE_RANK() : often used with WF	
-- Summary of the differences in those functions:
	-- row_number + rank: both return unique serial numbers
		-- rank: repeats the unique number if values are similar
		-- row_number: continue assign unique numbers despite the similarity.
	-- only dense_rank: return the values after ranking it in the PARTITION BY clause
	

SELECT * 
FROM employee_demographics;

#Let compare Group By and WF
-- first let's look at group by
	
SELECT gender, ROUND(AVG(salary),1)
FROM employee_demographics dem
JOIN employee_salary sal
	ON dem.employee_id = sal.employee_id
GROUP BY gender
;

-- now doing something similar with a window function (WF)

SELECT dem.employee_id, dem.first_name, gender, salary,
	AVG(salary) OVER()
FROM employee_demographics dem
JOIN employee_salary sal
	ON dem.employee_id = sal.employee_id
;

-- We can use AVG without doing a subquery in the select statement and it works 
# Doing WF keeps everything cleaner and shorter than subquery.

-- When add PATITION ON WF: it is just partitions or breaks based on a column when doing the calculation
-- Similar to Group By except it doesn't roll up
	

SELECT dem.employee_id, dem.first_name, gender, salary,
AVG(salary) OVER(PARTITION BY gender)
FROM employee_demographics dem
JOIN employee_salary sal
	ON dem.employee_id = sal.employee_id
;


-- Let's see the salaries were for genders with a rolling total (cumulative sume)

SELECT dem.employee_id, dem.first_name, gender, salary,
SUM(salary) OVER(PARTITION BY gender ORDER BY employee_id)
FROM employee_demographics dem
JOIN employee_salary sal
	ON dem.employee_id = sal.employee_id
;


-- Let's look at row_number, rank and dense rank now

#ROW_NUMBER(): give unique numbers for a partition, and the order of those numbers are based on 
	ORDER BY clause

-- To see the order of highest paid employees by gender	
SELECT dem.employee_id, dem.first_name, gender, salary,
ROW_NUMBER() OVER(PARTITION BY gender)
FROM employee_demographics dem
JOIN employee_salary sal
	ON dem.employee_id = sal.employee_id
;

-- To see the order of highest paid employees by gender, but ordering it by salary 
SELECT dem.employee_id, dem.first_name, gender, salary,
ROW_NUMBER() OVER(PARTITION BY gender ORDER BY salary desc)
FROM employee_demographics dem
JOIN employee_salary sal
	ON dem.employee_id = sal.employee_id
;


#RANK(): also give serial unique numbers, but similar value assigns the same number 
	then the next unique number = previous number - how many similar values before
	
-- let's compare row_number() and rank()
SELECT dem.employee_id, dem.first_name, gender, salary,
ROW_NUMBER() OVER(PARTITION BY gender ORDER BY salary desc) row_num,
Rank() OVER(PARTITION BY gender ORDER BY salary desc) rank_1 
FROM employee_demographics dem
JOIN employee_salary sal
	ON dem.employee_id = sal.employee_id
;

-- notice rank repeats on tom and jerry at 5, 
-- but then skips 6, and continue with 7 -- this goes based off positional rank


#DENSE_RANK() : affected by ORDER BY clause so it returns the values after ranking it 
	
-- let's compare this to dense rank
SELECT dem.employee_id, dem.first_name, gender, salary,
ROW_NUMBER() OVER(PARTITION BY gender ORDER BY salary desc) row_num,
Rank() OVER(PARTITION BY gender ORDER BY salary desc) rank_1,
dense_rank() OVER(PARTITION BY gender ORDER BY salary desc) dense_rank_2 -- this is numerically ordered instead of positional like rank
FROM employee_demographics dem
JOIN employee_salary sal
	ON dem.employee_id = sal.employee_id
;

-- notice that RANK returns numbers affected by PARTITION BY clause
-- that the different between RANK and DENSE_RANK. 















