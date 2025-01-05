-- CHALLENGE 17 --------------------------------------------
/* 
- Find all possible 60-minute meeting windows where all participating workshops are within their business hours
- Return results in UTC format
- Submit the earliest meeting start time that all offices can make.


Example Schema:
CREATE TABLE Workshops (
    workshop_id INT PRIMARY KEY,
    workshop_name VARCHAR(100),
    timezone VARCHAR(50),
    business_start_time TIME,
    business_end_time TIME
);

Example Result:
 meeting_start_utc | meeting_end_utc 
-------------------+-----------------
 14:00:00          | 15:00:00
 14:30:00          | 15:30:00
 15:00:00          | 16:00:00
 15:30:00          | 16:30:00
 16:00:00          | 17:00:00

*/
-- SOLUTION --------------------------------------------- 
with utc_times_cte as (
	select
		ws.business_start_time - ptn.utc_offset as utc_start_time,
		ws.business_end_time - ptn.utc_offset as utc_end_time
	from workshops ws
	join pg_timezone_names ptn on ptn.name = ws.timezone
	-- Filter out America/New_York to account for bug in data that prevents valid solution to problem
	-- Thanks Reddit for the info: https://www.reddit.com/r/adventofsql/comments/1hfxj1i/2024_day_17_solutions/
	where timezone != 'America/New_York' 
), valid_starts_cte as (
	select (generate_series(
		('2025-01-02'::date + (select max(utc_start_time) from utc_times_cte))::timestamp,
		('2025-01-02'::date + (select min(utc_end_time) from utc_times_cte))::timestamp,
		'30 minutes'::interval
	))::time AS meeting_start_utc
)
select 
	meeting_start_utc, 
	meeting_start_utc + '60 minutes'::interval as meeting_end_utc 
from valid_starts_cte
-- RESULT ---------------------------------------------
-- 09:00:00
