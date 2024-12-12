-- CHALLENGE 7 --------------------------------------------
/* 

Create a query that returns pairs of elves who share the same primary_skill. The pairs should be comprised of the elf with the most (max) and least (min) years of experience in the primary_skill.

When you have multiple elves with the same years_experience, order the elves by elf_id in ascending order.

Your query should return:
- The ID of the first elf with the Max years experience
- The ID of the first elf with the Min years experience
- Their shared skill

Notes:
- Each pair should be returned only once.
- Elves can not be paired with themselves, a primary_skill will always have more than 1 elf.
- Order by primary_skill, there should only be one row per primary_skill.
- In case of duplicates order first by elf_1_id, then elf_2_id.

In the inputs below provide one row per primary_skill in the format, with no spaces and comma separation:

max_years_experience_elf_id, min_years_experience_elf_id, shared_skill

Do not use any special characters such as " or ' in your answer.

*/

-- SOLUTION --------------------------------------------- 
with max_years_rnum_cte as (
	select 
		elf_id, 
		elf_name, 
		years_experience, 
		primary_skill,
		row_number() over (partition by primary_skill order by years_experience desc, elf_id) as rnum
	from workshop_elves we
), min_years_rnum_cte as (
	select 
		elf_id, 
		elf_name, 
		years_experience, 
		primary_skill,
		row_number() over (partition by primary_skill order by years_experience, elf_id) as rnum
	from workshop_elves we
)
select 
	mx.elf_id, 
	mn.elf_id, 
	initcap(mx.primary_skill)
from max_years_rnum_cte mx
join min_years_rnum_cte mn on mx.primary_skill = mn.primary_skill
where mx.rnum = 1 and 
	mn.rnum = 1

-- RESULT ---------------------------------------------
-- 4153,3611,Gift Sorting
-- 10497,1016,Gift Wrapping
-- 50,13551,Toy Making



