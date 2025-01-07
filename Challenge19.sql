-- CHALLENGE 19 --------------------------------------------
/* 
How much total salary was paid to all employees including those bonuses?

Employees will receive a bonus if their last performance review score is higher than the average last performance review score of all employees. The bonus is 15% extra on top of their salary.

Example Schema: 
CREATE TABLE employees (
    employee_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    salary DECIMAL(10, 2) NOT NULL,
    year_end_performance_scores INTEGER[] NOT NULL
);

Example Result:
 total_salary_with_bonuses 
---------------------------
                 381550.00

*/
-- SOLUTION --------------------------------------------- 
with last_review_cte as (
	select 
		employee_id, 
		salary,
		year_end_performance_scores[array_length(year_end_performance_scores, 1)] as last_review_score 
	from employees
), 
avg_review_cte as (
	select avg(last_review_score) as avg_review_score from last_review_cte
)
select 
	sum(
 		case 
 			when last_review_score > (select avg_review_score from avg_review_cte) then salary * 1.15
 			else salary
 		end
	)
from last_review_cte

-- RESULT ---------------------------------------------
-- 5491552488.10

