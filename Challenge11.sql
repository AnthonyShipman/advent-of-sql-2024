-- CHALLENGE 11 --------------------------------------------
/* 
Mrs. Claus needs a comprehensive analysis of the tree farms. Using window functions, create a query that will shed some light on the field perfomance.

Show the 3-season moving average per field per season per year

Write a single SQL query using window functions that will reveal these vital patterns. Your analysis will help ensure that every child who wishes for a Christmas tree will have one for years to come.

Order them by three_season_moving_avg descending to make it easier to find the largest figure.

Seasons are ordered as follows:

Spring THEN 1
Summer THEN 2
Fall THEN 3
Winter THEN 4

Find the row with the most three_season_moving_avg

Table Schema:
CREATE TABLE TreeHarvests (
    field_name VARCHAR(50),
    harvest_year INT,
    season VARCHAR(6),
    trees_harvested INT
);

*/
-- SOLUTION --------------------------------------------- 
with ordinal_seasons_cte as (
	select 
		field_name,
		harvest_year,
		case season
			when 'Spring' then 1
			when 'Summer' then 2
			when 'Fall'	  then 3
			when 'Winter' then 4
		end as ordinal_season,
		trees_harvested
	from treeharvests
)
select
	field_name,
	harvest_year,
	ordinal_season,
    round(
    	avg(trees_harvested) over (
    		partition by field_name
        	order by harvest_year, ordinal_season 
        	rows between 2 preceding and current row
    	),
     2) as three_season_moving_average
from ordinal_seasons_cte
order by 4 desc

-- RESULT ---------------------------------------------
-- 327.67

