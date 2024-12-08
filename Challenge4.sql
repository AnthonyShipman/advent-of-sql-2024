-- CHALLENGE --------------------------------------------
/* 

Challenge URL: https://adventofsql.com/challenges/4 
 
Help the elves analyze toy tags by finding:

New tags that weren't in previous_tags (call this added_tags)
Tags that appear in both previous and new tags (call this unchanged_tags)
Tags that were removed (call this removed_tags)
For each toy, return toy_name and these three categories as arrays.

Find the toy with the most added tags, there is only 1, and submit the following:
- toy_id
- added_tags length
- unchanged_tags length
- removed_tags length

Remember to handle cases where the array is empty, their output should be 0.

*/

-- SOLUTION ---------------------------------------------
with diff_sets as (
	select 
		toy_id, 
		toy_name, 
		array(select item from unnest(new_tags) as item except select item from unnest(previous_tags) as item) as added_tags,
		array(select item from unnest(new_tags) as item intersect select item from unnest(previous_tags) as item) as unchanged_tags,
		array(select item from unnest(previous_tags) as item except select item from unnest(new_tags) as item) as removed_tags
	from toy_production tp
)
select 
	toy_id, 
	toy_name,
	coalesce(array_length(added_tags, 1), 0) as added_length,
	coalesce(array_length(unchanged_tags,1), 0) as unchanged_length,
	coalesce(array_length(removed_tags, 1), 0) as removed_length
from diff_sets
order by added_length desc

-- RESULT ---------------------------------------------
-- toy_id: 					2726
-- added_tags length:	 	98
-- unchanged_tags length:	2
-- removed_tags length:		0

