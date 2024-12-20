-- CHALLENGE 10 --------------------------------------------
/* 
You are working with a table named drinks, which logs various types of beverages consumed over the Christmas parties, along with the date and quantity consumed. Your task is to determine which drinks were the most popular by calculating the total quantity consumed for each type of drink.

Submit the date where the following total quantity of drinks were consumed:

HotCocoa: 38
PeppermintSchnapps: 298
Eggnog: 198

Example Schema:
DROP TABLE IF EXISTS Drinks CASCADE;
CREATE TABLE Drinks (
    drink_id SERIAL PRIMARY KEY,
    drink_name VARCHAR(50) NOT NULL,
    date DATE NOT NULL,
    quantity INTEGER NOT NULL
);

*/
-- SOLUTION --------------------------------------------- 
select date from drinks group by date
having sum(case when drink_name = 'Hot Cocoa' then quantity else 0 end) = 38 
and sum(case when drink_name = 'Peppermint Schnapps' then quantity else 0 end) = 298 
and sum(case when drink_name = 'Eggnog' then quantity else 0 end) = 198

-- RESULT ---------------------------------------------
-- 2024-03-14

