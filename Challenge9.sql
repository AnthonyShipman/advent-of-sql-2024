-- CHALLENGE 8 --------------------------------------------
/* 
Rudolph is retiring as lead reindeer, and Santa needs to analyze each reindeer's speed records to choose the new leader.

To do this you need to:
- Calculate the average speed for each reindeer in each exercise type, excluding Rudolf.
- Find the highest average speed for each reindeer amongst those average speeds.
- Select the top 3 reindeer based on their highest average speed. Round the score to 2 decimal places.

Enter the name and score of the top 3 reindeer in the format name,highest_average_score, but remember Rudolph is retiring so don't pick him.

Example Schema:
DROP TABLE IF EXISTS Reindeers CASCADE;
CREATE TABLE Reindeers (
    reindeer_id SERIAL PRIMARY KEY,
    reindeer_name VARCHAR(50) NOT NULL,
    years_of_service INTEGER NOT NULL,
    speciality VARCHAR(100)
);

DROP TABLE IF EXISTS Training_Sessions CASCADE;
CREATE TABLE Training_Sessions (
    session_id SERIAL PRIMARY KEY,
    reindeer_id INTEGER REFERENCES Reindeers(reindeer_id),
    exercise_name VARCHAR(100) NOT NULL,
    speed_record DECIMAL(5,2) NOT NULL,
    session_date DATE NOT NULL,
    weather_conditions VARCHAR(50)
);

Example Result:

 reindeer_name | top_speed 
---------------+-----------
 Dancer        |     94.80
 Comet         |     93.20
 Dasher        |     92.30

*/
-- SOLUTION --------------------------------------------- 
with avg_per_exercise_cte as (
 	select 
 		reindeer_id,
 		exercise_name,
 		avg(speed_record) as avg_per_exercise
	from training_sessions ts
	group by 1, 2
)
select
	r.reindeer_name,
	round(ape.avg_per_exercise, 2) 
from avg_per_exercise_cte ape
join reindeers r 
	on ape.reindeer_id = r.reindeer_id 
where reindeer_name != 'Rudolph'
order by 2 desc 
limit 3
	

-- RESULT ---------------------------------------------
-- Cupid,88.64
-- Blitzen,88.38
-- Vixen,88.01


