-- CHALLENGE 12 --------------------------------------------
/* 
Find the toy with the second highest percentile of requests. Submit the name of the toy and the percentile value.

If there are multiple values, choose the first occurrence.

Order by percentile descending, then gift name ascending.

Example Schema:
DROP TABLE gifts CASCADE;
CREATE TABLE gifts (
    gift_id INT PRIMARY KEY,
    gift_name VARCHAR(100) NOT NULL,
    price DECIMAL(10,2)
);
DROP TABLE gift_requests CASCADE;
CREATE TABLE gift_requests (
    request_id INT PRIMARY KEY,
    gift_id INT,
    request_date DATE,
    FOREIGN KEY (gift_id) REFERENCES Gifts(gift_id)
);

*/
-- SOLUTION --------------------------------------------- 
with request_counts_cte as (
	select
		initcap(g.gift_name) as gift_name,
		count(*) as request_count
	from gift_requests gr 
	join gifts g on gr.gift_id = g.gift_id 
	group by 1
)
select
	gift_name,
	round(percent_rank() over (order by request_count)::numeric, 2) as pct_rank
from request_counts_cte
order by pct_rank desc, gift_name


-- RESULT ---------------------------------------------
-- Chemistry Set
-- 0.86


