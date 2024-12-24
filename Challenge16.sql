-- CHALLENGE 16 --------------------------------------------
/* 
In which timezone has Santa spent the most time?

Assume that each timestamp is when Santa entered the timezone.

Ignore the last timestamp when Santa is in Lapland.

Example Result:
| place_name | total_hours_spent |
|------------|-------------------------|
| New_York     | 2.0000000000000000 |
| Los_Angeles   | 1.0000000000000000 |
| Tokyo         | 1.0000000000000000 |
| Lapland      | null |


Example Schema:
CREATE TABLE sleigh_locations (
    id SERIAL PRIMARY KEY,
    timestamp TIMESTAMP WITH TIME ZONE NOT NULL,
    coordinate GEOGRAPHY(POINT) NOT NULL
);

CREATE TABLE areas (
    id SERIAL PRIMARY KEY,
    place_name VARCHAR(255) NOT NULL,
    polygon GEOGRAPHY(POLYGON) NOT NULL
);

*/
-- SOLUTION --------------------------------------------- 
select 
	place_name,
	max(sl.timestamp) - min(sl.timestamp) as total_hours_spent
from sleigh_locations sl 
join areas a on ST_Within(sl.coordinate::geometry , a.polygon::geometry)
group by 1
order by 2 desc limit 1

-- RESULT ---------------------------------------------
-- Paris
