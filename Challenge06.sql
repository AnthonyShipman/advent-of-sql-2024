-- CHALLENGE --------------------------------------------
/* 

Write a query that returns the name of each child and the name and price of their gift, but only for children who received gifts more expensive than the average gift price.
The results should be ordered by the gift price in ascending order.

Give the name of the child with the first gift thats higher than the average.
*/

-- SOLUTION ---------------------------------------------
with children_gifts_cte as (
	select
		c.name as child_name,
		g.name as gift_name,
		g.price as gift_price
	from children c 
	join gifts g on c.child_id = g.child_id
)
select
	child_name,
	initcap(gift_name),
	gift_price
from children_gifts_cte
where gift_price > (select avg(gift_price) from children_gifts_cte)
order by gift_price 

-- RESULT ---------------------------------------------
-- Hobart
