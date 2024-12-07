-- CHALLENGE --------------------------------------------
/* 

Challenge URL: https://adventofsql.com/challenges/3 
 
The challenge is that some records are stored in different XML schemas. Mrs. Claus needs help writing a SQL query that can search through all schema versions to find the most beloved dishes from the busiest celebrations. As she's having more than 78 guests this year, she wants to make sure the dishes are popular with a large crowd, so only use years where she had more than 78 guests.

You will have to do some prep-work before you write your final query, like understanding how many unique schema versions exist and how to parse each schema using SQL.

Help Mrs. Claus write a SQL query that can:
- Parse through all different schema versions of menu records
- Find menu entries where the guest count was above 78
- Extract the food_item_ids from those successful big dinners
- From this enormous list of items, determine which dish (by food_item_id) appears most frequently across all of the dinners.
- Input the food_item_id of the food item that appears the most often.
*/

-- SOLUTION ---------------------------------------------
with christmas_feast_food_items as (
	select 
		(xpath('string(//attendance_record/total_guests)', menu_data))[1]::text::numeric as guest_count,
		x.value::text as food_item_id
	from christmas_menus,
	lateral unnest(xpath('//food_item_id/text()', menu_data)) AS x(value)
	where (xpath('local-name(/*)', menu_data))[1]::text = 'christmas_feast'
),
northpole_database_food_items as (
	select 
		(xpath('string(//guest_registry/total_count)', menu_data))[1]::text::numeric as guest_count,
		x.value::text as food_item_id
	from  christmas_menus, 
	lateral unnest(xpath('//food_item_id/text()', menu_data)) AS x(value)
	where (xpath('local-name(/*)', menu_data))[1]::text = 'northpole_database'
),
polar_celebration_food_items as (
	select
		(xpath('string(//headcount/total_present)', menu_data))[1]::text::numeric as guest_count,
		x.value::text as food_item_id
	from  christmas_menus,
	lateral unnest(xpath('//food_item_id/text()', menu_data)) AS x(value)
	where (xpath('local-name(/*)', menu_data))[1]::text = 'polar_celebration'
),
all_counts_and_food_items as (
	select * from christmas_feast_food_items 
	union all
	select * from northpole_database_food_items
	union all
	select * from polar_celebration_food_items
)
select food_item_id, count(food_item_id)
from all_counts_and_food_items
where guest_count > 78
group by 1
order by 2 desc
limit 1

-- RESULT ---------------------------------------------
-- food_item_id = 493
