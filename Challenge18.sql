-- CHALLENGE 18 --------------------------------------------
/* 
- Find all possible 60-minute meeting windows where all participating workshops are within their business hours
- Return results in UTC format
- Submit the earliest meeting start time that all offices can make.


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


-- RESULT ---------------------------------------------

