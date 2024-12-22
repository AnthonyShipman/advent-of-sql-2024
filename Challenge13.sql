-- CHALLENGE 13 --------------------------------------------
/* 
Create a list of all the domains that exist in the contacts list emails.

Submit the domain names with the most emails.

Example Schema:
CREATE TABLE contact_list (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email_addresses TEXT[] NOT NULL,
);

*/
-- SOLUTION --------------------------------------------- 
with emails_cte as (
	select unnest(email_addresses) as email_address from contact_list 
)
select split_part(email_address, '@', 2) as domain, count(*)
from emails_cte
group by 1
order by count desc


-- RESULT ---------------------------------------------
-- bells.org
-- 155

