-- CHALLENGE 8 --------------------------------------------
/* 
We want to find out how many managers the most over-managed employee has (levels deep).

To do this, you're going to need to go through all the employees and find out who their manager is, and who their manger is, and who their manger is... you see where this is going

You need to produce a report that calculates this management depth for all employees

Order it by the number of levels in descending order.

Submit the highest total number of levels of all the staff in the DB.

If there are multiple with the same level submit that.

Expectd Output:
staff_id |      staff_name      | level |    path    
----------+----------------------+-------+------------
       10 | Apprentice Toy Maker |     5 | 1,2,4,7,10
        9 | Inventory Clerk      |     4 | 1,3,6,9
        8 | Junior Gift Wrapper  |     4 | 1,2,5,8
        7 | Junior Toy Maker     |     4 | 1,2,4,7
        6 | Inventory Manager    |     3 | 1,3,6
        4 | Senior Toy Maker     |     3 | 1,2,4
        5 | Senior Gift Wrapper  |     3 | 1,2,5
        3 | Head Elf Logistics   |     2 | 1,3
        2 | Head Elf Operations  |     2 | 1,2
        1 | Santa Claus          |     1 | 1

*/
-- SOLUTION --------------------------------------------- 
with recursive paths as (
	select 
		staff_id, 
		staff_name, 
		ARRAY[staff_id] as path
	from staff
	where manager_id is null
	union all 
	select 
		s.staff_id, 
		s.staff_name, 
		p.path || s.staff_id 
	from staff s
	join paths p on p.staff_id = s.manager_id
)
select 
	staff_id, 
	staff_name, 
	array_length(path, 1) as level,
	path
from paths
order by array_length(path, 1) desc
	

-- RESULT ---------------------------------------------
-- 24


