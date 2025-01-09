-- CHALLENGE 21 --------------------------------------------
/* 
Find the quarter with the highest growth rate relative to the previous quarter's sales figures

Order by growth rate descending

Submit the year and quarter in the format YYYY,Q

EXAMPLE SCHEMA:
CREATE TABLE sales (
    id SERIAL PRIMARY KEY,
    sale_date DATE NOT NULL,
    amount DECIMAL(10, 2) NOT NULL
);

EXAMPLE RESULT:
year | quarter | total_sales |      growth_rate       
------+---------+-------------+------------------------
 2023 |       2 |     2000.00 | 0.33288903698767077641
 2023 |       3 |     2500.75 | 0.25037500000000000000
 2023 |       4 |     3000.00 | 0.19964010796760971708
 2024 |       1 |     3500.25 | 0.16675000000000000000
 2023 |       1 |     1500.50 |  
 
 EXAMPLE SUBMISSION:
 2023,2
 
*/
-- SOLUTION --------------------------------------------- 
with total_sales_cte as (
	select 
		extract(year from sale_date) as year,
		extract(quarter from sale_date) as quarter,
		sum(amount) as total_sales 
	from sales
	group by 1, 2
), 
lag_sales_cte as (
	select
		year,
		quarter,
		total_sales,
		lag(total_sales) over (order by year, quarter) as prev_quarter_sales
	from total_sales_cte
)
select
	year,
	quarter,
	total_sales,
	(total_sales - prev_quarter_sales) / nullif(prev_quarter_sales, 0) as growth_rate
from lag_sales_cte
order by growth_rate desc nulls last

-- RESULT ---------------------------------------------
-- 1997, 4


