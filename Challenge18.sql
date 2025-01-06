-- CHALLENGE 18 --------------------------------------------
/* 
Write a query that finds the number of peers for the employee with the most peers. Peers are defined as employees who share both the same manager and the same level in the hierarchy.

Find the employee with the most peers and lowest level (e.g. smaller number). If there's more than 1 order by staff_id ascending.

Note: When counting peers, include the employee themselves in the count. So two employees who are peers would give a count of 2.

Submit the id of the staff member

Example Schema: 
CREATE TABLE staff (
    staff_id INT PRIMARY KEY,
    staff_name VARCHAR(100) NOT NULL,
    manager_id INT,
    FOREIGN KEY (manager_id) REFERENCES Staff(staff_id)
);

Example Result:
  staff_id |      staff_name      | level |    path    | manager_id | peers_same_manager | total_peers_same_level 
----------+----------------------+-------+------------+------------+--------------------+------------------------
        4 | Senior Toy Maker     |     3 | 1,2,4      |          2 |                  2 |                      3
        6 | Inventory Manager    |     3 | 1,3,6      |          3 |                  1 |                      3
        5 | Senior Gift Wrapper  |     3 | 1,2,5      |          2 |                  2 |                      3
        8 | Junior Gift Wrapper  |     4 | 1,2,5,8    |          5 |                  1 |                      3
        7 | Junior Toy Maker     |     4 | 1,2,4,7    |          4 |                  1 |                      3
        9 | Inventory Clerk      |     4 | 1,3,6,9    |          6 |                  1 |                      3
        3 | Head Elf Logistics   |     2 | 1,3        |          1 |                  2 |                      2
        2 | Head Elf Operations  |     2 | 1,2        |          1 |                  2 |                      2
        1 | Santa Claus          |     1 | 1          |            |                  1 |                      1
       10 | Apprentice Toy Maker |     5 | 1,2,4,7,10 |          7 |  

*/
-- SOLUTION --------------------------------------------- 
with recursive paths_cte as (
	select 
		staff_id, 
		staff_name, 
		ARRAY[staff_id] as path,
		manager_id
	from staff
	where manager_id is null
	union all 
	select 
		s.staff_id, 
		s.staff_name, 
		p.path || s.staff_id,
		s.manager_id
	from staff s
	join paths_cte p on p.staff_id = s.manager_id
), 
manager_count_cte as (
	select manager_id, count(*) as peers_same_manager 
	from staff 
	group by 1
), 
peer_count_cte as (
	select array_length(path, 1) as level, 
	count(*) as total_peers_same_level 
	from paths_cte 
	group by 1
)
select
	p.staff_id,
	p.staff_name,
	array_length(path, 1) as level,
	p.path,
	p.manager_id,
	mc.peers_same_manager,
	pc.total_peers_same_level
from paths_cte p
join peer_count_cte pc on array_length(path, 1) = pc.level
join manager_count_cte mc on p.manager_id = mc.manager_id
order by 
	pc.total_peers_same_level desc,
	array_length(path, 1),
	p.staff_id

-- RESULT ---------------------------------------------
-- 282

