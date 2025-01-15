-- CHALLENGE 22 --------------------------------------------
/* 
Find all the elves with SQL as a skill

Count each elf only once.

Only the skill SQL counts, MySQL etc. does not count.

EXAMPLE SCHEMA:
DROP TABLE IF EXISTS elves CASCADE;
    CREATE TABLE elves (
      id SERIAL PRIMARY KEY,
      elf_name VARCHAR(255) NOT NULL,
      skills TEXT NOT NULL
    );
    
EXAMPLE RESULT:
 numofelveswithsql 
-------------------
                 1

EXAMPLE SUBMISSION:
1
 
*/
-- SOLUTION --------------------------------------------- 
select count(*) as numofelveswithsql
from elves
where 'SQL' = any(string_to_array(skills, ','))

-- RESULT ---------------------------------------------
-- 2488


