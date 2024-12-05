-- CHALLENGE --------------------------------------------
/*
 * Challenge URL: 				https://adventofsql.com/challenges/2
 * 
 * These tables contain pieces of a child's Christmas wish, but they're all mixed up with magical interference from the Northern Lights! We need to:
 * 1. Filter out the holiday sparkles (noise)
 * 2. Combine Binky and Blinky's tables
 * 3. Decode the values back into regular letters
 * 4. Make sure everything's in the right order!
 * 
 * Valid characters:
 * 	- All lower case letters a - z
 *  - All upper case letters A - Z
 *  - Space
 *  - !
 *  - "
 *  - '
 *  - (
 *  - )
 *  - ,
 *  - -
 *  - .
 *  - :
 *  - ;
 *  - ?
 */


-- SOLUTION ---------------------------------------------
with letters_combined_cte as (
	select * from letters_a 
	union all
	select * from letters_b
),
letters_filtered_cte as (
	select * from letters_combined_cte
	where (value >= 65  and value <= 90) -- A to Z in ASCII
	or (value >= 97 and value <= 122) -- a to z in ASCII
	or value in (32, 33, 34, 39, 40, 41, 44, 45, 46, 58, 59, 63) -- <space>, !, ", ', (, ), ',', -, ., :, ;, ?
)
select STRING_AGG(CHR(value),'' order by id) 
from letters_filtered_cte


-- RESULT ---------------------------------------------
-- Dear Santa, I hope this letter finds you well in the North Pole! I want a SQL course for Christmas!

