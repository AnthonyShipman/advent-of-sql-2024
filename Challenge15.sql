-- CHALLENGE 15 --------------------------------------------
/* 
Using the list of areas you need to find which city the last sleigh_location is located in.

Submit the city name only.

Note: This task might seem simple but its going to get much trickier tomorrow and its essential you nail this part first.

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

Example Result:
timestamp         |	area
----------------------|-----------------------
2024-12-24 22:00:00+00	| New_York
2024-12-24 23:00:00+00	| Los_Angeles
2024-12-25 00:00:00+00	| Tokyo

*/
-- SOLUTION --------------------------------------------- 
select timestamp, place_name as area 
from sleigh_locations sl 
join areas a on ST_Within(sl.coordinate::geometry , a.polygon::geometry)
order by timestamp desc limit 1


-- RESULT ---------------------------------------------
-- Moscow 
