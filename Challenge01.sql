/*
PROBLEM

https://adventofsql.com/challenges/1
The challenge 🎁
Download challenge data: https://adventofsql.com/challenges/1#
Create a report showing what gifts children want, with difficulty ratings and categorization.

The primary wish will be the first choice

The secondary wish will be the second choice

You can presume the favorite color is the first color in the wish list

Gift complexity can be mapped from the toy difficulty to make. Assume the following:

    Simple Gift = 1
    Moderate Gift = 2
    Complex Gift >= 3
We assign the workshop based on the primary wish's toy category. Assume the following:

  outdoor = Outside Workshop
  educational = Learning Workshop
  all other types = General Workshop
Order the list by name in ascending order.

Your answer should limit its return to only 5 rows

SAMPLE RESULT
  
----------------------------------------------------------------------------------------------------------
name  | primary_wish | backup_wish | favorite_color | color_count | gift_complexity | workshop_assignment
Tommy | bike         | blocks      | red            | 2           | Complex Gift    | Outside Workshop
Sally | doll         | books       | pink           | 2           | Moderate Gift   | General Workshop
Bobby | blocks       | bike        | green          | 1           | Simple Gift     | Learning Workshop
*/


-- SOLUTION ----------------------------------------------
with children_cte as (
	select 
		child_id,
		name 
	from children
),
wish_lists_cte as (
	select 
		child_id,
		lower(wishes->>'first_choice') as primary_wish, 
		lower(wishes->>'second_choice') as backup_wish,
		lower(wishes->'colors'->>0) as favorite_color,
		json_array_length(wishes->'colors') as color_count
	from wish_lists c
), toy_catalogue_cte as (
	select
		lower(toy_name) as toy_name,
		case difficulty_to_make
			when 1 then 'Simple Gift'
			when 2 then 'Moderate Gift'
			else 'Complex Gift'
		end as gift_complexity,
		case category
			when 'outdoor' then 'Outside Workshop'
			when 'educational' then 'Learning Workshop'
			else 'General Workshop'
		end as workshop_assignment
	from toy_catalogue
)
select 
	children_cte.name, 
	wish_lists_cte.primary_wish,
	wish_lists_cte.backup_wish,
	wish_lists_cte.favorite_color,
	wish_lists_cte.color_count,
	toy_catalogue_cte.gift_complexity,
	toy_catalogue_cte.workshop_assignment
from children_cte
join wish_lists_cte on children_cte.child_id = wish_lists_cte.child_id
join toy_catalogue_cte on wish_lists_cte.primary_wish = toy_catalogue_cte.toy_name
order by name
limit 5

