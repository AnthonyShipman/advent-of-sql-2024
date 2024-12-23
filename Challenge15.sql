-- CHALLENGE 14 --------------------------------------------
/* 
Mrs. Claus needs to find the receipt for Santa's green suit that was dry cleaned.

She needs to know when it was dropped off, so submit the drop off date.

Order by the latest drop off date

Example Schema:
CREATE TABLE SantaRecords (
    record_id INT PRIMARY KEY,
    record_date DATE,
    cleaning_receipts JSONB
);


*/
-- SOLUTION --------------------------------------------- 
with unnested_receipts_cte as (
	select 
 		record_date, 
 		jsonb_array_elements(cleaning_receipts) as receipt
	from SantaRecords
)
select 
	record_date, 
	receipt->>'garment',
	receipt->>'color',
	* from unnested_receipts_cte
where receipt->>'garment' = 'suit'
	and receipt->>'color' = 'green'
order by record_date desc
limit 1

-- RESULT ---------------------------------------------
-- 2024-12-22
