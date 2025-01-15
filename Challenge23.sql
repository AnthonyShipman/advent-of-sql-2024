-- CHALLENGE 23 --------------------------------------------
/* 
Find the missing tags

Assume the first and last tags are in the database

Group them in islands, a group starts as the first missing element and finishes as the last missing element. A group is a sequential number of missing values.

Submit the tags in the missing groups as in the example

EXAMPLE SCHEMA:
CREATE TABLE sequence_table (
    id INT PRIMARY KEY
);

EXAMPLE RESULT:
 gap_start | gap_end | missing_numbers 
-----------+---------+-----------------
         4 |       6 | {4,5,6}
        10 |      10 | {10}
        12 |      14 | {12,13,14}
        18 |      21 | {18,19,20,21}

EXAMPLE SUBMISSION:
4,5,6
10
12,13,14
18,19,20,21
 
*/
-- SOLUTION --------------------------------------------- 
with full_series as (
  select generate_series(min(id), max(id)) as id
  from sequence_table
),
missing_ids as (
  select s.id
  from full_series s
  left join sequence_table i on s.id = i.id
  where i.id is null
),
gaps as (
  select 
    id,
    id - row_number() over (order by id) as gap_group
  from missing_ids
),
gap_ranges as (
  select 
    min(id) as gap_start,
    max(id) as gap_end,
    array_agg(id) as missing_values
  from gaps
  group by gap_group
)
select 
	gap_start, 
	gap_end, 
	missing_values
from gap_ranges
order by gap_start

-- RESULT ---------------------------------------------
-- 997,998,999,1000,1001
-- 3761,3762,3763,3764,3765
-- 6525,6526,6527
-- 6529
-- 9289,9290,9291,9292


